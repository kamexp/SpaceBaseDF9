local Gui = require('UI.Gui')

local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }

local nButtonWidth, nButtonHeight  = 418, 98

return 
{
    posInfo =
       {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tExtraInfo =
    {
    },    
    tElements =
    {       
        {
            key = 'Foreground',
            type = 'onePixel',
            pos = { 0, 0 },
            color = Gui.AMBER,
        },
        {
            key = 'Background',
            type = 'onePixel',
            pos = { 0, 0 },
            color = Gui.BLACK,
        },
    },
}
