local DFFile = require 'DFCommon.File'
local DFGraphics = require 'DFCommon.Graphics'
local DFUtil = require 'DFCommon.Util'
local Renderer = require('Renderer')

-- "m" for "module"
local m = {}

-- this is a library for loading in a tiled map and lua file
-- file placement requirements:
-- place the lua file generated by tiled under Data/Levels
-- place the tileset image file under Art/Levels/Tilesets
-- the hardcoding of the above is to go around the silliness of how tiled specifies the filepath for the tileset file

m.kEMPTY_TILE = "none"

-- the data that gets returned from this function is a table with the following fields
-- table: tLayerInfos  <an array of layerinfo>
-- tLayerInfos comprises of the following fields
--    table: tLayerProperties <a table of layer properties.  the key is the property name>
--    table: tProps           <an array of props in RowXCol.  1,1 is the top of the map, row increases to the right down (as seen in Tiled), col increases to the left and down
-- tProps comprises of
--        props as MOAIProp2D
--        with an addtional field of: tTileProperties <a table of tile properties.  the key is the property name>

function m.getLayerInfosFromTiled(sTiledFilePath, tSpriteSheetToScreenInfo, nSizeFactor, tTilesetToSpriteSheets, nGridTileWidthOffset, nGridTileHeightOffset)
    if sTiledFilePath == nil then
        return nil
    end

    -- load in the lua file
    local rTileInfo = dofile(DFFile.getLevelPath(sTiledFilePath..".lua"))
    if rTileInfo == nil then
        return nil
    end

    nSizeFactor = nSizeFactor or 1

    local tMapInfo = {}
    tMapInfo.nTileWidth = rTileInfo.tilewidth * nSizeFactor
    tMapInfo.nTileHeight = rTileInfo.tileheight * nSizeFactor
    tMapInfo.tProperties = rTileInfo.properties
    tMapInfo.tLayers = nil

    -- the following are dependent on the tiled exported lua structure 
    -- load in the tileset texture
    local tTileDeckInfos = {}
    for i, rTilesetInfo in ipairs(rTileInfo.tilesets) do
        local sTilesetPath = rTilesetInfo.image
        -- strip out all the added relative path stuff that tiled puts in
        while true do
            local nIndex = string.find(sTilesetPath, "/")
            local nLen = string.len(sTilesetPath)
            if nIndex then
                if nIndex + 1 > nLen then -- bad, had a slash at the end
                    break
                end
                sTilesetPath = string.sub(sTilesetPath, nIndex + 1)
            else
                break
            end
        end
        -- load the texture
        -- no pvr tiled env for now
        local tFields = DFUtil.split(sTilesetPath, ".")
        sFilePath = tFields[1] or ''
        sFileExtension = tFields[2] or 'png'
        if MOAIEnvironment.osBrand == MOAIEnvironment.OS_BRAND_IOS then
            -- load the pvr
            sFileExtension = 'pvr'
        end
        local rTileDeckInfo = {}
        local sTextureSuffix = ''
        if tTilesetToSpriteSheets and tTilesetToSpriteSheets[sFilePath] then            
            local nRectScaleX = 1
            local nRectScaleY = 1
            local tScreenInfo = Renderer.getCurScreenInfo()
            if tScreenInfo then
                local tInfo = tSpriteSheetToScreenInfo[tTilesetToSpriteSheets[sFilePath]]
                if tInfo then                    
                    sTextureSuffix = tInfo[tScreenInfo.key].sTextureSizeSuffix
                    nRectScaleX = tInfo[tScreenInfo.key].nTextureSizeFactor
                    nRectScaleY = tInfo[tScreenInfo.key].nTextureSizeFactor
                end
            end
                
            local rSpriteSheet = DFGraphics.loadSpriteSheet('Levels/Tilesets/'..tTilesetToSpriteSheets[sFilePath]..sTextureSuffix, g_IsInStartupSequence)
            if rSpriteSheet then
                for sName, data in pairs(rSpriteSheet.names) do
                    DFGraphics.alignSprite(rSpriteSheet, sName, "left", "bottom", nRectScaleX, nRectScaleY)
                end
                rTileDeckInfo.rSpriteSheet = rSpriteSheet
                rTileDeckInfo.sBaseName = sFilePath..sTextureSuffix
            end
        else
            local rTexture = DFGraphics.loadTexture("Levels/Tilesets/"..sFilePath..sTextureSuffix.."."..sFileExtension)
            if rTexture then
                local rTileDeck = MOAITileDeck2D:new()
                rTileDeck:setTexture(rTexture)  
                local nWidth = (rTilesetInfo.imagewidth / rTilesetInfo.tilewidth)
                local nHeight = (rTilesetInfo.imageheight / rTilesetInfo.tileheight)
                rTileDeck:setSize(nWidth, nHeight)
                rTileDeck:setRect(0, 0, rTilesetInfo.tilewidth * nSizeFactor, rTilesetInfo.tileheight * nSizeFactor)                
                rTileDeckInfo.rTileDeck = rTileDeck
            end
        end
        rTileDeckInfo.nFirstGID = rTilesetInfo.firstgid
        rTileDeckInfo.tTileProperties = rTilesetInfo.tiles
        
        function rTileDeckInfo:getProperties(gid)
            local nRelGID = gid - self.nFirstGID
            for i, rPropInfo in ipairs(self.tTileProperties) do
                if rPropInfo.id == nRelGID then
                    return rPropInfo.properties
                end
            end
            return {}
        end
        
        table.insert(tTileDeckInfos, rTileDeckInfo)
    end

    -- create the props    
    local tLayerInfos = {}
    for i, rLayerInfo in ipairs(rTileInfo.layers) do
        local tNewLayerInfo = {}
        -- for grid oriented props
        local rGridProp = nil
        local rMoaiGrid = nil
        local nXorig = 0
        local nGridWidth = 0
        local nGridHeight = 0
        local bCreateGrid = false
        local bSpriteDeckSet = false
        local tGridInfo = {}
        -- for non grid oriented props
        local tProps = nil
        -- set the properties
        tNewLayerInfo.tLayerProperties = rLayerInfo.properties
        -- iterate through the data table and create a prop
        if tNewLayerInfo.tLayerProperties['creategrid'] then
            rGridProp = MOAIProp2D.new()
            rMoaiGrid = MOAIGrid.new()
            rMoaiGrid:setShape(MOAIGridSpace.DIAMOND_SHAPE)
            nXorig = math.floor(rLayerInfo.height / 2) + 1 -- offset by two since these are 1 based
            nGridWidth = nXorig * 2
            nGridHeight = rLayerInfo.height + rLayerInfo.width + (rLayerInfo.height % 2) + (1 - (rLayerInfo.width % 2))
            local nOffsetWidth = nGridTileWidthOffset or 0
            local nOffsetHeight = nGridTileHeightOffset or 0
            rMoaiGrid:setSize(nGridWidth, nGridHeight, tMapInfo.nTileWidth + nOffsetWidth, (tMapInfo.nTileHeight + nOffsetHeight) / 2, 0, 0, 1, 1)
            rGridProp:setGrid(rMoaiGrid)
            for y = 1, nGridHeight do
                local tRowInfo = {}
                for x = 1, nGridWidth do
                    table.insert(tRowInfo, 0)
                end
                table.insert(tGridInfo, tRowInfo)
            end
            bCreateGrid = true      
        else
            tProps = {}
        end

        local nIndex = 1
        for nRow = 1, rLayerInfo.height do
            if not bCreateGrid then
                tProps[nRow] = {}
            end
            for nCol = 1, rLayerInfo.width do
                local GID = rLayerInfo.data[nIndex]
                if GID > 0 then
                    local rDeckInfo = nil
                    local nGIDOffset = 0
                    local tProperties = nil
                    local bFlipY = false
                    local bFlipX = false
                    -- the highest two bits represent the y and x flip info from tiled
                    if GID > math.pow(2, 32) then
                        bFlipY = true
                        GID = GID - math.pow(2, 32)
                    end
                    if GID > math.pow(2, 31) then
                        bFlipX = true
                        GID = GID - math.pow(2, 31)
                    end
                    for c, rTileDeckInfo in ipairs(tTileDeckInfos) do
                        if GID >= rTileDeckInfo.nFirstGID then
                            rDeckInfo = rTileDeckInfo
                            if rTileDeckInfo.nFirstGID > 1 then
                                nGIDOffset = rTileDeckInfo.nFirstGID - 1
                            end
                        end
                    end
                    if rDeckInfo then
                        local nRelGID = GID - nGIDOffset
                        if bCreateGrid then
                            if not bSpriteDeckSet then -- NOTE: per layer, all tiles should come from the same spritesheet for grids
                                if rDeckInfo.rSpriteSheet then
                                    rGridProp:setDeck(rDeckInfo.rSpriteSheet)
                                end
                                bSpriteDeckSet = true
                            end
                            -- not sure where to save out tile properties and x, y flipping for grids
                            -- unsupported for now
                            local nGridRow = nCol + nRow - 1
                            local nGridCol = nXorig - nRow + math.floor((nCol + nRow) / 2)
                            local nIndex = rDeckInfo.rSpriteSheet.names[rDeckInfo.sBaseName..'_'..nRelGID]
                            if nIndex then                            
                                tGridInfo[nGridRow][nGridCol] = nIndex
                            end
                        else
                            local rProp = MOAIProp2D.new()
                            rProp.tTileProperties = rDeckInfo:getProperties(GID)
                            if rDeckInfo.rSpriteSheet then
                                rProp:setDeck(rDeckInfo.rSpriteSheet)
                                local nIndex = rDeckInfo.rSpriteSheet.names[rDeckInfo.sBaseName..'_'..nRelGID]
                                if nIndex then
                                    rProp:setIndex(nIndex)
                                end
                                rProp.rSavedDeck = rDeckInfo.rSpriteSheet
                            else
                                rProp:setDeck(rDeckInfo.rTileDeck)
                                rProp:setIndex(nRelGID)
                                rProp.rSavedDeck = rDeckInfo.rTileDeck
                            end
                            
                            if bFlipX then
                                -- TODO: flip X
                            end
                            if bFlipY then
                                -- TODO: flip Y
                            end
                            tProps[nRow][nCol] = rProp
                        end
                    else
                        print("ERROR: DFTiled could not find the tiledeck for GID: "..tostring(GID))
                    end
                else
                    if tProps then
                        -- GID of 0 means no tile
                        tProps[nRow][nCol] = m.kEMPTY_TILE
                    end
                end
                nIndex = nIndex + 1
            end
        end
        if bCreateGrid then
            local nIndex = 1
            local nNumEntries = table.getn(tGridInfo)            
            while nIndex <= nNumEntries do
                rMoaiGrid:setRow(nIndex, unpack(tGridInfo[nNumEntries - nIndex + 1]))
                nIndex = nIndex + 1
            end
            tNewLayerInfo.rGridProp = rGridProp
            tNewLayerInfo.rGrid = rMoaiGrid
            tNewLayerInfo.tGridInfo = tGridInfo
            tNewLayerInfo.nGridWidth = nGridWidth
            tNewLayerInfo.nGridHeight = nGridHeight
        else
            tNewLayerInfo.tProps = tProps
        end
        table.insert(tLayerInfos, tNewLayerInfo)
    end

    tMapInfo.tLayerInfos = tLayerInfos
    return tMapInfo
end

return m