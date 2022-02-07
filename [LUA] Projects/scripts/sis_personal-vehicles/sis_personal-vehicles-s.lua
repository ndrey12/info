local freeid = {}
local vehicle_network_id = {}
local vehicle_owner_id = {}
local vehicle_hash = {}
local vehicle_sqlid = {}
local vehicle_name = {}
local vehicle_timer = {}
local vehicle_pos_x = {}
local vehicle_pos_y = {}
local vehicle_pos_z = {}
local vehicle_pos_heading = {}
local networkid_to_pos = {}
local cTime = os.time()
local cGarages = 0
local garage_pos_x = {}
local garage_pos_y = {}
local garage_pos_z = {}
local garage_houseid = {}

function AddGarage(garage_id, pos_x, pos_y, pos_z, house_id)
    garage_pos_x[garage_id] = pos_x
    garage_pos_y[garage_id] = pos_y
    garage_pos_z[garage_id] = pos_z
    garage_houseid[garage_id] = house_id
end
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM personal_cars_garages", {}, 
    function(result)
        cGarages = tonumber(#result)
        for i = 1, #result do
            AddGarage(i, result[i].pos_x, result[i].pos_y, result[i].pos_z, result[i].houseid)
        end
        print("[GARAGES]: loaded " .. cGarages .. " garages")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)
RegisterCommand("addgarage", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/addgarage", {0,0,0}, "^7 <HOUSE_ID(or 0 for no-one)>")
        else
            local houseid = tonumber(args[1])
            if(houseid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addgarage", {0,0,0}, "^7 <HOUSE_ID(or 0 for no-one)>")
            else
                local garage_pos = GetEntityCoords(GetPlayerPed(source))
                cGarages = cGarages + 1
                AddGarage(cGarages, garage_pos.x, garage_pos.y, garage_pos.z, houseid)
                exports.ghmattimysql:execute("INSERT INTO `personal_cars_garages` (`id`, `pos_x`, `pos_y`, `pos_z`, `houseid`) VALUES (@id,@pos_x,@pos_y,@pos_z,@houseid)", {['@id'] = cGarages, ['@pos_x'] = garage_pos.x, ['@pos_y'] = garage_pos.y, ['@pos_z'] = garage_pos.z, ['@houseid'] = houseid})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Garaj adaugata cu succes la casa cu ID " .. houseid)
            end
        end
    end
end, false)
RegisterNetEvent("sis_personal-vehicles-s::updateGarages")
AddEventHandler("sis_personal-vehicles-s::updateGarages", function(source)
    TriggerClientEvent("sis_personal-vehicles-c::updateGarages", source, cGarages, garage_pos_x, garage_pos_y,garage_pos_z, garage_houseid)
end)
local car_offer_sqlid = {}
local car_offer_price = {}
for i = 1, 130 do
    car_offer_sqlid[i] = {}
    car_offer_price[i] = {}
end
RegisterCommand("sellcar", function(source, args)
    local player_veh_id = GetVehiclePedIsIn(GetPlayerPed(source))
    if(player_veh_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli intr-o masina!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/sellcar", {0,0,0}, "^7 <ID> <PRICE>")
        else
            local target_dbid = tonumber(args[1])
            local price = tonumber(args[2])
            if(target_dbid == nil or price == nil) then
                TriggerClientEvent("chatMessage", source, "^1/sellcar", {0,0,0}, "^7 <ID> <PRICE>")
            else
                if(price < 0) then
                    TriggerClientEvent("chatMessage", source, "^1/sellcar", {0,0,0}, "^7 <ID> <PRICE>")
                else
                    local player_veh_netid = NetworkGetNetworkIdFromEntity(player_veh_id)
                    local veh_posid = networkid_to_pos[player_veh_netid]
                    if(veh_posid == nil) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Masina nu iti apartine!")
                    else
                        local player_dbid = exports.playerdata:getSqlID(source)
                        if(vehicle_owner_id[veh_posid] ~= player_dbid) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Masina nu iti apartine!")
                        else
                            if(exports.playerdata:IsSqlIdConnected(target_dbid) == false) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                            else
                                local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                                local target_veh_id = GetVehiclePedIsIn(GetPlayerPed(target_src))
                                if(target_veh_id ~= player_veh_id) then
                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu se afla in aceeasi masina!")
                                else
                                    source = tonumber(source)
                                    target_src = tonumber(target_src)
                                    car_offer_sqlid[source][target_src] = vehicle_sqlid[veh_posid]
                                    car_offer_price[source][target_src] = price
                                    local car_name = vehicle_name[veh_posid]
                                    local player_dbid = exports.playerdata:getSqlID(source)
                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7I-ai oferit jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "] masina ^4" .. car_name .. "^7 pentru ^4" .. price .. " ^7$.\nAcesta trebuie sa accepte oferta pentru a se finaliza tranzactia.")               
                                    TriggerClientEvent("chatMessage", target_src, "^1[Info]", {0,0,0}, "^7Jucatorul " .. GetPlayerName(source) .. "[ID:"..player_dbid .. "] ti-a oferit masina ^4" .. car_name .. "^7 pentru ^4" .. price .. "^7$.\nPentru a accepta oferta foloseste comanda: ^4 /acceptcar " .. player_dbid .. " " .. price .. "^7 .")
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("acceptcar", function(source, args)
    local player_veh_id = GetVehiclePedIsIn(GetPlayerPed(source))
    if(player_veh_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli intr-o masina!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/acceptcar", {0,0,0}, "^7 <ID> <PRICE>")
        else
            local target_dbid = tonumber(args[1])
            local price = tonumber(args[2])
            if(target_dbid == nil or price == nil) then
                TriggerClientEvent("chatMessage", source, "^1/acceptcar", {0,0,0}, "^7 <ID> <PRICE>")
            else
                if(price < 0) then
                    TriggerClientEvent("chatMessage", source, "^1/acceptcar", {0,0,0}, "^7 <ID> <PRICE>")
                else
                    local player_veh_netid = NetworkGetNetworkIdFromEntity(player_veh_id)
                    local veh_posid = networkid_to_pos[player_veh_netid]
                    if(veh_posid == nil) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in masina propusa de catre jucator spre vanzare!")
                    else
                        if(exports.playerdata:IsSqlIdConnected(target_dbid) == false) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                        else
                            local target_src = tonumber(exports.playerdata:getSourceFromDBID(target_dbid))
                            local target_veh_id = GetVehiclePedIsIn(GetPlayerPed(target_src))
                            if(target_veh_id ~= player_veh_id) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu se afla in aceeasi masina!")
                            else
                                --se afla in aceeasi masina
                                print("target_src" .. target_src)
                                print("source" .. source)
                                local offer_price = car_offer_price[tonumber(target_src)][tonumber(source)]
                                local offer_carid = car_offer_sqlid[tonumber(target_src)][tonumber(source)]
                                print("asdasd" .. offer_price)
                                if(offer_carid == nil or offer_price == nil) then
                                    print("aaaaaaa")
                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Oferta inexistenta!")
                                else
                                    local carsqlid = vehicle_sqlid[veh_posid]
                                    if(vehicle_owner_id[veh_posid] ~= target_dbid) then
                                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Oferta inexistenta!")
                                    else
                                        if(offer_carid ~= carsqlid) then
                                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Oferta inexistenta!")
                                        else
                                            if(offer_price ~= price) then
                                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Oferta inexistenta!")
                                            else
                                                local player_money = exports.playerdata:getMoney(source)
                                                if(player_money < price) then
                                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani!")
                                                else
                                                    local player_dbid = exports.playerdata:getSqlID(source)
                                                    local vehicle = NetworkGetEntityFromNetworkId(vehicle_network_id[veh_posid])
                                                    DeleteEntity(vehicle)
                                                    networkid_to_pos[veh_posid] = nil
                                                    vehicle_network_id[veh_posid] = nil
                                                    vehicle_timer[veh_posid] = nil
                                                    vehicle_owner_id[veh_posid] = player_dbid
                                                    exports.playerdata:RemovePersonalVehicle(target_src, veh_posid)
                                                    exports.playerdata:AddPersonalVehicle(source, veh_posid)
                                                    exports.ghmattimysql:execute('UPDATE `personal_cars` SET `owner_id`= @owner_id WHERE id = @id', {["@owner_id"] = player_dbid, ["@id"] = carsqlid})
                                                    local target_money = exports.playerdata:getMoney(target_src)
                                                    target_money = target_money + price
                                                    player_money = player_money - price
                                                    exports.playerdata:setMoney(source, player_money)
                                                    exports.playerdata:setMoney(target_src, target_money)
                                                    TriggerClientEvent("chatMessage", source, "^4[Info]", {0,0,0}, "^7Ai cumparat masina.")
                                                    TriggerClientEvent("chatMessage", target_src, "^4[Info]", {0,0,0}, "^7Jucatorul ti-a cumparat masina.")
                                                    exports.playerdata:updateMoney(source)
                                                    exports.playerdata:updateMoney(target_src)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

            end
        end
    end
end, false)
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    for i = 1, 130 do
        car_offer_sqlid[player_src][i] = nil
        car_offer_price[i][player_src] = nil
    end
end)
function GetPersonalVehicleFreeId()
    local i = 1
    while(freeid[i] ~= nil) do
        i = i + 1
    end
    return i
end
RegisterNetEvent("sis_personal-vehicles-s::AddPersonalVehicle")
AddEventHandler("sis_personal-vehicles-s::AddPersonalVehicle", function(source, player_dbid, v_hash, v_sqlid, v_name, v_pos_x, v_pos_y, v_pos_z, v_heading)
    local posID = GetPersonalVehicleFreeId()
    vehicle_sqlid[posID] =v_sqlid
    vehicle_hash[posID] = v_hash
    vehicle_network_id[posID]  = nil
    vehicle_owner_id[posID] = player_dbid
    vehicle_name[posID] = v_name
    vehicle_pos_x[posID] = v_pos_x
    vehicle_pos_y[posID] = v_pos_y
    vehicle_pos_z[posID] = v_pos_z
    vehicle_pos_heading[posID] = v_heading
    vehicle_timer[posID] = nil
    exports.playerdata:AddPersonalVehicle(source, posID)
    freeid[posID] = 1
end)
function LoadPersonalVehicle(source, player_dbid)
    local p = promise:new()
    local number_cars = 0
    exports.ghmattimysql:execute("SELECT * FROM `personal_cars` WHERE `owner_id` = @dbid", {["@dbid"] = player_dbid}, 
    function(result)
        number_cars = tonumber(#result)
        for i = 1, #result do
            local posID = GetPersonalVehicleFreeId()
            vehicle_sqlid[posID] = result[i].id
            vehicle_hash[posID] = result[i].vehicle_hash
            vehicle_network_id[posID]  = nil
            vehicle_owner_id[posID] = result[i].owner_id
            vehicle_name[posID] = result[i].vehicle_name
            vehicle_pos_x[posID] = result[i].pos_x
            vehicle_pos_y[posID] = result[i].pos_y
            vehicle_pos_z[posID] = result[i].pos_z
            vehicle_pos_heading[posID] = result[i].pos_heading
            vehicle_timer[posID] = nil
            exports.playerdata:AddPersonalVehicle(source, posID)
            freeid[posID] = 1
        end
        print("[Personal Cars]: loaded " .. number_cars .. " cars")
        p:resolve(true)
    end)
    Citizen.Await(p)
end
function FreePersonalVehicle(source)
    ---de sters si masina daca mai este pe server
    local player_src = source
    local player_cars = {} 
    player_cars = exports.playerdata:GetPersonalVehicle(player_src)
    for i = 1, #player_cars do
        if(vehicle_network_id[player_cars[i]] ~= nil) then
            local vehicle = NetworkGetEntityFromNetworkId(vehicle_network_id[player_cars[i]])
            DeleteEntity(vehicle)
            networkid_to_pos[player_cars[i]] = nil
            vehicle_network_id[player_cars[i]] = nil
            vehicle_timer[player_cars[i]] = nil
        end
        exports.playerdata:RemovePersonalVehicle(player_src, player_cars[i])
        freeid[player_cars[i]] = nil
    end
end
RegisterNetEvent("sis_personal-vehicles-s::sellCarToShowRoom")
AddEventHandler("sis_personal-vehicles-s::sellCarToShowRoom", function(source, carid)
    exports.playerdata:RemovePersonalVehicle(source, carid)
    local car_sqlid = vehicle_sqlid[carid]
    TriggerEvent("sis_showroom-s::sellCarToShowRoom", source, vehicle_hash[carid])
    freeid[carid] = nil
    exports.ghmattimysql:execute("DELETE FROM `personal_cars` WHERE `id` = @id", {['@id'] = car_sqlid})
    TriggerEvent("sis_personal-vehicles-s::updatePersonalVehicleData", source)
end)
RegisterCommand("v", function(source, args)
    local player_cars = {} 
    player_cars = exports.playerdata:GetPersonalVehicle(source)
    if(#player_cars > 0) then
        local cars_names = {}
        local cars_netid = {}
        local cars_hash = {}
        local cars_timer = {}
        local cars_pos_x = {}
        local cars_pos_y = {}
        local cars_pos_z = {}
        local cars_pos_heading = {}
        for i = 1, #player_cars do
            cars_names[i] = vehicle_name[player_cars[i]]
            cars_netid[i] = vehicle_network_id[player_cars[i]]
            cars_hash[i] = vehicle_hash[player_cars[i]]
            cars_pos_x[i] = vehicle_pos_x[player_cars[i]]
            cars_pos_y[i] = vehicle_pos_y[player_cars[i]]
            cars_pos_z[i] = vehicle_pos_z[player_cars[i]]
            cars_pos_heading[i] = vehicle_pos_heading[player_cars[i]]
            local var = vehicle_timer[player_cars[i]]
            if(var ~= nil) then
                cars_timer[i] = vehicle_timer[player_cars[i]] - cTime
            else
                cars_timer[i] = nil
            end
        end
        local player_house = exports.playerdata:getHouse(source)
        TriggerClientEvent("sis_personal-vehicles::EnableGarageMenu", source, player_cars, cars_names, cars_netid, cars_hash, cars_timer, cars_pos_x, cars_pos_y, cars_pos_z, cars_pos_heading, player_house)
    else
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai masini personale.")
    end
end, false)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
        cTime = os.time()
        for i = 1, #freeid do
            if(freeid[i] ~= nil) then
                if(vehicle_network_id[i] ~= nil) then
                    if(vehicle_timer[i] ~= nil) then
                        local vehicle = NetworkGetEntityFromNetworkId(vehicle_network_id[i])
                        local vehicle_bucket = GetEntityRoutingBucket(vehicle)
                        local player_source = exports.playerdata:getSourceFromDBID(vehicle_owner_id[i])
                        if(player_source ~= nil) then 
                            local player_bucket = GetEntityRoutingBucket(GetPlayerPed(exports.playerdata:getSourceFromDBID(vehicle_owner_id[i])))
                            if(vehicle_bucket ~= player_bucket or vehicle_timer[i] < cTime) then
                                DeleteEntity(vehicle)
                                networkid_to_pos[vehicle_network_id[i]] = nil
                                vehicle_network_id[i] = nil
                                vehicle_timer[i] = nil
                            end
                        end
                    end
                end
            end
        end
    end
end)
AddEventHandler('playerDropped', function (reason)
    FreePersonalVehicle(source)
end)
RegisterNetEvent("sis_personal-vehicles-s::updatePersonalVehicleData")
AddEventHandler("sis_personal-vehicles-s::updatePersonalVehicleData", function(source)
    local player_cars = {} 
    player_cars = exports.playerdata:GetPersonalVehicle(source)
    if(#player_cars > 0) then
        local cars_names = {}
        local cars_netid = {}
        local cars_hash = {}
        local cars_timer = {}
        local cars_pos_x = {}
        local cars_pos_y = {}
        local cars_pos_z = {}
        local cars_pos_heading = {}
        for i = 1, #player_cars do
            cars_names[i] = vehicle_name[player_cars[i]]
            cars_netid[i] = vehicle_network_id[player_cars[i]]
            cars_hash[i] = vehicle_hash[player_cars[i]]
            cars_pos_x[i] = vehicle_pos_x[player_cars[i]]
            cars_pos_y[i] = vehicle_pos_y[player_cars[i]]
            cars_pos_z[i] = vehicle_pos_z[player_cars[i]]
            cars_pos_heading[i] = vehicle_pos_heading[player_cars[i]]
            local var = vehicle_timer[player_cars[i]]
            if(var ~= nil) then
                cars_timer[i] = vehicle_timer[player_cars[i]] - cTime
            else
                cars_timer[i] = nil
            end
        end
        local player_house = exports.playerdata:getHouse(source)
        TriggerClientEvent("sis_personal-vehicles-c::updatePersonalVehicleData", source, player_cars, cars_names, cars_netid, cars_hash, cars_timer, cars_pos_x, cars_pos_y, cars_pos_z, cars_pos_heading, player_house)
    end
end)
RegisterNetEvent("sis_personal-vehicles-s::parkPersonalVehicle")
AddEventHandler("sis_personal-vehicles-s::parkPersonalVehicle", function(car_netid, veh_heading, veh_pos)
    --
    car_netid = tonumber(car_netid)
    local carpos = networkid_to_pos[car_netid]
    local carid = vehicle_sqlid[carpos]
    vehicle_pos_x[carpos] = veh_pos.x
    vehicle_pos_y[carpos] = veh_pos.y
    vehicle_pos_z[carpos] = veh_pos.z
    vehicle_pos_heading[carpos] = veh_heading
    TriggerClientEvent("chatMessage", source, "^4[Info]", {0,0,0}, "^7Ai parcat masina cu succes.")
    exports.ghmattimysql:execute('UPDATE `personal_cars` SET `pos_x`= @p_x, `pos_y`= @p_y, `pos_z`= @p_z, `pos_heading`= @p_heading WHERE id = @id', {["@p_x"] = veh_pos.x, ["@p_y"] = veh_pos.y, ["@p_z"] = veh_pos.z, ["@p_heading"] = veh_heading, ["@id"] = carid})
end)
RegisterNetEvent("sis_personal-vehicles-s::LoadPersonalVehicle")
AddEventHandler("sis_personal-vehicles-s::LoadPersonalVehicle", function(source, player_dbid)
    source = tonumber(source)
    player_dbid = tonumber(player_dbid)
    LoadPersonalVehicle(source, player_dbid)
end)
RegisterNetEvent("sis_personal-vehicles-s::setVehicleNetworkID")
AddEventHandler("sis_personal-vehicles-s::setVehicleNetworkID", function(car_pos, net_carid)
    car_pos = tonumber(car_pos)
    net_carid = tonumber(net_carid)
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(net_carid), 0)
    vehicle_network_id[car_pos] = net_carid
    networkid_to_pos[net_carid] = car_pos
    vehicle_timer[car_pos] = cTime +600
end)
RegisterNetEvent("sis_personal-vehicles-s::setVehicleTimer")
AddEventHandler("sis_personal-vehicles-s::setVehicleTimer", function(net_carid)
    net_carid = tonumber(net_carid)
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(net_carid), 0)
    local car_pos = networkid_to_pos[net_carid]
    if(car_pos ~= nil) then
        vehicle_timer[car_pos] = cTime + 600 
    end
end)
RegisterNetEvent("sis_personal-vehicles-s:vehicleDestroyed")
AddEventHandler("sis_personal-vehicles-s:vehicleDestroyed", function(net_carid)
    net_carid = tonumber(net_carid)
    local car_pos = networkid_to_pos[net_carid]
    if(car_pos ~= nil) then
        local vehicle = NetworkGetEntityFromNetworkId(net_carid)
        DeleteEntity(vehicle)
        networkid_to_pos[net_carid] = nil
        vehicle_network_id[car_pos] = nil
        vehicle_timer[car_pos] = nil
    end        
end)

RegisterNetEvent("sis_personal-vehicles_s_t::CheckActiveUI")
AddEventHandler("sis_personal-vehicles_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_personal-vehicles_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_personal-vehicles_s_r::CheckActiveUI")
AddEventHandler("sis_personal-vehicles_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 9)
end)