local show_payday 
local dobanda = 0
local timp_jucat 
RegisterNetEvent("sis_payday-c::showPayday")
AddEventHandler("sis_payday-c::showPayday", function(_dobanda, _timp_jucat)
    dobanda = _dobanda
    timp_jucat = _timp_jucat
	show_payday = 1
    Citizen.Wait(10000)
    show_payday = nil
end)
RegisterNetEvent("sis_payday-c::hidePayday")
AddEventHandler("sis_payday-c::hidePayday", function()
	show_payday = nil
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
        if(show_payday ~= nil) then    
            DrawRectangle(1542, 732, 300, 125, 0, 0, 0, 80, 0, 0)
            DrawText("PayDay", 1691, 734, 0.75, 181, 27, 173, 255, 7, 1, true, true, 0, 0, 0)
            DrawText("Dobanda: " .. dobanda .. "$", 1549, 786, 0.4, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Timp Jucat: " .. timp_jucat, 1549, 815, 0.4, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        end
        Wait(0)
     end
 end)
local secondsUntilKick = 180
local prevPos
local currentPos

local is_afk 
local last_status
local key_status = {}
Citizen.CreateThread(function()
    for i = 1, 1000 do
        key_status[i] = false
    end
    while true do
		Wait(0)
        for i = 1, 1000 do
            if (IsControlPressed(0,i) and key_status[i] == false)  then
                key_status[i] = true
                secondsUntilKick = 180
                is_afk = nil
            elseif(key_status[i] == true and not IsControlPressed(0,i)) then
                key_status[i] = false
            end
        end
    end
end)
Citizen.CreateThread(function()
	while true do
		Wait(1000)
        if(is_afk ~= last_status) then
            TriggerServerEvent("sis_payday-s::setAfkStatus",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), is_afk)
            last_status = is_afk
        end
		local playerPed = GetPlayerPed(-1)
		if playerPed then
			if is_afk == nil and secondsUntilKick > 0 then
				secondsUntilKick = secondsUntilKick - 1
			else
                if(is_afk == nil) then
                    is_afk = true
                    TriggerEvent("chatMessage", "^1[Info]", {255, 0, 0}, "^7You are now AFK!")
                end
			end
		end
	end
end)