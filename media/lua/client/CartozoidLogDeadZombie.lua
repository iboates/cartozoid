local function OnZombieDead(zombie)

    local timestamp = getGametimeTimestamp();
    local zombieX = math.floor(zombie:getX());
    local zombieY = math.floor(zombie:getY());
    local deadZombie = {["x"]=zombieX, ["y"]=zombieY, ["t"]=timestamp}
    local minutesSinceLastDeadZombie = (timestamp - cartozoidLastZombieDeath) / 60 -- convert seconds to minutes

    if cartozoidLastZombieDeath == nil or minutesSinceLastDeadZombie < NUM_GAME_MINUTES_BEFORE_RESETTING_ZOMBIE_KILL_COUNTER then
        table.insert(cartozoidDeadZombies, deadZombie); 
    else
        local fileWriter = getFileWriter(cartozoidPlayer:getDescriptor():getForename().."_"..cartozoidPlayer:getDescriptor():getSurname().."_"..cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
        -- todo: calculate average position of all dead zombies
        -- todo: use time of last dead zombie, not the timestamp (because it is actually the first one from the new group)
        fileWriter:writeln(timestamp..";"..zombieX..";"..zombieY..";0;"..#cartozoidDeadZombies)
        fileWriter:close()
        cartozoidDeadZombies = {deadZombie}
    end
    cartozoidLastZombieDeath = timestamp

end

Events.OnZombieDead.Add(OnZombieDead)