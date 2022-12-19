local function CartozoidOnCreatePlayer(playerIndex, player)

    -- TODO: when all is said and done, make fileWriter a global object
    -- TODO: add metadata block to file for first-time write

    -- Mod params
    POSITION_CHANGE_TOLERANCE = 5                             -- Number of tiles a player has to move before logging a new player position
    NUM_GAME_MINUTES_BEFORE_RESETTING_ZOMBIE_KILL_COUNTER = 10 -- Number of (real-world) seconds before registering zombie deaths as a new loggable event

    -- Globals
    cartozoidPlayer = player;
    cartozoidPlayerModData = cartozoidPlayer:getModData();

    cartozoidPlayerLastX = math.floor(cartozoidPlayer:getX());
    cartozoidPlayerLastY = math.floor(cartozoidPlayer:getY());

    cartozoidLastZombieDeath = 0;
    cartozoidDeadZombies = {}

    cartozoidSleepEventHasBeenLogged = false;
    cartozoidWakeUpEventHasBeenLogged = true; -- If this gets initialized to false then a wakeup event gets logged every time the game starts

    if not cartozoidPlayerModData.CartozoidUUID then
        cartozoidPlayerModData.CartozoidUUID = getRandomUUID();
    end
    --local fileWriter = getFileWriter(cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
    local fileWriter = getFileWriter(cartozoidPlayer:getDescriptor():getForename().."_"..cartozoidPlayer:getDescriptor():getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
    fileWriter:close()
end

Events.OnCreatePlayer.Add(CartozoidOnCreatePlayer);
