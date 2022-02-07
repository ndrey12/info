


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
        local pos = GetEntityCoords(GetPlayerPed(-1))
        DrawText("X: " .. math.floor(pos.x) .. " Y: " .. math.floor(pos.y) .. " Z: " .. math.floor(pos.z), 322, 1038, 0.4, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
            local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6)
            local health = math.floor(GetEntityHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
            DrawText("Speed:", 323, 954, 0.7, 181, 27, 173, 255, 1, 0, true, true, 0, 0, 0)
            DrawText(speed .. " Km/h", 425, 963, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Health: ", 322, 993, 0.7, 181, 27, 173, 255, 1, 0, true, true, 0, 0, 0)
            DrawText(" " .. health, 422, 1002, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        end
        Wait(0)
    end
end)