--[[Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedSourceOfDeath(playerPed)
			killername = false
			for id = 0, 128 do
				if killer == GetPlayerPed(id) then
					killername = GetPlayerName(id)
				end				
			end
			if killer == playerPed then
				TriggerServerEvent('sis_war::playerDied',0,0)
			elseif killername then
				TriggerServerEvent('sis_war::playerDied',killer,1)
			else
				TriggerServerEvent('sis_war::playerDied',0,2)
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end) ]]--

AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local culprit = args[2]
        local isDead = args[4] == 1

        if isDead and culprit == PlayerPedId() then
            if NetworkGetPlayerIndexFromPed(victim) ~= -1 then
                TriggerServerEvent("sis_war::playerDied", GetPlayerServerId(NetworkGetEntityOwner(victim)), GetPlayerServerId(NetworkGetEntityOwner(culprit)))
            end
        end
    end
end)
local warstatus = 0
local aliance1kills = 0
local aliance2kills = 0
local wartimeleft = 0
local w = 0
local h = 0
local zone_x = 0
local zone_y = 0
local zone_z = 0
local blip_id
local player_kills = 0
local player_deaths = 0
RegisterNetEvent("sis_war-c::updateWarInfo")
AddEventHandler("sis_war-c::updateWarInfo", function(_warstatus, _aliance1kills, _aliance2kills, _wartimeleft, _zone_x, _zone_y, _zone_z, _w, _h, _player_kills, _player_deaths) 
    warstatus = _warstatus
    aliance1kills = _aliance1kills
    aliance2kills = _aliance2kills
    wartimeleft = _wartimeleft
    zone_x = _zone_x
    zone_y = _zone_y
    zone_z = _zone_z
    w = _w
    h = _h
    player_kills = _player_kills
    player_deaths = _player_deaths
end)
Citizen.CreateThread(function()
    while true do
        if(warstatus == 1) then
            if(blip_id == nil) then
                blip_id = AddBlipForArea(zone_x, zone_y, zone_z, 400.0, 400.0)
                SetBlipRotation(blip_id, 0)
	            SetBlipColour(blip_id, 0xFF00FF80)
                SetBlipFlashes(blip_id, true)
            end
        elseif(blip_id ~= nil) then
            RemoveBlip(blip_id)
            blip_id = nil
        end
        Wait(50)
    end
end)
Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("sis_war-s::updateWarInfo", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
        Wait(50)
    end
end)
RMenu.Add('showcase', 'main', RageUI.CreateMenu("War Zones", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false
local war_zones = 0
local war_zones_name = {}
local menu_war_status = 0

RegisterNetEvent("sis_war-c::EnableSelectMenu")
AddEventHandler("sis_war-c::EnableSelectMenu", function(_war_zones, _war_zones_name)
    if(exports.playerdata:CheckActiveMenu() == false) then
        war_zones = _war_zones
        war_zones_name = _war_zones_name
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end 
end)

Citizen.CreateThread(function()
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            menu_temp_status = 1
            for i = 1, war_zones do
                RageUI.Button(war_zones_name[i], " ", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        TriggerServerEvent("sis_war-s::startWar", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), i)
                    end,
                });   
            end
        end)
        if(menu_war_status ~= menu_temp_status) then
            menu_war_status = menu_temp_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_war_status
    exports.playerdata:CheckActiveUI(status)
end)
RegisterNetEvent("sis_war_c_t::CheckActiveUI")
AddEventHandler("sis_war_c_t::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
        status = 1;
    end)
    TriggerServerEvent("sis_war_s_r::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)
RegisterNetEvent("sis_war::CheckActiveUI")
AddEventHandler("sis_war::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
        status = 1;
    end)
    TriggerServerEvent("playerdata::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)







local Width, Height = GetActiveScreenResolution()
 
 
 Citizen.CreateThread(function()
     while true do
         Width, Height = GetActiveScreenResolution()
         Wait(100)
     end
 end)
 
 
 local function ToHorizontalAlignment(atype, x)
     if atype == 2 then
         return Width - x
     elseif atype == 1 then
         return Width / 2 + x
     end
     return x
 end
 
 local function ToVerticalAlignment(atype, y)
     if atype == 2 then
         return Height - y
     elseif atype == 1 then
         return Height / 2 + y
     end
     return y
 end
 
 function DrawText(caption, xPos, yPos, scale, r, g, b, alpha, font, justify, shadow, outline, wordWrap, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local x = ToHorizontalAlignment(hAlig, xPos) / Width
     local y = ToVerticalAlignment(vAlig, yPos) / Height
 
     SetTextFont(font);
     SetTextScale(1.0, scale);
     SetTextColour(r, g, b, alpha);
 
     if shadow then SetTextDropShadow() end
     if outline then SetTextOutline() end
 
     if justify == 1 then
         SetTextCentre(true)
     elseif justify == 2 then
         SetTextRightJustify(true)
         SetTextWrap(0, x)
     end
 
     if wordWrap ~= 0 then
         SetTextWrap(x, (xPos + wordWrap) / Width)
     end
 
     BeginTextCommandDisplayText("STRING")
     local maxStringLength = 99
     for i = 0, #caption, maxStringLength do
         AddTextComponentSubstringPlayerName(string.sub(caption, i, #caption))
     end
     EndTextCommandDisplayText(x, y)
 end
 
 function DrawGameSprite(dict, txtName, xPos, yPos, width, height, heading, r, g, b, alpha, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local x = ToHorizontalAlignment(hAlig, xPos) / Width
     local y = ToVerticalAlignment(vAlig, yPos) / Height
 
     if not HasStreamedTextureDictLoaded(dict) then
         RequestStreamedTextureDict(dict, true)
     end
 
     local w = wSize / Width
     local h = hSize / Height
     local x = ToHorizontalAlignment(hAlig, xPos) / Width + w * 0.5
     local y = ToVerticalAlignment(vAlig, yPos) / Height + h * 0.5
 
     DrawSprite(dict, txtName, x, y, w, h, heading, r, g, b, alpha)
 end
 
 function DrawRectangle(xPos, yPos, wSize, hSize, r, g, b, alpha, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local w = wSize / Width
     local h = hSize / Height
     local x = ToHorizontalAlignment(hAlig, xPos) / Width + w * 0.5
     local y = ToVerticalAlignment(vAlig, yPos) / Height + h * 0.5
 
     DrawRect(x, y, w, h, r, g, b, alpha)
 end
 
 Citizen.CreateThread(function()
     while true do
        if(warstatus == 1) then
            --DrawText("Time Left", 944, 23, 1, 36, 205, 253, 255, 7, 1, true, true, 0, 0, 0)
            DrawText("Grove", 687, 80, 0.75, 27, 155, 7, 255, 1, 1, true, true, 0, 0, 0)
            DrawText("TT", 767, 83, 0.75, 151, 107, 5, 255, 1, 1, true, true, 0, 0, 0)
            DrawText(tostring(aliance1kills), 713, 119, 0.5, 255, 255, 255, 255, 2, 1, true, true, 0, 0, 0)
            DrawText("Ballas", 1145, 74, 0.75, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
            DrawText("TM", 1238, 74, 0.75, 169, 0, 0, 255, 1, 1, true, true, 0, 0, 0)
            DrawText(tostring(aliance2kills), 1179, 111, 0.5, 255, 255, 255, 255, 2, 1, true, true, 0, 0, 0)
            DrawText(wartimeleft, 940, 77, 0.8, 255, 255, 255, 255, 0, 1, true, true, 0, 0, 0)
            DrawText("Time Left", 944, 23,  0.75, 36, 205, 253, 255, 1, 1, true, true, 0, 0, 0)
            DrawText("Kills: " .. player_kills, 861, 133, 0.4, 255, 255, 255, 255, 1, 0, false, false, 0, 0, 0)
            DrawText("Deaths: " .. player_deaths, 957, 132, 0.4, 255, 255, 255, 255, 1, 0, false, false, 0, 0, 0)
        end
        Wait(0)
     end
 end)