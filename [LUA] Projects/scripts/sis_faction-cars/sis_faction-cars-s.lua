local faction_car_name = {}
local faction_car_hash = {}
local faction_car_factionid = {}
local faction_car_rank = {}
local faction_cars = 0
local faction_max_number = {}
local fc_name = {}
local fc_hash = {}
local fc_rank = {}
local fc_index = {}
-------------------------------------
local faction_garage_x = {}
local faction_garage_y = {}
local faction_garage_z = {}
local faction_garages = 0
-------------------------------------
local car_ownerid = {}
local car_netid_to_index = {}
local car_free_index = {}
local car_netid = {}
local car_timer = {}
local car_faction = {}
local player_sqld_to_index = {}
-------------------------------------
function GetVehicleFreeId()
    local i = 1
    while(car_free_index[i] ~= nil) do
        i = i + 1
    end
    return i
end

Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM faction_cars", {}, 
    function(result)
        faction_cars = tonumber(#result)
        for i = 1, #result do
            faction_car_name[i] = result[i].name
            faction_car_hash[i] = result[i].hash
            faction_car_factionid[i] = result[i].factionid
            faction_car_rank[i] = result[i].rank
        end
        print("[FACTION CARS]: loaded " .. faction_cars .. " cars")
        p:resolve(true)
    end)
    Citizen.Await(p)
    for i = 1, 7 do
        faction_max_number[i] = 0
        fc_name[i]   = {}
        fc_hash[i]   = {}
        fc_rank[i]   = {}
        fc_index[i]  = {}
    end
    for i = 1, faction_cars do
        local factionid = faction_car_factionid[i]
        faction_max_number[factionid] = faction_max_number[factionid] + 1
        local index = faction_max_number[factionid]
        fc_name[factionid][index]   = faction_car_name[i]
        fc_hash[factionid][index]   = faction_car_hash[i]
        fc_rank[factionid][index]   = faction_car_rank[i]
        fc_index[factionid][index]  = i
    end
    p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM faction_garages", {}, 
    function(result)
        faction_garages = tonumber(#result)
        for i = 1, #result do
            faction_garage_x[i] = result[i].x
            faction_garage_y[i] = result[i].y
            faction_garage_z[i] = result[i].z
        end
        print("[FACTION GRAGES]: loaded " .. faction_cars .. " garages")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)
RegisterCommand("addcartofaction", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 4) then
            TriggerClientEvent("chatMessage", source, "^1/addcartofaction", {0,0,0}, "^7 <faction> <rank> <hash_key> <name>")
        else
            local factionid = tonumber(args[1])
            local rank = tonumber(args[2])
            if(factionid == nil or rank == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addcartofaction", {0,0,0}, "^7 <faction> <rank> <hash_key> <name>")
            else
                local hash_key = args[3]
                local car_name = args[4]
                for i=5, #args do
                    car_name = car_name .. " " .. args[i]
                end
                exports.ghmattimysql:execute("INSERT INTO `faction_cars`(`name`, `hash`, `factionid`, `rank`) VALUES (@name,@hash,@factionid,@rank)", {['@name'] = car_name, ['@hash'] = hash_key, ['@factionid'] = factionid, ['@rank'] = rank})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Masina adaugata cu succes la factiunea cu numarul " .. factionid)
            end
        end
    end
end, false)
RegisterCommand("addfactiongarage", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/addfactiongarage", {0,0,0}, "^7 <faction>")
        else
            local factionid = tonumber(args[1])
            if(factionid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addfactiongarage", {0,0,0}, "^7 <faction>")
            else
                local player_pos = GetEntityCoords(GetPlayerPed(source))
                exports.ghmattimysql:execute("INSERT INTO `faction_garages`(`factionid`, `x`, `y`, `z`) VALUES (@factionid,@x,@y,@z)", {['@factionid'] = factionid, ['@x'] = player_pos.x, ['@y'] = player_pos.y, ['@z'] = player_pos.z})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^Garaj adaugata cu succes la factiunea cu numarul " .. factionid)
            end
        end
    end
end, false)
RegisterCommand("fcar", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local index = 0
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        for i = 1, faction_garages do
            if(exports.playerdata:CheckDistance(5, player_pos.x, player_pos.y, player_pos.z, faction_garage_x[i], faction_garage_y[i], faction_garage_z[i]) == true) then
                index = i
                break
            end
        end
        if(index == 0) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu esti la locatia potrivita!")
        else
            local player_dbid = exports.playerdata:getSqlID(source)
            if(player_sqld_to_index[player_dbid] ~= nil) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai deja o masina de la factiune spawnata! Foloseste comanda ^4/fcd ^7pentru a o sterge.")
            else
                local player_rank = exports.playerdata:getFactionRank(source)
                TriggerClientEvent("sis_faction-cars-c::enableMenu", source, faction, player_rank, faction_max_number[faction], fc_name[faction], fc_hash[faction], fc_rank[faction],  faction_garage_x[index], faction_garage_y[index], faction_garage_z[index])
            end
        end
    end
end, false)
RegisterNetEvent("sis_faction-cars-s::updateGarages")
AddEventHandler("sis_faction-cars-s::updateGarages", function(source)
    TriggerClientEvent("sis_faction-cars-c::updateGarages", source, faction_garages, faction_garage_x, faction_garage_y, faction_garage_z)
end)
RegisterNetEvent("sis_faction-cars-s::updateMenu")
AddEventHandler("sis_faction-cars-s::updateMenu", function(source)
    local player_faction = exports.playerdata:getFaction(source)
    local player_faction_rank = exports.playerdata:getFactionRank(source)
    TriggerClientEvent("sis_faction-cars-c::updateMenu", source, player_faction, player_faction_rank)
end)
RegisterNetEvent("sis_faction-cars-s::VehicleSpawned")
AddEventHandler("sis_faction-cars-s::VehicleSpawned", function(source, veh_netid, faction)
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(veh_netid), GetPlayerRoutingBucket(source))
    local index = GetVehicleFreeId()
    car_free_index[index] = 1
    local player_dbid = exports.playerdata:getSqlID(source)
    car_ownerid[index] = player_dbid
    car_netid_to_index[veh_netid] = index
    local cTime = os.time() + 60
    car_timer[index] = cTime
    car_netid[index] = veh_netid
    car_faction[index] = faction
    player_sqld_to_index[player_dbid] = index
end)
local currentTime = os.time()
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
        currentTime = os.time()
        local vehs = {}
        vehs = GetAllVehicles()
        for i = 1, #vehs do
            local netid = NetworkGetNetworkIdFromEntity(vehs[i])
            if(car_netid_to_index[netid] ~= nil) then
                local index = car_netid_to_index[netid]
                if(car_timer[index] ~= nil) then
                    local vehicle_bucket = GetEntityRoutingBucket(vehs[i])
                    local player_source = exports.playerdata:getSourceFromDBID(car_ownerid[index])
                    if(player_source ~= nil) then
                        local player_bucket = GetPlayerRoutingBucket(player_source)
                        if(player_bucket ~= vehicle_bucket) then
                            SetEntityRoutingBucket(vehs[i], player_bucket)
                        end
                        if(car_timer[index] < currentTime) then
                            DeleteEntity(vehs[i])
                            car_netid_to_index[netid] = nil
                            car_netid[index] = nil
                            car_timer[index] = nil
                            car_faction[index] = nil
                            player_sqld_to_index[ car_ownerid[index] ] = nil
                            car_ownerid[index] = nil
                            car_free_index[index] = nil
                        end
                    end
                end
            end
        end
    end
end)
RegisterNetEvent("sis_faction-cars-s::resetVehicleTimer")
AddEventHandler("sis_faction-cars-s::resetVehicleTimer", function(net_carid)
    local car_pos = car_netid_to_index[net_carid]
    if(car_pos ~= nil) then
        car_timer[car_pos] = currentTime + 60 
    end
end)
RegisterNetEvent("sis_personal-vehicles-s:vehicleDestroyed")
AddEventHandler("sis_personal-vehicles-s:vehicleDestroyed", function(net_carid)
    local car_pos = car_netid_to_index[net_carid]
    if(car_pos ~= nil) then
        local vehicle = NetworkGetEntityFromNetworkId(net_carid)
        DeleteEntity(vehicle)
        car_netid_to_index[net_carid] = nil
        car_netid[car_pos] = nil
        car_timer[car_pos] = nil
        car_faction[car_pos] = nil
        player_sqld_to_index[ car_ownerid[car_pos] ] = nil
        car_ownerid[car_pos] = nil
        car_free_index[car_pos] = nil
    end        
end)
RegisterCommand("fcd", function(source, args)
    local player_dbid = exports.playerdata:getSqlID(source)
    if(player_sqld_to_index[player_dbid] == nil) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai o masina de la factiunea activa.")
    else
        local index = player_sqld_to_index[player_dbid]
        local netid = car_netid[index] 
        local vehicle = NetworkGetEntityFromNetworkId(netid)
        DeleteEntity(vehicle)
        car_netid_to_index[netid] = nil
        car_netid[index] = nil
        car_timer[index] = nil
        car_faction[index] = nil
        player_sqld_to_index[ car_ownerid[index] ] = nil
        car_ownerid[index] = nil
        car_free_index[index] = nil
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai sters masina de la factiune cu succes.")
    end
end, false)
AddEventHandler('playerDropped', function (reason)
    player_dbid = exports.playerdata:getSqlID(source)
    if(player_sqld_to_index[player_dbid] ~= nil) then
        local index = player_sqld_to_index[player_dbid]
        local netid = car_netid[index] 
        local vehicle = NetworkGetEntityFromNetworkId(netid)
        DeleteEntity(vehicle)
        car_netid_to_index[netid] = nil
        car_netid[index] = nil
        car_timer[index] = nil
        player_sqld_to_index[ car_ownerid[index] ] = nil
        car_ownerid[index] = nil
        car_free_index[index] = nil
    end
end)
RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(currentVehicle, currentSeat, vehicleDisplayName)
    local player_src = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(player_src), False )
    local veh_netid = NetworkGetNetworkIdFromEntity(vehicle)
    local index = car_netid_to_index[veh_netid]
    if(index ~= nil) then
        local player_faction = exports.playerdata:getFaction(player_src)
        if(currentSeat == -1 and car_faction[index] ~= player_faction) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti conduce masina unei factiuni din care nu faci parte.")
            TaskLeaveVehicle(GetPlayerPed(player_src), vehicle, 16)
        end
    end
end)
RegisterNetEvent("sis_faction-cars_s_t::CheckActiveUI")
AddEventHandler("sis_faction-cars_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_faction-cars_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_faction-cars_s_r::CheckActiveUI")
AddEventHandler("sis_faction-cars_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 9)
end)