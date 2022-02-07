local cHouses = 0
local house_pos_x = {}
local house_pos_y = {}
local house_pos_z = {}
local house_owner_id = {}
local house_level = {}
local house_owner_name = {}
local house_buy_price = {}
local house_blip= {}
RegisterNetEvent("sis_houses-c::updateData")
AddEventHandler("sis_houses-c::updateData", function(_cHouses, _house_pos_x, _house_pos_y, _house_pos_z, _house_owner_id, _house_level, _house_owner_name, _house_buy_price)
    cHouses = _cHouses
    house_pos_x = _house_pos_x
    house_pos_y = _house_pos_y
    house_pos_z = _house_pos_z
    house_owner_id = _house_owner_id
    house_level = _house_level
    house_owner_name = _house_owner_name
    house_buy_price = _house_buy_price
end)

Citizen.CreateThread(function()
    while(true) do
        Wait(0)
        for i = 1, cHouses do
            DrawMarker(0, house_pos_x[i], house_pos_y[i], house_pos_z[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 181, 27, 173, 255,false,true,2,nil,nil,false)
            if(house_blip[i] ~= nil) then
                RemoveBlip(house_blip[i])
            end
            if(house_owner_id[i] == 0) then --blip 350 pentru casa la vanzare si 40 pentru cea cumparata
                house_blip[i] = AddBlipForCoord(house_pos_x[i], house_pos_y[i], house_pos_z[i])
                SetBlipAsShortRange(house_blip[i], true)
                SetBlipSprite(house_blip[i], 350)
                exports.motiontext:Draw3DText({
                    xyz={x = house_pos_x[i], y = house_pos_y[i], z = house_pos_z[i]},
                    text={
                        content= "~h~[HOUSE]",
                        rgb={2 , 247, 11},
                        textOutline=true,
                        scaleMultiplier=1,
                        font=0
                    },
                    perspectiveScale=1,
                    radius=1000,
                })
            else
                house_blip[i] = AddBlipForCoord(house_pos_x[i], house_pos_y[i], house_pos_z[i])
                SetBlipAsShortRange(house_blip[i], true)
                SetBlipSprite(house_blip[i], 40)
                exports.motiontext:Draw3DText({
                    xyz={x = house_pos_x[i], y = house_pos_y[i], z = house_pos_z[i]},
                    text={
                        content= "~h~~r~[HOUSE]",
                        rgb={2 , 247, 11},
                        textOutline=true,
                        scaleMultiplier=1,
                        font=0
                    },
                    perspectiveScale=1,
                    radius=1000,
                })
            end
        end
    end
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
        local player_pos = GetEntityCoords(GetPlayerPed(-1))
        for i = 1, cHouses do
            local distance = math.floor(math.sqrt((math.pow(player_pos.x - house_pos_x[i], 2) + math.pow(player_pos.y - house_pos_y[i], 2) + math.pow(player_pos.z - house_pos_z[i], 2))))
            if(distance <= 2) then
                DrawRectangle(754, 864, 400, 200, 0, 0, 0, 100, 0, 0)
                DrawText("House ID: " .. i  , 954, 864, 0.9, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Level: " .. house_level[i], 954, 915, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Price: " .. house_buy_price[i] .. " $", 954, 949, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Owner: " .. house_owner_name[i], 954, 978, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                if(house_owner_id[i] == 0) then
                    DrawText("/buyhouse", 954, 1017, 0.5, 2, 247, 11, 255, 1, 1, true, true, 0, 0, 0)
                end
                break
            end
        end
        Wait(0)
     end
 end)