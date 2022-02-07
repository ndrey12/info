exports.motiontext:Draw3DTextPermanent({
    xyz={x = -97.503295898438 , y = -1013.7890014648, z = 27.274780273438},
    text={
        content= "[JOB] ~y~Constructor~n~~c~/getjob",
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
                TriggerServerEvent("job_constructor-s::PlayerAtLocation", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
                can_trigger = 0
            end
        end
	end
end)
RegisterNetEvent("job_constructor-c::TurnOnBuilding")
AddEventHandler("job_constructor-c::TurnOnBuilding", function()
    can_trigger = 1
    location_id = math.random(1, 11)
    blip_id = AddBlipForCoord(pos_x[location_id],  pos_y[location_id],  pos_z[location_id])
    SetBlipSprite(blip_id, 274)
    SetBlipRoute(blip_id,  true)
end)
RegisterNetEvent("job_constructor-c::TurnOffBuilding")
AddEventHandler("job_constructor-c::TurnOffBuilding", function()
    location_id = 0
    SetBlipRoute(blip_id,  false)
    RemoveBlip(blip_id)
    blip_id = 0
end)
RegisterNetEvent("job_constructor-c::startBuilding")
AddEventHandler("job_constructor-c::startBuilding", function()
    if(location_id == 0) then
        TriggerEvent("job_constructor-c::TurnOnBuilding")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Ai inceput sa muncesti.")
    else
        TriggerEvent("job_constructor-c::TurnOffBuilding")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Te-ai oprit din muncit.")
    end
end)
RegisterNetEvent("job_constructor-c::PlayAnimation")
AddEventHandler("job_constructor-c::PlayAnimation", function()
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_HAMMERING', 0, true)
end)

pos_x[1] = -103.91208648682 
pos_y[1] = -971.02416992188 
pos_z[1] = 21.276245117188

pos_x[2] = -92.808792114258 
pos_y[2] = -967.16046142578 
pos_z[2] = 21.276245117188

pos_x[3] = -111.82417297363 
pos_y[3] = -992.76922607422 
pos_z[3] = 21.276245117188

pos_x[4] = -119.57801818848 
pos_y[4] = -1014.0922851562 
pos_z[4] = 26.314331054688

pos_x[5] = -137.36703491211 
pos_y[5] = -1009.147277832  
pos_z[5] = 27.274780273438

pos_x[6] = -145.49011230469 
pos_y[6] = -1026.8308105469 
pos_z[6] = 27.274780273438

pos_x[7] = -151.47692871094 
pos_y[7] = -1020.8043823242 
pos_z[7] = 27.257934570312

pos_x[8] = -147.91648864746 
pos_y[8] = -973.78021240234 
pos_z[8] = 21.276245117188

pos_x[9] = -158.30769348145 
pos_y[9] = -968.08349609375 
pos_z[9] = 21.276245117188

pos_x[10] = -154.70768737793 
pos_y[10] = -951.96923828125 
pos_z[10] = 21.276245117188

pos_x[11] = -140.14944458008 
pos_y[11] = -947.74945068359 
pos_z[11] = 21.276245117188