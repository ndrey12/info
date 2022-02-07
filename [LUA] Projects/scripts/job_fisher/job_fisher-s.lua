local fish_weight = {}
local is_fishing = {}

AddEventHandler('playerDropped', function (reason)
    local player_src = source
    fish_weight[player_src] = 0
    is_fishing[player_src] = nil
end)
RegisterNetEvent("job_fisher-s::resetFishWeight")
AddEventHandler("job_fisher-s::resetFishWeight", function(source)
    fish_weight[source] = 0
    is_fishing[source] = nil
end)
function GivePlayerFish(source)
    Wait(30000)
    if(is_fishing[source] ~= nil and fish_weight[source] == 0) then
        ClearPedTasks(GetPlayerPed(source))
        is_fishing[source] = nil
        local fish = math.random(0,1)
        if(fish == 1) then
            local greutate = math.random(500, 5000)
            fish_weight[source] = greutate
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai prins un peste de ^4" .. greutate .. "g ^7.")
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^4Ghinion! ^7Nu ai prins nimic.")
        end
    end
end
RegisterCommand("fish", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 6) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local x = -1849.8330078125
        local y = -1249.8461914063
        local z = 8.6051025390625
        local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
        if(distance <= 5) then
            if(fish_weight[source] ~= 0) then
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai prins deja un peste. Du-te la un magazin pentru a vinde pestele folosind comanda ^4/sellfish^7.")
            else
                if(is_fishing[source] == nil) then
                    is_fishing[source] = 1
                    TriggerClientEvent("job_fisher-c::PlayAnimation", source)
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai inceput sa pescuiesti.")
                    GivePlayerFish(source)
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Pescuiesti deja.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Fisher.")
    end
end, false)
RegisterCommand("sellfish", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 6) then
        if(exports.sis_business:IsPlayerAtWorkingPoint(source, 2) ~= 1) then
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        else
            if(fish_weight[source] == 0) then
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu mai ai pesti.")
            else
                local money = fish_weight[source]
                fish_weight[source] = 0
                local player_money = exports.playerdata:getMoney(source) + money
                exports.playerdata:setMoney(source, player_money)
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai primit ^4" .. money .. "$ ^7.")
                exports.playerdata:updateMoney(source)
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Fisher.")
    end
end, false)
