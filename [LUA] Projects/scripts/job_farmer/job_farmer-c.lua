exports.motiontext:Draw3DTextPermanent({
    xyz={x = 2881.6879882813, y = 4484.2944335938, z = 48.353881835938},
    text={
        content= "[JOB] ~y~Farmer~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 2878.8923339844, y = 4490.7954101563 , z = 48.337036132813},
    text={
        content= "[JOB] ~y~Farmer~n~~c~/farm",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
RegisterNetEvent("job_farmer-c::StartFarming")
AddEventHandler("job_farmer-c::StartFarming", function()
    local car = GetHashKey("tractor")
    RequestModel(car) 
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local vehicle
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local heading = GetEntityHeading(GetPlayerPed(-1))
    vehicle = CreateVehicle(car, 2858.3999023438 , 4633.0288085938 , 48.337036132813, true, true)
    Citizen.Wait(50)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleDoorsLocked(vehicle, 2)
    TriggerServerEvent("job_farmer-s::VehicleSpawned", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), NetworkGetNetworkIdFromEntity(vehicle))
end)
local is_farming
local time_left = 0
Citizen.CreateThread(function()
    while true do
        local tractor_speed = GetEntitySpeed(GetPlayerPed(-1), false)*3.6
        local veh_net_id = NetworkGetNetworkIdFromEntity(GetVehiclePedIsIn(PlayerPedId(), false))
        TriggerServerEvent("job_farmer-s::updateData", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), tractor_speed, veh_net_id)
        Wait(100)
    end
end)
RegisterNetEvent("job_farmer-c::updateData")
AddEventHandler("job_farmer-c::updateData", function(_is_farming, _time_left)
    is_farming = _is_farming
    time_left = _time_left
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
        if(is_farming ~= nil) then 
            DrawRectangle(759, 860, 400, 200, 0, 0, 0, 100, 0, 0)
            DrawText("Farmer", 872, 858, 1.2, 181, 27, 173, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Time Left: " .. time_left .. "s", 957, 935, 0.6, 255, 255, 255, 255, 6, 1, true, true, 0, 0, 0)
            DrawText("Viteza trebuie sa fie mai mare decat 15Km/H", 774, 999, 0.3, 255, 255, 255, 255, 0, 0, true, true, 0, 0, 0)
            DrawText("Trebuie sa te afli pe camp", 845, 1020, 0.3, 255, 255, 255, 255, 0, 0, true, true, 0, 0, 0)
        end
        Wait(0)
     end
 end)