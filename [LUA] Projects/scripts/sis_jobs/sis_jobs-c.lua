CreateThread(function()
	while true do
		Wait(0)
        --arms
		DrawMarker(2, 1224.4088134766, -2976.8308105469, 5.9091796875, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --drugs
        DrawMarker(2, -591.58679199219, -1627.8198242188, 33.037353515625, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --lawer
        DrawMarker(2, 439.20001220703, -993.30987548828, 30.678344726562, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --miner
        DrawMarker(2, 2571.3098144531, 2720.017578125 , 42.86083984375, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --constructor
        DrawMarker(2, -97.503295898438, -1013.7890014648, 27.274780273438, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --fisher
        DrawMarker(2, -1851.1120605469, -1240.9846191406, 8.6051025390625, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        --farmer
        DrawMarker(2, 2881.6879882813, 4484.2944335938, 48.353881835938, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
	end
end)
local jobs_pos_x = {}
local jobs_pos_y = {}
local jobs_names = {}
local countJobs = 7
---arms dealer
jobs_pos_x[1] = 1224.4088134766 
jobs_pos_y[1] = -2976.8308105469
jobs_names[1] = "Arms Dealer"
---drugs dealer
jobs_pos_x[2] = -591.58679199219
jobs_pos_y[2] = -1627.8198242188
jobs_names[2] = "Drugs Dealer"
---lawer
jobs_pos_x[3] = 439.20001220703
jobs_pos_y[3] = -993.30987548828
jobs_names[3] = "Lawer"
---miner
jobs_pos_x[4] = 2571.3098144531
jobs_pos_y[4] = 2720.017578125
jobs_names[4] = "Miner"
---constructor
jobs_pos_x[5] = -97.503295898438
jobs_pos_y[5] = -1013.7890014648
jobs_names[5] = "Constructor"
---fisher
jobs_pos_x[6] = -1851.1120605469
jobs_pos_y[6] = -1240.9846191406
jobs_names[6] = "Fisher"
---farmer
jobs_pos_x[7] = 2881.6879882813
jobs_pos_y[7] = 4484.2944335938
jobs_names[7] = "Farmer"
RMenu.Add('showcase', 'main_jobs', RageUI.CreateMenu("Jobs", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_jobs'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_jobs'):DisplayGlare(false);
RMenu:Get('showcase', 'main_jobs').EnableMouse = false
local menu_jobs_status = 0
RegisterNetEvent("sis_jobs::EnableMenu")
AddEventHandler("sis_jobs::EnableMenu", function()
    if(exports.playerdata:CheckActiveMenu() == false) then
        RageUI.Visible(RMenu:Get('showcase', 'main_jobs'), not RageUI.Visible(RMenu:Get('showcase', 'main_jobs')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_jobs'), function()
            menu_temp_status = 1
            for i = 1, countJobs do
                RageUI.Button(jobs_names[i], "", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        SetNewWaypoint(jobs_pos_x[i], jobs_pos_y[i])
                    end,
                });   
            end
        end)
        if(menu_temp_status ~= menu_jobs_status) then
            menu_jobs_status = menu_temp_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_jobs_status
    exports.playerdata:CheckActiveUI(status)
end)
RegisterNetEvent("sis_jobs_c_t::CheckActiveUI")
AddEventHandler("sis_jobs_c_t::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main_jobs'), function()
        status = 1;
    end)
    TriggerServerEvent("sis_jobs_s_r::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)

RegisterNetEvent("sis_jobs::CheckActiveUI")
AddEventHandler("sis_jobs::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main_jobs'), function()
        status = 1;
    end)
    TriggerServerEvent("playerdata::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)