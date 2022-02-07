exports.motiontext:Draw3DTextPermanent({
    xyz={x = 2571.3098144531 , y = 2720.017578125, z = 42.86083984375},
    text={
        content= "[JOB] ~y~Miner~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})


local pos_x = {}
local pos_y = {}
local pos_z = {}

local location_id = 0
local blip_id = 0
local can_trigger = 0
CreateThread(function()
	while true do
		Wait(0)
        if(location_id ~= 0) then
		    DrawMarker(2, pos_x[location_id],  pos_y[location_id],  pos_z[location_id], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            local player_pos = GetEntityCoords(GetPlayerPed(-1))
            local distance = math.sqrt((math.pow(pos_x[location_id] - player_pos.x, 2) + math.pow(pos_y[location_id] - player_pos.y, 2) + math.pow(pos_z[location_id] - player_pos.z, 2)))
            if(distance <= 1 and can_trigger == 1 and IsPedInAnyVehicle(PlayerPedId(), false) == false) then
                TriggerServerEvent("job_miner-s::PlayerAtLocation", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
                can_trigger = 0
            end
        end
	end
end)
RegisterNetEvent("job_miner-c::TurnOnMining")
AddEventHandler("job_miner-c::TurnOnMining", function()
    can_trigger = 1
    location_id = math.random(1, 15)
    blip_id = AddBlipForCoord(pos_x[location_id],  pos_y[location_id],  pos_z[location_id])
    SetBlipSprite(blip_id, 274)
    SetBlipRoute(blip_id,  true)
end)
RegisterNetEvent("job_miner-c::TurnOffMining")
AddEventHandler("job_miner-c::TurnOffMining", function()
    location_id = 0
    SetBlipRoute(blip_id,  false)
    RemoveBlip(blip_id)
    blip_id = 0
end)
RegisterNetEvent("job_miner-c::startMining")
AddEventHandler("job_miner-c::startMining", function()
    if(location_id == 0) then
        TriggerEvent("job_miner-c::TurnOnMining")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Ai inceput sa minezi.")
    else
        TriggerEvent("job_miner-c::TurnOffMining")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Te-ai oprit din minat.")
    end
end)
RegisterNetEvent("job_miner-c::PlayAnimation")
AddEventHandler("job_miner-c::PlayAnimation", function()
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
end)

pos_x[1] = 2986.2856445312 
pos_y[1] = 2813.3669433594 
pos_z[1] = 44.91650390625

pos_x[2] = 3002.0439453125 
pos_y[2] = 2788.8264160156 
pos_z[2] = 44.276245117188

pos_x[3] = 3002.3471679688 
pos_y[3] = 2760.8967285156 
pos_z[3] = 42.9619140625

pos_x[4] = 2980.9055175781 
pos_y[4] = 2749.4108886719 
pos_z[4] = 43.180908203125

pos_x[5] = 2970.4086914062 
pos_y[5] = 2772.4877929688 
pos_z[5] = 38.429321289062

pos_x[6] = 2980.9187011719 
pos_y[6] = 2789.1296386719 
pos_z[6] = 40.720825195312

pos_x[7] = 2973.982421875  
pos_y[7] = 2797.3977050781 
pos_z[7] = 41.2431640625

pos_x[8] = 2956.9978027344 
pos_y[8] = 2820.7253417969 
pos_z[8] = 42.591186523438

pos_x[9] = 2943.666015625  
pos_y[9] = 2820.6726074219
pos_z[9] = 43.298950195312

pos_x[10] = 2929.1999511719 
pos_y[10] = 2840.3471679688 
pos_z[10] = 49.7861328125

pos_x[11] = 2925.4943847656 
pos_y[11] = 2812.9318847656 
pos_z[11] = 44.613159179688

pos_x[12] = 2922.5539550781 
pos_y[12] = 2797.9516601562 
pos_z[12] = 41.07470703125

pos_x[13] = 2906.9143066406 
pos_y[13] = 2788.6813964844 
pos_z[13] = 46.399291992188

pos_x[14] = 2912.4790039062 
pos_y[14] = 2779.0021972656
pos_z[14] = 44.91650390625

pos_x[15] = 2913.4416503906 
pos_y[15] = 2796.7780761719 
pos_z[15] = 44.208740234375