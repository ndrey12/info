local deliver_timer = {}

RegisterCommand("build", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 5) then
        if(deliver_timer[source] == nil) then
            TriggerClientEvent("job_constructor-c::startBuilding", source)
            deliver_timer[source] = 0
        elseif(deliver_timer[source] == 0) then
            TriggerClientEvent("job_constructor-c::startBuilding", source)
            deliver_timer[source] = os.time()
        elseif(deliver_timer[source] + 120 < os.time()) then
            TriggerClientEvent("job_constructor-c::startBuilding", source)
            deliver_timer[source] = nil
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Trebuie sa astepti 2 minute pentru a putea refolosi comanda.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Constructor")
    end
end, false)
RegisterNetEvent("job_constructor-s::PlayerAtLocation")
AddEventHandler("job_constructor-s::PlayerAtLocation", function(source)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 5) then
        FreezeEntityPosition(GetPlayerPed(source), true)
        TriggerClientEvent("job_constructor-c::PlayAnimation", source)
        Wait(10000)
        FreezeEntityPosition(GetPlayerPed(source), false)
        TriggerClientEvent("job_constructor-c::TurnOffBuilding", source)
        local player_money = exports.playerdata:getMoney(source)
        local reward = math.random(0,150)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Seful te-a platit cu ^3" .. reward .. "^7 $ pentru munca depusa.")
        exports.playerdata:setMoney(source, player_money+reward)
        exports.playerdata:updateMoney(source)
        if(deliver_timer[source] ~= nil and deliver_timer[source] == 0) then
            TriggerClientEvent("job_constructor-c::TurnOnBuilding", source)
        end
        ClearPedTasks(GetPlayerPed(source))
    else
        TriggerClientEvent("job_constructor-c::TurnOffBuilding", source)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Constructor.")
        deliver_timer[source] = os.time()
    end
end)