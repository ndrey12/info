local faina = {}
local is_farming = {}
local time_left = {}
local farming_net_vehid = {}
local speed = {}
function StopFarming(source, type) -- type = 1 (a terminat de farmat corect) = 2 a iesit din tractor/altcv
    is_farming[source] = nil
    time_left[source] = 0
    if(type == 1) then
        local greutate = math.random(1000, 10000)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai primit ^3" .. greutate .. "g ^7 de faina. Du-te la un magazin si vinde-o.")
        faina[source] = greutate
    end
    print(farming_net_vehid[source])
    local netid = farming_net_vehid[source] 
    farming_net_vehid[source] = nil
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    Wait(100)
    DeleteEntity(vehicle)
end
---daca se mai afla jucatorul in vehicul
---daca mai exista tractorul
---sa il sterg daca isi ia destroy
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    faina[player_src] = 0
    is_farming[player_src] = nil
    speed[player_src] = 0
end)
RegisterNetEvent("job_farmer-s::reset")
AddEventHandler("job_farmer-s::reset", function(source)
    faina[source] = 0
    is_farming[source] = nil
    speed[source] = 0
end)
function StartFarming(source)
    is_farming[source] = 1
    time_left[source] = 180
    TriggerClientEvent("job_farmer-c::StartFarming", source)
end
RegisterCommand("farm", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 7) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local x = 2878.8923339844
        local y = 4490.7954101563
        local z = 48.151611328125
        local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
        if(distance <= 5) then
            if(faina[source] ~= 0) then
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Du-te la un magazin pentru a vinde faina folosind comanda ^4/vindefaina^7.")
            else
                if(is_farming[source] == nil) then
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai inceput sa muncesti.")
                    StartFarming(source)
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^Muncesti deja.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Farmer.")
    end
end, false)
RegisterCommand("vindefaina", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 7) then
        if(exports.sis_business:IsPlayerAtWorkingPoint(source, 2) ~= 1) then
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        else
            if(faina[source] == 0) then
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu mai ai faina.")
            else
                local money = faina[source]
                faina[source] = 0
                local player_money = exports.playerdata:getMoney(source) + money
                exports.playerdata:setMoney(source, player_money)
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai primit ^4" .. money .. "$ ^7.")
                exports.playerdata:updateMoney(source)
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Farmer.")
    end
end, false)
RegisterNetEvent("job_farmer-s::updateData")
AddEventHandler("job_farmer-s::updateData", function(source, tractor_speed, player_veh_netid)
    if(is_farming[source] ~= nil) then
        if(farming_net_vehid[source] ~= nil and farming_net_vehid[source] ~= player_veh_netid) then
            StopFarming(source, 2)
        end
        speed[source] = tractor_speed
    end
    TriggerClientEvent("job_farmer-c::updateData", source, is_farming[source], time_left[source])
end)
RegisterNetEvent("job_farmer-s::VehicleSpawned")
AddEventHandler("job_farmer-s::VehicleSpawned", function(source, vehid)
    farming_net_vehid[source] = vehid
end)
function distanceFarm ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end
Citizen.CreateThread(function()
    while true do
        for _, player_src in ipairs(GetPlayers()) do
            local source = tonumber(player_src)
            if(is_farming[source] ~= nil) then
                if(exports.playerdata:getJob(source) == 7) then
                    local veh_id = NetworkGetEntityFromNetworkId(farming_net_vehid[source])
                    local player_pos = GetEntityCoords(GetPlayerPed(source))
                    if(speed[source] >= 15 and distanceFarm(player_pos.x, player_pos.y, 2858.3999023438, 4633.0288085938) <= 100) then
                        time_left[source] = time_left[source] - 1
                        if(time_left[source] <= 0) then
                            StopFarming(source, 1)
                        end
                    end
                else
                    StopFarming(source, 2)
                    --- nu mai e farmer dar are tractor spawnat
                end
            end
        end
        Wait(1000)
    end
end)