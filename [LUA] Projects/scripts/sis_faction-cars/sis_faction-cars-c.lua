local nr_garages = 0
local garages_posx = {}
local garages_posy = {}
local garages_posz = {}
local garages_blip = {}
local menu_fc_status = 0
RegisterNetEvent("sis_faction-cars-c::updateGarages")
AddEventHandler("sis_faction-cars-c::updateGarages", function(_nr_garages, _garages_posx, _garages_posy, _garages_posz)
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
            if(garages_blip[i] == nil) then
                garages_blip[i] = AddBlipForCoord(xx,  yy,  zz)
                SetBlipAsShortRange(garages_blip[i], true)
                SetBlipSprite(garages_blip[i], 357)
            end
            DrawMarker(36, xx,yy,zz,0.0,0.0,0.0,0.0,0.0,0.0,4.0,4.0,4.0, 181, 27, 173, 255,false,true,2,nil,nil,false)
            exports.motiontext:Draw3DText({
                xyz={x = xx, y = yy, z = zz},
                text={
                    content= "[GARAGE] ~n~~y~FACTION",
                    rgb={171 , 0, 0},
                    textOutline=true,
                    scaleMultiplier=1,
                    font=0
                },
                perspectiveScale=4,
                radius=1000,
            })
        end
    end
end)
RMenu.Add('showcase', 'main', RageUI.CreateMenu("Faction Garage", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(400)
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            TriggerServerEvent("sis_faction-cars-s::updateMenu", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
        end) 
    end
end)
local faction = 0
local player_rank = 0
local faction_car_hash = {}
local faction_car_name = {}
local faction_car_rank = {}
local faction_cars = 0
local garage_x = 0
local garage_y = 0
local garage_z = 0
RegisterNetEvent("sis_faction-cars-c::enableMenu")
AddEventHandler("sis_faction-cars-c::enableMenu", function(_faction, _player_rank, _faction_cars, _faction_car_name, _faction_car_hash, _faction_car_rank, _garage_x, _garage_y, _garage_z)
    if(exports.playerdata:CheckActiveMenu() == false) then
        faction = _faction
        player_rank = _player_rank
        faction_cars = _faction_cars
        faction_car_hash = _faction_car_hash
        faction_car_name = _faction_car_name
        faction_car_rank = _faction_car_rank
        garage_x = _garage_x
        garage_y = _garage_y
        garage_z = _garage_z
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)
RegisterNetEvent("sis_faction-cars-c::updateMenu")
AddEventHandler("sis_faction-cars-c::updateMenu", function(_faction, _player_rank)
    if(faction ~= _faction) then
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))  
    else
        player_rank = _player_rank
        local player_pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = math.floor(math.sqrt((math.pow(garage_x - player_pos.x, 2) + math.pow(garage_y - player_pos.y, 2) + math.pow(garage_z - player_pos.z, 2))))
        if(distance > 6) then
            RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
        end
    end
end)
function SpawnFactionCar(index)
    local car = GetHashKey(faction_car_hash[index])
    RequestModel(car) 
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local vehicle
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local heading = GetEntityHeading(GetPlayerPed(-1))
    vehicle = CreateVehicle(car, x , y, z, heading, true, false)
    Citizen.Wait(50)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    TriggerServerEvent("sis_faction-cars-s::VehicleSpawned", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), VehToNet(vehicle), faction)
end
Citizen.CreateThread(function()
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            menu_temp_status = 1
            for i = 1, faction_cars do
                local text = ""
                if(player_rank >= faction_car_rank[i]) then
                    text = "~g~Disponibil"
                else
                    text = "~r~Indisponibil ~b(Rank " .. faction_car_rank[i] .. ")"
                end
                RageUI.Button(faction_car_name[i], text, {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
                        SpawnFactionCar(i)
                    end,
                });   
            end
        end)
        if(menu_temp_status ~= menu_fc_status) then
            menu_fc_status = menu_temp_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_fc_status
    exports.playerdata:CheckActiveUI(status)
end)
RegisterNetEvent("sis_faction-cars_c_t::CheckActiveUI")
AddEventHandler("sis_faction-cars_c_t::CheckActiveUI", function()
   local status = 0
   RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
      status = 1;
   end)
   TriggerServerEvent("sis_faction-cars_s_r::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)