
 
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
 
 
local data = "N/A"
local ora = "N/A"
local cash_money = 0
local bank_money = 0
function ConvertMoneyToText(money)
    if(money > 999) then
        local text = ""
        local rest = math.floor(math.fmod(money, 1000))
        if(rest <= 9) then 
            text = "00" .. tostring(rest)
        elseif(rest <= 99) then
            text = "0" .. tostring(rest)
        else
            text = tostring(rest)
        end
        money = math.floor(money / 1000)
        while(money > 0) do
            rest = math.floor(math.fmod(money, 1000))
            money = math.floor(money / 1000)
            if(money > 0) then
                if(rest <= 9) then 
                    text = "00" .. tostring(rest) ..  "." .. text
                elseif(rest <= 99) then
                    text = "0" .. tostring(rest) .. "." .. text
                else
                    text = tostring(rest) .. "." .. text
                end
            else
                text = tostring(rest) .. "." .. text
            end
        end
        return text
    else
        return tostring(money)
    end
end
local int_ora = nil
local int_minut = nil
local weather = "N/A"
Citizen.CreateThread(function()
    while true do
        local cash_text = ConvertMoneyToText(tonumber(cash_money))
        local bank_text = ConvertMoneyToText(tonumber(bank_money))
        DrawText("(CASH) " .. cash_text .." $", 1553, 89, 0.5, 1, 119, 32, 255, 7, 0, true, true, 0, 0, 0)
        DrawText("(BANK) " .. bank_text .." $", 1553, 116, 0.5, 1, 119, 32, 255, 7, 0, true, true, 0, 0, 0)
        DrawText("TIKI-TAKA", 1538, 904, 1.2, 181, 27, 173, 255, 7, 0, true, true, 0, 0, 0)
        DrawText("Romania   RPG", 1691, 887, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        DrawText(data, 1542, 887, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        DrawText(ora, 1540, 962, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        Wait(0)
    end
end)
RegisterNetEvent("sis_clock-c::updateClock")
AddEventHandler("sis_clock-c::updateClock", function(_data, _ora, money, bankmoney, _int_ora, _int_minut, _weather)
    data = _data
    ora = _ora
    cash_money = money
    bank_money = bankmoney
    if(weather ~= _weather) then
        weather = _weather
        SetWeatherTypeNowPersist(weather)
    end
    if(_int_minut ~= int_minut) then
        int_minut = _int_minut
        int_ora = _int_ora
        NetworkOverrideClockTime(int_ora, int_minut, 0)

    end
end)
 
 
 
 --=====================[Count 3]======================
