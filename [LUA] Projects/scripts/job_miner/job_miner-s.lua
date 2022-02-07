local deliver_timer = {}

RegisterCommand("mine", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 4) then
        if(deliver_timer[source] == nil) then
            TriggerClientEvent("job_miner-c::startMining", source)
            deliver_timer[source] = 0
        elseif(deliver_timer[source] == 0) then
            TriggerClientEvent("job_miner-c::startMining", source)
            deliver_timer[source] = os.time()
        elseif(deliver_timer[source] + 120 < os.time()) then
            TriggerClientEvent("job_miner-c::startMining", source)
            deliver_timer[source] = nil
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Trebuie sa astepti 2 minute pentru a putea refolosi comanda.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Miner")
    end
end, false)

RegisterNetEvent("job_miner-s::PlayerAtLocation")
AddEventHandler("job_miner-s::PlayerAtLocation", function(source)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 4) then
        FreezeEntityPosition(GetPlayerPed(source), true)
        TriggerClientEvent("job_miner-c::PlayAnimation", source)
        Wait(10000)
        FreezeEntityPosition(GetPlayerPed(source), false)
        TriggerClientEvent("job_miner-c::TurnOffMining", source)
        local player_money = exports.playerdata:getMoney(source)
        local reward = math.random(0,200)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai gasit zacaminte in valoare de ^3" .. reward .. "^7 $.")
        exports.playerdata:setMoney(source, player_money+reward)
        exports.playerdata:updateMoney(source)
        if(deliver_timer[source] ~= nil and deliver_timer[source] == 0) then
            TriggerClientEvent("job_miner-c::TurnOnMining", source)
        end
        ClearPedTasks(GetPlayerPed(source))
    else
        TriggerClientEvent("job_miner-c::TurnOffMining", source)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Miner.")
        deliver_timer[source] = os.time()
    end
end)