local dbids = {}
local factions = {}
local admins = {}
local is_spec = {}
local need_update = -1
local red = {}
local green = {}
local blue = {}
local enable_names = true

--PD
red[1] = 27
green[1] = 72
blue[1] = 250
--GROOVE
red[2] = 35
green[2] = 135
blue[2] = 34
--
red[3] = 163
green[3] = 30
blue[3] = 186
--
red[4] = 92
green[4] = 56
blue[4] = 17
--
red[5] = 156
green[5] = 12
blue[5] = 17
--
red[6] = 230
green[6] = 94
blue[6] = 114
--
red[7] = 115
green[7] = 114
blue[7] = 114
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if(need_update == -1) then
      TriggerServerEvent("player_tags-s::getPlayersTable", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
      need_update = -2
    end
    if(need_update == 1) then
      TriggerServerEvent("player_tags-s::getPlayersTable", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
      need_update = 2
    end
  end
end)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    while(need_update == -1 or need_update == -2) do
      Citizen.Wait(1)
    end
    if(enable_names == true) then
      local maxplayers = GetConvarInt('sv_maxclients', 128) - 1
      for _, playerId in ipairs(GetActivePlayers()) do
        if(NetworkIsPlayerActive(playerId)) then
          local player_src = GetPlayerServerId(playerId)
          if(is_spec[player_src] ~= nil and is_spec[player_src] == false) then
            local player_pos = GetEntityCoords(GetPlayerPed(playerId))

            local admin_text = ""
            if(admins[player_src] ~= nil and admins[player_src] > 0) then
              admin_text = "~n~~r~(STAFF)"
            end
            local r = 255
            local g = 255
            local b = 255
            if(factions[player_src] ~= nil and factions[player_src] > 0) then
              r = red[factions[player_src]]
              g = green[factions[player_src]]
              b = blue[factions[player_src]]
            end
            local playername = GetPlayerName(playerId)
            if(dbids[player_src] ~= nil and playername ~= nil and admin_text ~= nil) then
              exports.motiontext:Draw3DText({
                  xyz={x = player_pos.x, y = player_pos.y, z = player_pos.z + 1},
                  text={
                      content = "[ " .. dbids[player_src] .. " ] " .. playername .. admin_text,
                      rgb={r , g, b},
                      textOutline=true,
                      scaleMultiplier=1,
                      font=0
                  },
                  perspectiveScale=4,
                  radius=100,
              })
            else
              need_update = 1
            end
          end
        end
      end
    end 
  end
end)

RegisterNetEvent("playe_tags-c::setPlayersTable")
AddEventHandler("playe_tags-c::setPlayersTable", function()
    need_update = 0
end)


RegisterNetEvent("playe_tags-c::updatePlayersTable")
AddEventHandler("playe_tags-c::updatePlayersTable", function() 
    need_update = 1
end)

RegisterNetEvent("playe_tags-c::updateDBID")
AddEventHandler("playe_tags-c::updateDBID", function(target_source, target_dbid, target_faction, target_admin, spec_status)
    dbids[target_source] = target_dbid
    factions[target_source] = target_faction
    admins[target_source] = target_admin
    is_spec[target_source] = spec_status
end)

RegisterNetEvent("player_tags-c::shownames")
AddEventHandler("player_tags-c::shownames", function()
    if(enable_names == true) then
      enable_names = false
      TriggerEvent("chatMessage", "^1Ai ascuns numele jucatorilor.")
    else
      enable_names = true
      TriggerEvent("chatMessage", "^1Ai activat numele jucatorilor.")
    end
end)
Citizen.CreateThread(function()
	while true do
		if(IsControlJustPressed(0, 243) and enable_names == false) then
			enable_names = true
		elseif(IsControlJustReleased(0, 243) and enable_names == true) then
			enable_names = false
		end
		Citizen.Wait(0)
	end
end)



