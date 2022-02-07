local time = {}
local ltime = {}

RegisterNetEvent("sis_wanted-level::updateWantedLevelClient")
AddEventHandler("sis_wanted-level::updateWantedLevelClient", function(source)
    local wantedlevel = exports.playerdata:getWantedLevel(source)
    TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, wantedlevel)
end)

RegisterNetEvent("sis_wanted-level::updateWantedLevel")
AddEventHandler("sis_wanted-level::updateWantedLevel", function(source, wantedlevel)
    exports.playerdata:setWantedLevel(source, wantedlevel)
    exports.playerdata:updateWantedLevel(source)
end)

RegisterNetEvent("sis_wanted-level::initWantedTimer")
AddEventHandler("sis_wanted-level::initWantedTimer", function(source)
    time[source] = 300
    ltime[source] = os.time()
end)

RegisterNetEvent("sis_wanted-level::AddBPoints")
AddEventHandler("sis_wanted-level::AddBPoints", function(source, amount)
    if(exports.playerdata:getClub(source) > 0) then
        local bpoints = exports.playerdata:getBPoints(source)
        bpoints = bpoints + amount
        exports.playerdata:setBPoints(source, bpoints)
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Ai primit ^3" .. amount.. " ^7BPoints. Acum ai ^3" .. bpoints .. " ^7 Bpoints.")
        exports.playerdata:updateBPoints(source)
    end
end)
function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end
RegisterNetEvent("sis_wanted-level::decWantedTimer")
AddEventHandler("sis_wanted-level::decWantedTimer", function(source)
    if(source > 0) then
        local lastcheck = os.time()
        local var = lastcheck - ltime[source]
        if (var > 0) then
            ---verificat daca sunt politisti la 50m de el
            pos = GetEntityCoords(GetPlayerPed(source))
            local nrCops = 0
            for _, playerId in ipairs(GetPlayers()) do
                if(playerId ~= source and exports.playerdata:getFaction(playerId) == 1) then
                    temp_pos = GetEntityCoords(GetPlayerPed(playerId))
                    if(distance(pos.x, pos.y, temp_pos.x, temp_pos.y) < 50) then
                        nrCops = nrCops + 1
                    end
                end
            end
            ---
            if(nrCops == 0) then
                time[source] = time[source] - var
                ltime[source] = lastcheck
                if(time[source] <= 0) then
                    local wantedlevel = exports.playerdata:getWantedLevel(source)
                    wantedlevel = wantedlevel - 1
                    time[source] = 300
                    TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, wantedlevel)
                    if(exports.playerdata:getClub(source) > 0) then
                        TriggerClientEvent("sis_wanted-level::CheckBPoints", source)
                    end
                    if(wantedlevel == 0) then
                        time[source] = 0
                        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, 0)
                    end
                    exports.playerdata:setWantedLevel(source, wantedlevel)
                    exports.playerdata:updateWantedLevel(source, wantedlevel)
                end
                TriggerClientEvent("sis_wanted-level::updateWantedTimer", source, time[source])
            else
            ltime[source] = lastcheck
            end
        end
    end
end)
AddEventHandler('playerDropped', function (reason)
    --- verificat daca avea wanted  si trimis mesaj
    local player_src = source
    TriggerClientEvent("sis_wanted-level::playerDisconnected", player_src)
    local wanted = exports.playerdata:getWantedLevel(player_src)
    if(wanted > 0) then
        local sqlid = exports.playerdata:getSqlID(player_src)
        exports.playerdata:SendFactionMSG(1, "^4[PD]^1Jucatorul " .. GetPlayerName(player_src) .. "[".. sqlid.. "] s-a deconectat cu wanted " .. wanted .. " Reason: " ..  reason)
    end
end)

local finding_sqlid = {}
RegisterNetEvent("sis_wanted-level-s::updateWantedList")
AddEventHandler("sis_wanted-level-s::updateWantedList", function(source)
    local data = {}
    local cWPlayers = 0
    for _, player_src in ipairs(GetPlayers()) do
        local player_wanted = exports.playerdata:getWantedLevel(player_src)
        if(player_wanted >= 1) then
            cWPlayers = cWPlayers + 1
            data[cWPlayers] = {name, pos, sqlid, wanted, wantedreason}
            data[cWPlayers].name = GetPlayerName(player_src)
            data[cWPlayers].pos  = GetEntityCoords(GetPlayerPed(player_src))
            data[cWPlayers].sqlid = exports.playerdata:getSqlID(player_src) 
            data[cWPlayers].wanted = player_wanted 
            data[cWPlayers].wantedreason = exports.playerdata:getWantedReason(player_src)
        end
    end
    TriggerClientEvent("sis_wanted-level-c::updateWantedList", source, cWPlayers, data)
end)
RegisterNetEvent("sis_wanted-level-s::updateFindingData")
AddEventHandler("sis_wanted-level-s::updateFindingData", function(source)
    if(exports.playerdata:IsSqlIdConnected(finding_sqlid[tonumber(source)]) == true) then
        local target_src = exports.playerdata:getSourceFromDBID(finding_sqlid[tonumber(source)])
        local target_wantedlevel = exports.playerdata:getWantedLevel(target_src)
        if(target_wantedlevel == 0) then
            TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7Jucatorul nu mai are wanted!")
            finding_sqlid[tonumber(source)] = nil
            TriggerClientEvent("sis_wanted-level-c::setFindingSQLID", source, nil)
        else
            local target_ped = GetPlayerPed(target_src)
            local target_pos = GetEntityCoords(target_ped)
            TriggerClientEvent("sis_wanted-level-c::updateFindingData", source, target_pos)
        end
    else
        TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7Jucatorul pe care il cautai a iesit de pe server!")
        finding_sqlid[tonumber(source)] = nil
        TriggerClientEvent("sis_wanted-level-c::setFindingSQLID", source, nil)
    end
end)
RegisterNetEvent("sis_wanted-level-s::setFindingSQLID")
AddEventHandler("sis_wanted-level-s::setFindingSQLID", function(source, target_dbid)
    finding_sqlid[tonumber(source)] = target_dbid
end)
RegisterCommand("wantedlist", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local data = {}
        local cWPlayers = 0
        for _, player_src in ipairs(GetPlayers()) do
            local player_wanted = exports.playerdata:getWantedLevel(player_src)
            if(player_wanted >= 1) then
                cWPlayers = cWPlayers + 1
                data[cWPlayers] = {name, pos, sqlid, wanted, wantedreason}
                data[cWPlayers].name = GetPlayerName(player_src)
                data[cWPlayers].pos  = GetEntityCoords(GetPlayerPed(player_src))
                data[cWPlayers].sqlid = exports.playerdata:getSqlID(player_src) 
                data[cWPlayers].wanted = player_wanted 
                data[cWPlayers].wantedreason = exports.playerdata:getWantedReason(player_src)
            end
        end
        TriggerClientEvent("sis_wanted-level-c::enableWantedListMenu", source, cWPlayers, data)
    end
end, false)
RegisterCommand("cancelfind", function(source, args)
    if(finding_sqlid[tonumber(source)] ~= nil) then
        finding_sqlid[tonumber(source)] = nil
        TriggerClientEvent("sis_wanted-level-c::setFindingSQLID", source, nil)
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai incetat urmarirea jucatorului!")
    end
end, false)
RegisterNetEvent("sis_wanted-level-s::playerDied")
AddEventHandler("sis_wanted-level-s::playerDied", function(source, killer)
    local player_faction = exports.playerdata:getFaction(source)
    local killer_faction = exports.playerdata:getFaction(killer)
    if(killer_faction == 1) then
        return
    end
    if(killer_faction <= 5 and killer_faction >= 2 and player_faction <= 5 and player_faction >= 2) then
        return
    end
    local killer_pos = GetEntityCoords(GetPlayerPed(killer))
    local players = 0
    for _, player_src in ipairs(GetPlayers()) do
        local player_pos = GetEntityCoords(GetPlayerPed(player_src))
        if(distance(killer_pos.x, killer_pos.y, player_pos.x, player_pos.y) <= 100) then
            players = players + 1
        end
    end
    if(players > 2) then
        local killer_wanted = exports.playerdata:getWantedLevel(killer)
        if(killer_wanted == 0) then
            exports.playerdata:setWantedReason(killer, "Murder")
            exports.playerdata:updateWantedReason(killer)
        end
        killer_wanted = math.min(killer_wanted + 1, 6)
        exports.playerdata:setWantedLevel(killer, killer_wanted)
        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", killer, killer_wanted)
    end
    local contract_price = exports.playerdata:getContractPrice(source)
    if(contract_price ~= 0 and killer_faction == 7) then
        exports.playerdata:setContractPrice(source, 0)
        local killer_contracts = exports.playerdata:getContracts(killer) + 1
        print("killer contracts" .. killer_contracts)
        exports.playerdata:setContracts(killer, killer_contracts)
        print("aaaaa " .. exports.playerdata:getContracts(killer))
        local killer_money = exports.playerdata:getMoney(killer) + contract_price
        exports.playerdata:setMoney(killer, killer_money)
        TriggerClientEvent("chatMessage", killer, "^1[Hitman]", {0,0,0}, "^7Ai primit ^4" .. contract_price .. "$ ^7pentru indeplinirea unui contract.")
        exports.playerdata:updateMoney(killer)
        exports.playerdata:updateContractPrice(source)
        exports.playerdata:updateContracts(killer)
    end
end)
RegisterNetEvent("sis_wanted-level_s_t::CheckActiveUI")
AddEventHandler("sis_wanted-level_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_wanted-level_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_wanted-level_s_r::CheckActiveUI")
AddEventHandler("sis_wanted-level_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 7)
end)