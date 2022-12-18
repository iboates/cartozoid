local function CartozoidOnCreatePlayer(playerIndex, player)

    -- Mod params
    POSITION_CHANGE_TOLERANCE = 50                             -- Number of tiles a player has to move before logging a new player position
    NUM_REAL_SECONDS_BEFORE_RESTARTING_ZOMBIE_DEATH_COUNT = 10 -- Number of (real-world) seconds before registering zombie deaths as a new loggable event

    -- Globals
    cartozoidPlayer = player;
    cartozoidPlayerModData = cartozoidPlayer:getModData();

    cartozoidPlayerLastX = math.floor(cartozoidPlayer:getX());
    cartozoidPlayerLastY = math.floor(cartozoidPlayer:getY());

    cartozoidLastZombieDeath = nil;
    cartozoidDeadZombies = {}

    if not cartozoidPlayerModData.CartozoidUUID then
        cartozoidPlayerModData.CartozoidUUID = getRandomUUID();
    end
    local fileWriter = getFileWriter(cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
    fileWriter:close()
end

Events.OnCreatePlayer.Add(CartozoidOnCreatePlayer);
