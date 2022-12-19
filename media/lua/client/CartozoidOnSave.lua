local function CartozoidOnSave()

    ---- Flush current dead zombies (otherwise they only write the next time a player kills another zombie)
    --local timestamp = getGametimeTimestamp();
    --local fileWriter = getFileWriter(cartozoidPlayer:getForname().."_"..cartozoidPlayer:getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
    --fileWriter:writeln(timestamp..";"..zombieX..";"..zombieY..";0;"..#cartozoidDeadZombies)
    --fileWriter:close()

end

Events.OnSave.Add(CartozoidOnSave)