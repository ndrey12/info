RMenu.Add('showcase', 'main', RageUI.CreateMenu("Club Members", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(true);
RMenu:Get('showcase', 'main').EnableMouse = false
local menu_club_status = 0

local count_CMembers = 0
local names = {}
local ids = {}
local connected = {}
local cwarns = {}
local crank = {}
local bpoints = {}
RegisterNetEvent("sis_club::EnableMenu")
AddEventHandler("sis_club::EnableMenu", function(result, p_status)
    if(exports.playerdata:CheckActiveMenu() == false) then
        count_CMembers = #result
        for i = 1, count_CMembers do
            names[i] = result[i].name
            ids[i] = result[i].id
            connected[i] = p_status[i]
            cwarns[i] = result[i].club_warn
            crank[i] = result[i].club_rank
            bpoints[i] = result[i].bpoints
        end
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            menu_temp_status = 1
            for i = 1, count_CMembers do
                local string_Connected
                if(connected[i] == 1) then
                    string_Connected = "~g~(ONLINE) ~s~ "
                else
                    string_Connected = "~r~(OFFLINE) ~s~ "
                end
                RageUI.Button(string_Connected .. names[i] .. ' [ID:' .. ids[i] ..']', "Rank: "..crank[i] .. " | CWarns: "..cwarns[i].."/3" .. " | BPoints: " .. bpoints[i], {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                    end,
                });   
            end
        end)
        if(menu_temp_status ~= menu_club_status) then
            menu_club_status = menu_temp_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_club_status
    exports.playerdata:CheckActiveUI(status)
end)
RegisterNetEvent("sis_club_c_t::CheckActiveUI")
AddEventHandler("sis_club_c_t::CheckActiveUI", function()
    local status = 0
    RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
        status = 1;
    end)
    TriggerServerEvent("sis_club_s_r::CheckActiveUI",  GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), status)
end)