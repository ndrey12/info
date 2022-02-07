local cHouses = 0
local house_pos_x = {}
local house_pos_y = {}
local house_pos_z = {}
local house_owner_id = {}
local house_level = {}
local house_owner_name = {}
local house_buy_price = {}
RegisterNetEvent("sis_houses-s::setOwnerName")
AddEventHandler("sis_houses-s::setOwnerName", function(house_id, owner_name)
    house_owner_name[house_id] = owner_name
end)
function AddHouse(house_id, pos_x, pos_y, pos_z, owner_id, level, owner_name, buy_price)
    house_pos_x[house_id] = pos_x
    house_pos_y[house_id] = pos_y
    house_pos_z[house_id] = pos_z
    house_owner_id[house_id] = owner_id
    house_level[house_id] = level
    house_owner_name[house_id] = owner_name
    house_buy_price[house_id] = buy_price
end
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM houses", {}, 
    function(result)
        cHouses = tonumber(#result)
        for i = 1, #result do
            AddHouse(i, result[i].pos_x, result[i].pos_y, result[i].pos_z, result[i].owner_id, result[i].level, result[i].owner_name, result[i].buy_price)
        end
        print("[Houses]: loaded " .. cHouses .. " houses")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)
RegisterCommand("addhouse", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/addhouse", {0,0,0}, "^7 <level> <price>")
        else
            local level = tonumber(args[1])
            local price = tonumber(args[2])
            if(level == nil or price == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addhouse", {0,0,0}, "^7 <level> <price>")
            else
                local house_pos = GetEntityCoords(GetPlayerPed(source))
                cHouses = cHouses + 1
                AddHouse(cHouses, house_pos.x, house_pos.y, house_pos.z, 0, level, "The State", price)
                exports.ghmattimysql:execute("INSERT INTO `houses` (`id`, `pos_x`, `pos_y`, `pos_z`, `owner_id`, `level`, `owner_name`, `buy_price`) VALUES (@id,@pos_x,@pos_y,@pos_z,@houseid,@level,@owner_name,@price)", {['@id'] = cHouses, ['@pos_x'] = house_pos.x, ['@pos_y'] = house_pos.y, ['@pos_z'] = house_pos.z, ['@houseid'] = 0, ['@level'] = level, ['@owner_name'] = "The State", ['@price'] = price})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Casa cu id: " .. cHouses .. " adaugata cu succes.")
            end
        end
    end
end, false)
Citizen.CreateThread(function()
    while true do
        for _, player_src in ipairs(GetPlayers()) do
            TriggerClientEvent("sis_houses-c::updateData", player_src, cHouses, house_pos_x, house_pos_y, house_pos_z, house_owner_id, house_level, house_owner_name, house_buy_price)
        end
        Citizen.Wait(500)
    end
end)
RegisterCommand("buyhouse", function(source, args)
    if(exports.playerdata:getHouse(source) ~= 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Ai deja o casa.")
    else
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local houseIndex = 0
        for i = 1, cHouses do
            local distance = math.floor(math.sqrt((math.pow(player_pos.x - house_pos_x[i], 2) + math.pow(player_pos.y - house_pos_y[i], 2) + math.pow(player_pos.z - house_pos_z[i], 2))))
            if(distance <= 2) then
                houseIndex = i
                break
            end
        end
        if(houseIndex == 0) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu te afli in locatia potrivita.")
        else
            if(house_owner_id[houseIndex] ~= 0) then
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Casa nu este la vanzare.")
            else
                local player_money = exports.playerdata:getMoney(source)
                local house_price = house_buy_price[houseIndex]
                if(player_money < house_price) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai destui bani pentru a cumpara aceasta casa.")
                else
                    local player_lvl = exports.playerdata:getLevel(source)
                    if(house_level[houseIndex] > player_lvl) then
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai levelul necesar pentru a cumpara aceasta casa.")
                    else
                        player_money = player_money - house_price
                        exports.playerdata:setSpawnLocation(source, 1)
                        exports.playerdata:setMoney(source, player_money)
                        exports.playerdata:setHouse(source, houseIndex)
                        house_owner_name[houseIndex] = GetPlayerName(source)
                        house_owner_id[houseIndex] = exports.playerdata:getSqlID(source)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai cumparat casa cu id ^4" .. houseIndex .. "^7 pentru ^4 " .. house_price .. "^7 $.")
                        exports.ghmattimysql:execute('UPDATE `houses` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = house_owner_id[houseIndex], ["@owner_name"] = house_owner_name[houseIndex], ["@id"] = houseIndex})
                        exports.playerdata:updateMoney(source)
                        exports.playerdata:updateHouse(source)
                        exports.playerdata:updateSpawnLocation(source)
                    end
                end
            end
        end
    end
end, false)
RegisterCommand("sellhouse", function(source, args)
    local player_house_id = exports.playerdata:getHouse(source)
    if(player_house_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai o casa.")
    else
        exports.playerdata:setHouse(source, 0)
        exports.playerdata:setSpawnLocation(source, 0)
        house_owner_name[player_house_id] ="The State"
        house_owner_id[player_house_id] = 0
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut casa cu id ^4" .. player_house_id ..  "^7.")
        exports.ghmattimysql:execute('UPDATE `houses` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = player_house_id})
        exports.playerdata:updateHouse(source)
        exports.playerdata:updateSpawnLocation(source)
    end
end, false)
RegisterCommand("asellhouse", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin <= 4) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/asellhouse", {0,0,0}, "^7 <house_id>")
        else
            local houseid = tonumber(args[1])
            if(houseid < 0 or houseid > cHouses) then
                TriggerClientEvent("chatMessage", source, "^1/asellhouse", {0,0,0}, "^7 <house_id>")
            else
                if(house_owner_id[houseid] == 0) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Casa cu id ^4" .. houseid .. " ^7 este deja la vanzare.")
                else
                    local owner_dbid = house_owner_id[houseid]
                    if(exports.playerdata:IsSqlIdConnected(owner_dbid) == true) then
                        local owner_src = exports.playerdata:getSourceFromDBID(owner_dbid)
                        exports.playerdata:setHouse(owner_src, 0)
                        exports.playerdata:setSpawnLocation(owner_src, 0)
                        house_owner_name[houseid] ="The State"
                        house_owner_id[houseid] = 0
                        local admin_dbid = exports.playerdata:getSqlID(source)
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut casa cu id ^4" .. houseid ..  "^7.")
                        TriggerClientEvent("chatMessage", owner_src, "^1[Info]", {0,0,0}, "^7Adminul " .. GetPlayerName(source) .. "[ID:" .. admin_dbid .. "] ti-a vandut casa cu id ^4" .. houseid ..  "^7.")
                        exports.ghmattimysql:execute('UPDATE `houses` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = houseid})
                        exports.playerdata:updateHouse(owner_src)
                        exports.playerdata:updateSpawnLocation(owner_src)
                    else
                        local owner_dbid = house_owner_id[houseid]
                        house_owner_name[houseid] ="The State"
                        house_owner_id[houseid] = 0
                        exports.ghmattimysql:execute('UPDATE `houses` SET `owner_id`=@owner_id,`owner_name`=@owner_name WHERE `id` = @id', {["@owner_id"] = 0, ["@owner_name"] = "The State", ["@id"] = houseid})
                        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai vandut casa cu id ^4" .. houseid ..  "^7.")
                        exports.playerdata:updateHouse_DBID(owner_dbid, 0)
                        exports.playerdata:updateSpawnLocation_DBID(owner_dbid, 0)

                    end
                end
            end
        end
    end
end, false)
RegisterCommand("changespawn", function(source, args)
    local player_house_id = exports.playerdata:getHouse(source)
    if(player_house_id == 0) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "Nu ai o casa.")
    else
        if(exports.playerdata:getSpawnLocation(source) == 1) then
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Spawn location changed to ^4spawn/faction^7.")
            exports.playerdata:setSpawnLocation(source, 0)
        else
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Spawn location changed to ^4home^7.")
            exports.playerdata:setSpawnLocation(source, 1)
        end
        exports.playerdata:updateSpawnLocation(source)
    end
end, false)
RegisterCommand("sethouselevel", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/sethouselevel", {0,0,0}, "^7 <house_id> <level>")
        else
            local houseid = tonumber(args[1])
            local houselevel = tonumber(args[2])
            if(houseid == nil or houselevel == nil) then
                TriggerClientEvent("chatMessage", source, "^1/sethouselevel", {0,0,0}, "^7 <house_id> <level>")
            else
                if(cHouses < houseid) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Casa inexistenta.")
                else
                    house_level[houseid] = houselevel
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai setat level ^4" .. houselevel .. "^7 casei cu id ^4" .. houseid .. "^7.")
                    exports.ghmattimysql:execute('UPDATE `houses` SET `level`=@house_level WHERE `id` = @id', {["@house_level"] = houselevel, ["@id"] = houseid})
                end
            end
        end
    end
end, false)
RegisterCommand("sethouseprice", function(source, args)
    local player_admin = exports.playerdata:getAdminLevel(source)
    if(player_admin ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/sethouseprice", {0,0,0}, "^7 <house_id> <price>")
        else
            local houseid = tonumber(args[1])
            local houseprice = tonumber(args[2])
            if(houseid == nil or houseprice == nil) then
                TriggerClientEvent("chatMessage", source, "^1/sethouseprice", {0,0,0}, "^7 <house_id> <price>")
            else
                if(cHouses < houseid) then
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Casa inexistenta.")
                else
                    house_buy_price[houseid] = houseprice
                    TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Ai setat pretul ^4" .. houseprice .. "^7 casei cu id ^4" .. houseid .. "^7.")
                    exports.ghmattimysql:execute('UPDATE `houses` SET `buy_price`=@buy_price WHERE `id` = @id', {["@buy_price"] = houseprice, ["@id"] = houseid})
                end
            end
        end
    end
end, false)
function getPosX(houseid)
    return house_pos_x[houseid]
end
function getPosY(houseid)
    return house_pos_y[houseid]
end
function getPosZ(houseid)
    return house_pos_z[houseid]
end