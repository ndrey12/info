AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local culprit = args[2]
        local isDead = args[4] == 1

        if isDead and culprit == PlayerPedId() then
            if NetworkGetPlayerIndexFromPed(victim) ~= -1 then
                TriggerServerEvent("sis_turf::playerDied", GetPlayerServerId(NetworkGetEntityOwner(victim)), GetPlayerServerId(NetworkGetEntityOwner(culprit)))
            end
        end
    end
end)
local turfOn = 0
local TurfOwner = {}
local TurfPosX = {}
local TurfPosY = {}
local TurfPosZ = {}
local TurfWidth = {}
local TurfHeight = {}
local TurfBlips = {}
local TurfNumbers = 0
local TurfColors = {}
local kills = 0
local deaths = 0
local faction1_kills = 0
local faction2_kills = 0
local TurfTimeLeft = "N/A"
local TurfZoneID = 0
local AttackerID = 0
local DefenderID = 0
TurfColors[2] = 0x1d9b14E6
TurfColors[3] = 0x8512baE6
TurfColors[4] = 0x663e02E6
TurfColors[5] = 0xb70b0bE6

function GetGangName(id)
	if(id == 2) then
		return "Grove Street"
	elseif(id == 3) then
		return "Ballas"
	elseif(id == 4) then
		return "The Triads"
	elseif(id == 5) then
		return "The Mafia"
	end
	return "N/A"
end

Citizen.CreateThread(function()
    while true do
        for i = 1, TurfNumbers do
            if(turfOn == 1) then
                if(TurfBlips[i] == nil) then
                    TurfBlips[i] = AddBlipForArea(TurfPosX[i], TurfPosY[i], TurfPosZ[i], TurfWidth[i] + .0, TurfHeight[i] + .0)
                    SetBlipRotation(TurfBlips[i], 0)
                    SetBlipAsShortRange(TurfBlips[i], true)
                    if(TurfOwner[i] == 2) then
                        SetBlipColour(TurfBlips[i], 0x1d9b14E6)
                    elseif(TurfOwner[i] == 3) then
                        SetBlipColour(TurfBlips[i], 0x8512baE6)
                    elseif(TurfOwner[i] == 4) then
                        SetBlipColour(TurfBlips[i], 0x663e02E6)
                    elseif(TurfOwner[i] == 5) then
                        SetBlipColour(TurfBlips[i], 0xb70b0bE6)
                    end
                end
            else
                if(TurfBlips[i] ~= nil) then
                    RemoveBlip(TurfBlips[i])
                    TurfBlips[i] = nil
                end
            end
        end
        Wait(50)
    end
end)
RegisterNetEvent("sis_turf-c::updateTurfZonesInfo")
AddEventHandler("sis_turf-c::updateTurfZonesInfo", function(_TurfNumbers, _TurfOwner, _TurfPosX, _TurfPosY, _TurfPosZ, _TurfWidth, _TurfHeight)
    TurfNumbers = _TurfNumbers
    TurfOwner = _TurfOwner
    TurfPosX = _TurfPosX
    TurfPosY = _TurfPosY
    TurfPosZ = _TurfPosZ
    TurfWidth = _TurfWidth
    TurfHeight = _TurfHeight
end)
RegisterNetEvent("sis_turf-c::updateOwner")
AddEventHandler("sis_turf-c::updateOwner", function(zone_id, AttackerID)

    TurfOwner[zone_id] = AttackerID
    if(turfOn == 1 and TurfBlips[zone_id] ~= nil) then
        if(TurfOwner[zone_id] == 2) then
            SetBlipColour(TurfBlips[zone_id], 0x1d9b14E6)
        elseif(TurfOwner[zone_id] == 3) then
            SetBlipColour(TurfBlips[zone_id], 0x8512baE6)
        elseif(TurfOwner[zone_id] == 4) then
            SetBlipColour(TurfBlips[zone_id], 0x663e02E6)
        elseif(TurfOwner[zone_id] == 5) then
            SetBlipColour(TurfBlips[zone_id], 0xb70b0bE6)
        end
    end
    
end)
RegisterNetEvent("sis_turf-c::TurfOn")
AddEventHandler("sis_turf-c::TurfOn", function()
    if(turfOn == 1) then
        TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "^7Turfs ^1Off")
        turfOn = 0
    else
        TriggerEvent("chatMessage", "^1[Info]", {0,0,0}, "^7Turfs ^2On")
        turfOn = 1
    end
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("sis_turf-s::updateTurfInfo", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
        Wait(50)
    end
end)
RegisterNetEvent("sis_turf-c::updateTurfInfo")
AddEventHandler("sis_turf-c::updateTurfInfo", function(_TurfZoneID, _faction1_kills, _faction2_kills, _TurfTimeLeft, player_kills, player_deaths, fac1, fac2)
    TurfZoneID = _TurfZoneID
    faction1_kills = _faction1_kills
    faction2_kills = _faction2_kills
    TurfTimeLeft = _TurfTimeLeft
    kills = player_kills
    deaths = player_deaths
    AttackerID = fac1
    DefenderID = fac2
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
        if(TurfZoneID > 0) then
            --DrawText("Time Left", 944, 23, 1, 36, 205, 253, 255, 7, 1, true, true, 0, 0, 0)
            if(AttackerID == 2) then
                DrawText("Grove Street", 713, 80, 0.75, 27, 155, 7, 255, 1, 1, true, true, 0, 0, 0)
            elseif(AttackerID == 3)then
                DrawText("Ballas", 713, 80, 0.75, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
            elseif(AttackerID == 4)then
                DrawText("The Triads", 713, 80, 0.75, 151, 107, 5, 1, 1, true, true, 0, 0, 0)
            elseif(AttackerID == 5)then
                DrawText("The Mafia", 713, 80, 0.75, 169, 0, 0, 255, 1, 1, true, true, 0, 0, 0)
            end
            if(DefenderID == 2) then
                DrawText("Grove Street", 1179, 80, 0.75, 27, 173, 1, 255, 1, 1, true, true, 0, 0, 0)
            elseif(DefenderID == 3)then
                DrawText("Ballas", 1179, 80, 0.75, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
            elseif(DefenderID == 4)then
                DrawText("The Triads", 1179, 80, 0.75, 151, 107, 5, 255, 1, 1, true, true, 0, 0, 0)
            elseif(DefenderID == 5)then
                DrawText("The Mafia", 1179, 80, 0.75, 169, 0, 0, 255, 1, 1, true, true, 0, 0, 0)
            end

            DrawText(tostring(faction1_kills), 713, 120, 0.5, 255, 255, 255, 255, 2, 1, true, true, 0, 0, 0)
            DrawText(tostring(faction2_kills), 1179, 120, 0.5, 255, 255, 255, 255, 2, 1, true, true, 0, 0, 0)
            DrawText(TurfTimeLeft, 940, 77, 0.8, 255, 255, 255, 255, 0, 1, true, true, 0, 0, 0)
            DrawText("Time Left", 944, 23,  0.75, 36, 205, 253, 255, 1, 1, true, true, 0, 0, 0)
            DrawText("Kills: " .. kills, 861, 133, 0.4, 255, 255, 255, 255, 1, 0, false, false, 0, 0, 0)
            DrawText("Deaths: " .. deaths, 957, 132, 0.4, 255, 255, 255, 255, 1, 0, false, false, 0, 0, 0)
        end
        Wait(0)
     end
 end)