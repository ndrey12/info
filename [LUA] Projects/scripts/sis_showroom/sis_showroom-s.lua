local category_count = 7
local showroom_totalcars = 0
local category_name = {}
local showroom_car_name = {}
local showroom_car_category = {}
local showroom_car_hash = {}
local showroom_car_year = {}
local showroom_car_price = {}
local showroom_car_stock = {}
local car_list = {}
local car_price = {}
local car_year = {}
local car_stock = {}
local car_hash = {}
local car_ids = {}
category_name[1] = "Audi"
category_name[2] = "BMW"
category_name[3] = "Mercedes-Benz"
category_name[4] = "Ford"
category_name[5] = "Volkswagen"
category_name[6] = "Dacia"
category_name[7] = "Mazda"
category_name[8] = "Tesla"
category_name[9] = "Lamborghini"
category_name[10] = "Ferrari"
category_name[11] = "Porsche"
category_name[12] = "Bugatti"
category_name[13] = "Rolls-Royce"
category_name[14] = "Lexus"
category_name[15] = "Toyota"
category_name[16] = "Volvo"
category_name[17] = "Land Rover"
category_name[18] = "Jaguar"
category_name[19] = "Jeep"
category_name[20] = "Honda"
category_name[21] = "Subaru"
category_name[22] = "KIA"
category_name[23] = "Cadillac"
category_name[24] = "Nissan"
category_name[25] = "Kawasaki"
category_name[26] = "KTM"
local max_cars_cat = {}
RegisterNetEvent("sis_showroom-s::sellCarToShowRoom")
AddEventHandler("sis_showroom-s::sellCarToShowRoom", function(source, chash)
    for i = 1, showroom_totalcars do
        if(showroom_car_hash[i] == chash) then
            local player_money = exports.playerdata:getMoney(source)
            local car_money = math.floor(showroom_car_price[i] * 0.5)
            player_money = player_money + car_money
            exports.playerdata:setMoney(source, player_money)
            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Ai primit ^4" .. car_money .. "^7$ pentru masina ta.")
            exports.playerdata:updateMoney(source)
            return
        end
    end
end)
RegisterNetEvent("sis_showroom-s::loadPlayerModels")
AddEventHandler("sis_showroom-s::loadPlayerModels", function(source)
    for i = 1, showroom_totalcars do            
        TriggerClientEvent("LoadCarModel", source, showroom_car_hash[i])
    end
end)
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM showroom_cars", {}, 
    function(result)
        showroom_totalcars = tonumber(#result)
        for i = 1, #result do
            showroom_car_name[i] = result[i].name
            showroom_car_hash[i] = result[i].car_hash
            showroom_car_year[i] = result[i].year
            showroom_car_price[i] = result[i].price
            showroom_car_category[i] = result[i].category
            showroom_car_stock[i] = result[i].stock
        end
        print("[SHOWROOM]: loaded " .. showroom_totalcars .. " cars")
        p:resolve(true)
    end)
    Citizen.Await(p)
    for i = 1, category_count do
        max_cars_cat[i] = 0
        car_list[i] = {}
        car_price[i] = {}
        car_year[i] = {}
        car_stock[i] = {}
        car_hash[i] = {}
        car_ids[i] = {}
    end
    for i = 1, showroom_totalcars do
        local current_cat = showroom_car_category[i]
        max_cars_cat[current_cat] = max_cars_cat[current_cat] + 1
        local mx = max_cars_cat[current_cat]
        car_list[current_cat][mx] = showroom_car_name[i]
        car_price[current_cat][mx] = showroom_car_price[i]
        car_year[current_cat][mx] = showroom_car_year[i]
        car_stock[current_cat][mx] = showroom_car_stock[i]
        car_hash[current_cat][mx] = showroom_car_hash[i]
        car_ids[current_cat][mx] = i
    end
end)
RegisterCommand("addcartoshowroom", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 6) then
            TriggerClientEvent("chatMessage", source, "^1/addcartoshowroom", {0,0,0}, "^7 <CATEGORY> <PRICE> <YEAR> <STOCK> <HASH_KEY> <NAME>")
        else
            local category = tonumber(args[1])
            local price = tonumber(args[2])
            local year = tonumber(args[3])
            local stock = tonumber(args[4])
            if(category == nil or year == nil or price == nil or stock == nil) then
                TriggerClientEvent("chatMessage", source, "^1/addcartoshowroom", {0,0,0}, "^7 <CATEGORY> <PRICE> <YEAR> <STOCK> <HASH_KEY> <NAME>")
            else
                local hash_key = args[5]
                local car_name = args[6]
                for i=7, #args do
                    car_name = car_name .. " " .. args[i]
                end
                exports.ghmattimysql:execute("INSERT INTO `showroom_cars`(`category`, `name`, `car_hash`, `year`, `price`, `stock`) VALUES (@category,@name,@car_hash,@year,@price,@stock)", {['@category'] = category, ['@name'] = car_name, ['@car_hash'] = hash_key, ['@year'] = year, ['@price'] = price,['@stock'] = stock})
                TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Masina adaugata cu succes in categoria " .. category_name[category])
            end
        end
    end
end, false)

RegisterCommand("buycar", function(source, args)
    local player_pos = GetEntityCoords(GetPlayerPed(source))
    local distance = math.floor(math.sqrt((math.pow(-43.094505310059 - player_pos.x, 2) + math.pow(-1104.1450195312- player_pos.y, 2) + math.pow(26.415405273438 - player_pos.z, 2))))
    if(distance > 1) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu esti in locatia potrivita.")
    else
        TriggerClientEvent("sis_showroom::EnableMenu", source, category_count, category_name)
        for i = 1, category_count do
            TriggerClientEvent("sis_showroom-c::setShowroomInfo", source, i, car_list[i], car_price[i], car_year[i], car_stock[i], car_ids[i], car_hash[i])
        end
    end
end, false)

function updateStock(car_id)
    exports.ghmattimysql:execute('UPDATE `showroom_cars` SET `stock`= @amount WHERE id = @id', {["@amount"] = showroom_car_stock[car_id], ["@id"] =car_id})
end
function getLastPersonalCarDBID(car_id)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `id` FROM `personal_cars` ORDER BY `id` DESC LIMIT 1", {}, 
    function(result)
        p:resolve(result[1].id)
    end)
    return Citizen.Await(p)
end
local showroom_park_x = {}
local showroom_park_y = {}
local showroom_park_z = {}
showroom_park_x[1] = -45.191207885742 
showroom_park_y[1] = -1115.9604492188 
showroom_park_z[1] = 25.89306640625

showroom_park_x[2] = -47.802196502686 
showroom_park_y[2] = -1116.1845703125 
showroom_park_z[2] = 25.89306640625

showroom_park_x[3] = -50.716484069824 
showroom_park_y[3] = -1116.2373046875 
showroom_park_z[3] = 25.89306640625

showroom_park_x[4] = -53.604396820068 
showroom_park_y[4] = -1116.4747314453 
showroom_park_z[4] = 25.89306640625

showroom_park_x[5] = -56.347248077393 
showroom_park_y[5] = -1116.5933837891 
showroom_park_z[5] = 25.89306640625

showroom_park_x[6] = -59.116477966309 
showroom_park_y[6] = -1116.5538330078 
showroom_park_z[6] = 25.89306640625

showroom_park_x[7] = -61.898899078369 
showroom_park_y[7] = -1116.7648925781 
showroom_park_z[7] = 25.89306640625
RegisterNetEvent("sis_showroom-s::buyCarr")
AddEventHandler("sis_showroom-s::buyCarr", function(source)
    print("Hello World")
end)
RegisterServerEvent("sis_showroom-s::buyCar")
AddEventHandler("sis_showroom-s::buyCar", function(source, car_id, i, j)
    car_id = tonumber(car_id)
    source = tonumber(source)
    local player_money = exports.playerdata:getMoney(source)
    local vehicle_price = showroom_car_price[car_id]
    if(player_money < vehicle_price) then
        TriggerClientEvent("chatMessage", source, "^1[Showroom]", {0,0,0}, "^7Nu ai destui bani pentru a cumpara un ^4" .. showroom_car_name[car_id] .. " ^7.")
    else
        local vehicle_stock = showroom_car_stock[car_id]
        if(vehicle_stock == 0) then
            TriggerClientEvent("chatMessage", source, "^1[Showroom]", {0,0,0}, "^7Ne pare rau dar nu mai avem acel model pe stock.")
        else
            local player_dbid = exports.playerdata:getSqlID(source)
            player_money = player_money - vehicle_price
            showroom_car_stock[car_id] = showroom_car_stock[car_id] - 1
            car_stock[i][j] = showroom_car_stock[car_id]
            exports.playerdata:setMoney(source, player_money)
            local last_dbid = getLastPersonalCarDBID() + 1
            local parking_spot = math.random(1,7)
            exports.ghmattimysql:execute("INSERT INTO `personal_cars`(`id`, `owner_id`, `vehicle_hash`, `vehicle_name`, `pos_x`, `pos_y`, `pos_z`) VALUES (@id,@owner_id,@vehicle_hash,@vehicle_name,@p_x,@p_y,@p_z)", {['@id'] = last_dbid,['@owner_id'] = player_dbid, ['@vehicle_hash'] = showroom_car_hash[car_id], ['@vehicle_name'] = showroom_car_name[car_id], ['@p_x'] = showroom_park_x[parking_spot], ['@p_y'] = showroom_park_y[parking_spot], ['@p_z'] = showroom_park_z[parking_spot]})
            TriggerEvent("sis_personal-vehicles-s::AddPersonalVehicle", source, player_dbid, showroom_car_hash[car_id], last_dbid, showroom_car_name[car_id], showroom_park_x[parking_spot], showroom_park_y[parking_spot], showroom_park_z[parking_spot], 0.0)
            TriggerClientEvent("chatMessage", source, "^1[Showroom]", {0,0,0}, "^5FELICITARI!! ^7Ai cumparat un " .. showroom_car_name[car_id] .. " ^7 pentru ^3" .. vehicle_price .. "^7 $.")
            ---
            ---update
            updateStock(car_id)
            exports.playerdata:updateMoney(source)
        end
    end
end)
