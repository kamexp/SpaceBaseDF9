local Character=require('CharacterConstants')
local EnvObjectData = {}
local World=require('WorldConstants')

EnvObjectData.tMenus=
{
    ALL={ 'Door','Airlock','HeavyDoor','FirePanel','EmergencyAlarm',},
    POWER={ 'Generator', },
    LIFESUPPORT={},
    RESIDENCE={},
    GARDEN={},
    PUB={'Bar','Fridge','FridgeLvl2','Stove','StandingTable','BurgerSign','PizzaSign','FriesSign',},
    AIRLOCK={},
    REFINERY={},
    FITNESS={},
    INFIRMARY={},
    RESEARCH={},
}

EnvObjectData.tObjects=
{
    Spawner=
    {
        width=1,
        height=1,
        margin=0,
        customClass='EnvObjects.Spawner',
        customInspector='Spawner',
        spriteName='spawner',
        showInObjectMenu=false,
        noRoom=true,
        bCanBuildInSpace=true,
    },
    SpaceshipEngine=
    {
        spriteName='ShipEngine',
        friendlyNameLinecode='PROPSX094TEXT',
        description='PROPSX095TEXT',
		bCanBuildInSpace=true,
        noRoom=true,
        margin=1, -- this margin is a hack: it's to indicate where it will provide power.
        width=2,
        height=3,
        noRoom=true,
        bBlocksPathing=true,
        clickSound = 'fusionreactor',
        showInObjectMenu=false,
		matterCost=200,
        portrait = 'Env_SeedPod',
		nPowerOutput = 250,
        nSabotageDuration = 30,
    },
    DockPoint=
    {
        width=1,
        height=1,
        margin=0,
        customInspector='Generic',
        spriteName='dockpoint',
        showInObjectMenu=false,
        noRoom=true,
        bCanBuildInSpace=true,
    },
    Door=
    {
        layer='worldWall',        
        friendlyNameLinecode='PROPSX019TEXT',
        description='PROPSX020TEXT',
        door=true,
        noRoom=true,
        customInspector='Door',
        width=1,
        height=1,
        margin=0,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
--        spriteName='door_closed',
--        spriteSheetPath='Environments/Tiles/Wall',
        customClass='EnvObjects.Door',
        commandSpriteName='door_closed',
        commandSpriteNameFlipped='door_closed_flip',
        commandSpriteSheet='Environments/Tiles/Wall',
        clickSound = 'spacedoor',
        showInObjectMenu=true,
        placeSound = 'placedoor',
        portrait = 'Env_Door',
        sidebarIcon = 'icon_door',
        autoFlip=true,
		matterCost=12,
		sFlavorText='OBFLAV018TEXT',
    },
    HeavyDoor=
    {
        layer='worldWall',        
        friendlyNameLinecode='PROPSX064TEXT',
        description='PROPSX065TEXT',
        door=true,
        noRoom=true,
        customInspector='Door',
        width=1,
        height=1,
        margin=0,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
--        spriteName='door_closed',
--        spriteSheetPath='Environments/Tiles/Wall',
        customClass='EnvObjects.HeavyDoor',
        commandSpriteName='door_heavy_closed',
        commandSpriteNameFlipped='door_closed_flip',
        commandSpriteSheet='Environments/Tiles/Wall',
        clickSound = 'spacedoor',
        showInObjectMenu=true,
        placeSound = 'placedoor',
        portrait = 'Env_HeavyDoor',
        sidebarIcon = 'icon_heavydoor',
        researchPrereq='DoorLevel2',
        sFunctionality='Door',
        autoFlip=true,
		matterCost=20,
		sFlavorText = 'OBFLAV025TEXT',
    },
    Airlock=
    {
        layer='worldWall',
        friendlyNameLinecode='PROPSX021TEXT',
        description='PROPSX022TEXT',
        menuZoneName='AIRLOCK',
        door=true,
        noRoom=true,
        customInspector='Door',
        width=2,
        height=1,
        margin=0,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
--        spriteName='airlock_door_closed',
--        spriteSheetPath='Environments/Tiles/Wall',
        customClass='EnvObjects.Airlock',
        commandSpriteName='airlock_door_closed',
        commandSpriteNameFlipped='airlock_door_closed_flip',
        commandSpriteSheet='Environments/Tiles/Wall',
        clickSound = '',
        showInObjectMenu = true,
        placeSound = 'placeairlock',
        sidebarIcon = 'icon_airlock_door',
        portrait = 'Env_Airlock_Door',
        autoFlip=true,
		matterCost=15,
		sFlavorText = 'OBFLAV016TEXT',
    },
    Generator=
    {
        spriteName='generator',
        zoneName='POWER',
        friendlyNameLinecode='ZONEUI015TEXT',
        description='ZONEUI051TEXT',
        width=2,
        height=2,
        margin=2,
        decayPerSecond=0.03,
        explodeOnFailure=true,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        clickSound = 'fusionreactor',
        ambientSound = 'reactorloop',
        portrait = 'Env_Power_Generator',
        placeSound = 'placereactor',
        sidebarIcon = 'icon_generator',
        matterCost=200,
		nPowerOutput = 1000,
        nSabotageDuration = 30,
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV019TEXT',
    },
    GeneratorLevel2=
    {
        spriteName='generator2',
        zoneName='POWER',
        friendlyNameLinecode='PROPSX096TEXT',
        description='PROPSX097TEXT',
        width=2,
        height=2,
        margin=2,
        decayPerSecond=0.04,
        explodeOnFailure=true,
		researchPrereq = 'GeneratorLevel2',
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        clickSound = 'fusionreactor',
        ambientSound = 'reactorloop',
        portrait = 'Env_Power_Generator',
        placeSound = 'placereactor',
        sidebarIcon = 'icon_generator',
        matterCost=600,
		nPowerOutput = 2500,
        nSabotageDuration = 30,
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV022TEXT',
    },
    --[[
    ReactorTileGuts=
    {
        spriteName='reactor_tileguts',
        zoneName='POWER',
        friendlyNameLinecode='PROPSX013TEXT',
        description='PROPSX014TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
		matterCost=5,        
        portrait = 'Env_ReactorTileGuts',
        placeSound = 'placereactortile',
    },
    ReactorServerMachine=
    {
        spriteName='reactor_server_machine',
        zoneName='POWER',
        friendlyNameLinecode='PROPSX015TEXT',
        description='PROPSX016TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
        againstWall=true,
		matterCost=5,        
        portrait = 'Env_Reactor_ServerMachine',
        placeSound = 'placereactorserver',
    },
    ]]--
    FirePanel=
    {
        spriteName='fire_panel',
        friendlyNameLinecode='PROPSX001TEXT',
        description='PROPSX002TEXT',
        width=1,
        height=1,
        margin=0,
        againstWall=true,
        noRoom=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=50,
        portrait = 'Env_Firepanel',
        placeSound = 'placefirepanel',
        sidebarIcon = 'icon_fire_panel',
		sFlavorText = 'OBFLAV029TEXT',
    },
    FoodReplicator=
    {
        spriteName='food_replicator',
        friendlyNameLinecode='PROPSX027TEXT',
        description='PROPSX028TEXT',
        width=1,
        height=1,
        margin=0,
        customClass='EnvObjects.FoodReplicator',        
        againstWall=true,
        noRoom=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=50,
        nFoodPrice=1,
        portrait = 'Env_Replicator',
        placeSound = 'placefoodreplicator',
        sidebarIcon = 'icon_replicator',
		nPowerDraw = 20,
		tIconOffset = {-30, 150},
		sFlavorText = 'OBFLAV004TEXT',
		bCanDeactivate = true,
    },
    EmergencyAlarm=
    {
        spriteName='alarm_panel',
        friendlyNameLinecode='PROPSX040TEXT',
        description='PROPSX041TEXT',
        width=1,
        height=1,
        margin=0,
        customClass='EnvObjects.EmergencyAlarm',
        customInspector='EmergencyAlarmControls',
        againstWall=true,
        noRoom=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=50,
        nFoodPrice=0,
        portrait = 'Env_AlarmPanel',
        placeSound = 'placefirepanel',
        sidebarIcon = 'icon_alarm_panel',
		sFlavorText = 'OBFLAV020TEXT',
    },
    OxygenRecycler=
    {
        spriteName='oxygen_recycler',
        zoneName='LIFESUPPORT',
        friendlyNameLinecode='ZONEUI016TEXT',
        description='ZONEUI052TEXT',
        width=1,
        height=1,
        margin=1,
        decayPerSecond=0.06,
        explodeOnFailure=true,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=150,
        -- This gets added to this tile every 1/10 of a second.
        oxygenLevel=50,
        clickSound = 'oxygenrecycler',
        ambientSound = 'oxygenrecyclerloop',
        portrait = 'Env_LifeSupport_OxygenRecycler',
        placeSound = 'placerecycler',
        sidebarIcon = 'icon_oxygen_recycler',
		nPowerDraw = 25,
		tIconOffset = {-10, 140},
		sFlavorText = 'OBFLAV001TEXT',
		bCanDeactivate = true,
    },
    OxygenRecyclerLevel2=
    {
        spriteName='oxygen_recycler_level2',
        zoneName='LIFESUPPORT',
        friendlyNameLinecode='PROPSX062TEXT',
        description='PROPSX063TEXT',
        width=2,
        height=2,
        margin=1,
        decayPerSecond=0.06,
        explodeOnFailure=true,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=150,
        -- This gets added to this tile every 1/10 of a second.
        oxygenLevel=200,
        clickSound = 'oxygenrecycler',
        ambientSound = 'oxygenrecyclerloop',
        portrait = 'Env_LifeSupport_OxygenRecycler2',
        placeSound = 'placerecycler',
        sidebarIcon = 'icon_oxygen_recycler',
		researchPrereq = 'OxygenRecyclerLevel2',
        sFunctionality='OxygenRecycler',
		nPowerDraw = 30,
		tIconOffset = {40, 200},
		sFlavorText = 'OBFLAV002TEXT',
		bCanDeactivate = true,
    },
    AirScrubber=
    {
        spriteName='AirScrubber',
        customClass='EnvObjects.AirScrubber',
        zoneName='LIFESUPPORT',
        friendlyNameLinecode='PROPSX078TEXT',
        description='PROPSX079TEXT',
        width=1,
        height=1,
        margin=1,
        decayPerSecond=0.04,
        explodeOnFailure=true,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        againstWall=false,
		matterCost=300,
        nRange=12,
        portrait = 'Env_AirScrubber',
        placeSound = 'placeoxygenfilter',
		researchPrereq = 'AirScrubber',
        sidebarIcon = 'icon_airscrubber',
		nPowerDraw = 30,
		tIconOffset = {0, 120},
		sFlavorText = 'OBFLAV003TEXT',
		bCanDeactivate = true,
    },
    AirlockLocker=
    {
        spriteName='airlock_locker',
        customClass='EnvObjects.AirlockLocker',
        --spriteNameFlipped='airlock_locker_flipped',
        zoneName='AIRLOCK',
        friendlyNameLinecode='ZONEUI040TEXT',
        description='ZONEUI053TEXT',
        width=1,
        height=1,
        margin=0,
        againstWall=true,
        decayPerSecond=0.001,
        explodeOnFailure=true,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        clickSound = 'spacesuitlocker',
        portrait = 'Env_Airlock_Locker',
		matterCost=50,
        placeSound = 'placespacesuitlocker',
        sidebarIcon = 'icon_airlock_locker',
		sFlavorText = 'OBFLAV021TEXT',
    },
    Bed=
    {
        spriteName='bed',
        zoneName='RESIDENCE',
        additionalZones={BRIG=1,},
        friendlyNameLinecode='ZONEUI044TEXT',
        description='ZONEUI054TEXT',
        width=2,
        height=1,
        margin=1,
        --decayPerSecond=0.005,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        customClass='EnvObjects.Bed',
        bBlocksPathing=true,
        --inherentActivities={ 'SleepInBed', },
        clickSound = 'spacebed',
        portrait = 'Env_Bed',
		matterCost=150,
        placeSound = 'placebed',
        sidebarIcon = 'icon_bed',
        tAnimOffset = {x=55, y=60},
        tAnimOffsetFlipped = {x=55, y=25},
        --animDirFlipped = 'E',
        sFlavorText = 'OBFLAV026TEXT',
    },
    Bar=
    {
        spriteName='bar',
        zoneName='PUB',
        customClass='EnvObjects.Bar',
        friendlyNameLinecode='ZONEUI065TEXT',
        description='ZONEUI066TEXT',
        width=2,
        height=1,
        margin=1,
        decayPerSecond=0.005,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=250,
        portrait = 'Env_Bar',
        placeSound = 'placebar',
        sidebarIcon = 'icon_bar',
        sFlavorText = 'OBFLAV030TEXT',
    },
    Fridge =
    {
        spriteName='fridge',
        interactSprite='fridge_open',
        zoneName='PUB',
        friendlyNameLinecode='PROPSX033TEXT',
        description='PROPSX034TEXT',
        width=1,
        height=1,
        margin=0,
        againstWall=true,
        decayPerSecond=0.002,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=250,
        portrait = 'Env_Pub_Fridge',
        customClass='EnvObjects.Fridge',
        placeSound = 'placefridge',
        sidebarIcon = 'icon_fridge',
        bInventory=true,
        GenerateStartingInventory={tWhitelist={'Corn','Pod','Glowfruit'},tRange={0,2},tStackRange={1,7},},
        nCapacity=7,
		nPowerDraw = 35,
		sFlavorText = 'OBFLAV013TEXT',
		bCanDeactivate = true,
    },
    FridgeLevel2 =
    {
        spriteName='fridge_level2',
        interactSprite='fridge_level2_open',
        zoneName='PUB',
        friendlyNameLinecode='PROPSX069TEXT',
        description='PROPSX068TEXT',
        width=1,
        height=1,
        margin=0,
        againstWall=true,
        decayPerSecond=0.002,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=250,
        portrait = 'Env_Pub_Fridge',
        customClass='EnvObjects.Fridge',
        placeSound = 'placefridge',
        sidebarIcon = 'icon_fridge',
        bInventory=true,
        researchPrereq='FridgeLevel2',        
        nCapacity=15,
        sFunctionality='Fridge',
        GenerateStartingInventory={tWhitelist={'Corn','Pod','Glowfruit'},tRange={0,2},tStackRange={1,7},},
		nPowerDraw = 50,
		sFlavorText = 'OBFLAV014TEXT',
		bCanDeactivate = true,
    },
    Stove=
    {
        spriteName='stove',
        zoneName='PUB',
        friendlyNameLinecode='PROPSX030TEXT',
        description='PROPSX029TEXT',
        width=1,
        height=1,
        margin=0,
        againstWall=false,
        decayPerSecond=0.005,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=250,
        portrait = 'Env_Pub_Stove',
        placeSound = 'placestove',
        sidebarIcon = 'icon_stove',
		nPowerDraw = 30,
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV035TEXT',
    },
	StandingTable=
    {
        spriteName='standing_table',
        zoneName='PUB',
        friendlyNameLinecode='PROPSX031TEXT',
        description='PROPSX032TEXT',
        customClass='EnvObjects.PubTable',
        width=1,
        height=1,
        margin=1,
        bInventory=true,
        decayPerSecond=0.000,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
		matterCost=100,
        portrait = 'Env_Pub_StandingTable',
        placeSound = 'placetable',
        sidebarIcon = 'icon_standingtable',
		sFlavorText = 'OBFLAV005TEXT',
    },     
    RefineryDropoff=
    {
        spriteName='refinery',
        zoneName='REFINERY',
        friendlyNameLinecode='ZONEUI045TEXT',
        description='ZONEUI055TEXT',
        width=2,
        height=2,
        margin=1,
        decayPerSecond=0.005,
        explodeOnFailure=true,
        customClass='EnvObjects.RefineryDropoff',
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        --inherentActivities={ 'DropOffRocks', },
        clickSound = 'spacebed',
        ambientSound = 'refineryloop',
		matterCost=200,
        portrait = 'Env_Refinery',
        placeSound = 'placerefinery',
        sidebarIcon = 'icon_refinery',
		nPowerDraw = 40,
		tIconOffset = {60, 170},
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV032TEXT',
    },
    RefineryDropoffLevel2=
    {
        spriteName='refinery_level2',
        zoneName='REFINERY',
        friendlyNameLinecode='PROPSX066TEXT',
        description='PROPSX067TEXT',
        width=2,
        height=2,
        margin=1,
        decayPerSecond=0.005,
        explodeOnFailure=true,
        customClass='EnvObjects.RefineryDropoff',
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        --inherentActivities={ 'DropOffRocks', },
        clickSound = 'spacebed',
        ambientSound = 'refineryloop',
		matterCost=400,
        portrait = 'Env_Refinery',
        placeSound = 'placerefinery',
        sidebarIcon = 'icon_refinery',
        researchPrereq='RefineryDropoffLevel2',
        sFunctionality='RefineryDropoff',
		nPowerDraw = 50,
		tIconOffset = {60, 170},
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV033TEXT',
    },
    HousePlant=
    {
        spriteName='residence_houseplant',
        friendlyNameLinecode='ZONEUI059TEXT',
        description='ZONEUI060TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
		matterCost=150,
        portrait = 'Env_Plant_01',
        placeSound = 'placeplant',
        sidebarIcon = 'icon_plant',
		-- plants generate small amounts of oxygen
		-- (amount added to tile every 1/10 of a second)
		oxygenLevel=5,
		nMoraleScore=3,
		sFlavorText='OBFLAV015TEXT',
    },
    Dresser=
    {
        spriteName='residence_dresser01',
        friendlyNameLinecode='ZONEUI061TEXT',
        description='ZONEUI062TEXT',
        --zoneName='RESIDENCE',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
		matterCost=125,
        portrait = 'Env_Residence_Dresser',
        placeSound = 'placedresser',
        sidebarIcon = 'icon_dresser',
		nMoraleScore=1,
        bInventory=true,
		sFunctionality='Shelving',
		sFlavorText='OBFLAV023TEXT',
        GenerateStartingInventory={bStuff=true,tRange={0,2}},
        tDisplaySlots=
        {
            --{x=-64,y=50,z=10},
            --{x=-32,y=64,z=5},
            {x=-155,y=-12,z=10},
            {x=-125,y=3,z=5},
        },
    },
    WallShelf=
    {
        spriteName='ShelvesWallStack',
        spriteOffsetX=-15,
        spriteOffsetXFlipped=15,
        friendlyNameLinecode='PROPSX092TEXT',
        description='PROPSX093TEXT',
        --zoneName='RESIDENCE',
        width=1,
        height=1,
        margin=0,
        againstWall=true,
        noRoom=true,
        decayPerSecond=0,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=100,
        portrait = 'Env_Shelf',
        placeSound = 'placedresser',
        sidebarIcon = 'icon_shelf',
		nMoraleScore=1,
        bInventory=true,
		sFunctionality='Shelving',
        GenerateStartingInventory={bStuff=true,tRange={0,2}},
        tDisplaySlots=
        {
            {x=-183,y=-14,z=6},
            {x=-153,y=1,z=3},
            {x=-183,y=44,z=12},
            {x=-153,y=59,z=9},
        },
    },
    TVScreen1=
    {
        spriteName='tv_screen01',
        friendlyNameLinecode='PROPSX003TEXT',
        description='PROPSX004TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
        againstWall=true,
		matterCost=75,
        portrait = 'Env_TVScreen',
        placeSound = 'placemonitor',
        sidebarIcon = 'icon_tv_screen',
		nMoraleScore=1,
		nPowerDraw = 10,
		bCanDeactivate = true,
		sFlavorText = 'OBFLAV028TEXT',
    },
    BurgerSign=
    {
        spriteName='dec_wall_neon_burger',
        friendlyNameLinecode='PROPSX007TEXT',
        description='PROPSX008TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        zoneName='PUB',
        againstWall=true,
		matterCost=225,
        portrait = 'Env_Bar_NeonBurger',
        placeSound = 'placeneon',
        sidebarIcon = 'icon_wall_neon_burger',
        bIgnoreLighting=true,
		nMoraleScore=2,
		nPowerDraw = 5,
		sFlavorText = 'OBFLAV010TEXT',
    },
    PizzaSign=
    {
        spriteName='dec_wall_neon_pizza',
        friendlyNameLinecode='PROPSX011TEXT',
        description='PROPSX012TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        zoneName='PUB',
        againstWall=true,
		matterCost=150,
        portrait = 'Env_Bar_NeonPizza',
        placeSound = 'placeneon',
        sidebarIcon = 'icon_wall_neon_pizza',
		nMoraleScore=2,
        bIgnoreLighting=true,
		nPowerDraw = 5,
		sFlavorText = 'OBFLAV011TEXT',
    },
    FriesSign=
    {
        spriteName='dec_wall_neon_fries',
        friendlyNameLinecode='PROPSX009TEXT',
        description='PROPSX010TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        zoneName='PUB',
        againstWall=true,
		matterCost=75,
        portrait = 'Env_Bar_NeonFries',
        placeSound = 'placeneon',
        sidebarIcon = 'icon_wall_neon_fries',
		nMoraleScore=2,
        bIgnoreLighting=true,
		nPowerDraw = 5,
		sFlavorText = 'OBFLAV012TEXT',
    },
    Rug1=
    {
        spriteName='residence_rug01',
        friendlyNameLinecode='ZONEUI063TEXT',
        description='ZONEUI064TEXT',
        width=1,
        height=1,
        margin=0,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        noRoom=true,
        zoneName='RESIDENCE',
		matterCost=50,
        portrait = 'Env_Rug',
        placeSound = 'placerug',
        sidebarIcon = 'icon_rug',
		nMoraleScore=2,
        bHelpsMorale=true,
        bSortBack=true,
		sFlavorText = 'OBFLAV008TEXT',
    },
    BaseSeed=
    {
        spriteName='seedpod01',
        friendlyNameLinecode='PROPSX005TEXT',
        description='PROPSX006TEXT',
		bCanBuildInSpace=true,
        width=2,
        height=3,
        noRoom=true,
        bBlocksPathing=true,
        clickSound = 'fusionreactor',
        showInObjectMenu=false,
		matterCost=500,
        portrait = 'Env_SeedPod',
		nMoraleScore=10,
		nPowerOutput = 500,
        nSabotageDuration = 30,
		sFlavorText = 'OBFLAV027TEXT',
    },
    HydroPlant=
    {
        spriteName='hydro_farm',
        zoneName='GARDEN',
        friendlyNameLinecode='PROPSX025TEXT',
        description='PROPSX026TEXT',
        width=1,
        height=1,
        margin=1,
        customClass='EnvObjects.HydroPlant',
        decayPerSecond=0, -- the planter itself doesn't deteriorate
        healthdecayPerSecond=0.001,
        maintainJob=Character.BOTANIST,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        portrait = 'Env_Plant_Tray',
		matterCost=150,
        placeSound = 'placehydroplant',
        sidebarIcon = 'icon_plant_tray',
		-- plants generate small amounts of oxygen
		-- (amount added to tile every 1/10 of a second)
		oxygenLevel=10,
		nMoraleScore=4,
		sFlavorText = 'OBFLAV034TEXT',
    },
    WeightBench=
    {
        spriteName='weightbench',
		interactSprite='weightbench_inuse',
        zoneName='FITNESS',
        additionalZones={BRIG=1,},
        friendlyNameLinecode='PROPSX046TEXT',
        description='PROPSX047TEXT',
        width=2,
        height=1,
        margin=1,
        customClass='EnvObjects.WeightBench',
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        inherentActivities={ 'LiftAtWeightBench', },
        clickSound = 'fusionreactor',
		matterCost=100,
        portrait = 'Env_WeightBench',
        sidebarIcon = 'icon_weightbench',
        tAnimOffset = {x=25, y=45},
        tAnimOffsetFlipped = {x=45, y=25},
		sFlavorText = 'OBFLAV009TEXT',
    },
    ResearchDesk=
    {
        spriteName='research_desk',
        zoneName='RESEARCH',
        customClass='EnvObjects.ResearchDesk',
        friendlyNameLinecode='PROPSX060TEXT',
        description='PROPSX061TEXT',
        width=2,
        height=1,
        margin=1,
        decayPerSecond=0.005,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        explodeOnFailure=true,
        bBlocksPathing=true,
        --inherentActivities={ 'ResearchInLab', },
        clickSound = 'spacebed',
        portrait = 'Env_Research_Desk',
		matterCost=300,
        placeSound = 'placebed',
        sidebarIcon = 'icon_research_desk',
		nPowerDraw = 50,
		sFlavorText = 'OBFLAV006TEXT',
		bCanDeactivate = true,
    },
	WallMountedTurret=
    {
        spriteName='turret_frames0003',
        spriteOffsetX=-110,
        spriteOffsetXFlipped=-20,
        customClass='EnvObjects.Turret',
        friendlyNameLinecode='PROPSX084TEXT',
        description='PROPSX074TEXT',
        width=1,
        height=1,
        margin=1,
        againstWall=true,
        bCanFlipY=true,
        noRoom=true,
		bCanBuildInSpace=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        explodeOnFailure=true,
        customInspector='TurretControls',
        clickSound = 'spacebed',
        portrait = 'Env_TurretExt',
		matterCost=300,
        placeSound = 'placebed',
        sidebarIcon = 'icon_turret_ext',
		nPowerDraw = 150,
		bCanDeactivate = true,
		sFunctionality='Turret',
		sFlavorText = 'OBFLAV017TEXT',
    },
	WallMountedTurret2=
    {
        spriteName='turret_lv2_frames0003',
        spriteOffsetX=-110,
        spriteOffsetXFlipped=-20,
        customClass='EnvObjects.TurretLv2',
        friendlyNameLinecode='PROPSX080TEXT',
        description='PROPSX081TEXT',
        width=1,
        height=1,
        margin=1,
        againstWall=true,
        bCanFlipY=true,
        noRoom=true,
		bCanBuildInSpace=true,
        --decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        explodeOnFailure=true,
        customInspector='TurretControls',
        clickSound = 'spacebed',
        portrait = 'Env_TurretExtLv2',
		matterCost=600,
        placeSound = 'placebed',
        sidebarIcon = 'icon_turret_ext_lv2',
        researchPrereq='WallMountedTurret2',
		nPowerDraw = 200,
		bCanDeactivate = true,
		sFunctionality='Turret',
		sFlavorText = 'OBFLAV024TEXT',
    },
    --[[
	InteriorTurret=
    {
        spriteName='turret_frames0003',
        spriteOffset=-128,
        customClass='EnvObjects.Turret',
        friendlyNameLinecode='PROPSX073TEXT',
        description='PROPSX074TEXT',
        width=1,
        height=1,
        margin=1,
        againstWall=true,
        noRoom=true,
        --decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        explodeOnFailure=true,
        clickSound = 'spacebed',
        portrait = 'Env_TurretExt',
		matterCost=300,
        placeSound = 'placebed',
        sidebarIcon = 'icon_turret_ext',
    },
    ]]--
    HospitalBed=
    {
        spriteName='hospital_bed',
        interactSprite='hospital_bed_occupied',
        customClass='EnvObjects.HospitalBed',
        zoneName='INFIRMARY',
        friendlyNameLinecode='PROPSX076TEXT',
        description='PROPSX077TEXT',
        width=2,
        height=1,
        margin=1,
        customInspector='InfirmaryBedControls',
        decayPerSecond=0.005,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=true,
        --inherentActivities={ 'SleepInBed', },
        clickSound = 'spacebed',
        portrait = 'Env_HospitalBed',
		matterCost=400,
        placeSound = 'placebed',
        sidebarIcon = 'icon_hospital_bed',
        tAnimOffset = {x=55, y=60},
        tAnimOffsetFlipped = {x=55, y=25},
		nPowerDraw = 30,
		tIconOffset = {0, 150},
		bCanDeactivate = true,
        sFlavorText = 'OBFLAV031TEXT',
    },
	-- Malero EnvObject Mod
	KillbotController=
    {
        spriteName='alarm_panel',
        friendlyNameLinecode='MALEROPROP0001TEXT',
        description='MALEROPROP0001DESC',
        width=1,
        height=1,
        margin=0,
        customClass='EnvObjects.KillbotController',
        customInspector='KillbotControllerControls',
        againstWall=true,
        noRoom=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=50,
        nFoodPrice=0,
        portrait = 'Env_AlarmPanel',
        placeSound = 'placefirepanel',
        sidebarIcon = 'icon_alarm_panel',
		sFlavorText = 'MALEROPROP0001FLAVTEXT',
    },
	ImmigrantTransmitter=
    {
        spriteName='alarm_panel',
        friendlyNameLinecode='MALEROPROP0002TEXT',
        description='MALEROPROP0002DESC',
        width=1,
        height=1,
        margin=0,
        customClass='EnvObjects.ImmigrantTransmitter',
        customInspector='ImmigrantTransmitterControls',
        againstWall=true,
        noRoom=true,
        decayPerSecond=0.001,
        maintainJob=Character.TECHNICIAN,
        createJob=Character.BUILDER,
        bBlocksPathing=false,
        clickSound = 'spacesuitlocker',
		matterCost=50,
        nFoodPrice=0,
        portrait = 'Env_AlarmPanel',
        placeSound = 'placefirepanel',
        sidebarIcon = 'icon_alarm_panel',
		sFlavorText = 'MALEROPROP0002FLAVTEXT',
    },
}
EnvObjectData.tAliases=
{
    Fridge_level2='FridgeLevel2',
    tvScreen1='TVScreen1',
    burgerSign='BurgerSign',
    pizzaSign='PizzaSign',
    friesSign='FriesSign',
}

return EnvObjectData
