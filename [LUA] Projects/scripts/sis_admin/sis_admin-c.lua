
RegisterNetEvent("fixveh")
AddEventHandler("fixveh", function()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsUsing(playerPed)
        SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		TriggerEvent("chatMessage", "", {255,0,0}, "^1[AdmCmd] ^7Vehicle fixed!")
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[AdmCmd] ^7You are not in a vehicle!")
    end
end)

RegisterNetEvent("sethp")
AddEventHandler("sethp", function(hp_level) 
    SetEntityHealth(GetPlayerPed(-1), hp_level)
    SetEntityMaxHealth(GetPlayerPed(-1), 200)
end)
RegisterNetEvent("setarmour")
AddEventHandler("setarmour", function(armour_level) 
    SetPedArmour(GetPlayerPed(-1), armour_level)
    SetPlayerMaxArmour(GetPlayerPed(-1), 100)
end)

RMenu.Add('showcase', 'main_admins', RageUI.CreateMenu("AFaction Members", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_admins'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_admins'):DisplayGlare(false);

RMenu:Get('showcase', 'main_admins').EnableMouse = false


local count_FMembers = 0
local names = {}
local ids = {}
local connected = {}
local fwarns = {}
local frank = {}
local menu_admin_status = 0
RegisterNetEvent("sis_admin::EnableMenu")
AddEventHandler("sis_admin::EnableMenu", function(result, p_status)
    if(exports.playerdata:CheckActiveMenu() == false) then
        count_FMembers = #result
        for i = 1, count_FMembers do
            names[i] = result[i].name
            ids[i] = result[i].id
            connected[i] = p_status[i]
            fwarns[i] = result[i].fwarn
            frank[i] = result[i].factionrank
        end
        RageUI.Visible(RMenu:Get('showcase', 'main_admins'), not RageUI.Visible(RMenu:Get('showcase', 'main_admins')))      
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_admins'), function()
            temp_status = 1
            for i = 1, count_FMembers do
                local string_Connected
                if(connected[i] == 1) then
                    string_Connected = "~g~(ONLINE) ~s~ "
                else
                    string_Connected = "~r~(OFFLINE) ~s~ "
                end
                RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..frank[i] .. " | FWarns: "..fwarns[i].."/3", {}, true, {
                    onHovered = function()
                        Visual.Subtitle("onHovered", 100)
                    end,
                    onSelected = function()
                        Visual.Subtitle("onSelected", 100)
                    end,
                });   
            end
        end)
        if(temp_status ~= menu_admin_status) then
            menu_admin_status = temp_status
        end
    end
end)
local spec_ped = nil
local spec_source = nil
local spec_enabled = false
local end_spec = false

RegisterNetEvent("sis_admin-c::TurnOnSpec")
AddEventHandler("sis_admin-c::TurnOnSpec", function(_spec_source)
    if(spec_enabled == true) then
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[AdmCmd] ^7Esti deja spec pe o persoana!")
    end
    spec_source = _spec_source
    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, false, 0)
	SetEntityCollision(playerPed, false, false)
	SetEntityInvincible(playerPed, true)
	NetworkSetEntityInvisibleToNetwork(playerPed, true)
	NetworkSetInSpectatorMode(true, playerPed)
    spec_enabled = true
end)
--[[Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1)
        if(end_spec == true) then
            local playerPed = GetPlayerPed(-1)
            SetEntityCoords(playerPed, 2000.0, 2000.0, 2000.0)
        end
    end
end)]]--
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(40)
        if(spec_enabled == true and end_spec == false) then
            TriggerServerEvent("sis_admin-s::updateSpectatorPosition", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), spec_source)
        end
    end
end)
--[[RegisterNetEvent("sis_admin-c::TurfOffSpec")
AddEventHandler("sis_admin-c::TurfOffSpec", function()
    spec_enabled = false
    Wait(50)
    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, true, 0)
	SetEntityCollision(playerPed, true, true)
	SetEntityInvincible(playerPed, false)
	NetworkSetEntityInvisibleToNetwork(playerPed, false)
    NetworkSetInSpectatorMode(false, playerPed)

    TriggerEvent("sis_admin-c::RespawnPlayer")
end)]]--
RegisterNetEvent("sis_admin-c::TurnOffSpec")
AddEventHandler("sis_admin-c::TurnOffSpec", function(possible_source)
    if(possible_source == nil and spec_enabled == false) then
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[AdmCmd] ^7Nu esti spectator!")
    end
    if(possible_source ~= nil and possible_source ~= spec_source) then
        return
    end
    end_spec = true
    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, true, 0)
	SetEntityCollision(playerPed, true, true)
	SetEntityInvincible(playerPed, false)
	NetworkSetEntityInvisibleToNetwork(playerPed, false)
    NetworkSetInSpectatorMode(false, playerPed)
    Wait(200)
    end_spec = false
    spec_enabled = false
    exports.spawnmanager:forceRespawn()
    --SetEntityCoords(playerPed, 2000.0, 2000.0, 2000.0)
    --TriggerEvent("sis_admin-c::RespawnPlayer")
end) 
RegisterNetEvent("sis_admin_c_t::CheckActiveUI")
AddEventHandler("sis_admin_c_t::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main_admins'), function()
        status = 1;
    end)
    TriggerServerEvent("sis_admin_s_r::CheckActiveUI", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_admin_status
    exports.playerdata:CheckActiveUI(status)
end)

RegisterNetEvent("sis_admin-c::RespawnPlayer")
AddEventHandler("sis_admin-c::RespawnPlayer", function() 
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)
