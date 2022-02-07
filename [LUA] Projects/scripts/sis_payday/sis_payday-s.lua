local afk_status = {}
local last_payday = math.ceil(os.time() / 3600)
local last_payday_check = os.time()
RegisterServerEvent("sis_payday-s::setAfkStatus")
AddEventHandler("sis_payday-s::setAfkStatus", function(source, status)
	afk_status[tonumber(source)] = status
end)
RegisterServerEvent("sis_payday::payday")
AddEventHandler("sis_payday::payday", function()
	for _, player_src in ipairs(GetPlayers()) do
		local player_ps = exports.playerdata:getLastPaydaySeconds(player_src)
		exports.playerdata:setLastPaydaySeconds(player_src, 0)
		exports.playerdata:setLastPayday(player_src, last_payday)
		if(player_ps >= 1800) then
			local payday_money = math.min(10000, math.ceil( 0.1 * exports.playerdata:getBankMoney(player_src))) + player_ps
			local timpjucat = os.date("%M:%S", player_ps)
			TriggerClientEvent("sis_payday-c::showPayday", player_src, payday_money, timpjucat)
			local player_rp = exports.playerdata:getRespectPoints(player_src)
			exports.playerdata:setRespectPoints(player_src, player_rp + 1)
			exports.playerdata:updateRespectPoints(player_src)
			local player_rob_points = math.min(20, exports.playerdata:getRobPoints(player_src) + 4)
			exports.playerdata:setRobPoints(player_src, player_rob_points)
			exports.playerdata:updateRobPoints(player_src)
		else
			TriggerClientEvent("chatMessage", player_src, "^1[PayDay]", {0,0,0}, "^7Nu ai destule minute jucate pentru a primi payday.")
		end
	end
end)
Citizen.CreateThread(function()
    while(true) do
		Citizen.Wait(2000)
		local ctime = os.time()
		for _, player_src in ipairs(GetPlayers()) do
			local player_last_payday = exports.playerdata:getLastPayday(player_src)
			if(last_payday ~= player_last_payday) then
				exports.playerdata:setLastPaydaySeconds(player_src, 0)
				exports.playerdata:setLastPayday(player_src, last_payday)
			end
			if(afk_status[tonumber(player_src)] == nil) then
				local dif = ctime - last_payday_check
				local player_ps = exports.playerdata:getLastPaydaySeconds(player_src) + dif
				local player_ts = exports.playerdata:getTotalPlayingSeconds(player_src) + dif
				exports.playerdata:setLastPaydaySeconds(player_src, player_ps)
				exports.playerdata:setTotalPlayingSeconds(player_src, player_ts)
			end
		end
		last_payday_check = ctime
		if(math.ceil(last_payday_check / 3600) ~= last_payday) then
			last_payday = math.ceil(last_payday_check / 3600)
			TriggerEvent("sis_payday::payday")
		end
	end
end)
RegisterCommand("getlastseconds", function(source, args)
	print(exports.playerdata:getLastPaydaySeconds(source))
end, false)
RegisterCommand("payday", function(source, args)
	exports.playerdata:setLastPaydaySeconds(source, 1800)
	TriggerEvent("sis_payday::payday")
end, false)
RegisterCommand("buylevel", function(source, args) 
    local player_rp = exports.playerdata:getRespectPoints(source)
	local player_lvl = exports.playerdata:getLevel(source)
	local player_money = exports.playerdata:getMoney(source)
	local next_lvl_rp = player_lvl * 4
	local next_lvl_money = player_lvl * 10000
	if(player_rp < next_lvl_rp or player_money < next_lvl_money) then
		TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu ai destui bani sau RP.")
	else
		player_rp = player_rp - next_lvl_rp
		player_lvl = player_lvl + 1
		player_money = player_money - next_lvl_money
		exports.playerdata:setRespectPoints(source, player_rp)
		exports.playerdata:setMoney(source, player_money)
		exports.playerdata:setLevel(source, player_lvl)
		TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Level ^4UP^7.")
		exports.playerdata:updateRespectPoints(source)
		exports.playerdata:updateMoney(source)
		exports.playerdata:updateLevel(source)
	end
end, false)
AddEventHandler('playerDropped', function (reason)
    local player_src = source
    exports.playerdata:updateTotalPlayingSeconds(player_src)
	exports.playerdata:updateLastPayday(player_src)
	exports.playerdata:updateLastPaydaySeconds(player_src)
end)