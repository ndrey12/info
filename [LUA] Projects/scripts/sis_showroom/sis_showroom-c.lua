CreateThread(function()
	while true do
		Wait(0)
        --arms
		DrawMarker(2, -43.094505310059, -1104.1450195312, 26.415405273438, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
	end
end)
---
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -43.094505310059, y = -1104.1450195312, z = 26.415405273438},
    text={
        content= "[SHOWROOM] ~n~~y~/buycar",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})


RMenu.Add('showcase', 'main', RageUI.CreateMenu("Showroom", "", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false

local index = {}
local number_cat = 0
local cat_name 
local cars_list = {}
local cars_price = {}
local cars_year = {}
local cars_stock = {}
local cars_ids = {}
local cars_hash = {}
local loaded_cars = 0
RegisterNetEvent("sis_showroom-c::setShowroomInfo")
AddEventHandler("sis_showroom-c::setShowroomInfo", function(cat_id, _cars_list, _cars_price, _cars_year, _cars_stock, _cars_ids, _cars_hash)
    index[cat_id] = 1
    cars_list[cat_id] = {}
    cars_list[cat_id] = _cars_list
    cars_price[cat_id] = {}
    cars_price[cat_id] = _cars_price
    cars_year[cat_id] = {}
    cars_year[cat_id] = _cars_year
    cars_stock[cat_id] = {}
    cars_stock[cat_id] = _cars_stock
    cars_ids[cat_id] = {}
    cars_ids[cat_id] = _cars_ids
    cars_hash[cat_id] = {}
    cars_hash[cat_id] = _cars_hash
    loaded_cars = loaded_cars + 1
    --for i = 1, #_cars_list do
    --   local car = GetHashKey(cars_hash[cat_id][i])
    --   RequestModel(car)
    --end
end)
RegisterNetEvent("sis_showroom::EnableMenu")
AddEventHandler("sis_showroom::EnableMenu", function(_number_cat, _category_name)
    if(exports.playerdata:CheckActiveMenu() == false) then
        loaded_cars = 0
        number_cat = _number_cat
        cat_name = _category_name
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7In functie de viteza de internet ar putea dura pana se incarca masinile.")
        RageUI.CurrentMenu.Index = 1
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)
local cPrice = 0
local cName = ""
local cStock = 0
local cYear = 0
local status = 0
local lastIndex = 0
local player_veh = 0
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)
        local  cStatus = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            cStatus = 1
            while(number_cat ~= loaded_cars) do
                Citizen.Wait(1.0)
            end
            if(status == 0) then
                for i = 1, number_cat do
                    index[i] = 1
                end
            end
            local menu_closed = 0
            for i = 1, number_cat do
                RageUI.List(cat_name[i], cars_list[i], index[i], "Apasa ~g~ENTER~s~ pentru a cumpara masina", {}, true, {
                    onListChange = function(Index, Item)
                        index[i] = Index;
                        cPrice = cars_price[i][Index]
                        cName = cars_list[i][Index]
                        cStock = cars_stock[i][Index]
                        cYear = cars_year[i][Index]
                        if(player_veh ~= 0) then
                            DeleteVehicle(player_veh)
                        end
                        local car = GetHashKey(cars_hash[i][Index])
                       -- RequestModel(car)
                      --  while not HasModelLoaded(car) do
                      --      RequestModel(car)
                       --     Citizen.Wait(0)
                       -- end
                        player_veh = CreateVehicle(car, -45.784614562988, -1096.3912353516, 26.415405273438, 201.25985717773, false, false)
                        SetVehicleEngineOn(player_veh, false, false, true)
                        TaskWarpPedIntoVehicle(PlayerPedId(), player_veh, -1)
                        FreezeEntityPosition(PlayerPedId(), true)
                    end,
                    onSelected = function(Index, Item)
                        
                        FreezeEntityPosition(PlayerPedId(), false)
                        DeleteVehicle(player_veh)
                        player_veh = 0
                        lastIndex = 0 
                        --TriggerServerEvent("sis_showroom-s::buyCarr")
                        local cID = RageUI.CurrentMenu.Index
                        TriggerServerEvent("sis_showroom-s::buyCar",  GetPlayerServerId(PlayerId()), cars_ids[cID][index[cID]], cID, index[cID])
                        --TriggerServerEvent("sis_showroom-s::buyCar", GetPlayerServerId(PlayerId()), nil)
                        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
                        menu_closed = 1
                    end,
                });
            end
            if(menu_closed == 0) then
                if(RageUI.CurrentMenu.Index ~= lastIndex) then
                    lastIndex = RageUI.CurrentMenu.Index
                    cPrice = cars_price[lastIndex][index[lastIndex]]
                    cName = cars_list[lastIndex][index[lastIndex]]
                    cStock = cars_stock[lastIndex][index[lastIndex]]
                    cYear = cars_year[lastIndex][index[lastIndex]]
                    if(player_veh ~= 0) then
                        DeleteVehicle(player_veh)
                    end
                    local car = GetHashKey(cars_hash[lastIndex][index[lastIndex]])
                    --RequestModel(car)
                    --while not HasModelLoaded(car) do
                    --    RequestModel(car)
                    --    Citizen.Wait(0)
                    --end
                    player_veh = CreateVehicle(car, -45.784614562988, -1096.3912353516, 26.415405273438, 201.25985717773, false, false)
                    SetVehicleEngineOn(player_veh, false, false, true)
                    TaskWarpPedIntoVehicle(PlayerPedId(), player_veh, -1)
                    FreezeEntityPosition(PlayerPedId(), true)
                end
            end
        end)
        if(cStatus ~= status) then
            status = cStatus 
            if(cStatus == 0) then
                FreezeEntityPosition(PlayerPedId(), false)
                DeleteVehicle(player_veh)
                player_veh = 0
                lastIndex = 0
            end
        end
    end
end)
RegisterNetEvent("LoadCarModel")
AddEventHandler("LoadCarModel", function(hash_key)
    local car = GetHashKey(hash_key)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    exports.playerdata:CheckActiveUI(status)
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
Citizen.CreateThread(function()
    while true do
       if(status == 1) then
            local price_text = ConvertMoneyToText(cPrice)
            DrawText("Car Info", 867, 893, 0.7, 181, 27, 173, 255, 7, 0, true, true, 0, 0, 0)
            DrawRectangle(742, 893, 400, 150, 7, 7, 7, 150, 0, 0)
            DrawText("Price: " .. price_text .. "$", 764, 1000, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Year: " .. cYear, 764, 969, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Model: " .. cName, 767, 938, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Stock: " .. cStock, 902, 969, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        end
        Citizen.Wait(0)
    end
end)