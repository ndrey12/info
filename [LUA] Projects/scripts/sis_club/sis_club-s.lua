
RegisterCommand("c", function(source, args)
    local club_id = exports.playerdata:getClub(source)
    if(club_id > 0) then
        --de verificat daca are club mute
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/c", {0,0,0}, "^7 <message>")
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
                if exports.playerdata:getClub(playerId) == club_id then
                    if(club_id == 1) then
                        TriggerClientEvent('chat:addMessage', playerId, { args = { "[NFS]^7"..player_name.."["..player_dbid.."]", message}, color = {191, 144, 13} })
                    elseif(club_id == 2) then
                        TriggerClientEvent('chat:addMessage', playerId, { args = { "[F&F]^7"..player_name.."["..player_dbid.."]", message}, color = {13, 170, 191} })
                    end
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cinvite", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(args[1] == nil) then
            TriggerClientEvent("chatMessage", source, "^1/cinvite", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(exports.playerdata:dbid_exist(dbid) == true) then
                if(dbid > 0) then
                    if(exports.playerdata:getClub_DBID(dbid) == 0) then
                            club_id = exports.playerdata:getClub(source)
                            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7 L-ai invitat in club pe jucatorul " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
                                TriggerClientEvent("chatMessage", target_source, "^1[CLUB]", {0,0,0}, "^7 Ai fost invitat in club de catre " .. GetPlayerName(source) .. "[" .. dbid .. "].")
                                exports.playerdata:setClub(target_source, club_id)
                                exports.playerdata:updateClub(target_source) 
                                exports.playerdata:setClubRank(target_source, 1)
                                exports.playerdata:updateClubRank(target_source) 
                            else
                                exports.playerdata:updateClub_DBID(dbid, club_id)
                                exports.playerdata:updateClubRank_DBID(dbid, 1)
                                TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7 l-ai invitat in club pe jucatorului cu ID  " .. dbid .. ".")
                            end
                            exports.playerdata:addLog("[CInvite] " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] l-a invitat in club pe jucatorului cu ID  " .. dbid )
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Jucatorul se afla deja intr-un club!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/cinvite", {0,0,0}, "^7 <DB_ID>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cuninvite", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/cuninvite", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            local reason = args[2]
            if(#args > 2) then
                for i = 3, #args do
                    reason = reason .. " "
                    reason = reason .. args[i]
                end
            end
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                if(dbid > 0) then
                    club_id = exports.playerdata:getClub(source)
                    if(exports.playerdata:getClub_DBID(dbid) == club_id) then
                        if(exports.playerdata:getClubRank_DBID(dbid) < 7) then
                            local lider_dbid = exports.playerdata:getSqlID(source)
                            exports.playerdata:UnInvitePlayerFromClub(dbid, lider_dbid, reason)
                            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7L-ai dat afara pe ".. GetPlayerName(target_source) .. "[" .. dbid .. "]" .. " din club.")
                                TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)

                                TriggerClientEvent("chatMessage", target_source, "^1[!!]", {0,0,0}, "^7Ai fost dat afara din club de catre ".. GetPlayerName(source) .. "[" .. lider_dbid .. "].")
                                TriggerClientEvent("chatMessage", target_source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)
                            else
                                TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7L-ai dat afara pe ".. exports.playerdata:getName_DBID(dbid) .. "[" .. dbid .. "]" .. " din club.")
                                TriggerClientEvent("chatMessage", source, "^1[!!]", {0,0,0}, "^7Reason: ".. reason)
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un lider!")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Acel jucator nu este in club cu tine!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/cuninvite", {0,0,0}, "^7 <DB_ID> <REASON>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cwarn", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/cwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
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
                local lider_club = exports.playerdata:getClub(source)
                if(exports.playerdata:getClub_DBID(dbid) == lider_club) then
                    if(exports.playerdata:getClubRank_DBID(dbid) < 7) then
                    
                        local lider_name = GetPlayerName(source)
                        local lider_dbid = exports.playerdata:getSqlID(source) 
                        cwarns = exports.playerdata:CWarnPlayer(dbid, lider_dbid, reason)
                        local player_name = ""
                        if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                            player_name = GetPlayerName(exports.playerdata:getSourceFromDBID(dbid))
                        else
                            player_name = exports.playerdata:getName_DBID(dbid)
                        end
                        if(cwarns < 3) then --- aici modific limita de warn-uri pentru a da afara pe cnv
                            for _, playerId in ipairs(GetPlayers()) do
                                if (exports.playerdata:getClub(playerId) == lider_club) then
                                    TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7" .. player_name .. "[ID:" .. dbid .. "]" .. " a primit cwarn de la " .. lider_name .. "[ID:" .. lider_dbid.. "]")
                                    TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7Reason: " .. reason)
                                end
                            end
                        else
                            --[[aici jucatorul va primi uninvite pentru cele 3  faction warnuri si se vor reseta]]--
                            for _, playerId in ipairs(GetPlayers()) do
                                if (exports.playerdata:getClub(playerId) == lider_club) then
                                    TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7" .. player_name .. "[ID:" .. dbid .. "]" .. " a fost dat afara din club de catre " .. lider_name .. "[ID:" .. lider_dbid .. "]")
                                    TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7Reason: " .. "3/3 club warns ("..reason .. ")")
                                end
                            end
                            exports.playerdata:UnInvitePlayerFromClub(dbid, lider_dbid, "3/3 club warns ("..reason .. ")")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " Nu poti da club warn unui lider.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " Acel jucator nu este in clubul cu tine.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cunwarn", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/cunwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
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
                local lider_club = exports.playerdata:getClub(source)
                if(exports.playerdata:getClub_DBID(dbid) == lider_club) then
                    local lider_name = GetPlayerName(source)
                    local lider_dbid = exports.playerdata:getSqlID(source) 
                    local target_name = exports.playerdata:getName_DBID(dbid)
                    if(exports.playerdata:CUnWarnPlayer(dbid, lider_dbid, reason) == true) then
                        for _, playerId in ipairs(GetPlayers()) do
                            if (exports.playerdata:getClub(playerId) == lider_club) then
                                TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7" .. target_name .. "[ID:" .. dbid .. "]" .. " a primit club unwarn de la " .. lider_name .. "[ID:" .. lider_dbid .. "]")
                                TriggerClientEvent("chatMessage", playerId, "^1[CLUB]", {0,0,0}, "^7Reason: " .. reason)
                            end
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Acel jucator nu are club warn-uri.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " Acel jucator nu este in clubul tau.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[CLUB]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cmembers", function(source, args)
    local club = exports.playerdata:getClub(source)
    if(club ~= 0) then
        local p = promise:new()
        exports.ghmattimysql:execute("SELECT `id`, `name`, `club_rank`, `club_warn`, `bpoints` FROM `users` WHERE `club` = @club", {["@club"] = club}, 
        function(result)
            p:resolve(result)
        end)
        local data = Citizen.Await(p)
        local connected = {}
        for i = 1, #data do
            if(exports.playerdata:IsSqlIdConnected(data[i].id) == true) then
                connected[i] = 1
            else
                connected[i] = 2
            end
        end
        TriggerClientEvent("sis_club::EnableMenu", source, data, connected)
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("givebp", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/givebp", {0,0,0}, "^7 <DB_ID> <AMOUNT>")
        else
            local dbid = tonumber(args[1])
            local amount = tonumber(args[2])
            if(dbid == nil or amount == nil) then
                TriggerClientEvent("chatMessage", source, "^1/givebp", {0,0,0}, "^7 <DB_ID> <AMOUNT> <REASON>")
            else
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_src = exports.playerdata:getSourceFromDBID(dbid)
                    local player_club = exports.playerdata:getClub(source)
                    local target_club = exports.playerdata:getClub(target_src)
                    if(player_club ~= target_club) then
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Jucatorul nu face parte din clubul tau!")
                    else
                        local bpoints = exports.playerdata:getBPoints(target_src)
                        bpoints = bpoints + amount
                        exports.playerdata:setBPoints(target_src, bpoints)
                        local player_dbid = exports.playerdata:getSqlID(source)
                        local reason = args[3]
                        if(#args > 3) then
                            for i = 4, #args do
                                reason = reason .. " "
                                reason = reason .. args[i]
                            end
                        end
                        local text = "^1[CLUB] ^7Liderul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. dbid .. "] ^3" .. amount .. " ^7BPoints. Acum avand ^3" .. bpoints .. "^7 BPoints."
                        exports.playerdata:SendClubMSG(player_club, text)  
                        exports.playerdata:SendClubMSG(player_club, "^1[CLUB] ^7Reason: " .. reason)  
                        exports.playerdata:updateBPoints(target_src)
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("setcrank", function(source, args)
    local club_rank = exports.playerdata:getClubRank(source)
    if(club_rank == 7) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setcrank", {0,0,0}, "^7 <DB_ID> <RANK(1-6)>")
        else
            local dbid = tonumber(args[1])
            local rank_level = tonumber(args[2])
            if(dbid == nil or rank_level == nil) then
                TriggerClientEvent("chatMessage", source, "^1/setcrank", {0,0,0}, "^7 <DB_ID> <RANK(1-6)>")
            else
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_src = exports.playerdata:getSourceFromDBID(dbid)
                    local player_club = exports.playerdata:getClub(source)
                    local target_club = exports.playerdata:getClub(target_src)
                    if(player_club ~= target_club) then
                        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Jucatorul nu face parte din clubul tau!")
                    else
                        local target_rank = exports.playerdata:getClubRank(target_src)
                        if(target_rank == 7) then
                            TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un lider!")
                        else
                            exports.playerdata:setClubRank(target_src, rank_level)
                            local player_dbid = exports.playerdata:getSqlID(source)
                            local text = "^1[CLUB] ^7Liderul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. dbid .. "] rank level ^3" .. rank_level .. " ^7."
                            exports.playerdata:SendClubMSG(player_club, text)
                            exports.playerdata:updateClubRank(target_src)
                            text = "[CLUB] Liderul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] i-a dat jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. dbid .. "] rank level " .. rank_level .. "."
                            exports.playerdata:addLog(text)   
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7Jucatorul nu este conectat!")
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[CLUB]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterNetEvent("sis_club_s_t::CheckActiveUI")
AddEventHandler("sis_club_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_club_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_club_s_r::CheckActiveUI")
AddEventHandler("sis_club_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 6)
end)