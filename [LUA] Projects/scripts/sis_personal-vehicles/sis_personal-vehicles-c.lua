RMenu.Add('showcase', 'main', RageUI.CreateMenu("Garage", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false
RMenu.Add('showcase', 'submenu', RageUI.CreateSubMenu(RMenu:Get('showcase', 'main'), "Garage", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'submenu'):SetSubtitle("Number")
local menu_pv_status = 0
local player_cars = {}
local cars_names = {}
local cars_netid = {}
local cars_hash = {}
local cars_time = {}
local cars_pos_x = {}
local cars_pos_y = {}
local cars_pos_z = {}
local cars_pos_heading = {}
local cStatus = 0
local selected_car = 0
local nr_garages = 0
local garages_posx = {}
local garages_posy = {}
local garages_posz = {}
local garages_hid = {}
local garages_blip = {}
local houseid = -1
RegisterNetEvent("sis_personal-vehicles-c::updateGarages")
AddEventHandler("sis_personal-vehicles-c::updateGarages", function(_nr_garages, _garages_posx, _garages_posy, _garages_posz, _garages_hid)
    garages_posx = _garages_posx
    garages_posy = _garages_posy
    garages_posz = _garages_posz
    garages_hid = _garages_hid
    nr_garages = _nr_garages
end)
Citizen.CreateThread(function()
    while(true) do
        Wait(0)
        for i = 1, nr_garages do
            local xx = garages_posx[i]
            local yy = garages_posy[i]
            local zz = garages_posz[i]
            if(garages_blip[i] == nil and garages_hid[i] == 0) then
                garages_blip[i] = AddBlipForCoord(xx,  yy,  zz)
                SetBlipAsShortRange(garages_blip[i], true)
                SetBlipSprite(garages_blip[i], 357)
            end
            if(garages_hid[i] == 0) then
                DrawMarker(36, xx,yy,zz,0.0,0.0,0.0,0.0,0.0,0.0,4.0,4.0,4.0, 181, 27, 173, 255,false,true,2,nil,nil,false)
                exports.motiontext:Draw3DText({
                    xyz={x = xx, y = yy, z = zz},
                    text={
                        content= "[GARAGE] ~n~~y~PUBLIC",
                        rgb={171 , 0, 0},
                        textOutline=true,
                        scaleMultiplier=1,
                        font=0
                    },
                    perspectiveScale=4,
                    radius=1000,
                })
            else
                DrawMarker(36, xx,yy,zz,0.0,0.0,0.0,0.0,0.0,0.0,1.5,1.5,1.5, 181, 27, 173, 255,false,true,2,nil,nil,false)
                exports.motiontext:Draw3DText({
                    xyz={x = xx, y = yy, z = zz},
                    text={
                        content= "[GARAGE] ~n~~y~HouseID: ~r~" .. garages_hid[i],
                        rgb={171 , 0, 0},
                        textOutline=true,
                        scaleMultiplier=0.7,
                        font=0
                    },
                    perspectiveScale=4,
                    radius=5000,
                })
            end
        end
    end
end)

RegisterNetEvent("sis_personal-vehicles::EnableGarageMenu")
AddEventHandler("sis_personal-vehicles::EnableGarageMenu", function(_player_cars, _cars_names, _cars_netid, _cars_hash, _cars_timer, _cars_pos_x, _cars_pos_y, _cars_pos_z, _cars_pos_heading, _houseid)
    if(exports.playerdata:CheckActiveMenu() == false) then
        selected_car = 0
        player_cars = _player_cars
        cars_names = _cars_names
        cars_netid = _cars_netid
        cars_hash = _cars_hash
        cars_timer = _cars_timer
        cars_pos_x = _cars_pos_x
        cars_pos_y = _cars_pos_y
        cars_pos_z = _cars_pos_z
        cars_pos_heading = _cars_pos_heading
        houseid = _houseid
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)
local lock_index = {}
function SpawnPersonalCar(car_id, type)
    if(cars_netid[car_id] ~= nil) then
        TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "Masina este deja spawnata.")
    else
        local car = GetHashKey(cars_hash[car_id])
        RequestModel(car) 
        while not HasModelLoaded(car) do
            RequestModel(car)
            Citizen.Wait(0)
        end
        local vehicle
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
        if(type == 1) then
            local distance = math.floor(math.sqrt((math.pow(cars_pos_x[car_id] - x, 2) + math.pow(cars_pos_y[car_id] - y, 2) + math.pow(cars_pos_z[car_id] - z, 2))))
            if(distance > 100) then
                TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "Trebuie sa te afli langa locul unde ai parcat masina.")
                TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "In cazul in care ai uitat locatia o poti scoate de la un garaj public.")
                return
            end
            vehicle = CreateVehicle(car, cars_pos_x[car_id] , cars_pos_y[car_id], cars_pos_z[car_id], cars_pos_heading[car_id], true, false)
            SetEntityAsMissionEntity(vehicle, true, true)
        else
            local cGarageID = 0
            for i = 1, nr_garages do
                local distance = math.floor(math.sqrt((math.pow(garages_posx[i] - x, 2) + math.pow(garages_posy[i] - y, 2) + math.pow(garages_posz[i] - z, 2))))
                if(distance <= 5) then
                    cGarageID = i
                    break
                end
            end
            if(cGarageID ~= 0) then
                if(garages_hid[cGarageID] == 0) then
                    vehicle = CreateVehicle(car, x, y, z, 0.0, true, false)
                    SetEntityAsMissionEntity(vehicle, true, true)     
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                elseif(garages_hid[cGarageID] == houseid) then
                    vehicle = CreateVehicle(car, x, y, z, 0.0, true, false)
                    SetEntityAsMissionEntity(vehicle, true, true)     
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                else
                    TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "Garajul nu iti apartine.")
                    return
                end
            else
                TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
                return
            end
        end
        lock_index[car_id] = 1
        SetVehicleDoorsLocked(vehicle, 2)
        Citizen.Wait(50)
        TriggerServerEvent("sis_personal-vehicles-s::setVehicleNetworkID", player_cars[car_id], VehToNet(vehicle))
        TriggerServerEvent("sis_personal-vehicles-s::updatePersonalVehicleData",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
    end
end
local index = 1
--[[
1 = numai pentru jucator
2 = pentru toti jucatorii
3 = deschisa pentru toti
]]--
Citizen.CreateThread(function()
    local status = 0
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            menu_temp_status = 1
            status = 1
            for i = 1, #player_cars do
                RageUI.Button(cars_names[i], "", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        selected_car = i
                        index = 1
                        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
                        RageUI.Visible(RMenu:Get('showcase', 'submenu'), not RageUI.Visible(RMenu:Get('showcase', 'submenu'))) 
                        Citizen.Wait(10)
                    end,
                });   
            end
        end)
        RageUI.IsVisible(RMenu:Get('showcase', 'submenu'), function()
            menu_temp_status = 1
            status = 1
            if(cars_netid[selected_car]~= nil and cars_timer[selected_car] ~= nil) then
                RageUI.Button("~b~Despawn in ~r~" .. cars_timer[selected_car] .. "~b~ secunde", "", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                    end,
                });
                RageUI.Button("~r~Despawn", "Apasa ~g~ENTER ~s~pentru a despawna masina.", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        TriggerServerEvent("sis_personal-vehicles-s:vehicleDestroyed", cars_netid[selected_car])
                        TriggerServerEvent("sis_personal-vehicles-s::updatePersonalVehicleData",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
                    end,
                });
                RageUI.Button("Find car", "Apasa ~g~ENTER ~s~pentru a pune un waypoint catre masina.", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        local veh_pos = GetEntityCoords(NetToVeh(cars_netid[selected_car]))

                        SetNewWaypoint(veh_pos.x, veh_pos.y)
                    end,
                });
                RageUI.Button("Park", "Apasa ~g~ENTER ~s~pentru a parca masina in pozitia curenta.", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        local veh_id = NetToVeh(cars_netid[selected_car])
                        if(IsPedInAnyVehicle(PlayerPedId(), false)) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if(vehicle ~= nil and veh_id == vehicle) then
                                local veh_pos = GetEntityCoords(veh_id)
                                local veh_heading = GetEntityHeading(veh_id)
                                TriggerServerEvent("sis_personal-vehicles-s::parkPersonalVehicle",  cars_netid[selected_car], veh_heading, veh_pos)
                            else
                                TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "^7Nu te afli in masina personala.")
                            end
                        else
                            TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "^7Nu te afli in masina personala.")
                        end
                    end,
                });
                RageUI.List("Incuiata pentru",{{ Name = "Toti"}, { Name = "Nimeni"},}, lock_index[selected_car], "", {}, true, {
                    onListChange = function(Index, Item)
                        lock_index[selected_car] = Index
                        local vehid = NetToVeh(cars_netid[selected_car])
                        SetVehicleDoorsLocked(vehid, 1)
                        Citizen.Wait(100)
                        if(lock_index[selected_car] == 1) then
                            SetVehicleDoorsLocked(vehid, 2)
                        end
                        

                    end,
                    onSelected = function(Index, Item)
                    end,
                });
            else
                RageUI.List("Spawn car",{{ Name = "Parking location" }, { Name = "Current Garage"},}, index, "Apasa ~g~ENTER~s~ pentru spawna masina.", {}, true, {
                    onListChange = function(Index, Item)
                        index = Index
                    end,
                    onSelected = function(Index, Item)
                        SpawnPersonalCar(selected_car, Index)
                    end,
                });
                RageUI.Button("~r~Sell car", "Apasa ~g~ENTER ~s~pentru a vinde masina pentru 50% din pretul ei din showroom.", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        
                        local veh_pos = GetEntityCoords(NetToVeh(cars_netid[selected_car]))
                        TriggerServerEvent("sis_personal-vehicles-s::sellCarToShowRoom", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), player_cars[selected_car])
                    end,
                });
            end  
        end)
        if(cStatus == 0 and status == 1) then
            cStatus = 1
        end
        if(cStatus == 1 and status == 0) then
            cStatus = 0
        end
        if(menu_temp_status ~= menu_pv_status) then
            menu_pv_status = menu_temp_status
        end
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(50)
        if(IsPedInAnyVehicle(PlayerPedId(), false)) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            while(vehicle == nil) do
                Citizen.Wait(1)
            end
            local netid = VehToNet(vehicle)
            TriggerServerEvent("sis_personal-vehicles-s::setVehicleTimer",  netid)
            TriggerServerEvent("sis_faction-cars-s::resetVehicleTimer", netid)
        end
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(500)
        if(cStatus == 1) then
            TriggerServerEvent("sis_personal-vehicles-s::updatePersonalVehicleData",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
        end
    end
end)

RegisterNetEvent("sis_personal-vehicles-c::updatePersonalVehicleData")         
AddEventHandler("sis_personal-vehicles-c::updatePersonalVehicleData", function(_player_cars, _cars_names, _cars_netid, _cars_hash, _cars_timer, _cars_pos_x, _cars_pos_y, _cars_pos_z, _cars_pos_heading, _houseid)
    player_cars = _player_cars
    cars_names = _cars_names
    cars_netid = _cars_netid
    cars_hash = _cars_hash
    cars_timer = _cars_timer
    cars_pos_x = _cars_pos_x
    cars_pos_y = _cars_pos_y
    cars_pos_z = _cars_pos_z
    cars_pos_heading = _cars_pos_heading
    houseid = _houseid
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    exports.playerdata:CheckActiveUI(menu_pv_status)
end)
RegisterNetEvent("sis_personal-vehicles_c_t::CheckActiveUI")
AddEventHandler("sis_personal-vehicles_c_t::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
        status = 1;
    end)
    RageUI.IsVisible(RMenu:Get('showcase', 'submenu'), function()
        status = 1;
    end) 
    TriggerServerEvent("sis_personal-vehicles_s_r::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)
AddEventHandler('gameEventTriggered', function (name, args)
	if(name == "CEventNetworkVehicleUndrivable") then
		TriggerServerEvent("sis_personal-vehicles-s:vehicleDestroyed", NetworkGetNetworkIdFromEntity(args[1]))
	end
end)