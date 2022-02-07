AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local culprit = args[2]

        if culprit == PlayerPedId() then
            if NetworkGetPlayerIndexFromPed(victim) ~= -1 then
                TriggerServerEvent("sis_factions::copDutyDamage", GetPlayerServerId(NetworkGetEntityOwner(victim)), GetPlayerServerId(NetworkGetEntityOwner(culprit)))
            end
        end
    end
end)
CreateThread(function()
	while true do
		Wait(0)
        --getguns pd
		DrawMarker(2, 452.37362670898, -980.00439453125, 30.678344726562, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --seifuri
        DrawMarker(2, -611.86810302734 , -1038.7912597656, 21.78173828125, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        DrawMarker(2, 117.81098937988 , -1943.6966552734, 20.635864257812, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        DrawMarker(2, 1389.1516113281 ,  1132.0615234375, 14.32092285156, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        DrawMarker(2, -1811.7362060547,  446.8747253418,  128.50842285156, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --medics
        DrawMarker(2,  -448.11428833008, -332.34725952148, 34.486450195313, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --getguns hitman
		DrawMarker(2, 251.92088317871, -3066.369140625, 5.858642578125, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
	end
end)
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 452.37362670898 , y = -980.00439453125, z = 30.678344726562},
    text={
        content= "[Police Department] ~n~~c~/duty~n~/getguns",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 117.81098937988 , y = -1943.6966552734, z = 20.635864257812},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -611.86810302734 , y = -1038.7912597656, z = 21.78173828125},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 1389.1516113281 , y = 1132.0615234375, z = 114.32092285156},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -1811.7362060547, y = 446.8747253418, z = 128.50842285156},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -448.11428833008, y = -332.34725952148, z = 34.486450195313},
    text={
        content= "[MEDICS] ~n~~c~/getpills",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 251.92088317871, y = -3066.369140625, z = 5.858642578125},
    text={
        content= "[HITMAN] ~n~~c~/getguns",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
--[[
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 452.37362670898 , y = -980.00439453125, z = 30.678344726562},
    text={
        content= "[Police Department] ~n~~c~/duty~n~/getguns",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 117.81098937988 , y = -1943.6966552734, z = 20.635864257812},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -611.86810302734 , y = -1038.7912597656, z = 21.78173828125},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 1389.1516113281 , y = 1132.0615234375, z = 114.32092285156},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -1811.7362060547, y = 446.8747253418, z = 128.50842285156},
    text={
        content= "[SEIF] ~n~~c~/depositdrugs /depositmats~n~/withdrawdrugs /withdrawmats",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -448.11428833008, y = -332.34725952148, z = 34.486450195313},
    text={
        content= "[MEDICS] ~n~~c~/getpills",
        rgb={0, 21, 252},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})]]--
RMenu.Add('showcase', 'main_factions', RageUI.CreateMenu("Faction Members", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_factions'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_factions'):DisplayGlare(false);
RMenu:Get('showcase', 'main_factions').EnableMouse = false


local count_FMembers = 0
local faction
local names = {}
local ids = {}
local connected = {}
local fwarns = {}
local frank = {}
local assists = {}
local kills = {}
local tickets = {}
local arrests = {}
local total_kills = {}
local sold_pills = {}
local player_contracts = {}
local total_deaths = {}
local menu_factions_status = 0
RegisterNetEvent("sis_factions::EnableMenu")
AddEventHandler("sis_factions::EnableMenu", function(_faction, result, p_status)
    if(exports.playerdata:CheckActiveMenu() == false) then
        count_FMembers = #result
        faction = _faction
        for i = 1, count_FMembers do
            names[i] = result[i].name
            ids[i] = result[i].id
            connected[i] = p_status[i]
            fwarns[i] = result[i].fwarn
            frank[i] = result[i].factionrank
            if(faction == 1) then
                assists[i] = result[i].assists
                kills[i]   = result[i].kills
                tickets[i] = result[i].tickets
                arrests[i] = result[i].arrests
            elseif(faction >= 2 and faction <= 5) then
                total_kills[i] = result[i].total_kills
                total_deaths[i] = result[i].total_deaths
            elseif(faction == 6) then
                sold_pills[i] = result[i].sold_pills
            elseif(faction == 7) then
                player_contracts[i] = result[1].contracts
            end
        end
        RageUI.Visible(RMenu:Get('showcase', 'main_factions'), not RageUI.Visible(RMenu:Get('showcase', 'main_factions')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_factions'), function()
            temp_status = 1
            for i = 1, count_FMembers do
                local string_Connected
                if(connected[i] == 1) then
                    string_Connected = "~g~(ONLINE) ~s~ "
                else
                    string_Connected = "~r~(OFFLINE) ~s~ "
                end
                if(faction == 1) then
                    RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..frank[i] .. " | FWarns: "..fwarns[i].."/3 | Tickets: " .. tickets[i] .. "\nArrests: " .. arrests[i] .. " | Kills: " .. kills[i] .. " | Assists: " .. assists[i] , {}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                        end,
                    });   
                elseif(faction >= 2 and faction <= 5) then
                    RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..frank[i] .. " | FWarns: "..fwarns[i].."/3 | Kills: ~g~" .. total_kills[i] .. "~s~ | Deaths: ~r~" .. total_deaths[i], {}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                        end,
                    });  
                elseif(faction == 6) then
                    RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..frank[i] .. " | FWarns: "..fwarns[i].."/3 | Sold Pills: " .. sold_pills[i], {}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                        end,
                    }); 
                elseif(faction == 7) then
                    RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..frank[i] .. " | FWarns: "..fwarns[i].."/3 | Contracts: " .. player_contracts[i], {}, true, {
                        onHovered = function()
                        end,
                        onSelected = function()
                        end,
                    });  
                end
            end
        end)
        if(temp_status ~= menu_factions_status) then
            menu_factions_status = temp_status
        end
    end
end)
RegisterNetEvent("sis_factions-c::usePills")
AddEventHandler("sis_factions-c::usePills", function()
    local player_hp = GetEntityHealth(PlayerPedId(), false)
    if(player_hp <= 100) then
        player_hp = 100
    else
        player_hp = 200
    end
    SetEntityHealth(PlayerPedId(), player_hp)
end)
RMenu.Add('showcase', 'main_contracts', RageUI.CreateMenu("Contracts", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_contracts'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_contracts'):DisplayGlare(false);
RMenu:Get('showcase', 'main_contracts').EnableMouse = false
local contracts = 0
local menu_contracts_status = 0
local contracts_name = {}
local contracts_ids = {}
local contracts_price = {}
local contracts_posx = {}
local contracts_posy = {}
local contracts_posz = {}
local finding_sqlid
local target_x = 0.0
local target_y = 0.0
RegisterNetEvent("sis_factions-c::enableContractsMenu")
AddEventHandler("sis_factions-c::enableContractsMenu", function(_contracts, data)
    if(exports.playerdata:CheckActiveMenu() == false) then
        contracts = _contracts
        for i=1, contracts do
            contracts_name[i] = data[i].name 
            contracts_posx[i] = data[i].pos.x
            contracts_posy[i] = data[i].pos.y
            contracts_posz[i] = data[i].pos.z
            contracts_ids[i] = data[i].sqlid 
            contracts_price[i] = data[i].price 
        end
        RageUI.Visible(RMenu:Get('showcase', 'main_contracts'), not RageUI.Visible(RMenu:Get('showcase', 'main_contracts')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_contracts'), function()
            temp_status = 1
            if(contracts == 0) then
                RageUI.Button("Nu sunt contracte active", "", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                    end,
                });
            end
            local player_pos = GetEntityCoords(GetPlayerPed(-1))
            for i = 1, contracts do
                local distance = math.floor(math.sqrt((math.pow(contracts_posx[i] - player_pos.x, 2) + math.pow(contracts_posy[i]  - player_pos.y, 2) + math.pow(contracts_posz[i]  - player_pos.z, 2))))
                RageUI.Button(contracts_name[i] .. ' [ID:' .. contracts_ids[i] ..']', "Distance: ~c~" .. distance .. "~s~m | Price: " .. contracts_price[i] , {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        finding_sqlid = contracts_ids[i]
                        TriggerServerEvent("sis_factions-s::setFindingSQLID", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), finding_sqlid)
                        TriggerEvent("chatMessage", "^1[HITMAN]", {255,0,0}, " ^7Foloseste comanda /cancelhit pentru a opri cautarea.")
                    end,
                });    
            end
        end)
        if(temp_status ~= menu_contracts_status) then
            menu_contracts_status = temp_status
        end
    end
end)
RegisterNetEvent("sis_factions-c::updateContractsMenu")
AddEventHandler("sis_factions-c::updateContractsMenu", function(_contracts, data)
    contracts = _contracts
    for i=1, contracts do
        contracts_name[i] = data[i].name 
        contracts_posx[i] = data[i].pos.x
        contracts_posy[i] = data[i].pos.y
        contracts_posz[i] = data[i].pos.z
        contracts_ids[i] = data[i].sqlid 
        contracts_price[i] = data[i].price 
    end
end)

RegisterNetEvent("sis_factions-c::updateFindingData")
AddEventHandler("sis_factions-c::updateFindingData", function(target_pos)
    if(finding_sqlid ~= nil) then
        target_x = target_pos.x
        target_y = target_pos.y
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
        if(finding_sqlid ~= nil) then
            SetNewWaypoint(target_x, target_y)
            TriggerServerEvent("sis_factions-s::updateFindingData", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        end
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
        if(menu_contracts_status ~= 0) then
            TriggerServerEvent("sis_factions-s::updateContractsMenu", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        end
    end
end)
RegisterNetEvent("sis_factions-c::setFindingSQLID")
AddEventHandler("sis_factions-c::setFindingSQLID", function(target_dbid)
    finding_sqlid = target_dbid
    if(target_dbid == nil) then
        SetWaypointOff()
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = 0
    if(menu_factions_status == 1 or menu_contracts_status == 1) then
        status = 1
    end
    exports.playerdata:CheckActiveUI(status)
end)