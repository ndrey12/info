exports.motiontext:Draw3DTextPermanent({
    xyz={x = -591.58679199219, y = -1627.8198242188, z = 33.037353515625},
    text={
        content= "[JOB] ~y~Drugs Dealer~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -578.42639160156, y = -1628.294555664, z = 33.003662109375},
    text={
        content= "[JOB] ~y~Drugs Dealer~n~~c~/getdrugs",
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
CreateThread(function()
	while true do
		Wait(0)
        if(location_id ~= 0) then
		    DrawMarker(2, pos_x[location_id],  pos_y[location_id],  pos_z[location_id], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            local player_pos = GetEntityCoords(GetPlayerPed(-1))
            local distance = math.sqrt((math.pow(pos_x[location_id] - player_pos.x, 2) + math.pow(pos_y[location_id] - player_pos.y, 2) + math.pow(pos_z[location_id] - player_pos.z, 2)))
            if(distance <= 1) then
                TriggerServerEvent("job_drugs-s::PlayerAtLocation", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
                Citizen.Wait(500)
            end
        end
	end
end)
RegisterNetEvent("job_drugs-c::TurnOnDelivery")
AddEventHandler("job_drugs-c::TurnOnDelivery", function()
    location_id = math.random(1,21)
    blip_id = AddBlipForCoord(pos_x[location_id],  pos_y[location_id],  pos_z[location_id])
    SetBlipSprite(blip_id, 496)
    SetBlipRoute(blip_id,  true)
end)
RegisterNetEvent("job_drugs-c::TurnOffDelivery")
AddEventHandler("job_drugs-c::TurnOffDelivery", function()
    location_id = 0
    SetBlipRoute(blip_id,  false)
    RemoveBlip(blip_id)
    blip_id = 0
end)
RegisterNetEvent("job_drugs-c::startDelivery")
AddEventHandler("job_drugs-c::startDelivery", function()
    if(location_id == 0) then
        TriggerEvent("job_drugs-c::TurnOnDelivery")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Ai activat livrarile de droguri.")
    else
        TriggerEvent("job_drugs-c::TurnOffDelivery")
        TriggerEvent("chatMessage", "^1[JOB]", {0,0,0}, "^7 Ai dezactivat livrarile de droguri.")
    end
end)

pos_x[1] = -985.18682861328 
pos_y[1] = -1198.4307861328 
pos_z[1] = 5.4542236328125

pos_x[2] = -951.67913818359 
pos_y[2] = -1079.0505371094 
pos_z[2] = 2.134765625

pos_x[3] = -930.14501953125 
pos_y[3] = -1101.2703857422 
pos_z[3] = 2.16845703125

pos_x[4] = -1034.8615722656 
pos_y[4] = -1146.5670166016 
pos_z[4] = 2.151611328125

pos_x[5] = -1082.3472900391 
pos_y[5] = -1139.7230224609 
pos_z[5] = 2.151611328125

pos_x[6] = -1161.4813232422 
pos_y[6] = -1099.5428466797 
pos_z[6] = 2.185302734375

pos_x[7] = -1176.3692626953 
pos_y[7] = -1072.9055175781 
pos_z[7] = 5.892333984375

pos_x[8] = -1055.4857177734 
pos_y[8] = -998.21539306641 
pos_z[8] = 6.3978271484375

pos_x[9] = -1151.4329833984 
pos_y[9] = -913.13409423828 
pos_z[9] = 6.6168212890625

pos_x[10] = -1031.6043701172 
pos_y[10] = -902.18902587891 
pos_z[10] = 3.75244140625

pos_x[11] = -1135.7537841797 
pos_y[11] = 376.21978759766 
pos_z[11] = 71.286499023438

pos_x[12] = -1094.5186767578 
pos_y[12] = 427.35824584961 
pos_z[12] = 75.86962890625

pos_x[13] = -1087.9384765625 
pos_y[13] = 479.40658569336 
pos_z[13] = 81.312133789062

pos_x[14] = -1052.0966796875 
pos_y[14] = 431.88131713867 
pos_z[14] = 77.049072265625

pos_x[15] = -1175.1032714844 
pos_y[15] = 440.28131103516 
pos_z[15] = 86.8388671875

pos_x[16] = -1215.7583007812 
pos_y[16] = 458.71649169922 
pos_z[16] = 91.84326171875

pos_x[17] = -1193.1032714844 
pos_y[17] = 563.16925048828 
pos_z[17] = 100.33557128906

pos_x[18] = -1146.6593017578 
pos_y[18] = 546.31646728516 
pos_z[18] = 101.49816894531

pos_x[19] = -1107.4813232422 
pos_y[19] = 593.90771484375 
pos_z[19] = 104.44689941406

pos_x[20] = -1294.3516845703 
pos_y[20] = 454.61538696289 
pos_z[20] = 97.521606445312

pos_x[21] = -1406.3736572266 
pos_y[21] = 526.90551757812 
pos_z[21] = 123.82421875
RegisterNetEvent("job_drugs-c::useDrugs")
AddEventHandler("job_drugs-c::useDrugs", function(used_drugs)
    local player_hp = GetEntityHealth(PlayerPedId(), false)
    if(player_hp <= 100) then
        player_hp = math.min(100, player_hp + 10 * used_drugs)
    else
        player_hp = math.min(200, player_hp + 10 * used_drugs)
    end
    SetEntityHealth(PlayerPedId(), player_hp)
end)