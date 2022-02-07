local cBusiness = 0
local business_pos_x = {}
local business_pos_y = {}
local business_pos_z = {}
local business_owner_id = {}
local business_level = {}
local business_owner_name = {}
local business_buy_price = {}
local business_name = {}
local business_balance = {}
local business_profit = {}
local cWorkingPoints = 0
local working_point_pos_x = {}
local working_point_pos_y = {}
local working_point_pos_z = {}
local working_point_type = {}
-- 1 pentru banca 2 pentru magazin ---
function IsPlayerAtWorkingPoint(source, type) -- returneaza 1 pentru da, 0 in caz contrar 
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local wpIndex = 0
    for i = 1, cWorkingPoints do
        local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
        if(distance <= 2) then
            wpIndex = i
            break
            end
        end
    if(working_point_type[wpIndex] ~= type) then
        return 0
    else
        return 1
    end
end
RegisterNetEvent("sis_business-s::setOwnerName")
AddEventHandler("sis_business-s::setOwnerName", function(business_id, owner_name)
    business_owner_name[business_id] = owner_name
end)
RegisterServerEvent("sis_payday::payday")
AddEventHandler("sis_payday::payday", function()
    for i = 1, cBusiness do
        business_balance[i] = business_balance[i] + business_profit[i]
        exports.ghmattimysql:execute('UPDATE `business` SET `balance`=@balance WHERE `id` = @id', {["@balance"] = business_balance[i], ["@id"] = i})
    end
end)
function AddBusiness(business_id, pos_x, pos_y, pos_z, owner_id, level, owner_name, buy_price, name, balance, profit)
    business_pos_x[business_id] = pos_x
    business_pos_y[business_id] = pos_y
    business_pos_z[business_id] = pos_z
    business_owner_id[business_id] = owner_id
    business_level[business_id] = level
    business_owner_name[business_id] = owner_name
    business_buy_price[business_id] = buy_price
    business_name[business_id] = name
    business_balance[business_id] = balance
    business_profit[business_id] = profit
end
function AddWorkingPoint(wp_id, pos_x, pos_y, pos_z, type)
    working_point_pos_x[wp_id] = pos_x
    working_point_pos_y[wp_id] = pos_y
    working_point_pos_z[wp_id] = pos_z
    working_point_type[wp_id]  = type
end
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM business", {}, 
    function(result)
        cBusiness = tonumber(#result)
        for i = 1, #result do
            AddBusiness(i, result[i].pos_x, result[i].pos_y, result[i].pos_z, result[i].owner_id, result[i].level, result[i].owner_name, result[i].buy_price, result[i].name, result[i].balance, result[i].profit)
        end
        print("[Business]: loaded " .. cBusiness .. " Businesses")
        p:resolve(true)
    end)
    Citizen.Await(p)
    p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM working_points", {}, 
    function(result)
        cWorkingPoints = tonumber(#result)
        for i = 1, #result do
            AddWorkingPoint(i, result[i].pos_x, result[i].pos_y, result[i].pos_z, result[i].type)
        end
        print("[Working Points]: loaded " .. cWorkingPoints .. " business working points.")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)
RegisterCommand("addbusiness", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 4) then
            TriggerClientEvent("chatMessage", source, "^1/addbusiness", {0,0,0}, "^7 <level> <price> <profit> <name>")
        else
            local level = tonumber(args[1])
            local price = tonumber(args[2])
            local profit = tonumber(args[3])
            local name = args[4]
            if(#args > 4) then
                for i = 5, #args do
                    name = name .. " "
                    name = name .. args[i]
                end
            end
            if(level == nil or price == nil or profit == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addbusiness", {0,0,0}, "^7 <level> <price> <profit> <name>")
            else
                local business_pos = GetEntityCoords(GetPlayerPed(source))
                cBusiness = cBusiness + 1
                AddBusiness(cBusiness, business_pos.x, business_pos.y, business_pos.z, 0, level, "The State", price, name, 0, profit)
                exports.ghmattimysql:execute("INSERT INTO `business` (`id`, `pos_x`, `pos_y`, `pos_z`, `owner_id`, `level`, `owner_name`, `buy_price`, `name`, `balance`, `profit`) VALUES (@id,@pos_x,@pos_y,@pos_z,@ownerid,@level,@owner_name,@price,@name,@balance,@profit)", {['@id'] = cBusiness, ['@pos_x'] = business_pos.x, ['@pos_y'] = business_pos.y, ['@pos_z'] = business_pos.z, ['@ownerid'] = 0, ['@level'] = level, ['@owner_name'] = "The State", ['@price'] = price, ['@name'] = name, ['@balance'] = 0, ['@profit'] = profit})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Business cu id: " .. cBusiness .. " adaugata cu succes.")
            end
        end
    end
end, false)
RegisterCommand("addworkingpoint", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/addworkingpoint", {0,0,0}, "^7 <type>")
        else
            local type = tonumber(args[1])

            if(type == nil ) then
                TriggerClientEvent("chatMessage", source, "^1/addworkingpoint", {0,0,0}, "^7 <type>")
            else
                local wp_pos = GetEntityCoords(GetPlayerPed(source))
                cWorkingPoints = cWorkingPoints + 1
                AddWorkingPoint(cWorkingPoints, wp_pos.x, wp_pos.y, wp_pos.z, type)
                exports.ghmattimysql:execute("INSERT INTO `working_points` (`id`, `pos_x`, `pos_y`, `pos_z`, `type`) VALUES (@id,@pos_x,@pos_y,@pos_z,@type)", {['@id'] = cWorkingPoints, ['@pos_x'] = wp_pos.x, ['@pos_y'] = wp_pos.y, ['@pos_z'] = wp_pos.z, ['@type'] = type})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Working Point cu id: " .. cWorkingPoints .. " adaugata cu succes.")
            end
        end
    end
end, false)
Citizen.CreateThread(function()
    while true do
        for _, player_src in ipairs(GetPlayers()) do
            TriggerClientEvent("sis_business-c::updateData", player_src, cBusiness, business_pos_x, business_pos_y, business_pos_z, business_owner_id, business_level, business_owner_name, business_buy_price, business_name, business_profit, cWorkingPoints, working_point_pos_x, working_point_pos_y, working_point_pos_z, working_point_type)
        end
        Citizen.Wait(1000)
    end
end)
RegisterCommand("buybusiness", function(source, args)
    if(exports.playerdata:getBusiness(source) ~= 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Ai deja un business.")
    else
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local businessIndex = 0
        for i = 1, cBusiness do
            local distance = math.floor(math.sqrt((math.pow(player_pos.x - business_pos_x[i], 2) + math.pow(player_pos.y - business_pos_y[i], 2) + math.pow(player_pos.z - business_pos_z[i], 2))))
            if(distance <= 2) then
                businessIndex = i
                break
            end
        end
        if(businessIndex == 0) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            if(business_owner_id[businessIndex] ~= 0) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Afacerea nu este la vanzare.")
            else
                local player_money = exports.playerdata:getMoney(source)
                local business_price = business_buy_price[businessIndex]
                if(player_money < business_price) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai destui bani pentru a cumpara acest business.")
                else
                    local player_lvl = exports.playerdata:getLevel(source)
                    if(business_level[businessIndex] > player_lvl) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai levelul necesar pentru a cumpara acest business.")
                    else
                        player_money = player_money - business_price
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:setBusiness(source, businessIndex)
                        business_owner_name[businessIndex] = GetPlayerName(source)
                        business_owner_id[businessIndex] = exports.playerdata:getSqlID(source)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai cumparat afacerea cu id ^4" .. businessIndex .. "^7 pentru ^4 " .. business_price .. "^7 $.")
                        exports.ghmattimysql:execute('UPDATE `business` SET `owner_id` = @owner_id, `owner_name` = @owner_name WHERE `id` = @id', {["@owner_id"] = business_owner_id[businessIndex], ["@owner_name"] = business_owner_name[businessIndex], ["@id"] = businessIndex})
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateBusiness(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("sellbusiness", function(source, args)
    local player_business_id = exports.playerdata:getBusiness(source)
    if(player_business_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu detii un business.")
    else
        exports.playerdata:setBusiness(source, 0)
        business_owner_name[player_business_id] = "The State"
        business_owner_id[player_business_id] = 0
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut afacerea cu id ^4" .. player_business_id ..  "^7.")
        exports.ghmattimysql:execute('UPDATE `business` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = player_business_id})
        exports.playerdata:updateBusiness(source)
    end
end, false)
RegisterCommand("asellbusiness", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin <= 4) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/asellbusiness", {0,0,0}, "^7 <business_id>")
        else
            local businessid = tonumber(args[1])
            if(businessid < 0 or businessid > cBusiness) then
                TriggerClientEvent("chatMessage", source, "^1/asellbusiness", {0,0,0}, "^7 <business_id>")
            else
                if(business_owner_id[businessid] == 0) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Afacerea cu id ^4" .. businessid .. " ^7 este deja la vanzare.")
                else
                    local owner_dbid = business_owner_id[businessid]
                    if(exports.playerdata:IsSqlIdConnected(owner_dbid) == true) then
                        local owner_src = exports.playerdata:getSourceFromDBID(owner_dbid)
                        exports.playerdata:setBusiness(owner_src, 0)
                        business_owner_name[businessid] ="The State"
                        business_owner_id[businessid] = 0
                        local admin_dbid = exports.playerdata:getSqlID(source)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut afacerea cu id ^4" .. businessid ..  "^7.")
                        TriggerClientEvent("chatMessage", owner_src, "^1[Info]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "] ti-a vandut afacerea cu id ^4" .. businessid ..  "^7.")
                        exports.ghmattimysql:execute('UPDATE `business` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = businessid})
                        exports.playerdata:updateBusiness(owner_src)
                    else
                        local owner_dbid = business_owner_id[businessid]
                        business_owner_name[businessid] ="The State"
                        business_owner_id[businessid] = 0
                        exports.ghmattimysql:execute('UPDATE `business` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = businessid})
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut afacerea cu id ^4" .. businessid ..  "^7.")
                        exports.playerdata:updateBusiness_DBID(owner_dbid, 0)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("setbusinesslevel", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setbusinesslevel", {0,0,0}, "^7 <business_id> <level>")
        else
            local businessid = tonumber(args[1])
            local businesslevel = tonumber(args[2])
            if(businessid == nil or businesslevel == nil) then
                TriggerClientEvent("chatMessage", source, "^1/setbusinesslevel", {0,0,0}, "^7 <business_id> <level>")
            else
                if(cBusiness < businessid) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Afacere inexistenta inexistenta.")
                else
                    business_level[businessid] = businesslevel
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai setat level ^4" .. businesslevel .. "^7 afacerii cu id ^4" .. businessid .. "^7.")
                    exports.ghmattimysql:execute('UPDATE `business` SET `level`=@busines_level WHERE `id` = @id', {["@busines_level"] = businesslevel, ["@id"] = businessid})
                end
            end
        end
    end
end, false)
RegisterCommand("setbusinessprice", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/setbusinessprice", {0,0,0}, "^7 <business_id> <price>")
        else
            local businessid = tonumber(args[1])
            local businessprice = tonumber(args[2])
            if(businessid == nil or businessprice == nil) then
                TriggerClientEvent("chatMessage", source, "^1/sethouseprice", {0,0,0}, "^7 <business_id> <price>")
            else
                if(cBusiness < businessid) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Afacere inexistenta.")
                else
                    business_buy_price[businessid] = businessprice
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai setat pretul ^4" .. businessprice .. "^7 afacerii cu id ^4" .. businessid .. "^7.")
                    exports.ghmattimysql:execute('UPDATE `business` SET `buy_price`=@buy_price WHERE `id` = @id', {["@buy_price"] = businessprice, ["@id"] = businessid})
                end
            end
        end
    end
end, false)
RegisterCommand("bbalance", function(source, args)
    local player_business_id = exports.playerdata:getBusiness(source)
    if(player_business_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu detii un business.")
    else
        local business_money = business_balance[player_business_id]
        TriggerClientEvent("chatMessage", source, "^1[Business]", {0,0,0}, "^7Balance: ^4" .. business_money .. "$^7.")
    end
end, false)
RegisterCommand("bwithdraw", function(source, args)
    local player_business_id = exports.playerdata:getBusiness(source)
    if(player_business_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu detii un business.")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/bwithdraw", {0,0,0}, "^7 <amount>")
        else
            local money = tonumber(args[1])
            if(money == nil or money < 1) then
                TriggerClientEvent("chatMessage", source, "^1/bwithdraw", {0,0,0}, "^7 <amount>")
            else
                local business_money = business_balance[player_business_id]
                if(money > business_money) then
                    TriggerClientEvent("chatMessage", source, "^1[Business]", {0,0,0}, "^7Fonduri insuficiente.")
                else
                    local player_bankmoney = exports.playerdata:getBankMoney(source)
                    player_bankmoney = player_bankmoney + money
                    business_balance[player_business_id] = business_balance[player_business_id] - money
                    exports.playerdata:setBankMoney(source, player_bankmoney)
                    TriggerClientEvent("chatMessage", source, "^1[Business]", {0,0,0}, "^7Ai retras ^4" .. money .. "$ ^7din capitalul afacerii tale.")
                    exports.ghmattimysql:execute('UPDATE `business` SET `balance`=@balance WHERE `id` = @id', {["@balance"] = business_balance[player_business_id], ["@id"] = player_business_id})
                    exports.playerdata:updateBankMoney(source)
                end
            end
        end
    end
end, false)
RegisterCommand("robbank", function(source, args)
    if(exports.playerdata:getWantedLevel(source) ~= 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Ai deja wanted level.")
    else
        if(exports.playerdata:getFaction(source) == 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu poti jefui o banca daca esti politist.")
        else
            local player_pos = GetEntityCoords(GetPlayerPed(source))
            local wpIndex = 0
            for i = 1, cWorkingPoints do
                local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
                if(distance <= 2) then
                    wpIndex = i
                    break
                end
            end
            if(wpIndex == 0) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
            else
                if(working_point_type[wpIndex] ~= 1) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
                else
                    local player_rob_points = exports.playerdata:getRobPoints(source)
                    if(player_rob_points < 6) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai destule Rob Points.")
                    else
                        player_rob_points = player_rob_points - 6
                        exports.playerdata:setWantedReason(source, "Rob Bank")
                        exports.playerdata:setWantedLevel(source, 6)
                        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, 6)
                        local player_dbid = exports.playerdata:getSqlID(source)
                        local text = "^4[PD] ^7" .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] a jefuit o banca." 
                        exports.playerdata:SendFactionMSG(1, text)
                        local rob_money = math.random(10000, 50000)
                        TriggerClientEvent("chatMessage", source, "^1[WANTED]", {0,0,0}, "^7Ai jefut banca si ai primit ^4" .. rob_money .. "$^7.")
                        local player_money = exports.playerdata:getMoney(source) + rob_money
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateWantedLevel(source)
                        exports.playerdata:updateWantedReason(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("pay", function(source, args)
    if(#args < 3) then
        TriggerClientEvent("chatMessage", source, "^1/pay", {0,0,0}, "^7 <id> <amount(1-100.000$)> <reason>")
    else
        local target_dbid = tonumber(args[1])
        local amount = tonumber(args[2])
        local reason = args[3]
        if(#args > 3) then
            for i = 4, #args do
                reason = reason .. " "
                reason = reason .. args[i]
            end
        end
        if(target_dbid == nil or amount == nil or amount < 1 or amount > 100000) then
            TriggerClientEvent("chatMessage", source, "^1/pay", {0,0,0}, "^7 <id> <amount(1-100.000$)> <reason>")
        else
            if(exports.playerdata:IsSqlIdConnected(target_dbid) ~= true) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat.")
            else
                local target_source = tonumber(exports.playerdata:getSourceFromDBID(target_dbid))
                if(target_source == source) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu iti poti transfera tie bani.")
                else
                    local player_pos = GetEntityCoords(GetPlayerPed(source))
                    local target_pos = GetEntityCoords(GetPlayerPed(target_source))
                    local distance = math.floor(math.sqrt((math.pow(player_pos.x - target_pos.x, 2) + math.pow(player_pos.y - target_pos.y, 2) + math.pow(player_pos.z - target_pos.z, 2))))
                    if(distance > 4) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este langa tine.")
                    else
                        local player_money = exports.playerdata:getMoney(source)
                        if(player_money < amount) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani.")
                        else
                            local target_money = exports.playerdata:getMoney(target_source) + amount
                            player_money = player_money - amount
                            exports.playerdata:setMoney(source, player_money)
                            exports.playerdata:setMoney(target_source, target_money)
                            local player_dbid = exports.playerdata:getSqlID(source)
                            TriggerClientEvent("chatMessage", source, "^6[PAY]", {0,0,0}, "^7I-ai dat jucatorului " .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "] ^4" .. amount .. "$^7.")
                            TriggerClientEvent("chatMessage", target_source, "^6[PAY]", {0,0,0}, "^7Ai primit de la " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] ^4" .. amount .. "$^7. Reason: " .. reason)
                            local text = "^6[AdmPay]^7 " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "]  --> " .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "] | " .. amount .. "$ | " .. reason
                            exports.playerdata:SendAdminMSG(1, text)
                            exports.playerdata:updateMoney(source)
                            exports.playerdata:updateMoney(target_source)
                        end
                    end 
                end
            end
        end
    end
end, false)
RegisterCommand("transfer", function(source, args)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local wpIndex = 0
    for i = 1, cWorkingPoints do
        local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
        if(distance <= 2) then
            wpIndex = i
            break
        end
    end
    if(wpIndex == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
    else
        if(working_point_type[wpIndex] ~= 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            if(#args < 3) then
                TriggerClientEvent("chatMessage", source, "^1/transfer", {0,0,0}, "^7 <id> <amount> <reason>")
            else
                local target_dbid = tonumber(args[1])
                local amount = tonumber(args[2])
                local reason = args[3]
                if(#args > 3) then
                    for i = 4, #args do
                        reason = reason .. " "
                        reason = reason .. args[i]
                    end
                end
                if(target_dbid == nil or amount == nil or amount < 1) then
                    TriggerClientEvent("chatMessage", source, "^1/transfer", {0,0,0}, "^7 <id> <amount> <reason>")
                else
                    if(exports.playerdata:IsSqlIdConnected(target_dbid) ~= true) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Jucatorul nu este conectat.")
                    else
                        local target_source = tonumber(exports.playerdata:getSourceFromDBID(target_dbid))
                        if(target_source == source) then
                            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu iti poti transfera tie bani.")
                        else
                            local player_bank_money = exports.playerdata:getBankMoney(source)
                            if(player_bank_money < amount) then
                                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani in contul bancar.")
                            else
                                local target_bank_money = exports.playerdata:getBankMoney(target_source) + amount
                                player_bank_money = player_bank_money - amount
                                exports.playerdata:setBankMoney(source, player_bank_money)
                                exports.playerdata:setBankMoney(target_source, target_bank_money)
                                local player_dbid = exports.playerdata:getSqlID(source)
                                TriggerClientEvent("chatMessage", source, "^6[TRANSFER]", {0,0,0}, "^7I-ai transferat jucatorului " .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "] ^4" .. amount .. "$^7.")
                                TriggerClientEvent("chatMessage", target_source, "^6[TRANSFER]", {0,0,0}, "^7Ai primit de la " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] ^4" .. amount .. "$^7. Reason: " .. reason)
                                local text = "^6[AdmTransfer]^7 " .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "]  --> " .. GetPlayerName(target_source) .. "[ID:" .. target_dbid .. "] | " .. amount .. "$ | " .. reason
                                exports.playerdata:SendAdminMSG(1, text)
                                exports.playerdata:updateBankMoney(source)
                                exports.playerdata:updateBankMoney(target_source)
                            end
                        end
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("robstore", function(source, args)
    if(exports.playerdata:getWantedLevel(source) ~= 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Ai deja wanted level.")
    else
        if(exports.playerdata:getFaction(source) == 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu poti jefui un magazin daca esti politist.")
        else
            local player_pos = GetEntityCoords(GetPlayerPed(source))
            local wpIndex = 0
            for i = 1, cWorkingPoints do
                local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
                if(distance <= 2) then
                    wpIndex = i
                    break
                end
            end
            if(wpIndex == 0) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
            else
                if(working_point_type[wpIndex] ~= 2) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
                else
                    local player_rob_points = exports.playerdata:getRobPoints(source)
                    if(player_rob_points < 2) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai destule Rob Points.")
                    else
                        player_rob_points = player_rob_points - 2
                        exports.playerdata:setRobPoints(source, player_rob_points)
                        exports.playerdata:setWantedReason(source, "Rob Store")
                        exports.playerdata:setWantedLevel(source, 2)
                        TriggerClientEvent("sis_wanted-level::setWantedLevelClient", source, 2)
                        local player_dbid = exports.playerdata:getSqlID(source)
                        local text = "^4[PD] ^7" .. GetPlayerName(source) .. "[ID:" .. player_dbid .. "] a jefuit un magazin." 
                        exports.playerdata:SendFactionMSG(1, text)
                        local rob_money = math.random(2000, 5000)
                        TriggerClientEvent("chatMessage", source, "^1[WANTED]", {0,0,0}, "^7Ai jefut un mazin si ai primit ^4" .. rob_money .. "$^7.")
                        local player_money = exports.playerdata:getMoney(source) + rob_money
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateWantedLevel(source)
                        exports.playerdata:updateWantedReason(source)
                        exports.playerdata:updateRobPoints(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("deposit", function(source, args)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local wpIndex = 0
    for i = 1, cWorkingPoints do
        local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
        if(distance <= 2) then
            wpIndex = i
            break
        end
    end
    if(wpIndex == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
    else
        if(working_point_type[wpIndex] ~= 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/deposit", {0,0,0}, "^7 <amount>")
            else
                local deposit_money = tonumber(args[1])
                if(deposit_money == nil or deposit_money < 1) then
                    TriggerClientEvent("chatMessage", source, "^1/deposit", {0,0,0}, "^7 <amount>")
                else
                    local player_money = exports.playerdata:getMoney(source)
                    if(deposit_money > player_money) then
                        TriggerClientEvent("chatMessage", source, "^1[Bank]", {0,0,0}, "^7Nu ai destui bani.")
                    else
                        local player_bankmoney = exports.playerdata:getBankMoney(source) + deposit_money
                        player_money = player_money - deposit_money
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:setBankMoney(source, player_bankmoney)
                        TriggerClientEvent("chatMessage", source, "^1[Bank]", {0,0,0}, "^7Ai depozitat ^4" .. deposit_money .. "$ ^7in contul tau bancar.")
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateBankMoney(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("withdraw", function(source, args)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local wpIndex = 0
    for i = 1, cWorkingPoints do
        local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
        if(distance <= 2) then
            wpIndex = i
            break
        end
    end
    if(wpIndex == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
    else
        if(working_point_type[wpIndex] ~= 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/withdraw", {0,0,0}, "^7 <amount>")
            else
                local withdraw_money = tonumber(args[1])
                if(withdraw_money == nil or withdraw_money < 1) then
                    TriggerClientEvent("chatMessage", source, "^1/withdraw", {0,0,0}, "^7 <amount>")
                else
                    local player_bankmoney = exports.playerdata:getBankMoney(source)
                    if(withdraw_money > player_bankmoney) then
                        TriggerClientEvent("chatMessage", source, "^1[Bank]", {0,0,0}, "^7Fonduri insuficiente.")
                    else
                        local player_money = exports.playerdata:getMoney(source) + withdraw_money
                        player_bankmoney = player_bankmoney - withdraw_money
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:setBankMoney(source, player_bankmoney)
                        TriggerClientEvent("chatMessage", source, "^1[Bank]", {0,0,0}, "^7Ai retras ^4" .. withdraw_money .. "$ ^7din contul tau bancar.")
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateBankMoney(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("buygun", function(source, args)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local wpIndex = 0
    for i = 1, cWorkingPoints do
        local distance = math.floor(math.sqrt((math.pow(player_pos.x - working_point_pos_x[i], 2) + math.pow(player_pos.y - working_point_pos_y[i], 2) + math.pow(player_pos.z - working_point_pos_z[i], 2))))
        if(distance <= 2) then
            wpIndex = i
            break
        end
    end
    if(wpIndex == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
    else
        if(working_point_type[wpIndex] ~= 3) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            TriggerClientEvent("sis_business-c::showBuyGunMenu", source, working_point_pos_x[wpIndex], working_point_pos_y[wpIndex], working_point_pos_z[wpIndex])
        end
    end
end, false)
local weapon_name = {}
weapon_name[1] = "Knife"
weapon_name[2] = "Machete"
weapon_name[3] = "Bat"
weapon_name[4] = "Pistol"
weapon_name[5] = "AP Pistol"
weapon_name[6] = "Heavy Revolver"
weapon_name[7] = "Micro SMG"
weapon_name[8] = "SMG"
local weapon_cost = {}
weapon_cost[1] = 8000
weapon_cost[2] = 10000
weapon_cost[3] = 8000
weapon_cost[4] = 30000
weapon_cost[5] = 60000
weapon_cost[6] = 60000
weapon_cost[7] = 80000
weapon_cost[8] = 80000
local weapon_model = {}
weapon_model[1] = "weapon_knife"
weapon_model[2] = "weapon_machete"
weapon_model[3] = "weapon_bat"
weapon_model[4] = "weapon_pistol"
weapon_model[5] = "weapon_appistol"
weapon_model[6] = "weapon_revolver"
weapon_model[7] = "weapon_microsmg"
weapon_model[8] = "weapon_smg"
RegisterNetEvent("sis_business-s::giveWeapon")
AddEventHandler("sis_business-s::giveWeapon", function(source, i)
    local player_source = tonumber(source)
    local player_money = exports.playerdata:getMoney(player_source)
    local position = tonumber(i)
    if(weapon_cost[position] > player_money) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai destui bani.")
    else
        player_money = player_money - weapon_cost[position]
        exports.playerdata:setMoney(player_source, player_money)
        TriggerClientEvent("chatMessage", source, "^1[Gun Shop]", {0,0,0}, "Ti-ai cumparat un ^4" .. weapon_name[position] .. "^7 pentru ^4" .. weapon_cost[position] .. "$^7.")
        local player_ped = GetPlayerPed(player_source)
        local weaponHash = GetHashKey(weapon_model[position])
        GiveWeaponToPed(player_ped, weaponHash, 9999, false)
        exports.playerdata:updateMoney(player_source)
    end
end)