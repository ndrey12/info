local jobs_pos_x = {}
local jobs_pos_y = {}
local jobs_pos_z = {}
local jobs_names = {}
local countJobs = 7
---arms dealer
jobs_pos_x[1] = 1224.4088134766 
jobs_pos_y[1] = -2976.8308105469
jobs_pos_z[1] = 5.9091796875
jobs_names[1] = "Arms Dealer"
---drugs dealer
jobs_pos_x[2] = -591.58679199219
jobs_pos_y[2] = -1627.8198242188
jobs_pos_z[2] = 33.037353515625
jobs_names[2] = "Drugs Dealer"
---lawer
jobs_pos_x[3] = 439.20001220703
jobs_pos_y[3] = -993.30987548828
jobs_pos_z[3] = 30.678344726562
jobs_names[3] = "Lawer"
---miner
jobs_pos_x[4] = 2571.3098144531
jobs_pos_y[4] = 2720.017578125
jobs_pos_z[4] = 42.8608398437
jobs_names[4] = "Miner"
---constructor
jobs_pos_x[5] = -97.503295898438
jobs_pos_y[5] = -1013.7890014648
jobs_pos_z[5] = 27.274780273438
jobs_names[5] = "Constructor"
---fisher
jobs_pos_x[6] = -1851.1120605469
jobs_pos_y[6] = -1240.9846191406
jobs_pos_z[6] = 8.6051025390625
jobs_names[6] = "Fisher"
---farmer
jobs_pos_x[7] = 2881.6879882813
jobs_pos_y[7] = 4484.2944335938
jobs_pos_z[7] = 48.353881835938
jobs_names[7] = "Farmer"


RegisterCommand("getjob", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job == 0) then
        local player_pos = GetEntityCoords(GetPlayerPed(source))
        local i = 1
        local found = 0
        while(i <= countJobs and found == 0) do
            local x = jobs_pos_x[i]
            local y = jobs_pos_y[i]
            local z = jobs_pos_z[i]
            local distance = math.sqrt((math.pow(x - player_pos.x, 2) + math.pow(y - player_pos.y, 2) + math.pow(z - player_pos.z, 2)))
            if(distance <= 3) then
                found = 1
                exports.playerdata:setJob(source, i)
                exports.playerdata:updateJob(source)
                TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7You're now a ^3" .. jobs_names[i] .. "^7.")
            end
            i = i + 1
        end
        if(found == 0) then
            TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu te afli la locatia unui job.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai deja un job, foloseste comanda /quitjob pentru a demisiona!")
    end
end, false)
RegisterCommand("quitjob", function(source, args)
    local player_job = exports.playerdata:getJob(source)
    if(player_job > 0) then
        exports.playerdata:setJob(source, 0)
        exports.playerdata:updateJob(source)
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Ai demisionat.")
    else
        TriggerClientEvent("chatMessage", source, "^1[JOB]", {0,0,0}, "^7Nu ai job!")
    end
end, false)

RegisterCommand("jobs", function(source, args)
    TriggerClientEvent("sis_jobs::EnableMenu", source)
end, false)

RegisterNetEvent("sis_jobs_s_t::CheckActiveUI")
AddEventHandler("sis_jobs_s_t::CheckActiveUI", function(source)
    TriggerClientEvent("sis_jobs_c_t::CheckActiveUI", source)
end)
RegisterNetEvent("sis_jobs_s_r::CheckActiveUI")
AddEventHandler("sis_jobs_s_r::CheckActiveUI", function(source, status)
    exports.playerdata:CheckActiveUI(source, status, 5)
end)
