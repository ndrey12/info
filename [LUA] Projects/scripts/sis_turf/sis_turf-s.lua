local TurfOwner = {}
local TurfStatus = {}
local TurfVW = {}
local TurfKills1 = {}
local TurfKills2 = {}
local TurfTimer = {}
local TurfFactionID1 = {}
local TurfFactionID2 = {}
local TurfPosX = {}
local TurfPosY = {}
local TurfPosZ = {}
local TurfWidth = {}
local TurfHeight = {}
local TurfStartTime = {}
local TurfNumbers = 0
local CanTurf = {}
local TurfDefendTimer = {}
local FactionTurf = {}
local TurfZoneHistoryID = {}
function GetGangName(id)
	if(id == 2) then
		return "Grove Street"
	elseif(id == 3) then
		return "Ballas"
	elseif(id == 4) then
		return "The Triads"
	elseif(id == 5) then
		return "The Mafia"
	end
	return "N/A"
end
function GetFactionTurfStatus(factionid)
	return CanTurf[factionid]
end
function GetFactionTurfID(factionid)
	return TurfZoneHistoryID[FactionTurf[factionid]]
end
Citizen.CreateThread(function()
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM `turf_zone`", {}, 
    function(result)
        TurfNumbers = tonumber(#result)
        for i = 1, #result do
            TurfOwner[i] = result[i].owner_id
            TurfPosX[i] = result[i].x
			TurfPosY[i] = result[i].y
			TurfPosZ[i] = result[i].z
            TurfWidth[i] = result[i].width
            TurfHeight[i] = result[i].height
        end
        print("[TURF ZONES]: loaded " .. TurfNumbers .. " zones")
        p:resolve(true)
    end)
    Citizen.Await(p)
end)

function StopTurf(type, zone_id)
	if(TurfStatus[zone_id] ~= nil) then
		if(type == 0) then
			local winner = TurfFactionID2[zone_id]
			if(TurfKills1[zone_id] > TurfKills2[zone_id]) then
				winner = TurfFactionID2[zone_id]
				TurfOwner[zone_id] = winner
				TriggerClientEvent("chatMessage", -1, "^1[TurfInfo]", {0,0,0}, "^7Turf castigat de catre  ^4" .. GetGangName(winner) .. "^7.")
			elseif(TurfKills1[zone_id] < TurfKills2[zone_id]) then
				winner = TurfFactionID1[zone_id]
				TurfOwner[zone_id] = winner
				TriggerClientEvent("chatMessage", -1, "^1[TurfInfo]", {0,0,0}, "^7Turf castigat de catre  ^4" .. GetGangName(winner) .. "^7.")
			end
			if(winner == 0) then
				TriggerClientEvent("chatMessage", -1, "^1[TurfInfo]", {0,0,0}, "^Turf terminat la egalitate.")
			end
			TriggerClientEvent("chatMessage", -1, "^1[TurfInfo]", {0,0,0}, "^7" .. GetGangName(TurfFactionID1[zone_id]) .. "^4[" .. TurfKills1[zone_id] .. "] ^7 " .. GetGangName(TurfFactionID2[zone_id]) .. "^4[" .. TurfKills2[zone_id] .. "].")
			for _, player_src in ipairs(GetPlayers()) do
				local player_faction = exports.playerdata:getFaction(player_src)
				if(player_faction == TurfFactionID1[zone_id] or TurfFactionID2[zone_id] == player_faction) then
					if(exports.playerdata:getWantedLevel(player_src) == 0) then
						SetPlayerRoutingBucket(player_src, 0)
						exports.playerdata:ForceRespawn(player_src)
					end
				end
			end
			exports.ghmattimysql:execute("UPDATE `turf_zone` SET `owner_id`= @owner_id, WHERE `id` = @id", {['@owner_id'] = TurfOwner[zone_id],  ['@id'] = zone_id})
			exports.ghmattimysql:execute("UPDATE `turf_history` SET `f1_kills`= @f1_kills,`f2_kills`= @f2_kills WHERE `id` = @id", {['@f1_kills'] = TurfKills1[zone_id], ['@f2_kills'] = TurfKills2[zone_id], ['@id'] = TurfZoneHistoryID[zone_id]})
			TurfStatus[zone_id] = nil
			TurfVW[zone_id] = nil
			TurfKills1[zone_id] = nil
			TurfKills2[zone_id] = nil
			CanTurf[TurfFactionID1[zone_id]] = nil
			CanTurf[TurfFactionID2[zone_id]] = nil
			FactionTurf[TurfFactionID1[zone_id]] = nil
			FactionTurf[TurfFactionID2[zone_id]] = nil
			TurfZoneHistoryID[zone_id] = nil
			TurfFactionID1[zone_id] = nil
			TurfFactionID2[zone_id] = nil
		else
			TriggerClientEvent("chatMessage", -1, "^1[TurfInfo]", {0,0,0}, "^7Turf oprit fortat de catre un admin.")
			for _, player_src in ipairs(GetPlayers()) do
				local player_faction = exports.playerdata:getFaction(player_src)
				if(player_faction == TurfFactionID1[zone_id] or TurfFactionID2[zone_id] == player_faction) then
					if(exports.playerdata:getWantedLevel(player_src) == 0) then
						SetPlayerRoutingBucket(player_src, 0)
						exports.playerdata:ForceRespawn(player_src)
					end
				end
			end
			TurfStatus[zone_id] = nil
			TurfVW[zone_id] = nil
			TurfKills1[zone_id] = nil
			TurfKills2[zone_id] = nil
			CanTurf[TurfFactionID1[zone_id]] = nil
			CanTurf[TurfFactionID2[zone_id]] = nil
			FactionTurf[TurfFactionID1[zone_id]] = nil
			FactionTurf[TurfFactionID2[zone_id]] = nil
			TurfZoneHistoryID[zone_id] = nil
			TurfFactionID1[zone_id] = nil
			TurfFactionID2[zone_id] = nil
			
		end
	end
end
RegisterCommand("stopturf", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		if(#args < 1) then
            TriggerClientEvent("chatMessage", source, "^1/stopturf", {0,0,0}, "^7 <faction(2-5)>")
        else
			local factionid = tonumber(args[1])
			if(factionid == nil) then
				TriggerClientEvent("chatMessage", source, "^1/stopturf", {0,0,0}, "^7 <faction(2-5)>")
			else
				if(factionid < 2 or factionid > 5) then
					TriggerClientEvent("chatMessage", source, "^1/stopturf", {0,0,0}, "^7 <faction(2-5)>")
				else
					if(CanTurf[factionid] == nil or CanTurf[factionid] == 0) then
						TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Gangul/Mafia nu se afla intr-un turf.")
					else
						local zone_id = FactionTurf[factionid]
						StopTurf(1, zone_id)
					end
				end
			end
		end
    end
end, false)
RegisterCommand("addturfzone", function(source, args)
    local player_admin_level = exports.playerdata:getAdminLevel(source)
    if(player_admin_level ~= 5) then
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    else
        if(#args < 3) then
            TriggerClientEvent("chatMessage", source, "^1/addturfzone", {0,0,0}, "^7 <faction> <width> <height>")
        else
            local owner_id = tonumber(args[1])
			local width = 1.0*tonumber(args[2])
			local height = 1.0*tonumber(args[3])
			if(owner_id == nil or width == nil or height == nil) then
				TriggerClientEvent("chatMessage", source, "^1/addturfzone", {0,0,0}, "^7 <faction> <width> <height>")
			else
				local coords = GetEntityCoords(GetPlayerPed(source))
				exports.ghmattimysql:execute("INSERT INTO `turf_zone`(`owner_id`, `x`, `y`, `z`, `width`, `height`) VALUES (@owner_id,@x,@y,@z,@width,@height)", {['@owner_id'] = owner_id, ['@x'] = coords.x, ['@y'] = coords.y, ['@z'] = coords.z, ['@width'] = width, ['@height'] = height})
				TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Zona de turf adauga cu succes.")
			end
        end
    end
end, false)
RegisterNetEvent("sis_turf-s::updateTurfZonesInfo")
AddEventHandler("sis_turf-s::updateTurfZonesInfo", function(source)
	TriggerClientEvent("sis_turf-c::updateTurfZonesInfo", source, TurfNumbers, TurfOwner, TurfPosX, TurfPosY, TurfPosZ, TurfWidth, TurfHeight)
end)
RegisterCommand("turfs", function(source, args)
	TriggerClientEvent("sis_turf-c::TurfOn", source)
end, false)
function CheckPlayerTurfZone(source)
	local id = 0
	local player_pos = GetEntityCoords(GetPlayerPed(source))
	for i = 1, TurfNumbers do
		local h_max = TurfPosX[i] + TurfHeight[i] / 2 
		local h_min = TurfPosY[i] - TurfHeight[i] / 2 
		local w_max = TurfPosX[i] + TurfWidth[i] / 2
		local w_min = TurfPosY[i] - TurfWidth[i] / 2
		if(player_pos.x <= w_max and player_pos.x >= w_min and player_pos.y <= h_max and player_pos.y >= h_min) then
			id = i
			break
		end
	end
	return id
end
RegisterCommand("attack", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
	local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank < 3 or player_faction < 2 or player_faction > 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		local zone_id = CheckPlayerTurfZone(source)
		if(zone_id == 0) then
			TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu te afli intr-o zona de turf.")
		else
			local AttackerID = player_faction
			local DefenderID = TurfOwner[zone_id]
			if(CanTurf[AttackerID] ~= nil or CanTurf[DefenderID] ~= nil) then
				TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti ataca acest teritoriu.")
			else
				local a1
				local a2
				if(AttackerID == 2 or AttackerID == 4) then
					a1 = 1
				else 
					a1 = 2
				end
				if(DefenderID == 3 or DefenderID == 5) then
					a2 = 2
				else 
					a2 = 1
				end
				if(a1 == a2) then
					TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Nu poti ataca un teritoriu detinut de alianta.")
				else
					if(AttackerID == DefenderID) then
						TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7Deja detii acest teritoriu..")
					else
						CanTurf[AttackerID] = 0
						CanTurf[DefenderID] = 0
						FactionTurf[AttackerID] = zone_id
						FactionTurf[DefenderID] = zone_id
						TurfFactionID1[zone_id] = AttackerID
						TurfFactionID2[zone_id] = DefenderID
						for _, playerId in ipairs(GetPlayers()) do
							if (DefenderID == exports.playerdata:getFaction(playerId)) then
								TriggerClientEvent("chatMessage", playerId, "^1[TURF]", {0,0,0}, "^7Teritoriul va este atacat de catre ^4" .. GetGangName(AttackerID) .. "^7. Foloseste comanda ^4/defend^7 in urmatoarele 2 min daca nu teritoriul va fi pierdut.")
							end
						end
						local ctime = os.time()
						TurfDefendTimer[zone_id] = ctime + 120 
					end
				end
			end
		end
	end
end, false)
RegisterCommand("defend", function(source, args)
    local player_faction = exports.playerdata:getFaction(source)
	local player_faction_rank = exports.playerdata:getFactionRank(source)
    if(player_faction_rank < 3 or player_faction < 2 or player_faction > 5) then
        TriggerClientEvent("chatMessage", source, "^1[Info]", {0,0,0}, "^7You don't have permission to use this command!")
    else
		if(CanTurf[player_faction] == nil or CanTurf[player_faction] > 0) then
			TriggerClientEvent("chatMessage", source, "^1[TURF]", {0,0,0}, "^7Teritoriile tale nu sunt amenintate.")
		else
			local zone_id = FactionTurf[player_faction]
			TurfDefendTimer[zone_id] = nil
			local p = promise:new()
			exports.ghmattimysql:execute("SELECT * FROM turf_history WHERE 1", {}, 
			function(result)
				p:resolve(#result)
			end) 
			TurfZoneHistoryID[zone_id] = Citizen.Await(p) + 1
			local fac1 = player_faction
			local fac2 = TurfFactionID1[zone_id]
			CanTurf[fac1] = 1
			CanTurf[fac2] = 1
			TurfStatus[zone_id] = 0
			TurfVW[zone_id] = fac1
			TurfStartTime[zone_id] = os.time()
			TurfTimer[zone_id] = TurfStartTime[zone_id] + 1200
			TurfKills1[zone_id] = 0
			TurfKills2[zone_id] = 0
			exports.ghmattimysql:execute("INSERT INTO `turf_history`(`attacker_id`, `defender_id`, `f1_kills`, `f2_kills`, `zone_id`, `start_time`, `stop_time`) VALUES (@fac1, @fac2, 0, 0, @zone_id, @start_time, @stop_time)", {['@fac1'] = fac1,['@fac2'] = fac2,['@zone_id'] = zone_id, ['@start_time'] = TurfStartTime[zone_id], ['@stop_time'] = TurfTimer[zone_id]})
			for _, player_src in ipairs(GetPlayers()) do
				player_faction = exports.playerdata:getFaction(player_src)
				if (player_faction == fac1 or player_faction == fac2) then
					if(exports.playerdata:getWantedLevel(player_src) == 0) then
						SetPlayerRoutingBucket(player_src, TurfVW[zone_id])
						exports.playerdata:ForceRespawn(player_src)
					end
				end
			end
		end
    end
end, false)
Citizen.CreateThread(function()
    while true do
		local ctime = os.time()
		for i = 1, TurfNumbers do
			if(TurfTimer[i] ~= nil) then
				if(ctime >= TurfTimer[i]) then
					TurfTimer[i] = nil
					StopTurf(0, i)
				end
			end
			if(TurfDefendTimer[i] ~= nil) then
				if(ctime >= TurfDefendTimer[i]) then
					local AttackerID = TurfFactionID1[i]
					local DefenderID = TurfFactionID2[i]
					TurfOwner[i] = AttackerID
					CanTurf[AttackerID] = nil
					CanTurf[DefenderID] = nil
					FactionTurf[AttackerID] = nil
					FactionTurf[DefenderID] = nil
					local text = "^7Winner: ^4" .. GetGangName(AttackerID) .. "^7."
					for _, player_src in ipairs(GetPlayers()) do
						local player_faction = exports.playerdata:getFaction(player_src)
						if (DefenderID == player_faction or AttackerID == player_faction) then
							TriggerClientEvent("chatMessage", player_src, "^1[TURF]", {0,0,0}, text)
						end
						TriggerClientEvent("sis_turf-c::updateOwner", player_src, i, AttackerID)
					end
					exports.ghmattimysql:execute("UPDATE `turf_zone` SET `owner_id`= @owner_id WHERE `id`= @id", {['@owner_id'] = owner_id, ['@id'] = zone_id})
					-- de updatat pe client
					TurfDefendTimer[i] = nil
				end
			end
		end
		Citizen.Wait(500)
	end
end)

RegisterNetEvent("sis_turf-s::updateTurfInfo")
AddEventHandler("sis_turf-s::updateTurfInfo", function(player_src)
	local player_faction = exports.playerdata:getFaction(player_src)
	if(player_faction >= 2 and player_faction <= 5) then
		local wartimeleft = "N/A"
		if(CanTurf[player_faction] == 1) then
			local zone_id = FactionTurf[player_faction]
			local timp = os.time()
			timp = TurfTimer[zone_id] - timp
			turftimeleft = os.date("%M:%S", timp)
			local player_kills = exports.playerdata:getTurfKills(player_src)
			local player_deaths = exports.playerdata:getTurfDeaths(player_src)
			local player_bucket = GetPlayerRoutingBucket(player_src)
			if(player_bucket ~= TurfVW[zone_id]) then
				SetPlayerRoutingBucket(player_src, TurfVW[zone_id])
			end
			TriggerClientEvent("sis_turf-c::updateTurfInfo", player_src, zone_id, TurfKills1[zone_id], TurfKills2[zone_id], turftimeleft, player_kills, player_deaths, TurfFactionID1[zone_id], TurfFactionID2[zone_id])
		else
			TriggerClientEvent("sis_turf-c::updateTurfInfo", player_src, 0, 0, 0, "N/A", 0, 0, 0, 0)
		end	
	else
		TriggerClientEvent("sis_turf-c::updateTurfInfo", player_src, 0, 0, 0, "N/A", 0, 0, 0, 0)
	end
end)
RegisterNetEvent('sis_turf::playerDied')
AddEventHandler("sis_turf::playerDied", function(source, killer)
	local player_src = source
	local killer_src = killer
	local player_faction = exports.playerdata:getFaction(player_src)
	local killer_faction = exports.playerdata:getFaction(killer_src)
	if(CanTurf[player_faction] == 1 and CanTurf[killer_faction] == 1) then
		local zone_id = FactionTurf[player_faction]
		if(player_faction >= 2 and player_faction <= 5 and killer_faction >= 2 and killer_faction <= 5) then
			local player_pos = GetEntityCoords(GetPlayerPed(player_src))
			local killer_pos = GetEntityCoords(GetPlayerPed(killer_src))
			local h_max = TurfPosY[zone_id] + TurfHeight[zone_id] / 2 
			local h_min = TurfPosY[zone_id] - TurfHeight[zone_id] / 2 
			local w_max = TurfPosX[zone_id] + TurfWidth[zone_id] / 2
			local w_min = TurfPosX[zone_id] - TurfWidth[zone_id] / 2
			if(player_pos.x <= w_max and player_pos.x >= w_min and player_pos.y <= w_max and player_pos.y >= w_min) then
				if(killer_pos.x <= w_max and killer_pos.x >= w_min and killer_pos.y <= w_max and killer_pos.y >= w_min) then
					if(player_faction ~= killer_faction) then
						local killer_kills = exports.playerdata:getTurfKills(killer_src) + 1
						local killer_total_kills = exports.playerdata:getTotalKills(killer_src) + 1
						local player_deaths = exports.playerdata:getTurfDeaths(player_src) + 1
						local player_total_deaths = exports.playerdata:getTotalDeaths(player_src) + 1
						exports.playerdata:setTurfKills(killer_src, killer_kills)
						exports.playerdata:setTurfDeaths(player_src, player_deaths)
						exports.playerdata:setTotalKills(killer_src, killer_total_kills)
						exports.playerdata:setTotalDeaths(player_src, player_total_deaths)
						exports.playerdata:updateTurfKills(killer_src)
						exports.playerdata:updateTurfDeaths(player_src)
						exports.playerdata:updateTotalKills(killer_src)
						exports.playerdata:updateTotalDeaths(player_src)
						if(TurfFactionID1[zone_id] == killer_faction) then
							TurfKills1[zone_id] = TurfKills1[zone_id] + 1
						else
							TurfKills2[zone_id] = TurfKills2[zone_id] + 1
						end

					end
				end	
			end
		end
	end
end)