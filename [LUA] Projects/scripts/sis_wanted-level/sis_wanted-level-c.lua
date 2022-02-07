--- De verificat daca os.time ia timp-ul din client sau din server
AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local culprit = args[2]
        local isDead = args[4] == 1

        if isDead and culprit == PlayerPedId() then
            if NetworkGetPlayerIndexFromPed(victim) ~= -1 then
                TriggerServerEvent("sis_wanted-level-s::playerDied", GetPlayerServerId(NetworkGetEntityOwner(victim)), GetPlayerServerId(NetworkGetEntityOwner(culprit)))
            end
        end
    end
end)
local had_wanted = 0
local wanted_level = 0
local wanted_time = 0
local playerDisc = 0
function ShowTimeLeftWanted(seconds) 
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(0.5,0.5)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString("Wanted Level scade in " .. math.floor(seconds / 60) .. " min " .. seconds % 60 .. " sec.")
    DrawText(0.81,0.05)
end
Citizen.CreateThread(function()
    while playerDisc == 0 do
        SetFakeWantedLevel(wanted_level)
        if(wanted_level == 0 and had_wanted > 0) then
             wanted_time = 0
             had_wanted = 0
        end
        if(wanted_level > 0 and had_wanted == 0) then
            wanted_time = 300
            had_wanted = 1
            TriggerServerEvent("sis_wanted-level::initWantedTimer", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        elseif (wanted_time > 0) then
            TriggerServerEvent("sis_wanted-level::decWantedTimer", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
            TriggerEvent("setwanted", wanted_level)
        end
        Citizen.Wait(1000)
    end
end)
Citizen.CreateThread(function()
    while playerDisc == 0 do
        if wanted_time > 0 then
            ShowTimeLeftWanted(wanted_time)
        end
        Citizen.Wait(1)
    end
end)
Citizen.CreateThread(function()
    while playerDisc == 0 do
        if wanted_time == 0 then
            TriggerServerEvent("sis_wanted-level::updateWantedLevelClient", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        end
        Citizen.Wait(10000)
    end
end)
RegisterNetEvent("sis_wanted-level::setWantedLevelClient")
AddEventHandler("sis_wanted-level::setWantedLevelClient", function(wantedlevel)
    wanted_level = wantedlevel  
end)
RegisterNetEvent("sis_wanted-level::updateWantedTimer")
AddEventHandler("sis_wanted-level::updateWantedTimer", function(wantedtimer)
    wanted_time = wantedtimer    
end)
RegisterNetEvent("setwanted")
AddEventHandler("setwanted", function(wantedlevel) 
    SetFakeWantedLevel(wantedlevel)
end)
RegisterNetEvent("sis_wanted-level::playerDisconnected")
AddEventHandler("sis_wanted-level::playerDisconnected", function() 
    playerDisc = 1
end)

RegisterNetEvent("sis_wanted-level::CheckBPoints")
AddEventHandler("sis_wanted-level::CheckBPoints", function(wantedtimer)
    if(IsPedInAnyVehicle(PlayerPedId(), false)) then
        TriggerServerEvent("sis_wanted-level::AddBPoints", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), 100)
    end
end)

RMenu.Add('showcase', 'main', RageUI.CreateMenu("Wanted List", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false
local wanted_players = 0
local players_name = {}
local players_sqlid = {}
local players_wanted = {}
local players_wantedreason = {}
local players_posx = {}
local players_posy = {}
local players_posz = {}
local finding_sqlid
local target_x
local target_y
local status = 0
RegisterNetEvent("sis_wanted-level-c::setFindingSQLID")
AddEventHandler("sis_wanted-level-c::setFindingSQLID", function(target_dbid)
    finding_sqlid = target_dbid
    if(target_dbid == nil) then
        SetWaypointOff()
    end
end)
RegisterNetEvent("sis_wanted-level-c::updateWantedList")
AddEventHandler("sis_wanted-level-c::updateWantedList", function(cWPlayers, data)
    wanted_players = cWPlayers
    for i=1, wanted_players do
        players_name[i] = data[i].name 
        players_posx[i] = data[i].pos.x
        players_posy[i] = data[i].pos.y
        players_posz[i] = data[i].pos.z
        players_sqlid[i] = data[i].sqlid 
        players_wanted[i] = data[i].wanted 
        players_wantedreason[i] = data[i].wantedreason 
    end
end)
RegisterNetEvent("sis_wanted-level-c::enableWantedListMenu")
AddEventHandler("sis_wanted-level-c::enableWantedListMenu", function(cWPlayers, data)
    if(exports.playerdata:CheckActiveMenu() == false) then
        wanted_players = cWPlayers
        for i=1, wanted_players do
            players_name[i] = data[i].name 
            players_posx[i] = data[i].pos.x
            players_posy[i] = data[i].pos.y
            players_posz[i] = data[i].pos.z
            players_sqlid[i] = data[i].sqlid 
            players_wanted[i] = data[i].wanted 
            players_wantedreason[i] = data[i].wantedreason 
        end
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)
RegisterNetEvent("sis_wanted-level-c::updateFindingData")
AddEventHandler("sis_wanted-level-c::updateFindingData", function(target_pos)
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
            TriggerServerEvent("sis_wanted-level-s::updateFindingData", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        end
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1000)
        if(status ~= 0) then
            TriggerServerEvent("sis_wanted-level-s::updateWantedList", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) )
        end
    end
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)
        local cstatus = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            cstatus = 1
            local player_pos = GetEntityCoords(GetPlayerPed(-1))
            for i = 1, wanted_players do
                local string = "~b~(W: " .. players_wanted[i] .. " )~s~ "
                local distance = math.floor(math.sqrt((math.pow(players_posx[i] - player_pos.x, 2) + math.pow(players_posy[i]- player_pos.y, 2) + math.pow(players_posz[i] - player_pos.z, 2))))
                RageUI.Button(string .. players_name[i] .. ' [ID:' .. players_sqlid[i] ..']', "Distance: ~c~" .. distance .. "~s~m | MDC: " .. players_wantedreason[i] , {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        target_x = players_posx[i]
                        target_y = players_posy[i]
                        finding_sqlid = players_sqlid[i]
                        TriggerServerEvent("sis_wanted-level-s::setFindingSQLID", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))),players_sqlid[i] )
                        TriggerEvent("chatMessage", "^4[PD]", {255,0,0}, " ^7Foloseste comanda /cancelfind pentru a opri cautarea.")
                    end,
                });   
            
            end
        end)
        if(cstatus ~= status) then
            status = cstatus
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    exports.playerdata:CheckActiveUI(status)
end)