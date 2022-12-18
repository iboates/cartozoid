local function OnZombieDead(zombie)

    -- todo: use game time intervals instead of real time
    local timestamp = getTimestamp();
    print("Cartozoid zombie killed at:");
    print(timestamp);
    print("Cartozoid game timestamp:");
    print(getGametimeTimestamp());
    print(getGameTime());
    zombieX = math.floor(zombie:getX());
    zombieY = math.floor(zombie:getY());
    local deadZombie = {["x"]=zombieX, ["y"]=zombieY, ["t"]=getGametimeTimestamp()}

    if cartozoidLastZombieDeath == nil or timestamp - cartozoidLastZombieDeath < NUM_REAL_SECONDS_BEFORE_RESTARTING_ZOMBIE_DEATH_COUNT then
        table.insert(cartozoidDeadZombies, deadZombie); 
    else
        local fileWriter = getFileWriter(cartozoidPlayerModData.CartozoidUUID..".txt", true, true);
        -- todo: calculate average position of all dead zombies
        fileWriter:writeln(zombieX..";"..zombieY..";0;"..#cartozoidDeadZombies)
        fileWriter:close()
        cartozoidDeadZombies = {deadZombie}
    end
    cartozoidLastZombieDeath = timestamp

end

Events.OnZombieDead.Add(OnZombieDead)