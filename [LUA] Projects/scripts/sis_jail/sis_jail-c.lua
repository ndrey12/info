
------------------------------------------
local playerDisc = 0
local jail_time = 0
RegisterNetEvent("sis_jail-c::playerDisconnected")
AddEventHandler("sis_jail-c::playerDisconnected", function() 
    playerDisc = 1
end)
--[[
AddEventHandler("baseevents:onPlayerKilled", function(killer, data)
    TriggerServerEvent("sis_jail-s::PlayerKilled", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), killer, data )

end)
AddEventHandler("baseevents:onPlayerDied", function(killer, data)
    TriggerServerEvent("sis_jail-s::PlayerKilled", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), -1, data )
end)]]--
AddEventHandler('gameEventTriggered', function(eventName, args)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local culprit = args[2]
        local isDead = args[4] == 1

        if isDead and culprit == PlayerPedId() then
            if NetworkGetPlayerIndexFromPed(victim) ~= -1 then
                TriggerServerEvent("sis_jail-s::PlayerKilled", GetPlayerServerId(NetworkGetEntityOwner(victim)), GetPlayerServerId(NetworkGetEntityOwner(culprit)))
            end
        end
    end
end)

exports.motiontext:Draw3DTextPermanent({
    xyz={x = 441.25714111328, y = -981.16485595703, z = 30.678344726562},
    text={
        content= "Pentru a te preda foloseste comanda~n~~g~/surrender",
        rgb={255 , 255, 55},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=1,
    radius=30,
}) 
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 471.67913818359, y = -1023.6264038086, z = 28.15087890625},
    text={
        content= "Pentru a aresta un jucator urmarit foloseste comanda~n~~g~/arrest",
        rgb={255 , 255, 55},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=1,
    radius=30,
}) 

function ShowTime(seconds)
    SetTextFont(1)
    SetTextProportional(0)
    SetTextScale(0.5,0.5)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    if(seconds > 3600) then
        AddTextComponentString("Timp ramas  " .. math.floor(seconds / 3600) .. " ore " .. math.floor(seconds % 3600 / 60) .. " min " .. seconds % 60 .. " sec.")
    elseif (seconds > 60) then
        AddTextComponentString("Timp ramas  " ..  math.floor(seconds / 60) .. " min " .. seconds % 60 .. " sec.")
    else
        AddTextComponentString("Timp ramas  " ..  seconds % 61 .. " sec.")
    end
    DrawText(0.81,0.05)
end
RegisterNetEvent("sis_jail-c::showTimeLeft")
AddEventHandler("sis_jail-c::showTimeLeft", function(seconds) 
    jail_time = seconds
end)
Citizen.CreateThread(function()
    while true do
        if jail_time > 0 then
            ShowTime(jail_time)
            
            DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0, 25, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
            local pos = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1763.0109863281, 2491.4372558594, 45.556762695312)
            if(distance > 200 and jail_time > 0) then
                exports.spawnmanager:forceRespawn()
            end
        end
        Citizen.Wait(1)
    end
end)