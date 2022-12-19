require "math"

local function CartozoidEveryTenMinutes()

    local playerX = math.floor(cartozoidPlayer:getX());
    local playerY = math.floor(cartozoidPlayer:getY());
    local deltaX = math.abs(playerX - cartozoidPlayerLastX);
    local deltaY = math.abs(playerY - cartozoidPlayerLastY);
    local totalDelta = math.sqrt(deltaX^2 + deltaY^2)

    if totalDelta > POSITION_CHANGE_TOLERANCE then
        local timestamp = getGametimeTimestamp();
        local fileWriter = getFileWriter(cartozoidPlayer:getDescriptor():getForename().."_"..cartozoidPlayer:getDescriptor():getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
        fileWriter:writeln(timestamp..";"..playerX..";"..playerY..";;")
        fileWriter:close()
        cartozoidPlayerLastX = playerX;
        cartozoidPlayerLastY = playerY;
    end

    if cartozoidPlayer:isAsleep() then
        -- Player is asleep
        print("Cartozoid: Player is asleep")
        if not cartozoidSleepEventHasBeenLogged then
            -- We have not logged the sleep event
            local timestamp = getGametimeTimestamp();
            local fileWriter = getFileWriter(cartozoidPlayer:getDescriptor():getForename().."_"..cartozoidPlayer:getDescriptor():getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
            fileWriter:writeln(timestamp..";"..playerX..";"..playerY..";1;");
            fileWriter:close();
            -- Sleep event logged, make sure it doesn't log again
            cartozoidSleepEventHasBeenLogged = true;
            -- Now we have to check every ten minutes if the player woke up, and log that
            cartozoidWakeUpEventHasBeenLogged = false;
        end
    elseif not cartozoidWakeUpEventHasBeenLogged then
        -- Player is not asleep, but the wakeup event hasnot been logged
        local timestamp = getGametimeTimestamp() - 600; -- Subtract 10 minutes because the player actually woke up at the last 10 minute interval
        local fileWriter = getFileWriter(cartozoidPlayer:getDescriptor():getForename().."_"..cartozoidPlayer:getDescriptor():getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
        fileWriter:writeln(timestamp..";"..playerX..";"..playerY..";2;");
        fileWriter:close();
        -- Wakeup event logged, make sure it doesn't log again
        cartozoidWakeUpEventHasBeenLogged = true;
        -- Now we have to check every ten minutes if the player has gone to sleep again
        cartozoidSleepEventHasBeenLogged = false;
    end
        

end

Events.EveryTenMinutes.Add(CartozoidEveryTenMinutes);
