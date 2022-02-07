local time = {}
local jail_time = {}

AddEventHandler('playerDropped', function (reason)
    --- verificat daca avea wanted  si trimis mesaj
    local player_source = source
    local player_sqlid = exports.playerdata:getSqlID(player_source)
    local steamid = exports.playerdata:GetPlayerSteamID(player_source)
    if(steamid == nil) then
        steamid = exports.playerdata:getSteamID_DBID(player_sqlid)
    end
    if(jail_time[steamid] > 0) then
        exports.playerdata:updateJailTime_DBID(player_sqlid, math.floor(jail_time[steamid]))
        jail_time[steamid] = 0
        time[steamid] = 0
    end
end)
function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end
RegisterNetEvent('sis_jail-s::PlayerKilled')
AddEventHandler('sis_jail-s::PlayerKilled', function (source, killerID)
    --- verificat daca avea wanted  si trimis mesaj
    source = tonumber(source)
    killerID = tonumber(killerID)
    local player_source = source
    local wanted_level = exports.playerdata:getWantedLevel(player_source)
    if(wanted_level > 0) then
        pos = GetEntityCoords(GetPlayerPed(player_source))
        local nrCops = 0
        for _, playerId in ipairs(GetPlayers()) do
            if(playerId ~= player_source and exports.playerdata:getFaction(playerId) == 1) then
                temp_pos = GetEntityCoords(GetPlayerPed(playerId))
                if(distance(pos.x, pos.y, temp_pos.x, temp_pos.y) < 100) then
                    nrCops = nrCops + 1
                    if(tonumber(playerId) ~= killerID) then
                        local cop_assists = exports.playerdata:getAssists(playerId)
                        exports.playerdata:setAssists(playerId, cop_assists + 1)
                        exports.playerdata:updateAssists(playerId)
                    end
                end
            end
        end
        local isKillerCop = 0
        if(exports.playerdata:getFaction(killerID) == 1) then
            isKillerCop = 1
        end
        if(exports.playerdata:getFaction(killerID) == 1  or nrCops > 0) then
            local jail_time = wanted_level * 300
            exports.playerdata:setWantedLevel(source, 0)
            exports.playerdata:setJailTime(source, jail_time)
            exports.playerdata:updateWantedLevel(source)
            exports.playerdata:updateJailTime(source)
            exports.playerdata:ForceRespawn(source)
            TriggerEvent("sis_jail-s::setJailTime", source, jail_time)
            TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, 0)
            if(isKillerCop == 1) then
                local cop_kills = exports.playerdata:getKills(killerID) + 1
                exports.playerdata:setKills(killerID, cop_kills)
                exports.playerdata:updateKills(killerID)

            end
        end
    end
end)

function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end
RegisterCommand("surrender", function(source, args) 
    pos = GetEntityCoords(GetPlayerPed(source))
    if(distance(pos.x, pos.y, 441.25714111328,  -981.16485595703) <= 5) then
        local wanted_level = exports.playerdata:getWantedLevel(source)
        if(wanted_level > 0) then
            jltime = wanted_level * 180

            exports.playerdata:setWantedLevel(source, 0)
            exprots.playerdata:setJailTime(source, jltime)
            exports.playerdata:ForceRespawn(source)
            TriggerEvent("sis_jail-s::setJailTime", source, jltime)
            TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, 0)
            
        
            local wanted_reason = exports.playerdata:getWantedReason(source)
            local player_dbid = exports.playerdata:getSqlID(source)
            exports.playerdata:SendFactionMessage(1, "^1[SURRENDER] ^7Jucatorul " .. GetPlayerName(source) .. "[" .. player_dbid .. "]" .. " s-a predat cu wanted " .. wanted_level )
            exports.playerdata:SendFactionMessage(1, "^1[SURRENDER] ^7Reason: " .. wanted_reason) 
            exports.playerdata:setWantedReason(source, "N/A")
            exports.playerdata:updateWantedReason(source)
            exports.playerdata:updateWantedLevel(source)
            exports.playerdata:updateJailTime(source)

        else
            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu esti urmarit de politie.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Pentru a folosi aceasta comanda trebuie sa te afli in sectia de politie !")
    end
end, false)

RegisterNetEvent("sis_jail-s::setJailTime")
AddEventHandler("sis_jail-s::setJailTime", function(source, seconds)
    steamid = exports.playerdata:GetPlayerSteamID(source)
    while(steamid == nil) do
        steamid = exports.playerdata:GetPlayerSteamID(source)
        Citizen.Wait(50)
    end
    if(seconds == 0) then
        jail_time[steamid] = 0
        time[steamid] = 0
    else
        local need_respawn = 0
        if(time[steamid] ~= 0) then
            need_respawn = 1
        end
        jail_time[steamid] = seconds
        time[steamid] =  os.time() + seconds
        if(need_respawn == 1) then
            exports.playerdata:ForceRespawn(source)
        end
    end
    TriggerClientEvent("sis_jail-c::showTimeLeft", source, jail_time[steamid])
end)

Citizen.CreateThread(function()
    while(true) do
        local cTime = os.time()
        for _, playerId in ipairs(GetPlayers()) do
            steamid = exports.playerdata:GetPlayerSteamID(playerId)
            if (jail_time[steamid] ~= nil and jail_time[steamid] > 0) then
                local dif_time = time[steamid] - cTime
                if(dif_time <= 0) then
                    dif_time = 0
                    TriggerClientEvent("sis_jail-c::showTimeLeft", playerId, 0)
                    jail_time[steamid] = 0
                    time[steamid] = 0
                    exports.playerdata:setJailTime(playerId, 0)
                    exports.playerdata:updateJailTime(playerId)
                    exports.playerdata:ForceRespawn(playerId)
                elseif(dif_time < jail_time[steamid]) then
                    jail_time[steamid] = dif_time
                    TriggerClientEvent("sis_jail-c::showTimeLeft", playerId, dif_time)
                    exports.playerdata:setJailTime(playerId, dif_time)
                end

            end
        end
        Citizen.Wait(900)
    end
end)