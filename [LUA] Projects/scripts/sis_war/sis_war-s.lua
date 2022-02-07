local war_zone_name = {}
local war_zone_x = {}
local war_zone_y = {}
local war_zone_z = {}
local war_zone_width = {}
local war_zone_height = {}
local war_zones = 0
local warstatus = 0
local warstoptime = 0
local warstarttime = 0
local aliance1kills = 0
local aliance2kills = 0
local war_lastid = 0
local war_id = 0
function GetWarID()
	return war_lastid
end
function GetWarStatus()
	return warstatus
end
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM `war-zone`", {}, 
    function(result)
        war_zones = tonumber(#result)
        for i = 1, #result do
            war_zone_name[i] = result[i].name
            war_zone_x[i] = result[i].x
			war_zone_y[i] = result[i].y
			war_zone_z[i] = result[i].z
            war_zone_width[i] = result[i].width
            war_zone_height[i] = result[i].height
        end
        print("[WAR ZONES]: loaded " .. war_zones .. " zones")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)

RegisterCommand("stopwar", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		if(warstatus == 0) then
			TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu este un war in desfasurare!")
		else
			StopWar(1)
		end
    end
end, false)
RegisterCommand("startwar", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
	local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank ~= 7 or player_faction < 2 or player_faction > 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		if(warstatus ~= 0) then
			TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Este deja un war in desfasurare!")
		else
			TriggerClientEvent("sis_war-c::EnableSelectMenu", source, war_zones, war_zone_name)
		end
    end
end, false)
RegisterNetEvent("sis_war-s::startWar")
AddEventHandler("sis_war-s::startWar", function(source, _war_id)
    local player_src = source
	local player_faction = exports.playerdata:getFaction(player_src)
	local player_faction_rank = exports.playerdata:getFactionRank(player_src)
	if(player_faction_rank ~= 7 or player_faction < 2 or player_faction > 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		if(warstatus ~= 0) then
			TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Este deja un war in desfasurare!")
		else
			StartWar(_war_id)
		end
	end
end)
RegisterNetEvent("sis_war_s_t::CheckActiveUI")
AddEventHandler("sis_war_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_war_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_war_s_r::CheckActiveUI")
AddEventHandler("sis_war_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 10)
end)
RegisterCommand("addwarzone", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/addwarzone", {0,0,0}, "^7 <name>")
        else
            local war_name = args[1]
            for i=2, #args do
                war_name = war_name .. " " .. args[i]
            end
			local coords = GetEntityCoords(GetPlayerPed(source))
			local width = 400
			local height = 400
            exports.ghmattimysql:execute("INSERT INTO `war-zone`(`name`, `x`, `y`, `z`, `width`, `height`) VALUES (@name,@x,@y,@z,@width,@height)", {['@name'] = war_name, ['@x'] = coords.x, ['@y'] = coords.y, ['@z'] = coords.z, ['@width'] = width, ['@height'] = height})
            TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Zona de war adauga cu succes.")
        end
    end
end, false)
function StartWar(_war_id)
	---inseram aici in db si updatam dupa
	
	local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM war_history WHERE 1", {}, 
    function(result)
        p:resolve(#result)
    end) 
    war_lastid = Citizen.Await(p) + 1
	print("WAR ID" .. war_lastid)
	war_id = _war_id
	warstatus = 1
	warstarttime = os.time()
	warstoptime = warstarttime + 3600
	aliance1kills = 0
	aliance2kills = 0
	for _, player_src in ipairs(GetPlayers()) do
		local player_faction = exports.playerdata:getFaction(player_src)
		if(player_faction >= 2 and player_faction <= 5) then
			if(exports.playerdata:getWantedLevel(player_src) == 0) then
				exports.playerdata:ForceRespawn(player_src)
			end
		end
	end
	TriggerClientEvent("chatMessage", -1, "^1[WAR]", {0,0,0}, "^7Have been started in zone with name: ^4" .. war_zone_name[war_id])
	exports.ghmattimysql:execute("INSERT INTO `war_history`(`winner`, `a1_kills`, `a2_kills`, `zone_id`, `start_time`, `stop_time`) VALUES (@winner,@a1_kills,@a2_kills,@zone_id,@start_time,@stop_time)", {['@winner'] = -2, ['@a1_kills'] = aliance1kills, ['@a2_kills'] = aliance2kills, ['@zone_id'] = war_id, ['@start_time'] = warstarttime, ['@stop_time'] = warstoptime})
end
function GetAlliance(factionid)
	if(factionid == 2 or factionid == 4) then
		return 1
	elseif(factionid == 3 or factionid == 5) then
		return 2
	else 
		return 0
	end
end

RegisterNetEvent('sis_war::playerDied')
AddEventHandler("sis_war::playerDied", function(source, killer)
	if(warstatus == 1) then
		local player_src = source
		local killer_src = killer
		local player_faction = exports.playerdata:getFaction(player_src)
		local killer_faction = exports.playerdata:getFaction(killer_src)
		if(player_faction >= 2 and player_faction <= 5 and killer_faction >= 2 and killer_faction <= 5) then
			local player_pos = GetEntityCoords(GetPlayerPed(player_src))
			local killer_pos = GetEntityCoords(GetPlayerPed(killer_src))
			local h_max = war_zone_y[war_id] + war_zone_height[war_id] / 2 
			local h_min = war_zone_y[war_id] - war_zone_height[war_id] / 2 
			local w_max = war_zone_x[war_id] + war_zone_width[war_id] / 2
			local w_min = war_zone_x[war_id] - war_zone_width[war_id] / 2
			if(player_pos.x <= w_max and player_pos.x >= w_min and player_pos.y <= w_max and player_pos.y >= w_min) then
				if(killer_pos.x <= w_max and killer_pos.x >= w_min and killer_pos.y <= w_max and killer_pos.y >= w_min) then
					local player_alliance = GetAlliance(player_faction)
					local killer_alliance = GetAlliance(killer_faction)
					if(player_alliance ~= killer_alliance) then
						local killer_kills = exports.playerdata:getWarKills(killer_src) + 1
						local killer_total_kills = exports.playerdata:getTotalKills(killer_src) + 1

						local player_deaths = exports.playerdata:getWarDeaths(player_src) + 1
						local player_total_deaths = exports.playerdata:getTotalDeaths(player_src) + 1
						exports.playerdata:setWarKills(killer_src, killer_kills)
						exports.playerdata:setWarDeaths(player_src, player_deaths)
						exports.playerdata:setTotalKills(killer_src, killer_total_kills)
						exports.playerdata:setTotalDeaths(player_src, player_total_deaths)
						exports.playerdata:updateWarKills(killer_src)
						exports.playerdata:updateWarDeaths(player_src)
						exports.playerdata:updateTotalKills(killer_src)
						exports.playerdata:updateTotalDeaths(player_src)
						if(killer_alliance == 1) then
							aliance1kills = aliance1kills + 1
						else
							aliance2kills = aliance2kills + 1
						end
					end
				end	
			end
		end
	end
end)

function StopWar(type)
	if(warstatus == 1) then
		if(type == 0) then
			local winner = 0
			if(aliance1kills > aliance2kills) then
				winner = 1
				TriggerClientEvent("chatMessage", -1, "^1[WarInfo]", {0,0,0}, "^7War castigat de catre alianta ^4Grove-TheTriads^7.")
			elseif(aliance1kills < aliance2kills) then
				winner = 2
				TriggerClientEvent("chatMessage", -1, "^1[WarInfo]", {0,0,0}, "^7War castigat de catre alianta ^4Ballas-TheMafia^7.")
			end
			if(winner == 0) then
				TriggerClientEvent("chatMessage", -1, "^1[WarInfo]", {0,0,0}, "^7War terminat la egalitate.")
			end
			TriggerClientEvent("chatMessage", -1, "^1[WarInfo]", {0,0,0}, "^7Grove-TheTriads^4[" .. aliance1kills .. "] ^7 Ballas-TheMafia^4[" .. aliance2kills .. "]^7.")
			for _, player_src in ipairs(GetPlayers()) do
				local player_faction = exports.playerdata:getFaction(player_src)
				if(player_faction >= 2 and player_faction <= 5) then
					if(exports.playerdata:getWantedLevel(player_src) == 0) then
						SetPlayerRoutingBucket(player_src, 0)
						exports.playerdata:ForceRespawn(player_src)
					end
				end
			end
			exports.ghmattimysql:execute("UPDATE `war_history` SET `winner`= @winner,`a1_kills`= @a1_kills,`a2_kills`= @a2_kills WHERE `id` = @id", {['@winner'] = winner, ['@a1_kills'] = aliance1kills, ['@a2_kills'] = aliance2kills, ['@id'] = war_lastid})
			warstatus = 0
		else
			warstatus = 0
			TriggerClientEvent("chatMessage", -1, "^1[WarInfo]", {0,0,0}, "^7War oprit fortat de catre un admin.")
			for _, player_src in ipairs(GetPlayers()) do
				local player_faction = exports.playerdata:getFaction(player_src)
				if(player_faction >= 2 and player_faction <= 5) then
					if(exports.playerdata:getWantedLevel(player_src) == 0) then
						SetPlayerRoutingBucket(player_src, 0)
						exports.playerdata:ForceRespawn(player_src)
					end
				end
			end
			exports.ghmattimysql:execute("UPDATE `war_history` SET `winner`= @winner,`a1_kills`= @a1_kills,`a2_kills`= @a2_kills WHERE `id` = @id", {['@winner'] = -1, ['@a1_kills'] = aliance1kills, ['@a2_kills'] = aliance2kills, ['@id'] = war_lastid})
		end
	end
end
Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(10)
		if(warstatus == 1) then
			local cTime = os.time()
			if(os.time() > warstoptime) then
				StopWar(0)
			end
		end
	end
end)
RegisterNetEvent("sis_war-s::updateWarInfo")
AddEventHandler("sis_war-s::updateWarInfo", function(player_src)
	local player_faction = exports.playerdata:getFaction(player_src)
	if(player_faction >= 2 and player_faction <= 5) then
		local wartimeleft = "N/A"
		if(warstatus == 1) then
			local timp = os.time()
			timp = warstoptime - timp
			wartimeleft = os.date("%M:%S", timp)
			local player_kills = exports.playerdata:getWarKills(player_src)
			local player_deaths = exports.playerdata:getWarDeaths(player_src)
			local player_bucket = GetPlayerRoutingBucket(player_src)
			if(player_bucket ~= 1) then
				SetPlayerRoutingBucket(player_src, 1)
			end
		end
		TriggerClientEvent("sis_war-c::updateWarInfo", player_src, warstatus, aliance1kills, aliance2kills, wartimeleft, war_zone_x[war_id], war_zone_y[war_id], war_zone_z[war_id], war_zone_width[war_id], war_zone_height[war_id], player_kills, player_deaths)
	else
		TriggerClientEvent("sis_war-c::updateWarInfo", player_src, 0, 0, 0, "N/A", 0, 0, 0, 0, 0, 0, 0)
	end
end)