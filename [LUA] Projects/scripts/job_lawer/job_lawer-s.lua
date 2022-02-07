local timer = {}

RegisterCommand("needlawer", function(source, args)
    local player_jail_time = exports.playerdata:getJailTime(source)
    if(player_jail_time == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu esti in jail!")
    else
        local cTime = os.time()
        if(timer[source] == nil or timer[source] + 120 <= cTime) then
            local player_dbid = exports.playerdata:getSqlID(source)
            timer[source] = cTime
            local text = "^7Jucatorul " .. GetPlayerName(source) .. "[ID:"..player_dbid.."] are nevoie de un avocat."
            local nr_lawers = 0
            for _, playerId in ipairs(GetPlayers()) do
                local target_job = exports.playerdata:getJob(playerId)
                if(target_job == 3) then
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, text)
                    nr_lawers = nr_lawers + 1
                end
            end
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Cererea ta a fost trimisa catre ^3" .. nr_lawers .. "^7 avocati.")
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Trebuie sa astepti 2m pentru a putea folosi aceasta comanda!")
        end
    end
end, false)

local lawer_offer = {}
for i = 1, 130 do
    lawer_offer[i] = {}
end


RegisterCommand("free", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 3) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/free", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)>")
        else
            local x = 461.60440063477
            local y = -989.15606689453
            local z = 24.89892578125
            local player_pos = GetEntityCoords(GetPlayerPed(source))
            local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
            if(distance > 3) then
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
            else
                local target_dbid = tonumber(args[1])
                local price = tonumber(args[2])
                if(price == nil or target_dbid == nil) then
                    TriggerClientEvent("chatMessage", source, "^1/free", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)>")
                else
                    if(price >= 0 and price <= 100000) then
                        if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                            local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                            local target_jail_time = exports.playerdata:getJailTime(target_src)
                            if(target_jail_time == 0) then
                                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Jucatorul nu este in jail!")
                            else
                                local player_lawer_skill = exports.playerdata:getSkillLawer(source)
                                if(target_jail_time > player_lawer_skill * 300) then
                                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Lawer skill prea mic!")
                                else
                                    lawer_offer[source][target_src] = price
                                    local player_dbid = exports.playerdata:getSqlID(source)
                                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7I-ai trimis o oferta jucatorului " .. GetPlayerName(target_src) .. "[ID:".._target_dbid.."] in valoare de ^3" .. price .. " ^7$.")
                                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Ai primit o oferta de la avocatul " .. GetPlayerName(source) .. "[ID:"..player_dbid.."] in valoare de ^3" .. price .. " ^7$.")
                                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Foloseste comanda ^3/acceptlawer " .. player_dbid .. " " .. price .. " ^7 pentru a o accepta.")
                                end
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Jucatorul nu este conectat!")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1/free", {0,0,0}, "^7 <DB_ID> <PRICE(0-100.000$)>")
                    end
                end
            end
        end

    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti avocat!")
    end
end, false)

RegisterCommand("acceptlawer", function(source, args)
    local player_jail_time = exports.playerdata:getJailTime(source)
    if(player_jail_time == 0) then
        TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Nu esti in jail.")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/acceptlawer", {0,0,0}, "^7 <DB_ID> <PRICE>")
        else
            local lawer_dbid = tonumber(args[1])
            local lawer_price = tonumber(args[2])
            if(lawer_dbid == nil or lawer_price == nil) then
                TriggerClientEvent("chatMessage", source, "^1/acceptlawer", {0,0,0}, "^7 <DB_ID> <PRICE>")
            else
                if(exports.playerdata:IsSqlIdConnected(lawer_dbid) == false) then
                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Jucatorul este offline.")
                else
                    local lawer_src = exports.playerdata:getSourceFromDBID(lawer_dbid)
                    if(exports.playerdata:getJob(lawer_src) == 3) then
                        if(lawer_offer[lawer_src][source] == nil) then
                            TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Oferta inexistenta.")
                        elseif(lawer_offer[lawer_src][source] == price) then
                            local player_money = exports.playerdata:getMoney(source)
                            if(lawer_price > player_money)  then
                                TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Nu ai destui bani.")
                            else
                                local lawer_skill = exports.playerdata:getSkillLawer(lawer_src)
                                if(player_jail_time > 300 * lawer_skill) then
                                    if(lawer_skill ~= 5) then
                                        local lawer_free = exports.playerdata:getFreeLawer(lawer_src) + 1
                                        if(lawer_free == lawer_skill * 50) then
                                            lawer_free = 0
                                            exports.playerdata:setSkillLawer(lawer_src, lawer_skill + 1)
                                            TriggerClientEvent("chatMessage", lawer_src, "^1[LAWER]", {0,0,0}, "^7Ai primit lawer skill ^3" .. lawer_skill + 1 .. "^7.")
                                            exports.playerdata:updateSkillLawer(lawer_src)
                                        end
                                        exports.playerdata:setFreeLawer(lawer_src, lawer_free)
                                        exports.playerdata:updateFreeLawer(lawer_src)                                    
                                    end
                                    exports.playerdata:setJailTime(source, 0)
                                    exports.playerdata:setMoney(source, player_money - lawer_price)
                                    exports.playerdata:ForceRespawn(source)
                                    lawer_offer[lawer_src][source] = nil
                                    TriggerEvent("sis_jail-s::setJailTime", source, 0)
                                    local player_dbid
                                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Ai acceptat oferta avocatului " .. GetPlayerName(lawer_src) .. "[ID:" .. lawer_dbid .. "] in valoare de ^3" .. lawer_price .. "^7.")
                                    TriggerClientEvent("chatMessage", lawer_src, "^1[LAWER]", {0,0,0}, "^7Jucatorul " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "]" .. "ti-a acceptat oferta in valoare de ^3" .. lawer_price .. "^7.")
                                    local lawer_money = exports.playerdata:getMoney(lawer_src)
                                    lawer_money = lawer_money + lawer_price
                                    exports.playerdata:setMoney(lawer_src, lawer_money)
                                    exports.playerdata:updateMoney(lawer_src)
                                    exports.playerdata:updateJailTime(source)
                                    exports.playerdata:updateMoney(source)
                                else
                                    TriggerClientEvent("chatMessage", source, "^1[LAWER]", {0,0,0}, "^7Oferta inexistenta.")
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
    end
end, false)
RegisterCommand("jl", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 3) then
        TriggerClientEvent("job_lawer::EnableMenu", source)
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Lawer.")
    end
end, false)
RegisterNetEvent("job_lawer-s::updateMenuData")
AddEventHandler("job_lawer-s::updateMenuData", function(source)
    local jlp_data = {}
    local cnt = 0
    local skill = exports.playerdata:getSkillLawer(source)
    for _, player_src in ipairs(GetPlayers()) do
        local jail_time = exports.playerdata:getJailTime(player_src)
        if(jail_time > 0) then
            cnt = cnt + 1
            jlp_data[cnt] = {seconds, name, dbid}
            jlp_data[cnt].seconds = jail_time
            jlp_data[cnt].name = GetPlayerName(player_src)
            jlp_data[cnt].dbid = exports.playerdata:getSqlID(player_src)
        end
    end
    TriggerClientEvent("job_lawer-c::updateMenuData", source, cnt, jlp_data, skill * 300)
end)
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    for i = 1, 130 do
        lawer_offer[player_src][i] = nil
        lawer_offer[i][player_src] = nil
    end
end)
  
  

