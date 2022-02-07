local cBusiness = 0
local business_pos_x = {}
local business_pos_y = {}
local business_pos_z = {}
local business_owner_id = {}
local business_level = {}
local business_owner_name = {}
local business_buy_price = {}
local business_name = {}
local business_profit = {}
local business_blip= {}
local cWorkingPoints = 0
local working_point_pos_x = {}
local working_point_pos_y = {}
local working_point_pos_z = {}
local working_point_type = {}
local working_point_blip = {}
RegisterNetEvent("sis_business-c::updateData")
AddEventHandler("sis_business-c::updateData", function(_cBusiness, _business_pos_x, _business_pos_y, _business_pos_z, _business_owner_id, _business_level, _business_owner_name, _business_buy_price, _business_name, _business_profit, _cWorkingPoints, _working_point_pos_x, _working_point_pos_y, _working_point_pos_z, _working_point_type)
    cBusiness            = _cBusiness
    business_pos_x       = _business_pos_x
    business_pos_y       = _business_pos_y
    business_pos_z       = _business_pos_z
    business_owner_id    = _business_owner_id
    business_level       = _business_level
    business_owner_name  = _business_owner_name
    business_buy_price   = _business_buy_price
    business_name        = _business_name
    business_profit      = _business_profit
    cWorkingPoints       = _cWorkingPoints
    working_point_pos_x  = _working_point_pos_x
    working_point_pos_y  = _working_point_pos_y
    working_point_pos_z  = _working_point_pos_z
    working_point_type   = _working_point_type
end)

Citizen.CreateThread(function()
    while(business_name[cBusiness] == nil) do
        Wait(10)
    end
    while(working_point_type[cWorkingPoints] == nil) do
        Wait(10)
    end
    while(true) do
        Wait(0)
        for i = 1, cBusiness do
            DrawMarker(29, business_pos_x[i], business_pos_y[i], business_pos_z[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 181, 27, 173, 255,false,true,2,nil,nil,false)
            if(business_blip[i] ~= nil) then
                RemoveBlip(business_blip[i])
            end
            if(business_owner_id[i] == 0) then --blip 476 pentru business la vanzare si 475 pentru cea cumparata
                business_blip[i] = AddBlipForCoord(business_pos_x[i], business_pos_y[i], business_pos_z[i])
                SetBlipAsShortRange(business_blip[i], true)
                SetBlipSprite(business_blip[i], 476)
                exports.motiontext:Draw3DText({
                    xyz={x = business_pos_x[i], y = business_pos_y[i], z = business_pos_z[i]},
                    text={
                        content= "~h~[BUSINESS]~n~~m~" .. business_name[i],
                        rgb={2 , 247, 11},
                        textOutline=true,
                        scaleMultiplier=1,
                        font=0
                    },
                    perspectiveScale=1,
                    radius=1000,
                })
            else
                business_blip[i] = AddBlipForCoord(business_pos_x[i], business_pos_y[i], business_pos_z[i])
                SetBlipAsShortRange(business_blip[i], true)
                SetBlipSprite(business_blip[i], 475)
                exports.motiontext:Draw3DText({
                    xyz={x = business_pos_x[i], y = business_pos_y[i], z = business_pos_z[i]},
                    text={
                        content= "~h~~r~[BUSINESS]~n~~m~" .. business_name[i],
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
        for i = 1, cWorkingPoints do
            DrawMarker(29, working_point_pos_x[i], working_point_pos_y[i], working_point_pos_z[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 181, 27, 173, 255,false,true,2,nil,nil,false)
            if(working_point_blip[i] == nil) then
                if(working_point_type[i] == 1) then 
                    working_point_blip[i] = AddBlipForCoord(working_point_pos_x[i], working_point_pos_y[i], working_point_pos_z[i])
                    SetBlipAsShortRange(working_point_blip[i], true)
                    SetBlipSprite(working_point_blip[i], 605)
                    exports.motiontext:Draw3DTextPermanent({
                        xyz={x = working_point_pos_x[i], y = working_point_pos_y[i], z = working_point_pos_z[i]},
                        text={
                            content= "[Bank] ~n~~c~/deposit /withdraw~n~/transfer /robbank",
                            rgb={0, 21, 252},
                            textOutline=true,
                            scaleMultiplier=1,
                            font=0
                        },
                        perspectiveScale=2,
                        radius=100,
                    })
                end
                if(working_point_type[i] == 2) then 
                    working_point_blip[i] = AddBlipForCoord(working_point_pos_x[i], working_point_pos_y[i], working_point_pos_z[i])
                    SetBlipAsShortRange(working_point_blip[i], true)
                    SetBlipSprite(working_point_blip[i], 59)
                    exports.motiontext:Draw3DTextPermanent({
                        xyz={x = working_point_pos_x[i], y = working_point_pos_y[i], z = working_point_pos_z[i]},
                        text={
                            content= "[Store]~n~~c~/sellfish /vindefaina",
                            rgb={2 , 247, 11},
                            textOutline=true,
                            scaleMultiplier=1,
                            font=0
                        },
                        perspectiveScale=1,
                        radius=1000,
                    })
                end
                if(working_point_type[i] == 3) then 
                    working_point_blip[i] = AddBlipForCoord(working_point_pos_x[i], working_point_pos_y[i], working_point_pos_z[i])
                    SetBlipAsShortRange(working_point_blip[i], true)
                    SetBlipSprite(working_point_blip[i], 110)
                    exports.motiontext:Draw3DTextPermanent({
                        xyz={x = working_point_pos_x[i], y = working_point_pos_y[i], z = working_point_pos_z[i]},
                        text={
                            content= "[Gun Shop]~n~~c~/buygun",
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
        for i = 1, cBusiness do
            local distance = math.floor(math.sqrt((math.pow(player_pos.x - business_pos_x[i], 2) + math.pow(player_pos.y - business_pos_y[i], 2) + math.pow(player_pos.z - business_pos_z[i], 2))))
            if(distance <= 2) then
                DrawRectangle(754, 864, 400, 200, 0, 0, 0, 100, 0, 0)
                DrawText("Business ID: " .. i  , 954, 864, 0.9, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Level: " .. business_level[i], 954, 915, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Price: " .. business_buy_price[i] .. " $", 954, 949, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                DrawText("Owner: " .. business_owner_name[i], 954, 978, 0.6, 255, 255, 255, 255, 1, 1, true, true, 0, 0, 0)
                if(business_owner_id[i] == 0) then
                    DrawText("/buybusiness", 954, 1017, 0.5, 2, 247, 11, 255, 1, 1, true, true, 0, 0, 0)
                end
                break
            end
        end
        Wait(0)
     end
 end)

 RMenu.Add('showcase', 'main_buygun', RageUI.CreateMenu("Gun Shop", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_buygun'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_buygun'):DisplayGlare(false);
RMenu:Get('showcase', 'main_buygun').EnableMouse = false
local menu_status = 0
local weapon_name = {}
weapon_name[1] = "Knife"
weapon_name[2] = "Machete"
weapon_name[3] = "Bat"
weapon_name[4] = "Pistol"
weapon_name[5] = "AP Pistol"
weapon_name[6] = "Heavy Revolver"
weapon_name[7] = "Micro SMG"
weapon_name[8] = "SMG"

local weapon_cost = {}
weapon_cost[1] = 8000
weapon_cost[2] = 10000
weapon_cost[3] = 8000
weapon_cost[4] = 30000
weapon_cost[5] = 60000
weapon_cost[6] = 60000
weapon_cost[7] = 80000
weapon_cost[8] = 80000
local gun_shop_pos_x = 0
local gun_shop_pos_y = 0
local gun_shop_pos_z = 0
RegisterNetEvent("sis_business-c::showBuyGunMenu")
AddEventHandler("sis_business-c::showBuyGunMenu", function(_gun_shop_pos_x, _gun_shop_pos_y, _gun_shop_pos_z)
    if(exports.playerdata:CheckActiveMenu() == false) then
        gun_shop_pos_x = _gun_shop_pos_x
        gun_shop_pos_y = _gun_shop_pos_y
        gun_shop_pos_z = _gun_shop_pos_z
        RageUI.Visible(RMenu:Get('showcase', 'main_buygun'), not RageUI.Visible(RMenu:Get('showcase', 'main_buygun')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local temp_menu_status = 0
    while (true) do
        Citizen.Wait(1.0)
        temp_menu_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_buygun'), function()
            local player_pos = GetEntityCoords(GetPlayerPed(-1))
            local distance = math.floor(math.sqrt((math.pow(player_pos.x - gun_shop_pos_x, 2) + math.pow(player_pos.y - gun_shop_pos_y, 2) + math.pow(player_pos.z - gun_shop_pos_z, 2))))
            if(distance > 5) then
                RageUI.Visible(RMenu:Get('showcase', 'main_buygun'), not RageUI.Visible(RMenu:Get('showcase', 'main_buygun')))
            else
                temp_menu_status = 1
                for i = 1, 8 do
                    RageUI.Button(weapon_name[i], "Cost: ~r~" .. weapon_cost[i] .. "$", {}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                            TriggerServerEvent("sis_business-s::giveWeapon", GetPlayerServerId(PlayerId()), i)
                        end,
                    });   
                end
            end
        end)
        if(temp_menu_status ~= menu_status) then
            menu_status = temp_menu_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_status
    exports.playerdata:CheckActiveUI(status)
end)