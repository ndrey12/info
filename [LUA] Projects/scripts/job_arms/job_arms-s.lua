local packets = {}

RegisterNetEvent("job_arms-s::resetPackets")
AddEventHandler("job_arms-s::resetPackets", function(source)
    packets[source] = 0
end)

RegisterCommand("getmats", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 1) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local x = 1238.188964843
        local y = -2969.68359375
        local z = 9.312866210937
        local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
        if(distance <= 3) then
            if(#args < 1) then
                TriggerClientEvent("chatMessage", source, "^1/getmats", {0,0,0}, "^7 <AMOUNT(1-10)>")
            else
                local max_packets = 10 - packets[source]
                local bought_packets = tonumber(args[1])
                if(bought_packets <= max_packets and bought_packets > 0) then
                    --- de adaugat verificare pentru bani
                    local player_money = exports.playerdata:getMoney(source)
                    if(player_money >= bought_packets * 50) then
                        exports.playerdata:setMoney(source, player_money - (bought_packets * 50))
                        packets[source] = packets[source] + bought_packets
                        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai cumparat ^3" .. bought_packets .. "^7 pachete pentru ^3" ..bought_packets * 50 .. "$^7. Acum ai ^3" .. packets[source] .. "^7.")
                        exports.playerdata:updateMoney(source)
                    else
                        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Mai ai nevoie de  ^3" .. bought_packets * 50 -  player_money .. "$ ^7pentru a cumpara ^3" .. bought_packets .. "^7 pachet/e.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Poti cumpara intre 1 si 10 pachete. Acum ai ^3" .. packets[source] .. "^7.")
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Arms Dealer.")
    end
end, false)
RegisterCommand("delivermats", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 1) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local x = 3615.3229980469
        local y = 3735.9033203125
        local z = 28.673217773438
        local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
        if(distance <= 3) then
            if(packets[source] > 0) then
                local player_mats = exports.playerdata:getMats(source)
                local got_mats = packets[source] * 100
                packets[source] = 0
                player_mats = player_mats + got_mats
                exports.playerdata:setMats(source, player_mats)
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai primit ^3" .. got_mats .. "^7 materiale.")
                exports.playerdata:updateMats(source)
            else
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu mai ai pachete.")
            end

        else
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli in locatia potrivita.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Arms Dealer.")
    end
end, false)
local weapon_model = {}
weapon_model[1] = "weapon_knife"
weapon_model[2] = "weapon_machete"
weapon_model[3] = "weapon_bat"
weapon_model[4] = "weapon_pistol"
weapon_model[5] = "weapon_appistol"
weapon_model[6] = "weapon_revolver"
weapon_model[7] = "weapon_microsmg"
weapon_model[8] = "weapon_smg"
weapon_model[9] = "weapon_assaultsmg"
weapon_model[10] = "weapon_pumpshotgun"
weapon_model[11] = "weapon_assaultrifle"
weapon_model[12] = "weapon_carbinerifle"
weapon_model[13] = "weapon_specialcarbine"
weapon_model[14] = "weapon_combatmg"
local weapon_name = {}
weapon_name[1] = "Knife"
weapon_name[2] = "Machete"
weapon_name[3] = "Bat"
weapon_name[4] = "Pistol"
weapon_name[5] = "AP Pistol"
weapon_name[6] = "Heavy Revolver"
weapon_name[7] = "Micro SMG"
weapon_name[8] = "SMG"
weapon_name[9] = "Assault SMG"
weapon_name[10] = "Pump Shotgun"
weapon_name[11] = "Assault Rifle"
weapon_name[12] = "Carbine Rifle"
weapon_name[13] = "Special Carbine"
weapon_name[14] = "Combat MG"
local weapon_cost = {}
weapon_cost[1] = 400
weapon_cost[2] = 500
weapon_cost[3] = 400
weapon_cost[4] = 1500
weapon_cost[5] = 3000
weapon_cost[6] = 3000
weapon_cost[7] = 4000
weapon_cost[8] = 4000
weapon_cost[9] = 5000
weapon_cost[10] = 4000
weapon_cost[11] = 6000
weapon_cost[12] = 6000
weapon_cost[13] = 6000
weapon_cost[14] = 10000
RegisterNetEvent("job_arms-s::giveWeapon")
AddEventHandler("job_arms-s::giveWeapon", function(target_dbid, weapon_id, mats_cost, player_dbid)
    if(weapon_id <= 14 and weapon_id >= 1) then
        mats_cost = weapon_cost[weapon_id]
        if(mats_cost ~= 0) then
            if(exports.playerdata:IsSqlIdConnected(player_dbid) == true) then
                local player_src = exports.playerdata:getSourceFromDBID(player_dbid)
                if(exports.sis_cuff:CheckHandCuff(tonumber(player_src)) == 0) then
                    if(exports.playerdata:IsSqlIdConnected(target_dbid) == true) then
                        local target_src = exports.playerdata:getSourceFromDBID(target_dbid)
                        local player_mats = exports.playerdata:getMats(player_src)
                        if(player_mats >= mats_cost) then
                            local player_ped = GetPlayerPed(player_src)
                            local target_ped = GetPlayerPed(target_src)
                            local player_pos = GetEntityCoords(player_ped)
                            local target_pos = GetEntityCoords(target_ped)
                            local distance = math.sqrt((math.pow(target_pos.x - player_pos.x, 2) + math.pow(target_pos.y - player_pos.y, 2) + math.pow(target_pos.z - player_pos.z, 2)))
                            if(distance <= 10) then
                                player_mats = player_mats - mats_cost
                                exports.playerdata:setMats(player_src, player_mats)
                                exports.playerdata:updateMats(player_src)
                                local weaponHash = GetHashKey(weapon_model[weapon_id])
                                GiveWeaponToPed(target_ped, weaponHash, 9999, false)
                                TriggerClientEvent("chatMessage", player_src, "^1[Arms Dealer]", {0,0,0}, "^7I-ai oferit jucatorului " .. GetPlayerName(target_src) .. "[ID:" .. target_dbid .. "] o arma (^3" .. weapon_name[weapon_id] .. "^7) pentru ^3" .. mats_cost .. "^7 de materiale")
                                TriggerClientEvent("chatMessage", target_src, "^1[Arms Dealer]", {0,0,0}, "^7Ai primit de la " .. GetPlayerName(player_src) .. "[ID:" .. player_dbid .. "]" .. " o arma (^3" .. weapon_name[weapon_id] .. "^7).")                            
                            else
                                TriggerClientEvent("chatMessage", player_src, "^1[Arms Dealer]", {0,0,0}, "^7Jucatorul nu este langa tine.")
                            end
                        else
                            TriggerClientEvent("chatMessage", player_src, "^1[Arms Dealer]", {0,0,0}, "^7Nu ai destule materiale, iti mai trebuie ^3" .. mats_cost - player_mats .. "^7.")
                        end
                    else
                        TriggerClientEvent("chatMessage", player_src, "^1[Arms Dealer]", {0,0,0}, "^7Jucatorul nu este conectat.")
                    end
                else
                    TriggerClientEvent("chatMessage", player_src, "^1[Arms Dealer]", {0,0,0}, "^7Nu poti folosi aceasta comanda daca esti incatusat.")
                end
            end
        end
    end
end)

RegisterCommand("givegun", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 1) then
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/givegun", {0,0,0}, "^7 <DB_ID>")
        else
            local dbid = tonumber(args[1])
            if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                local player_dbid = exports.playerdata:getSqlID(source)
                local target_src = exports.playerdata:getSourceFromDBID(dbid)
                local target_name = GetPlayerName(target_src)
                TriggerClientEvent("job_arms::GiveGun_EnableMenu", source, target_name, dbid, player_dbid)
            else
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Jucatorul nu este conectat.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Arms Dealer.")
    end
end, false)
RegisterCommand("givemats", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 1) then
        if(#args < 2) then
            TriggerClientEvent("chatMessage", source, "^1/givemats", {0,0,0}, "^7 <DB_ID> <AMOUNT>")
        else
            local dbid = tonumber(args[1])
            local amount = tonumber(args[2])
            local player_mats = exports.playerdata:getMats(source)
            if(amount >= 1 and amount <= player_mats) then
                if(exports.playerdata:IsSqlIdConnected(dbid) == true) then
                    local player_dbid = exports.playerdata:getSqlID(source)
                    if(dbid ~= player_dbid) then
                        local target_src = exports.playerdata:getSourceFromDBID(dbid)
                        local target_name = GetPlayerName(target_src)
                        local player_name = GetPlayerName(source)
                        local target_mats = exports.playerdata:getMats(target_src) + amount
                        player_mats = player_mats - amount
                        exports.playerdata:setMats(source, player_mats)
                        exports.playerdata:setMats(target_src, target_mats)
                        TriggerClientEvent("chatMessage", target_src, "^1[INFO]", {0,0,0}, "^7Ai primit de la " .. player_name .. "[ID:" .. player_dbid .. "]^3 " .. amount .."^7 materiale.")
                        TriggerClientEvent("chatMessage", source, "^1[INFO]", {0,0,0}, "^7I-ai dat jucatorului " .. target_name .. "[ID:" .. dbid .. "] ^3" .. amount .. "^7 materiale.")
                        exports.playerdata:updateMats(source)
                        exports.playerdata:updateMats(target_src)
                    else
                        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu poti folosi aceasta comanda pe tine.")
                    end
                else
                    TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Jucatorul nu este conectat.")
                end
            else
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu ai destule materiale.")
            end
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu esti Arms Dealer.")
    end
end, false)




RegisterCommand("agivegun", function(source, args, rawCommand)
	local playerPed = GetPlayerPed(source)
	local weaponHash = GetHashKey(args[1])
	local ammoCount = 9999
	
	TriggerEvent("chatMessage", "", {0, 0, 0}, "Giving weapon")
	GiveWeaponToPed(playerPed, weaponHash, ammoCount, false)
end)