local timer = {}
local deliver_timer = {}
local timer_usedrugs = {}
RegisterNetEvent("job_drugs-s::resetTimer")
AddEventHandler("job_drugs-s::resetTimer", function(source)
    timer[source] = 0
    timer_usedrugs[source] = nil
end)
RegisterCommand("getdrugs", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 2) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local x = -578.42639160156
        local y = -1628.2945556641
        local z = 33.003662109375
        local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
        if(distance <= 3) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/drugs", {0,0,0}, "^7 <AMOUNT>")
            else
                local time = os.time()
                if(timer[source] + 60 < time) then
                    local player_drugs = exports.playerdata:getDrugs(source)
                    local skill_drugs = exports.playerdata:getSkillDrugs(source)
                    if(skill_drugs * 10 >= player_drugs) then
                        local amount_drugs = tonumber(args[1])
                        
                        if(amount_drugs > 0 and amount_drugs <= 10 * skill_drugs - player_drugs) then
                            local drugs_cost = amount_drugs * 50
                            local player_money = exports.playerdata:getMoney(source)
                            if(player_money >= drugs_cost) then
                                timer[source] = time
                                local player_money = player_money - drugs_cost
                                local player_drugs = player_drugs + amount_drugs
                                exports.playerdata:setMoney(source, player_money)
                                exports.playerdata:setDrugs(source, player_drugs)
                                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai cumparat ^3" .. amount_drugs .. "^7 gram/e pentru ^3" .. drugs_cost .. "^7 $. Acum ai ^3" .. player_drugs .. "^7 gram/e.")
                                exports.playerdata:updateMoney(source)
                                exports.playerdata:updateDrugs(source)
                            else
                                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Mai ai nevoie de  ^3" .. drugs_cost - player_money .. "$ ^7pentru a cumpara ^3" .. amount_drugs .. "^7 gram/e.")
                            end
                        else
                            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Poti cumpara intre ^3 0 ^7si ^3" .. 10 * skill_drugs .."^7 grame. Acum ai .. ^3" .. player_drugs .. "^7 gram/e.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Trebuie sa vinzi toate drogurile  pentru a putea cumpara altele.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Trebuie sa astepti 60 de secunde pentru a refolosi comnda.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Drugs Dealer.")
    end
end, false)
RegisterCommand("deliverdrugs", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 2) then
        if(deliver_timer[source] == nil) then
            TriggerClientEvent("job_drugs-c::startDelivery", source)
            deliver_timer[source] = 0
        elseif(deliver_timer[source] == 0) then
            TriggerClientEvent("job_drugs-c::startDelivery", source)
            deliver_timer[source] = os.time()
        elseif(deliver_timer[source] + 120 < os.time()) then
            TriggerClientEvent("job_drugs-c::startDelivery", source)
            deliver_timer[source] = nil
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Trebuie sa astepti 2 minute pentru a putea refolosi comanda.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Drugs Dealer.")
    end
end, false)
RegisterNetEvent("job_drugs-s::PlayerAtLocation")
AddEventHandler("job_drugs-s::PlayerAtLocation", function(source)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 2) then
        local player_drugs = exports.playerdata:getDrugs(source)
        if(player_drugs ~= 0) then
            TriggerClientEvent("job_drugs-c::TurnOffDelivery", source)
            local drugs_needed = math.random(1,10)
            if(drugs_needed > player_drugs) then
                drugs_needed = player_drugs
            end
            local drugs_money = drugs_needed * 200
            local player_money = exports.playerdata:getMoney(source) + drugs_money
            
            
            player_drugs = player_drugs - drugs_needed
            exports.playerdata:setDrugs(source, player_drugs)
            exports.playerdata:setMoney(source, player_money)
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai primit ^3" .. drugs_money .. "^7$ pentru ^3" .. drugs_needed .. " ^7 gram/e.")
            local player_skill_drugs = exports.playerdata:getSkillDrugs(source) 
            if(player_skill_drugs ~= 5) then
                local player_sales_drugs = exports.playerdata:getSalesDrugs(source) 

                if(player_sales_drugs == player_skill_drugs * 50) then
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai facut skill level ^3" .. player_skill_drugs + 1 .. "^7.")
                    exports.playerdata:setSkillDrugs(source, player_skill_drugs + 1)
                    exports.playerdata:updateSkillDrugs(source)
                    player_sales_drugs = 0
                else
                    player_sales_drugs = player_sales_drugs + 1
                end
                exports.playerdata:setSalesDrugs(source, player_sales_drugs)
                exports.playerdata:updateSalesDrugs(source)
            end
            exports.playerdata:updateDrugs(source)
            exports.playerdata:updateMoney(source)
            TriggerClientEvent("job_drugs-c::TurnOnDelivery", source)
            
        else
            TriggerClientEvent("job_drugs-c::TurnOffDelivery", source)
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu mai ai droguri.")
        end
    else
        TriggerClientEvent("job_drugs-c::TurnOffDelivery", source)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Drugs Dealer.")
    end
end)

RegisterCommand("usedrugs", function(source, args)
    local player_drugs = exports.playerdata:getDrugs(source)
    if(player_drugs ~= 0) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/usedrugs", {0,0,0}, "^7 <AMOUNT(1-5)>")
        else
            local used_drugs = tonumber(args[1])
            if(used_drugs <= 5 and used_drugs >= 1) then
                if(used_drugs <= player_drugs) then
                    local cTime = os.time()
                    if(timer_usedrugs[source] == nil or timer_usedrugs[source] + 60 <= cTime) then
                        timer_usedrugs[source] = cTime
                        player_drugs = player_drugs - used_drugs
                        exports.playerdata:setDrugs(source, player_drugs)
                        TriggerClientEvent("job_drugs-c::useDrugs", source, used_drugs)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai folosit ^3".. used_drugs .. "^7 gram/e.")
                        exports.playerdata:updateDrugs(source)
                    else
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Trebuie sa astepti 60s pentru a folosi aceasta comanda.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destule droguri.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1/usedrugs", {0,0,0}, "^7 <AMOUNT(1-5)>")
            end
            
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai droguri.")
    end
end, false)
RegisterCommand("givedrugs", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 2) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/givedrugs", {0,0,0}, "^7 <DB_ID> <AMOUNT>")
        else
            local dbid = tonumber(args[1])
            local amount = tonumber(args[2])
            local player_drugs = exports.playerdata:getDrugs(source)
            if(amount >= 1 and amount <= player_drugs) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local player_dbid = exports.playerdata:getSqlID(source)
                    if(dbid ~= player_dbid) then
                        local target_src = exports.playerdata:getSourceFromDBID(dbid)
                        local target_name = GetPlayerName(target_src)
                        local player_name = GetPlayerName(source)
                        local target_drugs = exports.playerdata:getMats(target_src) + amount
                        player_drugs = player_drugs - amount
                        exports.playerdata:setDrugs(source, player_drugs)
                        exports.playerdata:setDrugs(target_src, target_drugs)
                        TriggerClientEvent("chatMessage", target_src, "^1[INFO]", {0,0,0}, "^7Ai primit de la " .. player_name .. "[ID:" .. player_dbid .. "]^3 " .. amount .."^7 gram/e.")
                        TriggerClientEvent("chatMessage", source, "^1[INFO]", {0,0,0}, "^7I-ai dat jucatorului " .. target_name .. "[ID:" .. dbid .. "] ^3" .. amount .. "^7 gram/e.")
                        exports.playerdata:updateDrugs(source)
                        exports.playerdata:updateDrugs(target_src)
                    else
                        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe tine.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Jucatorul nu este conectat.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu ai destule droguri.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Drugs Dealer.")
    end
end, false)