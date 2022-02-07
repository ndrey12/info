function GetFactionName(factionid)
    if(factionid == 1) then
        return "Police Department"
    end
    if(factionid == 2) then
        return "GROVE STREET"
    end
    if(factionid == 3) then
        return "Ballas"
    end
    if(factionid == 4) then
        return "The Triads"
    end
    if(factionid == 5) then 
        return "The Mafia"
    end
    if(factionid == 6) then
        return "Medics"
    end
    if(factionid == 7) then
        return "Hitman"
    end
end
local cop_duty = {}
RegisterCommand("finvite", function(source, args)
    local faction_rank = exports.playerdata:getFactionRank(source)
    if(faction_rank == 7) then
        if(args[1] == nil) then
            TriggerClientEvent("chatMessage", source, "^1/finvite", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(exports.playerdata:dbid_exist(dbid) == true) then
                if(dbid > 0) then
                    if(exports.playerdata:getFaction_DBID(dbid) == 0) then
                        if(exports.playerdata:getFactionPunish_DBID(dbid) == 0) then
                            faction_id = exports.playerdata:getFaction(source)
                            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7 L-ai invitat in factiune pe jucatorul " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
                                TriggerClientEvent("chatMessage", target_source, "^1[FACTIONS]", {0,0,0}, "^7 Ai fost invitat in factiune de catre " .. GetPlayerName(source) .. "[" .. dbid .. "].")
                                exports.playerdata:setFaction(target_source, faction_id)
                                exports.playerdata:updateFaction(target_source) 
                                exports.playerdata:setFactionRank(target_source, 1)
                                exports.playerdata:updateFactionRank(target_source) 
                                TriggerEvent("player_tags::update")
                            else
                                exports.playerdata:updateFaction_DBID(dbid, faction_id)
                                exports.playerdata:updateFactionRank_DBID(dbid, 1)
                                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7 l-ai invitat in factiune pe jucatorului cu ID  " .. dbid .. ".")
                            end
                            exports.playerdata:addLog("[FInvite] " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] l-a invitat in factiune pe jucatorului cu ID  " .. dbid )
                            --print("[FInvite] " .. GetPlayerName(source) .. "[" .. exports.playerdata:getSqlID(source) .. "] l-a invitat in factiune pe jucatorului cu ID = " .. dbid .. "." )
                        else
                            TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Acel jucator are FPunish") 
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Acel jucator nu este civil!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/finvite", {0,0,0}, "^7 <DB_ID>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("funinvite", function(source, args)
    local faction_rank = exports.playerdata:getFactionRank(source)
    if(faction_rank == 7) then
    
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/funinvite", {0,0,0}, "^7 <DB_ID> <FPUNISH DAYS(0-30 days)> <REASON>")
        else
            local dbid = tonumber(args[1])
            local fpdays = tonumber(args[2])
            local reason = args[3]
            if(#args > 3) then
                for i = 4, #args do
                    reason = reason .. " "
                    reason = reason .. args[i]
                end
            end
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true and fpdays ~= nil) then
                if(dbid > 0) then
                    if(fpdays <= 30 and fpdays >= 0) then
                        faction_id = exports.playerdata:getFaction(source)
                        if(exports.playerdata:getFaction_DBID(dbid) == faction_id) then
                            if(exports.playerdata:getFactionRank_DBID(dbid) < 7) then

                                local lider_dbid = exports.playerdata:getSqlID(source)
                                exports.playerdata:UnInvitePlayerFromFaction(dbid, lider_dbid, reason, fpdays)
                                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                    TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7L-ai dat afara pe ".. GetPlayerName(target_source) .. "[" .. dbid .. "]" .. " din factiune cu " .. fpdays .. "FPunish.")
                                    TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)

                                    TriggerClientEvent("chatMessage", target_source, "^1[!!]", {0,0,0}, "^7Ai fost dat afara din factiune de catre ".. GetPlayerName(source) .. "[" .. lider_dbid .. "]" .. " cu " .. fpdays .. "FPunish.")
                                    TriggerClientEvent("chatMessage", target_source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)
                                else
                                    TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7L-ai dat afara pe ".. exports.playerdata:getName_DBID(dbid) .. "[" .. dbid .. "]" .. " din factiune cu " .. fpdays .. "FPunish.")
                                    TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)
                                end
                            else
                                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un lider!")
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Acel jucator nu este in factiunea ta!")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1/funinvite", {0,0,0}, "^7 <DB_ID> <FPUNISH DAYS(0-30 days)> <REASON>")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/funinvite", {0,0,0}, "^7 <DB_ID> <FPUNISH DAYS(0-30 days)> <REASON>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end

end, false)
RegisterCommand("f", function(source, args)
    local faction_id = exports.playerdata:getFaction(source)
    if(faction_id > 0) then
        --de verificat daca are faction mute
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/f", {0,0,0}, "^7 <message>")
        else
            local mute_seconds = exports.playerdata:getFMute(source)
            if(mute_seconds > 0) then
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You are muted for " .. mute_seconds .. "s.")
            else
                local message = args[1]
                local player_name = GetPlayerName(source)
                local player_dbid = exports.playerdata:getSqlID(source)
                if(#args > 1) then
                    for i = 2, #args do
                        message = message .. " "
                        message = message .. args[i]
                    end
                end
                for _, playerId in ipairs(GetPlayers()) do
                    if exports.playerdata:getFaction(playerId) == faction_id then
                        if(faction_id == 1) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[PD]^7"..player_name.."["..player_dbid.."]", message}, color = {27, 72, 250} })
                        elseif(faction_id == 2) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[GROVE]^7"..player_name.."["..player_dbid.."]", message}, color = {35, 135, 34} })
                        elseif(faction_id == 3) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[BALLAS]^7"..player_name.."["..player_dbid.."]", message}, color = {163, 30, 186} })
                        elseif(faction_id == 4) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[The Triads]^7"..player_name.."["..player_dbid.."]", message}, color = {92, 56, 17} })
                        elseif(faction_id == 5) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[The Mafia]^7"..player_name.."["..player_dbid.."]", message}, color = {156, 12, 17} })
                        elseif(faction_id == 6) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[Medics]^7"..player_name.."["..player_dbid.."]", message}, color = {230, 94, 114} })
                        elseif(faction_id == 7) then
                            TriggerClientEvent('chat:addMessage', playerId, { args = { "[Hitman]^7"..player_name.."["..player_dbid.."]", message}, color = {115, 114, 114} })
                        end
                    end
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("fa", function(source, args)
    local faction_id = exports.playerdata:getFaction(source)
    if(faction_id <= 5 and faction_id >= 2) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/fa", {0,0,0}, "^7 <message>")
        else
            local mute_seconds = exports.playerdata:getFMute(source)
            if(mute_seconds > 0) then
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You are muted for " .. mute_seconds .. "s.")
            else
                local message = args[1]
                local player_name = GetPlayerName(source)
                local player_dbid = exports.playerdata:getSqlID(source)
                if(#args > 1) then
                    for i = 2, #args do
                        message = message .. " "
                        message = message .. args[i]
                    end
                end
                -- 2 cu 4 si 3 cu 5
                for _, player_src in ipairs(GetPlayers()) do
                    local player_faction = exports.playerdata:getFaction(player_src)
                    if(faction_id == 2 or faction_id == 4) then
                        if(player_faction == 2 or player_faction == 4) then
                            if(faction_id == 2) then
                                TriggerClientEvent('chat:addMessage', player_src, { args = { "[FA][GROVE]^7"..player_name.."["..player_dbid.."]", message}, color = {35, 135, 34} })
                            elseif(faction_id == 4) then
                                TriggerClientEvent('chat:addMessage', player_src, { args = { "[FA][The Triads]^7"..player_name.."["..player_dbid.."]", message}, color = {92, 56, 17} })
                            end
                        end
                    else
                        if(player_faction == 3 or player_faction == 5) then
                            if(faction_id == 3) then
                                TriggerClientEvent('chat:addMessage', player_src, { args = { "[FA][BALLAS]^7"..player_name.."["..player_dbid.."]", message}, color = {163, 30, 186} })
                            elseif(faction_id == 5) then
                                TriggerClientEvent('chat:addMessage', playerId, { args = { "[FA][The Mafia]^7"..player_name.."["..player_dbid.."]", message}, color = {156, 12, 17} })
                            end
                        end
                    end
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("lc", function(source, args)
    local faction_id = exports.playerdata:getFaction(source)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(faction_id > 0 or admin_level > 0) then
        --de verificat daca are faction mute
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/lc", {0,0,0}, "^7 <message>")
        else
            local message = args[1]
            local player_name = GetPlayerName(source)
            local player_dbid = exports.playerdata:getSqlID(source)
            if(#args > 1) then
                for i = 2, #args do
                    message = message .. " "
                    message = message .. args[i]
                end
            end
            local prefix
            if(admin_level > 0) then
                 prefix =  "^9[LC][Admin]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 1) then
                prefix =  "^9[LC][PD]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 2) then
                prefix =  "^9[LC][GROVE]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 3) then
                prefix = "^9[LC][BALLAS]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 4) then
                prefix = "^9[LC][The Triads]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 5) then
                prefix = "^9[LC][The Mafia]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 6) then
                prefix = "^9[LC][Medics]^7"..player_name.."["..player_dbid.."]"
            elseif(faction_id == 7) then
                prefix = "^9[LC][Hitman]^7"..player_name.."["..player_dbid.."]"
            end
            for _, playerId in ipairs(GetPlayers()) do
                if (exports.playerdata:getFactionRank(playerId) == 7 or exports.playerdata:getAdminLevel(playerId) > 0) then
                    TriggerClientEvent('chat:addMessage', playerId, { args = { prefix, message}, color = {0,0,0}})
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
function distance ( x1, y1, x2, y2 )
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end
RegisterCommand("cuff", function(source, args) 
    local admin_level = 0
    if(exports.sis_cuff:CheckHandCuff(source) == 0) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/cuff", {0,0,0}, "^7 <PLAYER_DBID>")
        else
            local target_dbid = tonumber(args[1])
            if(target_dbid ~= nil and exports.playerdata:dbid_exist(target_dbid) == true) then
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(target_dbid)
                    if(target_source ~= source or admin_level > 0) then
                        local player_pos = GetEntityCoords(GetPlayerPed(source))
                        local target_pos = GetEntityCoords(GetPlayerPed(target_source))
                        if(distance(player_pos.x, player_pos.y, target_pos.x, target_pos.y) <= 3) then
                            if(exports.sis_cuff:CheckHandCuff(tonumber(target_source)) == 1) then
                                TriggerClientEvent("Handcuff", target_source)
                            elseif(exports.sis_cuff:CheckHandUp(tonumber(target_source)) == 1) then
                                TriggerClientEvent("Handcuff", target_source)
                                TriggerClientEvent("Handsup", target_source)
                            else
                                TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 Jucatorul nu are mainile ridicate.")
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 Jucatorul nu este langa tine.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 Nu poti folosi aceasta comanda pe tine.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 Jucatorul nu este connectat.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 DBID inexistent.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[CUFF]", {0,0,0}, "^7 Nu poti folosi aceasta comanda acum.")
    end
end, false)
RegisterCommand("arrest", function(source, args) 
    local faction_id = exports.playerdata:getFaction(source)
    if(faction_id == 1) then
        pos = GetEntityCoords(GetPlayerPed(source))
        if(distance(pos.x, pos.y, 471.67913818359,  -1023.6264038086) <= 5) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/arrest", {0,0,0}, "^7 <PLAYER_DBID>")
            else
                local target_dbid = tonumber(args[1])
                if(target_dbid ~= nil and exports.playerdata:dbid_exist(target_dbid) == true) then
                    if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(target_dbid)
                        local target_pos = GetEntityCoords(GetPlayerPed(target_source))
                        if(distance(target_pos.x, target_pos.y, pos.x, pos.y) <= 5) then
                            local wanted_level = exports.playerdata:getWantedLevel(target_source)
                            if(wanted_level > 0) then
                                    if(exports.sis_cuff:CheckHandCuff(tonumber(target_source)) == 1) then
                                        TriggerClientEvent("Handcuff", target_source)
                                        jltime = wanted_level * 240

                                        exports.playerdata:setWantedLevel(target_source, 0)
                                        exports.playerdata:setJailTime(target_source, jltime)
                                        exports.playerdata:ForceRespawn(target_source)
                                        TriggerEvent("sis_jail-s::setJailTime", target_source, jltime)
                                        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", target_source, 0)
                                        
                                    
                                        local wanted_reason = exports.playerdata:getWantedReason(target_source)
                                        local player_dbid = exports.playerdata:getSqlID(source)
                                        local player_arrests = exports.playerdata:getArrests(source)
                                        exports.playerdata:setArrests(source, player_arrests + 1)
                                        exports.playerdata:SendFactionMessage(1, "^1[ARREST] ^7Jucatorul " .. GetPlayerName(target_source) .. "[" .. target_dbid .. "]" .. " a fost arestat de catre " .. GetPlayerName(source) .. "[" .. player_dbid .. "]")
                                        exports.playerdata:SendFactionMessage(1, "^1[ARREST] ^7Reason: " .. wanted_reason) 
                                        exports.playerdata:setWantedReason(target_source, "N/A")
                                        exports.playerdata:updateWantedReason(target_source)
                                        exports.playerdata:updateWantedLevel(target_source)
                                        exports.playerdata:updateJailTime(target_source)
                                        exports.playerdata:updateArrests(source)
                                    else
                                        TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Jucatorul nu are catusele puse.")
                                    end
                            else
                                TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Nu nu are wanted.")
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Jucatorul nu este langa tine.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Jucatorul nu este conectat.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7DBID inexistent in baza de date.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Pentru a folosi aceasta comanda trebuie sa te afli in spatele sectiei de politie !")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[CMD]", {0,0,0}, "^7Nu ai acces la aceasta comanda.")
    end
end, false)
RegisterCommand("fwarn", function(source, args)
    local faction_rank = exports.playerdata:getFactionRank(source)
    if(faction_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/fwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local reason = args[2]
                if(#args > 2) then
                    for i = 3, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                local lider_faction = exports.playerdata:getFaction(source)
                if(exports.playerdata:getFaction_DBID(dbid) == lider_faction) then
                    if(exports.playerdata:getFactionRank_DBID(dbid) < 7) then
                    
                        local lider_name = GetPlayerName(source)
                        local lider_dbid = exports.playerdata:getSqlID(source) 
                        fwarns = exports.playerdata:FWarnPlayer(dbid, lider_dbid, reason)
                        local player_name
                        if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                            player_name = GetPlayerName(exports.playerdata:getSourceFromDBID(dbid))
                        else
                            player_name = exports.playerdata:getName_DBID(dbid)
                        end
                        if(fwarns < 3) then --- aici modific limita de warn-uri pentru a da afara pe cnv
                            for _, playerId in ipairs(GetPlayers()) do
                                if (exports.playerdata:getFaction(playerId) == lider_faction) then
                                    TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7" .. player_name .. "[ID:" .. dbid .. "]" .. " a primit warn de la " .. lider_name .. "[ID:" .. lider_dbid.. "]")
                                    TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7Reason: " .. reason)
                                end
                            end
                        else
                            --[[aici jucatorul va primi uninvite pentru cele 3  faction warnuri si se vor reseta]]--
                            for _, playerId in ipairs(GetPlayers()) do
                                if (exports.playerdata:getFaction(playerId) == lider_faction) then
                                    TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7" .. player_name .. "[ID:" .. dbid .. "]" .. " a fost dat afara din factiune de catre " .. lider_name .. "[ID:" .. lider_dbid .. "]")
                                    TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7Reason: " .. "3/3 faction warns ("..reason .. ")")
                                end
                            end
                            exports.playerdata:UnInvitePlayerFromFaction(dbid, lider_dbid, "3/3 faction warn ("..reason .. ")", 3)
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " Nu poti da faction warn unui lider.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " Acel jucator nu este in factiunea ta.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("funwarn", function(source, args)
    local faction_rank = exports.playerdata:getFactionRank(source)
    if(faction_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/funwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local reason = args[2]
                if(#args > 2) then
                    for i = 3, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                local lider_faction = exports.playerdata:getFaction(source)
                if(exports.playerdata:getFaction_DBID(dbid) == lider_faction) then
                    local lider_name = GetPlayerName(source)
                    local lider_dbid = exports.playerdata:getSqlID(source) 
                    local target_name = exports.playerdata:getName_DBID(dbid)
                    if(exports.playerdata:FUnWarnPlayer(dbid, lider_dbid, reason) == true) then
                        for _, playerId in ipairs(GetPlayers()) do
                            if (exports.playerdata:getFaction(playerId) == lider_faction) then
                                TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7" .. target_name .. "[ID:" .. dbid .. "]" .. " a primit faction unwarn de la " .. lider_name .. "[ID:" .. lider_dbid .. "]")
                                TriggerClientEvent("chatMessage", playerId, "^1[FACTIONS]", {0,0,0}, "^7Reason: " .. reason)
                            end
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Acel jucator nu are faction warn-uri.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " Acel jucator nu este in factiunea ta.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[FACTIONS]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("fmembers", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction ~= 0) then
        local data
        if(faction == 1) then
            local p = promise:new()
            exports.ghmattimysql:execute("SELECT `id`, `name`, `factionrank`, `fwarn`, `arrests`, `tickets`, `kills`, `assists` FROM `users` WHERE `faction` = @faction", {["@faction"] = faction}, 
            function(result)
                p:resolve(result)
            end)
            data = Citizen.Await(p)
        elseif(faction >= 2 and faction <= 5) then
            local p = promise:new()
            exports.ghmattimysql:execute("SELECT `id`, `name`, `factionrank`, `fwarn`, `total_kills`, `total_deaths` FROM `users` WHERE `faction` = @faction", {["@faction"] = faction}, 
            function(result)
                p:resolve(result)
            end)
            data = Citizen.Await(p)
        elseif(faction == 6) then
            local p = promise:new()
            exports.ghmattimysql:execute("SELECT `id`, `name`, `factionrank`, `fwarn`, `sold_pills` FROM `users` WHERE `faction` = @faction", {["@faction"] = faction}, 
            function(result)
                p:resolve(result)
            end)
            data = Citizen.Await(p)
        elseif(faction == 7) then
            local p = promise:new()
            exports.ghmattimysql:execute("SELECT `id`, `name`, `factionrank`, `fwarn`, `contracts` FROM `users` WHERE `faction` = @faction", {["@faction"] = faction}, 
            function(result)
                p:resolve(result)
            end)
            data = Citizen.Await(p)
        end
        local connected = {}
        for i = 1, #data do
            if(exports.playerdata:IsSqlIdConnected(data[i].id) == true) then
                connected[i] = 1
            else
                connected[i] = 2
            end
        end
        TriggerClientEvent("sis_factions::EnableMenu", source, faction, data, connected)
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("setfrank", function(source, args)
    local faction_rank = exports.playerdata:getFactionRank(source)
    if(faction_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setfrank", {0,0,0}, "^7 <DB_ID> <RANK(1-6)>")
        else
            local dbid = tonumber(args[1])
            local rank_level = tonumber(args[2])
            if(dbid == nil or rank_level == nil) then
                TriggerClientEvent("chatMessage", source, "^1/setfrank", {0,0,0}, "^7 <DB_ID> <RANK(1-6)>")
            else
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_src = exports.playerdata:getSourceFromDBID(dbid)
                    local player_faction = exports.playerdata:getFaction(source)
                    local target_faction = exports.playerdata:getFaction(target_src)
                    if(player_faction ~= target_faction) then
                        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Jucatorul nu face parte din clubul tau!")
                    else
                        local target_rank = exports.playerdata:getClubRank(target_src)
                        if(target_rank == 7) then
                            TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un lider!")
                        else
                            exports.playerdata:setFactionRank(target_src, rank_level)
                            local player_dbid = exports.playerdata:getSqlID(source)
                            local text = "^1[FACTIONS] ^7Liderul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. dbid .. "] rank level ^3" .. rank_level .. " ^7."
                            exports.playerdata:SendFactionMSG(player_faction, text)
                            exports.playerdata:updateFacionRank(target_src)
                            text = "[FACTIONS] Liderul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. dbid .. "] rank level " .. rank_level .. "."
                            exports.playerdata:addLog(text)   
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[FACTIONS]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("mdc", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/mdc", {0,0,0}, "^7 <DB_ID>")
        else
            local target_dbid = tonumber(args[1])
            if(target_dbid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/mdc", {0,0,0}, "^7 <DB_ID>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                    local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                    local target_wantedlevel = exports.playerdata:getWantedLevel(target_src)
                    if(target_wantedlevel == 0) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu are wanted!")
                    else
                        local target_wantedreason = exports.playerdata:getWantedReason(target_src)
                        TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7Jucatorul are wanted level ^3" .. target_wantedlevel .. "^7. Reason: ^3" .. target_wantedreason .. "^7.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end

            end
        end
    end
end, false)
RegisterCommand("su", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/mdc", {0,0,0}, "^7 <DB_ID> <WANTED_LEVEL(1,6)> <REASON>")
        else
            local target_dbid = tonumber(args[1])
            local amount = tonumber(args[2])
            if(target_dbid == nil or amount == nil or amount > 6 or amount < 1) then
                TriggerClientEvent("chatMessage", source, "^1/mdc", {0,0,0}, "^7 <DB_ID> <WANTED_LEVEL(1,6)> <REASON>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                    local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                    if(exports.playerdata:getFaction(target_src) == 1) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti da wanted level unui politist!")
                    else
                        local target_wantedlevel = exports.playerdata:getWantedLevel(target_src)
                        local reason = args[3]
                        if(#args > 3) then
                            for i = 4, #args do
                                reason = reason .. " "
                                reason = reason .. args[i]
                            end
                        end
                        target_wantedlevel = math.min(6, target_wantedlevel + amount)
                        exports.playerdata:setWantedReason(target_src, reason)
                        exports.playerdata:setWantedLevel(target_src, target_wantedlevel)
                        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", target_src, target_wantedlevel)
                        local player_dbid = exports.playerdata:getSqlID(source)
                        local text = "^4[PD] ^7" .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat wanted level ^3" .. amount .. "^7 jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]. Jucatorul are acum wanted level ^3" .. target_wantedlevel .. "^7.\n^4 Reason:^7" .. reason 
                        exports.playerdata:SendFactionMSG(1, text)
                        TriggerClientEvent("chatMessage", target_src, "^1[WANTED]", {0,0,0}, "^7Ai primit ^3" .. amount .. " ^7 wanted level de la politistul " ..  GetPlayerName(source) .. "[ID:" .. player_dbid .. "]. Reason: " .. reason)
                        exports.playerdata:updateWantedLevel(target_src)
                        exports.playerdata:updateWantedReason(target_src)
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end

            end
        end
    end
end, false)
RegisterCommand("frisk", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/frisk", {0,0,0}, "^7 <DB_ID>")
        else
            local target_dbid = tonumber(args[1])
            if(target_dbid == nil ) then
                TriggerClientEvent("chatMessage", source, "^1/frisk", {0,0,0}, "^7 <DB_ID>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                    local target_src = tonumber(exports.playerdata:getSourceFromDBID(target_dbid))
                    if(exports.playerdata:getFaction(target_src) == 1) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti perchezitiona un politist!")
                    else
                        local target_ped = GetPlayerPed(target_src)
                        local player_ped = GetPlayerPed(source)
                        local target_pos = GetEntityCoords(target_ped)
                        local player_pos = GetEntityCoords(player_ped)
                        local distancee = math.sqrt((math.pow(target_pos.x - player_pos.x, 2) + math.pow(target_pos.y - player_pos.y, 2) + math.pow(target_pos.z - player_pos.z, 2)))
                        if(distancee > 5) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este langa tine!")
                        else
                            if(exports.sis_cuff:CheckHandCuff(target_src) == 0) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este incatusat!")
                            else
                                local target_drugs = exports.playerdata:getDrugs(target_src)
                                local target_mats = exports.playerdata:getMats(target_src)
                                exports.playerdata:setDrugs(target_src, 0)
                                exports.playerdata:setMats(target_src, 0)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                TriggerClientEvent("chatMessage", target_src, "^1[Info]", {0,0,0}, "^7Ai fost perchezitionat de catre politistul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "].")
                                TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "Ai confiscat de la jucatorul " .. GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]" .. "^3 " .. target_drugs .. " ^7drugs si ^3" .. target_mats .. " ^7 materiale.")
                                exports.playerdata:updateDrugs(target_src)
                                exports.playerdata:updateMats(target_src)
                            end
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end
            end
        end
    end
end, false)
local cop_tickets = {}
for i = 1, 130 do
    cop_tickets[i] = {price, reason}
end
RegisterCommand("ticket", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/ticket", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)> <REASON>")
        else
            local target_dbid = tonumber(args[1])
            local price = tonumber(args[2])
            if(target_dbid == nil or price == nil) then
                TriggerClientEvent("chatMessage", source, "^1/ticket", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)> <REASON>")
            else
                if(price >= 0 and price <= 100000) then
                    if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                        local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                        if(exports.playerdata:getFaction(target_src) == 1) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti amenda un politist!")
                        else
                            local target_ped = GetPlayerPed(target_src)
                            local player_ped = GetPlayerPed(source)
                            local target_pos = GetEntityCoords(target_ped)
                            local player_pos = GetEntityCoords(player_ped)
                            local distancee = math.sqrt((math.pow(target_pos.x - player_pos.x, 2) + math.pow(target_pos.y - player_pos.y, 2) + math.pow(target_pos.z - player_pos.z, 2)))
                            if(distancee > 5) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este langa tine!")
                            else
                                local reason = args[3]
                                if(#args > 3) then
                                    for i = 4, #args do
                                        reason = reason .. " "
                                        reason = reason .. args[i]
                                    end
                                end
                                cop_tickets[source][target_src].price = price
                                cop_tickets[source][target_src].reason = reason
                                local player_dbid = exports.playerdata:getSqlID(source)
                                TriggerClientEvent("chatMessage", source, "^4[TICKET]", {0,0,0}, "^7L-ai sanctionat pe jucatorului " .. GetPlayerName(target_src) .. "[ID:".._target_dbid.."] cu o amenda in valoare de ^3" .. price .. "^7 $. Reason: " .. reason .. ".")
                                TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Ai fost sanctionat de cate " .. GetPlayerName(source) .. "[ID:"..player_dbid.."] cu o amenda in valoare de ^3" .. price .. " ^7$. Reason:" .. reason .. ".")
                                TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Foloseste comanda ^3/acceptticket " .. player_dbid .. " " .. price .. " ^7 pentru a o plati.")
                            end
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/ticket", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)> <REASON>")
                end
            end
        end
    end
end, false)
RegisterCommand("acceptticket", function(source, args)
    if(#args < 2) then
       TriggerClientEvent("chatMessage", source, "^1/acceptticket", {0,0,0}, "^7 <DB_ID> <PRICE>")
    else
        local cop_dbid = tonumber(args[1])
        local cop_price = tonumber(args[2])
        if(cop_dbid == nil or cop_price == nil) then
            TriggerClientEvent("chatMessage", source, "^1/acceptticket", {0,0,0}, "^7 <DB_ID> <PRICE>")
        else
            if(exports.playerdata:IsSqlIdConnected(cop_dbid) == false) then
                TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Jucatorul este offline.")
            else
                local cop_src = exports.playerdata:getSourceFromDBID(lawer_dbid)
                if(exports.playerdata:getJob(cop_src) == 3) then
                    if(cop_tickets[cop_src][source] == nil) then
                        TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^Ticket inexistent.")
                    elseif(cop_tickets[cop_src][source] == price) then
                    local player_money = exports.playerdata:getMoney(source)
                            if(cop_price > player_money)  then
                                TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Nu ai destui bani.")
                            else
                                local cop_faction = exports.playerdata:getFaction(cop_src)
                                if(cop_faction == 1) then
                                    
                                    cop_tickets[cop_src][source] = nil
                                    local cop_tickets = exports.playerdata:getTickets(cop_src) + 1
                                    exports.playerdata:setMoney(source, player_money - cop_price)
                                    exports.playerdata:setTickets(cop_src, cop_tickets)
                                    local player_dbid
                                    TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Ai platit amenda primita de la politistul " .. GetPlayerName(cop_src) .. "[ID:" .. cop_dbid .. "] in valoare de ^3" .. cop_price .. "^7$.")
                                    TriggerClientEvent("chatMessage", cop_src, "^1[TICKET]", {0,0,0}, "^7Jucatorul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "]" .. "a platit amenda in valoare de ^3" .. cop_price .. "^7$ iar tu ai primit jumatate din ea.")
                                    local cop_money = exports.playerdata:getMoney(cop_src)
                                    cop_money = lawer_money + math.floor(cop_price / 2)
                                    exports.playerdata:setMoney(cop_src, cop_money)
                                    exports.playerdata:updateMoney(cop_src)
                                    exports.playerdata:updateMoney(source)
                                    exports.playerdata:updateTickets(cop_src, cop_tickets)
                                else
                                    TriggerClientEvent("chatMessage", source, "^1[TICKET]", {0,0,0}, "^7Jucatorul nu mai este politist.")
                                end
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Oferta inexistenta.")
                        end
                else
                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Jucatorul care ti-a trimis oferta nu mai este avocat.")
                end
            end
        end
    end
end, false)

RegisterCommand("raportclear", function(source, args)
    local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank ~= 7) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local player_faction = exports.playerdata:getFaction(source)
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/raportclear", {0,0,0}, "^7 <DB_ID>")
            else
                local target_dbid = tonumber(args[1])
                if(target_dbid ~= nil and exports.playerdata:dbid_exist(target_dbid) == true) then
                    if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                        local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                        local target_faction = exports.playerdata:getFaction(target_src)
                        if(target_faction ~= player_faction) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este in factiunea ta!")
                        else
                            if(player_faction == 1) then
                                exports.playerdata:setArrests(target_src, 0)
                                exports.playerdata:setTickets(target_src, 0)
                                exports.playerdata:setKills(target_src, 0)
                                exports.playerdata:setAssists(target_src, 0)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                                exports.playerdata:updateArrests(target_src)
                                exports.playerdata:updateTickets(target_src)
                                exports.playerdata:updateKills(target_src)
                                exports.playerdata:updateAssists(target_src)
                            elseif(player_faction >= 2 and player_faction <= 5) then
                                exports.playerdata:setTotalKills(target_src, 0)
                                exports.playerdata:setTotalDeaths(target_src, 0)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                                exports.playerdata:updateTotalKills(target_src)
                                exports.playerdata:updateTotalDeaths(target_src)
                            elseif(player_faction == 6) then
                                exports.playerdata:setSoldPills(target_src, 0)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                                exports.playerdata:updateSoldPills(target_src)
                            elseif(player_faction == 7) then
                                exports.playerdata:setContracts(target_src, 0)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                                exports.playerdata:updateContracts(target_src)
                            end
                        end
                    else
                        local target_faction = exports.playerdata:getFaction_DBID(target_dbid)
                        if(target_faction ~= player_faction) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este in factiunea ta!")
                        else
                            if(player_faction == 1) then
                                local target_name = exports.playerdata:getName_DBID(target_dbid)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                exports.playerdata:updateArrests_DBID(target_dbid, 0)
                                exports.playerdata:updateTickets_DBID(target_dbid, 0)
                                exports.playerdata:updateKills_DBID(target_dbid, 0)
                                exports.playerdata:updateAssists_DBID(target_dbid, 0)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  target_name .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(1, text)
                            elseif(player_faction >= 2 and player_faction <= 5) then
                                local target_name = exports.playerdata:getName_DBID(target_dbid)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                exports.playerdata:updateTotalKills_DBID(target_dbid, 0)
                                exports.playerdata:updateTotalDeaths_DBID(target_dbid, 0)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                            elseif(player_faction == 6)then
                                local target_name = exports.playerdata:getName_DBID(target_dbid)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                exports.playerdata:updateSoldPills_DBID(target_dbid, 0)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                            elseif(player_faction == 7) then
                                local target_name = exports.playerdata:getName_DBID(target_dbid)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                exports.playerdata:updateContracts_DBID(target_dbid, 0)
                                local text = "^4[FACTION] ^7 Liderul " .. GetPlayerName(source)  .. "[ID:"  .. player_dbid .. "] i-a resetat norma membrului " ..  GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]."
                                exports.playerdata:SendFactionMSG(player_faction, text)
                            end
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7DBID inexistent!")
                end
            end
    end
end, false)
RegisterCommand("duty", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction ~= 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local player_ped = GetPlayerPed(source)
        local player_pos = GetEntityCoords(player_ped)
        local distancee = math.sqrt((math.pow(452.37362670898 - player_pos.x, 2) + math.pow(-980.00439453125 - player_pos.y, 2) + math.pow(30.678344726562- player_pos.z, 2)))
        if(distancee > 2) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        else
            if(cop_duty[tonumber(source)] == nil) then
                cop_duty[tonumber(source)] = 1
                TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7You are now ^2OnDuty^7!")
                SetPedArmour(player_ped, 100)
            else
                cop_duty[tonumber(source)] = nil
                TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7You are now ^4OffDuty^7!")
                SetPedArmour(player_ped, 0)
            end
        end
    end
end, false)  

--[[Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(10)
        for _, player_src in ipairs(GetPlayers()) do
            local player_faction = exports.playerdata:getFaction(player_src)
            if (player_faction == 1) then
                if(cop_duty[tonumber(player_src)] ~= nil) then
                    local player_ped = GetPlayerPed(player_src)
                    local target_ped = GetPedSourceOfDamage(player_ped)
                    if(target_ped ~= 0) then
                        local target_src = NetworkGetEntityOwner(target_ped)
                        local target_dbid = exports.playerdata:getSqlID(target_src)
                        TriggerClientEvent("chatMessage", player_src, "^4[PD]", {0,0,0}, "^7" .. GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "]" .. "te-a atacat.")
                    end
                end
            end
        end
    end
end)]]--
RegisterNetEvent("sis_factions::copDutyDamage")
AddEventHandler("sis_factions::copDutyDamage", function(source, attacker)
    local player_faction = exports.playerdata:getFaction(source)
    if (player_faction == 1) then
        if(cop_duty[tonumber(source)] ~= nil) then
            if(exports.playerdata:getContractPrice(source) ~= 0 and exports.playerdata:getFaction(attacker) == 7) then
                return
            end
            local player_ped = GetPlayerPed(source)
            local target_ped = GetPedSourceOfDamage(player_ped)
            if(target_ped ~= 0) then
                local target_dbid = exports.playerdata:getSqlID(attacker)
                TriggerClientEvent("chatMessage", source, "^4[PD]", {0,0,0}, "^7^5" .. GetPlayerName(attacker) .. "[ID:" .. target_dbid .. "] ^7" .. "te-a atacat.")
            end
        end
    end
end)
RegisterCommand("getguns", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction == 1) then
        if(cop_duty[tonumber(source)] == nil) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu esti OnDuty!")
        else
            local player_ped = GetPlayerPed(source)
            local player_pos = GetEntityCoords(player_ped)
            local distancee = math.sqrt((math.pow(452.37362670898 - player_pos.x, 2) + math.pow(-980.00439453125 - player_pos.y, 2) + math.pow(30.678344726562- player_pos.z, 2)))
            if(distancee > 2) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
            else
                local player_rank = exports.playerdata:getFactionRank(source)
                if(player_rank >= 1) then
                    local weaponHash = GetHashKey("weapon_nightstick")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                    weaponHash = GetHashKey("weapon_appistol")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                    weaponHash = GetHashKey("weapon_microsmg")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                end
                if(player_rank >= 2) then
                    local weaponHash = GetHashKey("weapon_pumpshotgun")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                    weaponHash = GetHashKey("weapon_smg")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                end
                if(player_rank >= 3) then
                    local weaponHash = GetHashKey("weapon_assaultrifle")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                    weaponHash = GetHashKey("weapon_carbinerifle")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                end
                if(player_rank >= 4) then
                    local weaponHash = GetHashKey("weapon_combatmg")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                end
                if(player_rank >= 5) then
                    local weaponHash = GetHashKey("weapon_sniperrifle")
                    GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                end
            end
        end
    elseif(faction == 7) then
        local player_ped = GetPlayerPed(source)
        local player_pos = GetEntityCoords(player_ped)
        local distancee = math.sqrt((math.pow(251.92088317871 - player_pos.x, 2) + math.pow(-3066.369140625 - player_pos.y, 2) + math.pow(5.858642578125 - player_pos.z, 2)))
        if(distancee > 2) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        else
            local player_rank = exports.playerdata:getFactionRank(source)
            if(player_rank >= 1) then
                local weaponHash = GetHashKey("weapon_sniperrifle")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                weaponHash = GetHashKey("weapon_appistol")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                weaponHash = GetHashKey("weapon_microsmg")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
            end
            if(player_rank >= 2) then
                local weaponHash = GetHashKey("weapon_pumpshotgun")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                weaponHash = GetHashKey("weapon_smg")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
            end
            if(player_rank >= 3) then
                local weaponHash = GetHashKey("weapon_assaultrifle")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
                weaponHash = GetHashKey("weapon_carbinerifle")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
            end
            if(player_rank >= 4) then
                local weaponHash = GetHashKey("weapon_combatmg")
                GiveWeaponToPed(player_ped, weaponHash, 9999, false)
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
function IsPlayerAtSeif(source)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local distancee = math.sqrt((math.pow(117.81098937988 - player_pos.x, 2) + math.pow(-1943.6966552734 - player_pos.y, 2) + math.pow(20.635864257812 - player_pos.z, 2)))
    if(distancee <= 3) then
        return true
    end
    local distancee = math.sqrt((math.pow(-611.86810302734 - player_pos.x, 2) + math.pow(-1038.7912597656 - player_pos.y, 2) + math.pow(21.78173828125 - player_pos.z, 2)))
    if(distancee <= 3) then
        return true
    end
    local distancee = math.sqrt((math.pow(1389.1516113281 - player_pos.x, 2) + math.pow(1132.0615234375 - player_pos.y, 2) + math.pow(114.32092285156 - player_pos.z, 2)))
    if(distancee <= 3) then
        return true
    end
    local distancee = math.sqrt((math.pow(-1811.7362060547 - player_pos.x, 2) + math.pow(446.8747253418 - player_pos.y, 2) + math.pow(128.50842285156 - player_pos.z, 2)))
    if(distancee <= 3) then
        return true
    end
    return false
end

RegisterCommand("depositdrugs", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then --- aici adaugam pentru vip sa poata depozita
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(IsPlayerAtSeif(source) == true) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/depositdrugs", {0,0,0}, "^7 <amount>")
            else
                local drugs = tonumber(args[1])
                if(drugs == nil) then
                    TriggerClientEvent("chatMessage", source, "^1/depositdrugs", {0,0,0}, "^7 <amount>")
                else
                    local player_drugs = exports.playerdata:getDrugs(source)
                    local player_safedrugs = exports.playerdata:getSafeDrugs(source)
                    if(player_drugs < drugs) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule droguri!")
                    else
                        player_drugs = player_drugs - drugs
                        player_safedrugs = player_safedrugs + drugs
                        exports.playerdata:setDrugs(source, player_drugs)
                        exports.playerdata:setSafeDrugs(source, player_safedrugs)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai depozitat ^4" .. drugs .. "^7 droguri.")
                        exports.playerdata:updateDrugs(source)
                        exports.playerdata:updateSafeDrugs(source)
                    end
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        end 
    end
end, false) 
RegisterCommand("withdrawdrugs", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then --- aici adaugam pentru vip sa poata depozita
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(IsPlayerAtSeif(source) == true) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/withdrawdrugs", {0,0,0}, "^7 <amount>")
            else
                local drugs = tonumber(args[1])
                if(drugs == nil) then
                    TriggerClientEvent("chatMessage", source, "^1/withdrawdrugs", {0,0,0}, "^7 <amount>")
                else
                    local player_drugs = exports.playerdata:getDrugs(source)
                    local player_safedrugs = exports.playerdata:getSafeDrugs(source)
                    if(player_safedrugs < drugs) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule droguri!")
                    else
                        player_drugs = player_drugs + drugs
                        player_safedrugs = player_safedrugs - drugs
                        exports.playerdata:setDrugs(source, player_drugs)
                        exports.playerdata:setSafeDrugs(source, player_safedrugs)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai retras ^4" .. drugs .. "^7 droguri.")
                        exports.playerdata:updateDrugs(source)
                        exports.playerdata:updateSafeDrugs(source)
                    end
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        end 
    end
end, false) 
RegisterCommand("depositmats", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then --- aici adaugam pentru vip sa poata depozita
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(IsPlayerAtSeif(source) == true) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/depositmats", {0,0,0}, "^7 <amount>")
            else
                local mats = tonumber(args[1])
                if(mats == nil) then
                    TriggerClientEvent("chatMessage", source, "^1/depositmats", {0,0,0}, "^7 <amount>")
                else
                    local player_mats = exports.playerdata:getMats(source)
                    local player_safemats = exports.playerdata:getSafeMats(source)
                    if(player_mats < mats) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule materiale!")
                    else
                        player_mats = player_mats - mats
                        player_safemats = player_safemats + mats
                        exports.playerdata:setMats(source, player_mats)
                        exports.playerdata:setSafeMats(source, player_safemats)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai depozitat ^4" .. mats .. "^7 materiale.")
                        exports.playerdata:updateMats(source)
                        exports.playerdata:updateSafeMats(source)
                    end
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        end 
    end
end, false) 
RegisterCommand("withdrawmats", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then --- aici adaugam pentru vip sa poata depozita
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(IsPlayerAtSeif(source) == true) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/withdrawmats", {0,0,0}, "^7 <amount>")
            else
                local mats = tonumber(args[1])
                if(mats == nil) then
                    TriggerClientEvent("chatMessage", source, "^1/withdrawmats", {0,0,0}, "^7 <amount>")
                else
                    local player_mats = exports.playerdata:getMats(source)
                    local player_safemats = exports.playerdata:getSafeMats(source)
                    if(player_safemats < mats) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule materiale!")
                    else
                        player_mats = player_mats + mats
                        player_safemats = player_safemats - mats
                        exports.playerdata:setMats(source, player_mats)
                        exports.playerdata:setSafeMats(source, player_safemats)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai retras ^4" .. mats .. "^7 materiale.")
                        exports.playerdata:updateMats(source)
                        exports.playerdata:updateSafeMats(source)
                    end
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locatia potrivita!")
        end 
    end
end, false) 
RegisterCommand("checkprot", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/checkprot", {0,0,0}, "^7 <id>")
        else
            local target_dbid = tonumber(args[1])
            if(target_dbid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/checkprot", {0,0,0}, "^7 <id>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == false) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                else
                    local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                    local target_faction = exports.playerdata:getFaction(target_src)
                    if(target_faction >= 2 or target_faction <= 5) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un mafiot!")
                    else
                        local cTime = os.time()
                        local taxa_expire_time
                        if(faction == 2) then
                            taxa_expire_time = exports.playerdata:getTaxa1(target_src)
                        elseif(faction == 3) then
                            taxa_expire_time = exports.playerdata:getTaxa2(target_src)
                        elseif(faction == 4) then
                            taxa_expire_time = exports.playerdata:getTaxa3(target_src)
                        else
                            taxa_expire_time = exports.playerdata:getTaxa4(target_src)
                        end
                        if(cTime > taxa_expire_time) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4" .. GetPlayerName(target_src) .. " [ID:" .. target_dbid .. "]^7 is ^1unprotected.")
                        else
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4" .. GetPlayerName(target_src) .. " [ID:" .. target_dbid .. "]^7 is ^2protected.")
                        end
                    end
                end
            end
        end
    end
end, false) 
RegisterCommand("protections", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction >= 2 and faction <= 5) then 
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local taxa1 = exports.playerdata:getTaxa1(source)
        local taxa2 = exports.playerdata:getTaxa2(source)
        local taxa3 = exports.playerdata:getTaxa3(source)
        local taxa4 = exports.playerdata:getTaxa4(source)
        local cTime = os.time()
        if(taxa1 < cTime) then
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7Grove Street ^1NO")
        else
            local var = taxa1 - cTime
            local ore = var / 3600
            local minute = ( var % 3600 ) / 60
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7Grove Street ^2YES ^7(^4" .. ore .. "^7h ^4" .. minute .. "^7m)")
        end
        if(taxa2 < cTime) then
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7Ballas ^1NO")
        else
            local var = taxa2 - cTime
            local ore = var / 3600
            local minute = ( var % 3600 ) / 60
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7Ballas ^2YES ^7(^4" .. ore .. "^7h ^4" .. minute .. "^7m)")
        end

        if(taxa3 < cTime) then
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7The Triads ^1NO")
        else
            local var = taxa3 - cTime
            local ore = var / 3600
            local minute = ( var % 3600 ) / 60
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7The Triads ^2YES ^7(^4" .. ore .. "^7h ^4" .. minute .. "^7m)")
        end
        if(taxa4 < cTime) then
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7The Mafia ^1NO")
        else
            local var = taxa4 - cTime
            local ore = var / 3600
            local minute = ( var % 3600 ) / 60
            TriggerClientEvent("chatMessage", source, "^1[PROTECTIONS]", {0,0,0}, "^7The Mafia ^2YES ^7(^4" .. ore .. "^7h ^4" .. minute .. "^7m)")
        end
    end
end, false)   
RegisterCommand("protect", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction < 2 or faction > 5) then 
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/protect", {0,0,0}, "^7 <id> <hours(1-24)>")
        else
            local target_dbid = tonumber(args[1])
            local protect_hours = tonumber(args[2])
            if(target_dbid == nil or protect_hours == nil or protect_hours > 24 or protect_hours < 1) then
                TriggerClientEvent("chatMessage", source, "^1/protect", {0,0,0}, "^7 <id> <hours(1-24)>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) == false) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat!")
                else
                    local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                    local target_faction = exports.playerdata:getFaction(target_src) 
                    if(target_faction >= 2 or target_faction <= 5) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti proteja un mafiot!")
                    else
                        local cTime = os.time()
                        local taxa_expire_time
                        if(faction == 2) then
                            taxa_expire_time = exports.playerdata:getTaxa1(target_src)
                        elseif(faction == 3) then
                            taxa_expire_time = exports.playerdata:getTaxa2(target_src)
                        elseif(faction == 4) then
                            taxa_expire_time = exports.playerdata:getTaxa3(target_src)
                        else
                            taxa_expire_time = exports.playerdata:getTaxa4(target_src)
                        end
                        if(taxa_expire_time > cTime + 60 * 60) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul este deja protejat de mafia ta.\nPoti oferi protectie unui jucator care mai are mai putin de o ora ramasa.")
                        else
                            local cTaxa = math.max(taxa_expire_time + cTime) + 60 * 60 * protect_hours
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "I-ai oferit protectie pentru ^4" .. protect_hours .. "^7 ore jucatorului ^4" .. GetPlayerName(target_src) .. " [ID:" .. target_dbid .. "]^7.")
                            if(faction == 2) then
                                exports.playerdata:setTaxa1(target_src, cTaxa)
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4Grove Street ^7 ti-a oferit potectie pentru ^4" .. protect_hours .. " ^7ore.")
                                exports.playerdata:updateTaxa1(target_src)
                            elseif(faction == 3) then
                                exports.playerdata:setTaxa2(target_src, cTaxa)
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4Ballas ^7 ti-a oferit potectie pentru ^4" .. protect_hours .. " ^7ore.")
                                exports.playerdata:updateTaxa2(target_src)
                            elseif(faction == 4) then
                                exports.playerdata:setTaxa3(target_src, cTaxa)
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4The Triads ^7 ti-a oferit potectie pentru ^4" .. protect_hours .. " ^7ore.")
                                exports.playerdata:updateTaxa3(target_src)
                            else
                                exports.playerdata:setTaxa4(target_src, cTaxa)
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^4The Mafia ^7 ti-a oferit potectie pentru ^4" .. protect_hours .. " ^7ore.")
                                exports.playerdata:updateTaxa4(target_src)
                            end
                        end
                    end
                end
            end
        end
    end
end, false) 
RegisterCommand("fmute", function(source, args) 
    local player_faction = exports.playerdata:getFaction(source)
    local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank >= 5 ) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/fmute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
        else
            local dbid = tonumber(args[1])
            local mute_minutes = tonumber(args[2])
            local reason = args[3]
            if(#args > 3) then
                for i = 4, #args do
                    reason = reason .. " "
                    reason = reason .. args[i]
                end
            end
            if(dbid ~= nil and mute_minutes ~= nil) then
                if(mute_minutes <= 0) then
                    TriggerClientEvent("chatMessage", source, "^1/fmute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
                else
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        local target_faction = exports.playerdata:getFaction(target_source)
                        local target_faction_rank = exports.playerdata:getFactionRank(target_source)
                        if(target_faction ~= player_faction) then
                            TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Jucatorul nu se afla in aceeasi factiune cu tine.")
                        else
                            if(target_faction_rank >= 5) then
                                TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un jucator cu un rank mai mare sau egal cu al tau.")
                            else
                                local target_mute = exports.playerdata:getFMute(target_source)
                                if(target_mute > 0) then
                                    TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Acel jucator are deja mute.")
                                else
                                    exports.playerdata:setFMute(target_source, mute_minutes * 60)
                                    local message = "^7Membrul ^3" .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "] ^7 a primit mute pentru ^3" .. mute_minutes .. "m^7 de la ^3" .. GetPlayerName(source) .. "^7. Reason: " .. reason
                                    exports.playerdata:SendFactionMessage(player_faction, message)
                                    exports.playerdata:updateFMute(target_source)
                                end
                            end
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Player is not connected.")
                    end 
                end
            else
                TriggerClientEvent("chatMessage", source, "^1/fmute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("funmute", function(source, args) 
    local player_faction = exports.playerdata:getFaction(source)
    local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank >= 5 ) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/funmute", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    local target_faction = exports.playerdata:getFaction(target_source)
                    if(target_faction ~= player_faction) then
                        TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Jucatorul nu se afla in aceeasi factiune cu tine.")
                    else
                        local target_mute = exports.playerdata:getFMute(target_source)
                        if(target_mute <= 0) then
                            TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Jucatorul nu are mute.")
                        else
                            exports.playerdata:setFMute(target_source, 0)
                            TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7I-ai dat unmute jucatorului ^3" .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "]^7.")
                            TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Ai primit unmute de la ^3" .. GetPlayerName(source) .. "^7.")
                            exports.playerdata:updateFMute(target_source)
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Factions]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/unmute", {0,0,0}, "^7 <DB_ID>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
local timer_usepills = {}
RegisterNetEvent("sis_factions-s::resetPillsTimer")
AddEventHandler("sis_factions-s::resetPillsTimer", function(source)
    timer_usepills[source] = nil
end)
RegisterCommand("usepills", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction == 2 or player_faction == 3 or player_faction == 4 or player_faction == 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti folosi aceasta comanda.")
    else
        local player_pills = exports.playerdata:getPills(source)
        if(player_pills ~= 0) then
            local player_hp = GetEntityHealth(GetPlayerPed(source))
            if(player_hp == 100 or player_hp == 200) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai viata full.")
            else
                local cTime = os.time()
                if(timer_usepills[source] == nil or timer_usepills[source] + 60 <= cTime) then
                    timer_usepills[source] = cTime
                    player_pills = player_pills - 1
                    exports.playerdata:setPills(source, player_pills)
                    TriggerClientEvent("sis_factions-c::usePills", source)
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai folosit o pastila.")
                    exports.playerdata:updatePills(source)
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Trebuie sa astepti 60s pentru a folosi aceasta comanda.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai pills.")
        end
    end
end, false)
RegisterCommand("getpills", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 6) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti folosi aceasta comanda.")
    else
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local distancee = math.sqrt((math.pow(-448.11428833008 - player_pos.x, 2) + math.pow(-332.34725952148 - player_pos.y, 2) + math.pow(34.486450195313 - player_pos.z, 2)))
        if(distancee <= 3) then
            local player_pills = exports.playerdata:getPills(source)
            local player_faction_rank = exports.playerdata:getFactionRank(source)
            local max_pills = player_faction_rank * 50
            if(player_pills == max_pills) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai deja numarul maxim de pills.")
            else
                if(#args < 1) then
                    TriggerClientEvent("chatMessage", source, "^1/getpills", {0,0,0}, "^7 <amount>")
                else
                    local pills = tonumber(args[1])
                    if(pills == nil or pills < 1 or pills > max_pills - player_pills) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Poti lua maxim ^4" .. max_pills - player_pills .. "^7 pills.")
                    else
                        player_pills = player_pills + pills
                        exports.playerdata:setPills(source, player_pills)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai luat ^4" .. pills.. "^7 pills. Acum ai ^4" .. player_pills .. "^7 pills.")
                        exports.playerdata:updatePills(source)
                    end
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli in locul potrivit.")
        end
    end
end, false)
local pills_offer = {}
for i = 1, 130 do
    pills_offer[i] = {}
end
RegisterCommand("sellpills", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction ~= 6) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti folosi aceasta comanda.")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/sellpills", {0,0,0}, "^7 <id> <amount(1-10)>")
        else
            local target_sqlid = tonumber(args[1])
            local amount = tonumber(args[2])
            if(target_sqlid == nil or amount == nil or amount > 10 or amount < 1) then
                TriggerClientEvent("chatMessage", source, "^1/sellpills", {0,0,0}, "^7 <id> <amount(1-10)>")
            else
                if(exports.playerdata:IsSqlIdConnected(target_sqlid) ~= true) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat.")
                else
                    local target_source = tonumber(exports.playerdata:getSourceFromDBID(target_sqlid))
                    local target_faction = exports.playerdata:getFaction(target_source)
                    if(target_faction == 6) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul este medic.")
                    else
                        local player_pills = exports.playerdata:getPills(source)

                        if(player_pills < amount) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule pills.")
                        else
                            local player_pos = GetEntityCoords(GetPlayerPed(source))
                            local target_pos = GetEntityCoords(GetPlayerPed(target_source))
                            local distancee = math.sqrt((math.pow(target_pos.x - player_pos.x, 2) + math.pow(target_pos.y - player_pos.y, 2) + math.pow(target_pos.z - player_pos.z, 2)))
                            if(distancee > 5) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este langa tine.")
                            else
                                local target_pills = exports.playerdata:getPills(target_source)
                                if(target_pills + amount > 10) then
                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul are deja ^4" .. target_pills .. " ^7pills. Ii poti vinde maxim ^4" .. 10- target_pills .. "^7 pills.")
                                else
                                    local target_money = exports.playerdata:getMoney(target_source)
                                    if(target_money < amount * 100) then
                                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu are destui bani.")
                                    else
                                        pills_offer[source][target_source] = amount
                                        local player_dbid = exports.playerdata:getSqlID(source)
                                        TriggerClientEvent("chatMessage", target_source, "^1[Info]", {0,0,0}, "^7Medicul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] ti-a oferit ^4" .. amount .. "^7 pills pentru ^4" .. 100 * amount .. "$^7. Pentru a accepta foloseste comanda: ^4/acceptpills " .. player_dbid .. " " .. amount .. "^7.")
                                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai oferit jucatorului " .. GetPlayerName(target_source) .. "[ID:" .. target_sqlid .. "] ^4" .. amount .. "^7 pills.")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("acceptpills", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
    if(player_faction == 6) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti folosi aceasta comanda.")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/acceptpills", {0,0,0}, "^7 <id> <amount(1-10)>")
        else
            local medic_dbid = tonumber(args[1])
            local amount = tonumber(args[2])
            if(medic_dbid == nil or amount == nil or amount > 10 or amount < 1) then
                TriggerClientEvent("chatMessage", source, "^1/acceptpills", {0,0,0}, "^7 <id> <amount(1-10)>")
            else
                if(exports.playerdata:IsSqlIdConnected(medic_dbid) ~= true) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Medicul nu este conectat.")
                else
                    local medic_source = tonumber(exports.playerdata:getSourceFromDBID(medic_dbid))
                    local medic_faction = exports.playerdata:getFaction(medic_source)
                    if(medic_faction ~= 6) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu mai este medic.")
                    else
                        local medic_pos = GetEntityCoords(GetPlayerPed(medic_source))
                        local player_pos = GetEntityCoords(GetPlayerPed(source))
                        local distancee = math.sqrt((math.pow(medic_pos.x - player_pos.x, 2) + math.pow(medic_pos.y - player_pos.y, 2) + math.pow(medic_pos.z - player_pos.z, 2)))
                        if(distancee > 5) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Medicul nu este langa tine.")
                        else
                            if(pills_offer[medic_source][source] == nil or pills_offer[medic_source][source] ~= amount) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Oferta inexistenta.")
                            else
                                local medic_pills = exports.playerdata:getPills(medic_source) 
                                if(medic_pills < amount) then
                                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Medicul nu mai are destule pills.")
                                else
                                    local player_pills = exports.playerdata:getPills(source)
                                    if(player_pills + amount > 10) then
                                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Poti detine maxim 10 pills.")
                                        pills_offer[medic_source][source] = nil
                                    else
                                        local player_money = exports.playerdata:getMoney(source)
                                        if(amount * 100 > player_money) then
                                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani. Iti mai trebuie ^4" .. amount * 100 - player_money .. "$^7.")
                                        else
                                            pills_offer[medic_source][source] = nil
                                            medic_pills = medic_pills - amount
                                            player_pills = player_pills + amount
                                            exports.playerdata:setPills(source, player_pills)
                                            exports.playerdata:setPills(medic_source, medic_pills)
                                            local medic_money = exports.playerdata:getMoney(medic_source) + amount * 100
                                            player_money = player_money - amount * 100
                                            local player_dbid = exports.playerdata:getSqlID(source)
                                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai cumparat ^4" .. amount .. "^7 pills pentru ^4" .. amount*100 .. "$^7.")
                                            TriggerClientEvent("chatMessage", medic_source, "^1[Info]", {0,0,0}, "^7Jucatorul ".. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] ti-a acceptat oferta pentru ^4" .. amount .. "^7 pills.")
                                            local medic_sold_pills = exports.playerdata:getSoldPills(medic_source) + amount
                                            exports.playerdata:setSoldPills(medic_source, medic_sold_pills)
                                            exports.playerdata:updateSoldPills(medic_source)
                                            exports.playerdata:setMoney(source, player_money)
                                            exports.playerdata:setMoney(medic_source, medic_money)
                                            exports.playerdata:updateMoney(source)
                                            exports.playerdata:updateMoney(medic_source)
                                            exports.playerdata:updatePills(source)
                                            exports.playerdata:updatePills(medic_source)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end, false)
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    for i = 1, 130 do
        pills_offer[player_src][i] = nil
        pills_offer[i][player_src] = nil
    end
end)
RegisterCommand("contract", function(source, args)
    if(#args < 2) then
        TriggerClientEvent("chatMessage", source, "^1/contract", {0,0,0}, "^7 <id> <price(10.000$ - 100.000$)>")
    else
        local target_dbid = tonumber(args[1])
        local contract_price = tonumber(args[2])
        if(target_dbid == nil or contract_price == nil or contract_price < 10000 or contract_price > 100000) then
            TriggerClientEvent("chatMessage", source, "^1/contract", {0,0,0}, "^7 <id> <price(10.000$ - 100.000$)>")
        else
            local player_money = exports.playerdata:getMoney(source)
            if(player_money < contract_price) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani.")
            else
                if(exports.playerdata:IsSqlIdConnected(target_dbid) ~= true) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat.")
                else
                    local target_source = tonumber(exports.playerdata:getSourceFromDBID(target_dbid))
                    if(target_source == source) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti pune contract pe tine.")
                    else
                        local target_faction = exports.playerdata:getFaction(target_source)
                        if(target_faction == 7) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti pune contract pe un hitman.")
                        else
                            if(exports.playerdata:getContractPrice(target_source) ~= 0) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul are deja un contract.")
                            else
                                player_money = player_money - contract_price
                                exports.playerdata:setMoney(source, player_money)
                                exports.playerdata:setContractPrice(target_source, contract_price)
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai pus un contract pentru ^4" .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "] ^7 in valoare de ^4" .. contract_price .. "$^7.")
                                local text = "^7A fost pun un contract pentru ^4" .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "]^7 in valoare de ^4" .. contract_price .. "$^7."
                                exports.playerdata:SendFactionMessage(7, text)
                                exports.playerdata:updateContractPrice(target_source)
                                exports.playerdata:updateMoney(source)
                            end
                        end
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("contracts", function(source, args)
    local faction = exports.playerdata:getFaction(source)
    if(faction ~= 7) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        local data = {}
        local contracts = 0
        for _, player_src in ipairs(GetPlayers()) do
            local player_contract_price = exports.playerdata:getContractPrice(player_src)
            if(player_contract_price >= 1) then
                contracts = contracts + 1
                data[contracts] = {name, pos, sqlid, wanted, wantedreason}
                data[contracts].name = GetPlayerName(player_src)
                data[contracts].pos  = GetEntityCoords(GetPlayerPed(player_src))
                data[contracts].sqlid = exports.playerdata:getSqlID(player_src) 
                data[contracts].price = player_contract_price 
            end
        end
        TriggerClientEvent("sis_factions-c::enableContractsMenu", source, contracts, data)
    end
end, false)
local finding_sqlid = {}
RegisterCommand("cancelhit", function(source, args)
    if(finding_sqlid[tonumber(source)] ~= nil) then
        finding_sqlid[tonumber(source)] = nil
        TriggerClientEvent("sis_factions-c::setFindingSQLID", source, nil)
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai incetat urmarirea jucatorului!")
    end
end, false)
RegisterNetEvent("sis_factions-s::updateContractsMenu")
AddEventHandler("sis_factions-s::updateContractsMenu", function(source)
    local data = {}
    local contracts = 0
    for _, player_src in ipairs(GetPlayers()) do
        local player_contract_price = exports.playerdata:getContractPrice(player_src)
        if(player_contract_price >= 1) then
            contracts = contracts + 1
            data[contracts] = {name, pos, sqlid, wanted, wantedreason}
            data[contracts].name = GetPlayerName(player_src)
            data[contracts].pos  = GetEntityCoords(GetPlayerPed(player_src))
            data[contracts].sqlid = exports.playerdata:getSqlID(player_src) 
            data[contracts].price = player_contract_price 
        end
    end
    TriggerClientEvent("sis_factions-c::updateContractsMenu", source, contracts, data)
end)
RegisterNetEvent("sis_factions-s::updateFindingData")
AddEventHandler("sis_factions-s::updateFindingData", function(source)
    if(exports.playerdata:IsSqlIdConnected(finding_sqlid[tonumber(source)]) == true) then
        local target_src = exports.playerdata:getSourceFromDBID(finding_sqlid[tonumber(source)])
        local target_contract_price = exports.playerdata:getContractPrice(target_src)
        if(target_contract_price == 0) then
            TriggerClientEvent("chatMessage", source, "^4[Hitman]", {0,0,0}, "^7Jucatorul nu mai are contract!")
            finding_sqlid[tonumber(source)] = nil
            TriggerClientEvent("sis_factions-c::setFindingSQLID", source, nil)
        else
            local target_ped = GetPlayerPed(target_src)
            local target_pos = GetEntityCoords(target_ped)
            TriggerClientEvent("sis_factions-c::updateFindingData", source, target_pos)
        end
    else
        TriggerClientEvent("chatMessage", source, "^4[Hitman]", {0,0,0}, "^7Jucatorul pe care il cautai a iesit de pe server!")
        finding_sqlid[tonumber(source)] = nil
        TriggerClientEvent("sis_factions-c::setFindingSQLID", source, nil)
    end
end)
RegisterNetEvent("sis_factions-s::setFindingSQLID")
AddEventHandler("sis_factions-s::setFindingSQLID", function(source, target_dbid)
    finding_sqlid[tonumber(source)] = target_dbid
end)
RegisterNetEvent("sis_factions::resetCopDuty")
AddEventHandler("sis_factions::resetCopDuty", function(source)
    cop_duty[tonumber(source)] = nil
end)

RegisterNetEvent("baseevents:enteringVehicle")
AddEventHandler("baseevents:enteringVehicle", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    local player_src = source
    print(vehicleDisplayName)
    --ClearPedTasksImmediately(GetPlayerPed(player_src))
end)
