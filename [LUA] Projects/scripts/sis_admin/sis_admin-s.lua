local function GetAdminRankLevelName(level)
    if level == 1 then 
        return "[Helper]"
    end
    if level == 2 then 
        return "[Moderator]"
    end
    if level == 3 then 
        return "[Admin]"
    end
    if level == 4 then 
        return "[Co-Owner]"
    end
    if level == 5 then 
        return "[Owner]"
    end
    return "[Player]"
end

RegisterCommand("ac", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if adminlevel > 0 then
        local message = table.concat(args, " ")
        local playername = GetPlayerName(source)
        local rankname = GetAdminRankLevelName(adminlevel)
        for _, playerId in ipairs(GetPlayers()) do
            if exports.playerdata:getAdminLevel(playerId) > 0 then
                TriggerClientEvent("chatMessage", playerId, "", {0,0,0}, "^1" .. rankname .. "^7 " .. playername ..": ^1" .. message)
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("setadmin", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel == 5) then
    
        if(args[1] == nil or args[2] == nil) then
            TriggerClientEvent("chatMessage", source, "^1/setadmin", {0,0,0}, "^7 <DB_ID> <LEVEL(0-5)>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local a_lvl = tonumber(args[2])
                if(a_lvl ~= nil and dbid > 0 and a_lvl <= 5 and a_lvl >= 0) then
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai setat admin level " .. a_lvl .. " " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
                        TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7 Ai primit admin level " .. a_lvl .. " de la " .. GetPlayerName(source) .. "[" .. dbid .. "].")
                        exports.playerdata:setAdminLevel(target_source, a_lvl)
                        exports.playerdata:updateAdminLevel(target_source) 
                        TriggerEvent("player_tags::update")
                    else
                        exports.playerdata:updateAdminLevel_DBID(dbid, a_lvl)
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai setat admin level " .. a_lvl .. " jucatorului cu ID = " .. dbid .. ".")
                    end
                    exports.playerdata:addLog("[SetAdmin] " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] i-a setat admin level " .. a_lvl .. " jucatorului cu ID = " .. dbid .. "." )
                    print("[SetAdmin] " .. GetPlayerName(source) .. "[" .. exports.playerdata:getSqlID(source) .. "] i-a setat admin level " .. a_lvl .. " jucatorului cu ID = " .. dbid .. "." )
                else
                    TriggerClientEvent("chatMessage", source, "^1/setadmin", {0,0,0}, "^7<DB_ID> <LEVEL(0-5)>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end

end, false)

RegisterCommand("kick", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/ban", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:IsSqlIdConnected(dbid) == true) then
                local target_source = tonumber(exports.playerdata:getSourceFromDBID(dbid))
                local target_admin = tonumber(exports.playerdata:getAdminLevel(target_source))
                if(target_admin >= adminlevel) then
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti da kick unui admin cu grad mai mare sau egal cu al tau!")
                else
                    local reason = args[2]
                    if(#args > 2) then
                        for i = 3, #args do
                            reason = reason .. " "
                            reason = reason .. args[i]
                        end
                    end
                    local player_dbid = tonumber(exports.playerdata:getSqlID(source))
                    TriggerClientEvent("chatMessage", -1, "^1[KICK]", {0,0,0}, "^7!" .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "] a primit kick de la adminul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "]. Reason: ".. reason) 
                    DropPlayer(target_source, "You were kicked by " .. GetPlayerName(source) .."[ID:".. player_dbid .. "]" ..  "\nREASON: " .. reason)
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Jucatorul nu este conectat!") 
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!") 
    end
end, false)
--[[BAN SISTEM]]--
RegisterCommand("ban", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/ban", {0,0,0}, "^7 <DB_ID> <DAYS(0 = permanent)> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local days = tonumber(args[2])
                if(days ~= nil and dbid ~= nil) then
                    local reason = args[3]
                    if(#args > 3) then
                        for i = 4, #args do
                            reason = reason .. " "
                            reason = reason .. args[i]
                        end
                    end
                    if(exports.playerdata:getAdminLevel_DBID(dbid) < exports.playerdata:getAdminLevel(source)) then
                        if(exports.playerdata:BanPlayer(dbid, exports.playerdata:getSqlID(source), days, reason) == true) then
                            if(days == 0) then
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a fost banat permanent de catre " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                            else
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a fost banat pentru " .. days .. " zile" .. " de catre " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator este banat deja.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un admin care are un grad mai mare sau egal cu al tau!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/ban", {0,0,0}, "^7 <DB_ID> <DAYS(0 = permanent)> <REASON>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("unban", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/unban", {0,0,0}, "^7 <DB_ID> <REASON>")
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
                local var = exports.playerdata:UnBanPlayer(dbid, exports.playerdata:getSqlID(source), reason)
                if(exports.playerdata:UnBanPlayer(dbid, exports.playerdata:getSqlID(source), reason) == true) then
                    
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit unban de la " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este banat.")
                end    
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
--[[WARN SISTEM]]--
RegisterCommand("warn", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
    
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/warn", {0,0,0}, "^7 <DB_ID> <REASON>")
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
                if(exports.playerdata:getAdminLevel_DBID(dbid) <= exports.playerdata:getAdminLevel(source)) then
                    if(exports.playerdata:getWarn_DBID(dbid) < 4) then
                        exports.playerdata:WarnPlayer(dbid, exports.playerdata:getSqlID(source), reason)
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit warn de la " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                    else
                        --[[aici jucatorul va primi ban pentru cele 5 warnuri si se vor reseta]]--
                        --[[de verificat daca este deja banat]]--
                        if(exports.playerdata:BanPlayer(dbid, exports.playerdata:getSqlID(source), 3, "5/5 warn ("..reason .. ")") == true) then
                            exports.playerdata:updateWarn_DBID(dbid, 0)
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a fost banat pentru " .. 3 .. " zile" .. " de catre " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. "5/5 warn ("..reason .. ")")
                            
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti da warn unui jucator banat deja!")
                        end
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un admin care are un grad mai mare sau egal cu al tau!")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("unwarn", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/unwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
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
                if(exports.playerdata:UnWarnPlayer(dbid, exports.playerdata:getSqlID(source), reason) == true) then
                    
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit unwarn de la " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu are warn-uri.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
--[[202]]--
RegisterCommand("cc", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        for i=1,64 do 
            TriggerClientEvent("chatMessage", -1, "", {0,0,0}, "||")
        end
        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, GetPlayerName(source) .. " a sters chat-ul.")
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("goto", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/goto", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                if(dbid ~= exports.playerdata:getSqlID(source)) then
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        local pos = GetEntityCoords(GetPlayerPed(target_source))
                        SetEntityCoords(GetPlayerPed(source), pos.x, pos.y, pos.z)
                        TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7" .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] s-a teleportat la tine")
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este conectat.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe tine!")
                end    
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("gotoxyz", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/gotoxyz", {0,0,0}, "^7 <X> <Y> <Z>")
        else
            local x = tonumber(args[1]) + .0
            local y = tonumber(args[2]) + .0
            local z = tonumber(args[3]) + .0
            SetEntityCoords(GetPlayerPed(source), x, y, z)
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("savepos", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 5) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        local heading = GetEntityHeading(GetPlayerPed(source))
        print("X: " .. pos.x .. " Y: " .. pos.y ..  " Z: " .. pos.z .. "Heading: " .. heading )     
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("gethere", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
    
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/gethere", {0,0,0}, "^7<DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                if(dbid ~= exports.playerdata:getSqlID(source)) then
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        pos = GetEntityCoords(GetPlayerPed(source))
                        SetEntityCoords(GetPlayerPed(target_source), pos.x, pos.y, pos.z)
                        TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7" .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] te-a teleportat la el.")
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este conectat.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe tine!")
                end    
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
--[[Faction Sistem]]--
RegisterCommand("makeleader", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel == 5) then
    
        if(args[1] == nil or args[2] == nil) then
            TriggerClientEvent("chatMessage", source, "^1/makeleader", {0,0,0}, "^7 <DB_ID> <FACTION ID(1-7)>")
            TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^4(PD-1) ^2(GROVE STREET-2) ^6(BALLAS-3)")
            TriggerClientEvent("chatMessage", source, "^1Info:", {110, 67, 11}, "^0(THE TRIADS-4) ^8(THE MAFIA-5) (MEDICS-6)")
            TriggerClientEvent("chatMessage", source, "^1Info:", {125, 125, 125}, "^9(HITMAN-7)")
        else
            local dbid = tonumber(args[1])
            local faction_id = tonumber(args[2])
            if(faction_id ~= nil) then
                if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                    if(dbid > 0 and faction_id <= 7 and faction_id >= 1) then
                        if(exports.playerdata:getFaction_DBID(dbid) == 0) then
                            if(exports.playerdata:getFactionPunish_DBID(dbid) == 0) then
                                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai dat lider la factiunea numarul " .. faction_id .. " jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
                                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7 Ai primit lider la factiunea numarul " .. faction_id .. " de la " .. GetPlayerName(source) .. "[" .. dbid .. "].")
                                    exports.playerdata:setFaction(target_source, faction_id)
                                    exports.playerdata:updateFaction(target_source) 
                                    exports.playerdata:setFactionRank(target_source, 7)
                                    exports.playerdata:updateFactionRank(target_source) 
                                    TriggerEvent("player_tags::update")
                                else
                                    exports.playerdata:updateFaction_DBID(dbid, faction_id)
                                    exports.playerdata:updateFactionRank_DBID(dbid, 7)
                                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai dat lider la factiunea numarul  " .. faction_id .. " jucatorului cu ID = " .. dbid .. ".")
                                end
                                exports.playerdata:addLog("[MakeLeader] " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] i-a dat lider la factiunea numarul  " .. faction_id .. " jucatorului cu ID = " .. dbid .. "." )
                                print("[MakeLeader] " .. GetPlayerName(source) .. "[" .. exports.playerdata:getSqlID(source) .. "] i-a dat lider la factiunea numarul " .. faction_id .. " jucatorului cu ID = " .. dbid .. "." )
                            else
                                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator are FPunish") 
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este civil!")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1/makeleader", {0,0,0}, "^7 <DB_ID> <FACTION ID(1-7)>")
                        TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^4(PD-1) ^2(GROVE STREET-2) ^6(BALLAS-3)")
                        TriggerClientEvent("chatMessage", source, "^1Info:", {110, 67, 11}, "(THE TRIADS-4) ^8(THE MAFIA-5) (MEDICS-6)")
                        TriggerClientEvent("chatMessage", source, "^1Info:", {125, 125, 125}, "(HITMAN-7)")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1/makeleader", {0,0,0}, "^7 <DB_ID> <FACTION ID(1-7)>")
                TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^4(PD-1) ^2(GROVE STREET-2) ^6(BALLAS-3)")
                TriggerClientEvent("chatMessage", source, "^1Info:", {110, 67, 11}, "^0(THE TRIADS-4) ^8(THE MAFIA-5) (MEDICS-6)")
                TriggerClientEvent("chatMessage", source, "^1Info:", {125, 125, 125}, "^9(HITMAN-7)")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("fpk", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/fpk", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/fpk", {0,0,0}, "^7 <DB_ID> <REASON>")
            else
                local reason = args[2]
                if(#args > 2) then
                    for i = 3, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                local var = exports.playerdata:UnInvitePlayerFromFaction(dbid, exports.playerdata:getSqlID(source), reason, 0)
                if(var == true) then
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit fpk de la " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                elseif (var == false) then
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu se afla intr-o factiune.")
                end  
            end  
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("fixveh", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
        TriggerClientEvent('fixveh', source)
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("sethp", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/sethp", {0,0,0}, "^7 <DB_ID> <HP_LEVEL>")
        else
            local dbid = tonumber(args[1])
            local hp_level = tonumber(args[2])
            if(hp_level ~= nil and hp_level >= 0 and hp_level <= 200) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    TriggerClientEvent('sethp', target_source, hp_level)
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "] i-a fost setat HP-ul la " .. hp_level .. ".")
                local admin_dbid = exports.playerdata:getSqlID(source)
                TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]" .. " ti-a setat HP-ul la " .. hp_level .. ".")
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7HP_Level trebuie sa fie intre 0 si 200.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("setarmour", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setarmour", {0,0,0}, "^7 <DB_ID> <ARMOUR_LEVEL>")
        else
            local dbid = tonumber(args[1])
            local armour_level = tonumber(args[2])
            if(armour_level ~= nil and armour_level >= 0 and armour_level <= 100) then
                if(dbid ~= nil and exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    TriggerClientEvent('setarmour', target_source, armour_level)
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "] i-a fost setat armour level la " .. armour_level .. ".")
                local admin_dbid = exports.playerdata:getSqlID(source)
                TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]" .. " ti-a setat armour level la " .. armour_level .. ".")
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^Armour_level trebuie sa fie intre 0 si 100.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("aheal", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/aheal", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:IsSqlIdConnected(dbid) == true) then
                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                TriggerClientEvent('sethp', target_source, 200)
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai dat heal jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "]." )
                local admin_dbid = exports.playerdata:getSqlID(source)
                TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit heal de la adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]." )
            else
                 TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
            end 
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("aclear", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/aclear", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:IsSqlIdConnected(dbid) == true) then
                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                exports.playerdata:setWantedLevel(target_source, 0)
                TriggerClientEvent("sis_wanted-level::setWantedLevelClient", target_source, 0)
                exports.playerdata:updateWantedLevel(target_source, 0)
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai dat clear jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "]." )
                local admin_dbid = exports.playerdata:getSqlID(source)
                TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit clear de la adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]." )
                exports.playerdata:SendFactionMSG(1, "^4[PD]^7 Adminul ".. GetPlayerName(source) .. "[" .. admin_dbid .. "] a dat clear wanted jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
            else
                 TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
            end 
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("setwanted", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/setwanted", {0,0,0}, "^7 <DB_ID> <WANTED_LEVEL(0-6)> <REASON>")
        else
            local dbid = tonumber(args[1])
            local wanted_l = tonumber(args[2])
            local reason = args[3]

            if(#args > 3) then
                for i = 4, #args do
                    reason = reason .. " "
                    reason = reason .. args[i]
                end
            end
            if(dbid ~= nil and wanted_l ~= nil and wanted_l >= 0 and wanted_l <= 6) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    exports.playerdata:setWantedReason(target_source, reason)
                    exports.playerdata:setWantedLevel(target_source, wanted_l)
                    TriggerClientEvent("sis_wanted-level::setWantedLevelClient", target_source, wanted_l)
                    exports.playerdata:updateWantedLevel(target_source)
                    exports.playerdata:updateWantedReason(target_source)
                    local admin_dbid = exports.playerdata:getSqlID(source)
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]" .. " i-a setat wanted level " .. wanted_l .. " jucatorului " .. GetPlayerName(target_source) .. "[".. dbid .. "].")
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: ".. reason)
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/setwanted", {0,0,0}, "^7 <DB_ID> <WANTED_LEVEL(0-6)> <REASON>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("ajail", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 2) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/ajail", {0,0,0}, "^7 <DB_ID> <TIME(min)> <REASON>")
        else
            local dbid = tonumber(args[1])
            local time = tonumber(args[2])
            if(dbid == nil or time == nil) then
                TriggerClientEvent("chatMessage", source, "^1/ajail", {0,0,0}, "^7 <DB_ID> <TIME(min)> <REASON>")
            else
                local reason = args[3]
                if(#args > 3) then
                    for i = 4, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                if(time >= 0) then
                    if(exports.playerdata:dbid_exist(dbid) == true) then
                        local wanted_level = exports.playerdata:getWantedLevel_DBID(dbid)
                        if(wanted_level == 0) then
                            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                time_s = time * 60
                                exports.playerdata:setJailTime(target_source, time_s)
                                TriggerEvent("sis_jail-s::setJailTime", target_source, time_s)
                                TriggerClientEvent("sis_admin-c::RespawnPlayer", target_source)
                                exports.playerdata:updateJailTime(target_source)

                                local admin_dbid = exports.playerdata:getSqlID(source)
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]" .. " i-a dat jail pentru " .. time .. " min jucatorului " .. GetPlayerName(target_source) .. "[".. dbid .. "].")
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: ".. reason)
                            else
                                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                            end 
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator are wanted.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7DBID does not exist.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Timpul pedepsei trebuie sa fie mai mare decat 0 minute.")
                end
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("unwarnforall", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel == 5) then
        local dbid = exports.playerdata:getSqlID(source)
        for _, playerId in ipairs(GetPlayers()) do
            local target_dbid = exports.playerdata:getSqlID(playerId)
            exports.playerdata:UnWarnPlayer(target_dbid, dbid, "UNWARNFORALL")
        end
        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. dbid .. "] a dat unwarn la toti jucatorii online." )
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("moneyforall", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel == 5) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/moneyforall", {0,0,0}, "^7 <amount>")
        else
            local money = tonumber(args[1])
            if(money ~= nil) then
                local dbid = exports.playerdata:getSqlID(source)
                for _, playerId in ipairs(GetPlayers()) do
                    local pmoney = exports.playerdata:getMoney(playerId)
                    pmoney = pmoney + money
                    exports.playerdata:setMoney(playerId, pmoney)
                    exports.playerdata:updateMoney(playerId)
                end
                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. dbid .. "] a dat ".. money .. "$$ tuturor jucatorilor online." )
            else
                TriggerClientEvent("chatMessage", source, "^1/moneyforall", {0,0,0}, "^7 <amount>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("asetfp", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/asetfp", {0,0,0}, "^7 <DB_ID> <DAYS(0-30 days)> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local days = tonumber(args[2])
                if(days ~= nil and dbid ~= nil) then
                    if(days <= 30 and days >= 0) then
                        local reason = args[3]
                        if(#args > 3) then
                            for i = 4, #args do
                                reason = reason .. " "
                                reason = reason .. args[i]
                            end
                        end
                        ---de verificat daca days = 0 atunci sa scoatem direct
                        local fptime = os.time() + days * 24 * 3600
                        if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                            local target_source = exports.playerdata:getSourceFromDBID(dbid)
                            if(days > 0) then
                                exports.playerdata:setFactionPunish(target_source, fptime)
                            else
                                exports.playerdata:setFactionPunish(target_source, 0)
                            end
                            exports.playerdata:updateFactionPunish(target_source)
                            --- trimis mesaj la player+admin+log
                            local admin_dbid = exports.playerdata:getSqlID(source)
                            TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Adminul ".. GetPlayerName(source).. "["..admin_dbid.."] ti-a setat " .. days .. " zile de FPunish.\n")
                            TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Reason: "..reason)

                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai setat jucatorului ".. GetPlayerName(target_source).. "["..dbid.."] " .. days .. " zile de FPunish.\n")
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Reason: "..reason)
                            exports.playerdata:addLog("[ASETFP]"..GetPlayerName(source).."["..admin_dbid.."] i-a setat lui ".. GetPlayerName(target_source).. "[".. dbid.. "] "..days.."zile de FPunish.")                     
                        else
                            exports.playerdata:updateFactionPunish_DBID(dbid, fptime)
                            local target_name = exports.playerdata.getName_DBID(dbid)
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai setat jucatorului ".. target_name.. "["..dbid.."] " .. days .. " zile de FPunish.\n")
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Reason: "..reason)
                            exports.playerdata:addLog("[ASETFP]"..GetPlayerName(source).."["..admin_dbid.."] i-a setat lui ".. target_name.. "[".. dbid.. "] "..days.."zile de FPunish.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1/asetfp", {0,0,0}, "^7 <DB_ID> <DAYS(0-30 days)> <REASON>")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1/asetfp", {0,0,0}, "^7 <DB_ID> <DAYS(0-30 days)> <REASON>")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
            end
    
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("lwarn", function(source, args)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(admin_level >= 4) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/lwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local target_faction_rank = exports.playerdata:getFactionRank_DBID(dbid)
                if(target_faction_rank == 7) then
                    local reason = args[2]
                    if(#args > 2) then
                        for i = 3, #args do
                            reason = reason .. " "
                            reason = reason .. args[i]
                        end
                    end
                    local admin_dbid = exports.playerdata:getSqlID(source)
                    local lwarns = exports.playerdata:LWarnPlayer(dbid, admin_dbid, reason)
                    if(lwarns == 3) then
                        ---aici primeste fpk
                        local var = exports.playerdata:UnInvitePlayerFromFaction(dbid, exports.playerdata:getSqlID(source), "3/3 LWarns (" .. reason .. ")", 0)
                        if(var == true) then
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Liderul " .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit fpk de la " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. "3/3 LWarns (" .. reason .. ")")
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "Eroare la UnInvitePlayerFromFaction. Notifica scripterul serverelui cu privere la aceasta eroare.")
                        end
                    else
                        ---aici a primit doar warn fara fpk
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Liderul " .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit LWarn de la " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este lider!")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("lunwarn", function(source, args)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(admin_level >= 4) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/lunwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local target_faction_rank = exports.playerdata:getFactionRank_DBID(dbid)
                if(target_faction_rank == 7) then
                    local reason = args[2]
                    if(#args > 2) then
                        for i = 3, #args do
                            reason = reason .. " "
                            reason = reason .. args[i]
                        end
                    end
                    local admin_dbid = exports.playerdata:getSqlID(source)
                    if(exports.playerdata:LUnWarnPlayer(dbid, admin_dbid, reason) == true) then
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Liderului " .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " i-a fost scos un lider warn de catre " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                        TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu are LWarns!")
                    end  
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu este lider!")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)


RegisterCommand("acwarn", function(source, args)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(admin_level == 5) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/acwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local target_admin_level = exports.playerdata:getAdminLevel_DBID(dbid)
                if(target_admin_level > 0) then
                    if(target_admin_level < 5) then
                        local reason = args[2]
                        if(#args > 2) then
                            for i = 3, #args do
                                reason = reason .. " "
                                reason = reason .. args[i]
                            end
                        end
                        local admin_dbid = exports.playerdata:getSqlID(source)
                        local acwarns = exports.playerdata:ACWarnPlayer(dbid, admin_dbid, reason)
                        if(acwarns == 3) then

                            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit remove de la " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. "3/3 ACWarns (" .. reason .. ")")
                                exports.playerdata:setAdminLevel(target_source, 0)
                                exports.playerdata:updateAdminLevel(target_source)
                                exports.playerdata:setACWarn(target_source, 0) 
                                TriggerEvent("player_tags::update")
                            else
                                exports.playerdata:updateAdminLevel_DBID(dbid, 0)
                                exports.playerdata:updateACWarn_DBID(dbid, 0)
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit remove de la " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. "3/3 ACWarns (" .. reason .. ")")
                            end
                        else
                            ---aici a primit doar warn fara fpk
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Liderul " .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit LWarn de la " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "]")
                            TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti da ACWarn unui Owner.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu are grad!")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("acunwarn", function(source, args)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(admin_level == 5) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/acunwarn", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                local target_admin_level = exports.playerdata:getAdminLevel_DBID(dbid)
                if(target_admin_level > 0) then
                    if(target_admin_level < 5) then
                        local reason = args[2]
                        if(#args > 2) then
                            for i = 3, #args do
                                reason = reason .. " "
                                reason = reason .. args[i]
                            end
                        end
                        local admin_dbid = exports.playerdata:getSqlID(source)
                        if(exports.playerdata:ACUnWarnPlayer(dbid, admin_dbid, reason) == true) then
                            local admin_name = GetPlayerName(source)
                            local target_name = exports.playerdata:getName_DBID(dbid)
                            for _, playerId in ipairs(GetPlayers()) do
                                if (exports.playerdata:getAdminLevel(playerId) > 0) then
                                    TriggerClientEvent("chatMessage", playerId, "^1[AdmCmd]", {0,0,0}, "^7" .. target_name .. "[ID:" .. dbid .. "]" .. " i-a fost scos un acces warn de catre " .. admin_name .. "[ID:" .. admin_dbid .. "]")
                                    TriggerClientEvent("chatMessage", playerId, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                                end
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu are ACWarns!")
                        end 
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti scoate un ACWarn unui Owner!")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu are grad!")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)

RegisterCommand("afmembers", function(source, args)
    local admin_level = exports.playerdata:getAdminLevel(source)
    if(admin_level >= 2) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/afmember", {0,0,0}, "^7 <FACTION_ID(1-7)>")
        else
            local faction = tonumber(args[1])
            if(faction ~= nil and faction < 8 and faction > 0) then
                local p = promise:new()
                exports.ghmattimysql:execute("SELECT `id`, `name`, `factionrank`, `fwarn` FROM `users` WHERE `faction` = @faction", {["@faction"] = faction}, 
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
                TriggerClientEvent("sis_admin::EnableMenu", source, data, connected)
            else
                TriggerClientEvent("chatMessage", source, "^1/afmember", {0,0,0}, "^7 <FACTION_ID(1-7)>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("setjob", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setjob", {0,0,0}, "^7 <DB_ID> <JOB_ID>")
            TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^7Arms Dealer(1) Drugs Dealer(2) Lawer(3) Miner(4) Constructor(5) Fisher(6)")
        else
            local dbid = tonumber(args[1])
            local jobid = tonumber(args[2])
            --de updatat de fiecare data cand adaug un job nou
            if(jobid ~= nil and jobid >= 0 and jobid <= 6) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    exports.playerdata:setJob(target_source, jobid)
                    exports.playerdata:updateJob(target_source)
                    
                    local admin_dbid = exports.playerdata:getSqlID(source)
                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[" .. admin_dbid .. "]" .. " ti-a setat job " .. jobid)
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai setat jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "]" .. " job " .. jobid)
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/setjob", {0,0,0}, "^7 <DB_ID> <JOB_ID>")
                TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^7Arms Dealer(1) Drugs Dealer(2) Lawer(3) Miner(4) Constructor(5) Fisher(6)")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("mute", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/mute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
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
                    TriggerClientEvent("chatMessage", source, "^1/mute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
                else
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        local target_admin = exports.playerdata:getAdminLevel(target_source)
                        if(target_admin > 0) then
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe un admin.")
                        else
                            local target_mute = exports.playerdata:getMute(target_source)
                            if(target_mute > 0) then
                                TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator are deja mute.")
                            else
                                exports.playerdata:setMute(target_source, mute_minutes * 60)
                                TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Jucatorul ^3" .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "] ^7 a primit mute pentru ^3" .. mute_minutes .. "m^7 de la adminul ^3" .. GetPlayerName(source) .. "^7. Reason: " .. reason)
                                exports.playerdata:updateMute(target_source)
                            end
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                    end 
                end
            else
                TriggerClientEvent("chatMessage", source, "^1/mute", {0,0,0}, "^7 <DB_ID> <TIME(minutes)> <REASON>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("unmute", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/unmute", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    local target_mute = exports.playerdata:getMute(target_source)
                    if(target_mute <= 0) then
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Jucatorul nu are mute.")
                    else
                        exports.playerdata:setMute(target_source, 0)
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai dat unmute jucatorului ^3" .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "]^7.")
                        TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit unmute de la adminul ^3" .. GetPlayerName(source) .. "^7.")
                        exports.playerdata:updateMute(target_source)
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/unmute", {0,0,0}, "^7 <DB_ID>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("respawn", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/respawn", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                    TriggerClientEvent("sis_admin-c::RespawnPlayer", target_source)
                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7You have been respawned by " .. GetPlayerName(source) .. ".")
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player " .. GetPlayerName(target_source) .. " have been respawned.")
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/respawn", {0,0,0}, "^7 <DB_ID>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
local is_spec = {}
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("sis_admin-c::TurnOffSpec", playerId, player_src)
    end
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
    end
    
end)
RegisterNetEvent("sis_admin-s::updateSpectatorPosition")
AddEventHandler("sis_admin-s::updateSpectatorPosition", function(source, target_src)
    if(is_spec[tonumber(source)] ~= -1) then
        if(is_spec[tonumber(source)] ~= true) then
            is_spec[tonumber(source)] = true
            for _, playerId in ipairs(GetPlayers()) do
                TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
            end
        end
        local player_ped = GetPlayerPed(source)
        local target_ped = GetPlayerPed(target_src)
        if(target_ped ~= nil) then
            local target_pos = GetEntityCoords(target_ped)
            if(target_pos ~= nil) then
                SetEntityCoords(player_ped, target_pos.x, target_pos.y, target_pos.z)
            end
        end
    end
end)
RegisterNetEvent("sis_admin-s::resetSpecStatus")
AddEventHandler("sis_admin-s::resetSpecStatus", function(source)
    if(is_spec[tonumber(source)] ~= -1) then
        is_spec[tonumber(source)] = false
        for _, playerId in ipairs(GetPlayers()) do
            TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
        end
    end
end)
function CheckSpecStatus(source)
    if(is_spec[tonumber(source)] == true) then
        return true
    end
    return false
end
RegisterCommand("checkspec", function(source, args) 
    print(CheckSpecStatus(source))
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
    end
end, false) 
RegisterCommand("spec", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(is_spec[tonumber(source)] ~= true and is_spec[tonumber(source)] ~= -1) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/spec", {0,0,0}, "^7 <DB_ID>")
            else
                local dbid = tonumber(args[1])
                if(dbid ~= nil) then
                    if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                        local target_source = exports.playerdata:getSourceFromDBID(dbid)
                        local target_admin = exports.playerdata:getAdminLevel(target_source)
                        if(target_admin >= adminlevel) then
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Nu poti da spec pe un admin care are un grad mai mare sau egal cu al tau.")
                        else
                            TriggerClientEvent("sis_admin-c::TurnOnSpec", source, target_source)
                            
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                    end 
                else
                    TriggerClientEvent("chatMessage", source, "^1/spec", {0,0,0}, "^7 <DB_ID>")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Esti deja spectator pe cineva!")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("endspec", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        is_spec[tonumber(source)] = -1
        TriggerClientEvent("sis_admin-c::TurnOffSpec", source, nil)
        Wait(3000)
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7gata!")
        is_spec[tonumber(source)] = false
        for _, playerId in ipairs(GetPlayers()) do
            TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterNetEvent("sis_admin_s_t::CheckActiveUI")
AddEventHandler("sis_admin_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_admin_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_admin_s_r::CheckActiveUI")
AddEventHandler("sis_admin_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 2)
end)

RegisterCommand("makecleader", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel == 5) then
    
        if(args[1] == nil or args[2] == nil) then
            TriggerClientEvent("chatMessage", source, "^1/makecleader", {0,0,0}, "^7 <DB_ID> <CLUB ID(1-2)>")
            TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^7Need for Speed(1) Fast and Furious(2)")
        else
            local dbid = tonumber(args[1])
            local club_id = tonumber(args[2])
            if(club_id ~= nil) then
                if(dbid ~= nil and exports.playerdata:dbid_exist(dbid) == true) then
                    if(dbid > 0 and club_id <= 2 and club_id >= 1) then
                        if(exports.playerdata:getClub_DBID(dbid) == 0) then
                                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                                    local target_source = exports.playerdata:getSourceFromDBID(dbid)
                                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai dat lider la clubul numarul " .. club_id .. " jucatorului " .. GetPlayerName(target_source) .. "[" .. dbid .. "].")
                                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7 Ai primit lider la clubul numarul " .. club_id .. " de la " .. GetPlayerName(source) .. "[" .. dbid .. "].")
                                    exports.playerdata:setClub(target_source, club_id)
                                    exports.playerdata:updateClub(target_source) 
                                    exports.playerdata:setClubRank(target_source, 7)
                                    exports.playerdata:updateClubRank(target_source) 
                                else
                                    exports.playerdata:updateClub_DBID(dbid, club_id)
                                    exports.playerdata:updateClubRank_DBID(dbid, 7)
                                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7 I-ai dat lider la clubul numarul  " .. club_id .. " jucatorului cu ID = " .. dbid .. ".")
                                end
                                exports.playerdata:addLog("[MakeCLeader] " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "] i-a dat lider la clubul numarul  " .. faction_id .. " jucatorului cu ID = " .. dbid .. "." )
                                print("[MakeCLeader] " .. GetPlayerName(source) .. "[" .. exports.playerdata:getSqlID(source) .. "] i-a dat lider la clubul numarul " .. club_id .. " jucatorului cu ID = " .. dbid .. "." )
                        else
                            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator se afla intr-un club!")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1/makecleader", {0,0,0}, "^7 <DB_ID> <CLUB ID(1-2)>")
            TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^7Need for Speed(1) Fast and Furious(2)")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]:", {0, 0, 0}, " DBID inexistent in baza de date.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1/makecleader", {0,0,0}, "^7 <DB_ID> <CLUB ID(1-2)>")
            TriggerClientEvent("chatMessage", source, "^1Info:", {0,0,0}, "^7Need for Speed(1) Fast and Furious(2)")
            end
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("cpk", function(source, args)
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 3) then
    
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/cpk", {0,0,0}, "^7 <DB_ID> <REASON>")
        else
            local dbid = tonumber(args[1])
            if(dbid == nil) then
                TriggerClientEvent("chatMessage", source, "^1/cpk", {0,0,0}, "^7 <DB_ID> <REASON>")
            else
                local reason = args[2]
                if(#args > 2) then
                    for i = 3, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                local var = exports.playerdata:UnInvitePlayerFromClub(dbid, exports.playerdata:getSqlID(source), reason)
                if(var == true) then
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7" .. exports.playerdata:getName_DBID(dbid) .. "[ID:" .. dbid .. "]" .. " a primit cpk de la " .. GetPlayerName(source) .. "[ID:" .. exports.playerdata:getSqlID(source) .. "]")
                    TriggerClientEvent("chatMessage", -1, "^1[AdmCmd]", {0,0,0}, "^7Reason: " .. reason)
                elseif (var == false) then
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Acel jucator nu se afla intr-un club.")
                end  
            end  
        end   
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false)
RegisterCommand("freeze", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/freeze", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = tonumber(exports.playerdata:getSourceFromDBID(dbid))
                    local player_dbid = tonumber(exports.playerdata:getSqlID(source))
                    FreezeEntityPosition(GetPlayerPed(target_source), true)
                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit freeze de la adminul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "].")
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai dat freeze jucatorului " .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "].") 
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/spec", {0,0,0}, "^7 <DB_ID>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
RegisterCommand("unfreeze", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/freeze", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(dbid ~= nil) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local target_source = tonumber(exports.playerdata:getSourceFromDBID(dbid))
                    local player_dbid = tonumber(exports.playerdata:getSqlID(source))
                    FreezeEntityPosition(GetPlayerPed(target_source), false)
                    TriggerClientEvent("chatMessage", target_source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit unfreeze de la adminul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "].")
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7I-ai dat unfreeze jucatorului " .. GetPlayerName(target_source) .. "[ID:" .. dbid .. "].") 
                else
                    TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Player is not connected.")
                end 
            else
                TriggerClientEvent("chatMessage", source, "^1/spec", {0,0,0}, "^7 <DB_ID>")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 