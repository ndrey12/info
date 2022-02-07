exports.motiontext:Draw3DTextPermanent({
    xyz={x = 439.20001220703, y = -993.30987548828, z = 30.678344726562},
    text={
        content= "[JOB] ~y~Lawer~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x =  461.60440063477, y = -989.15606689453, z = 24.89892578125},
    text={
        content= "[JOB] ~y~Lawer~n~~c~/free",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})


RMenu.Add('showcase', 'main', RageUI.CreateMenu("Jail List", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main'):SetSubtitle("Number")
RMenu:Get('showcase', 'main'):DisplayGlare(false);
RMenu:Get('showcase', 'main').EnableMouse = false
local menu_lawyer_status = 0
local jl_players = -1
local jl_players_data = {}
local max_skill_seconds = 0
RegisterNetEvent("job_lawer::EnableMenu")
AddEventHandler("job_lawer::EnableMenu", function()
    if(exports.playerdata:CheckActiveMenu() == false) then
        TriggerServerEvent("job_lawer-s::updateMenuData", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
        RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main'))) 
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end 
end)
RegisterNetEvent("job_lawer-c::updateMenuData")
AddEventHandler("job_lawer-c::updateMenuData", function(_jl_players, _jl_players_data, skill_seconds)
   jl_players_data = _jl_players_data 
   jl_players = _jl_players
   max_skill_seconds = skill_seconds
end)
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(500) 
        TriggerServerEvent("job_lawer-s::updateMenuData", GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
    end
end)
Citizen.CreateThread(function()
    local menu_temp_status = 0
    while (true) do
        Citizen.Wait(1.0)
        menu_temp_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main'), function()
            menu_temp_status = 1
            for i = 1, jl_players do
                local text = ""
                if(jl_players_data[i].seconds <= max_skill_seconds) then
                    text = "Timp ramas: ~g~" .. jl_players_data[i].seconds .. "~s~ secunde."
                else
                    text = "Timp ramas: ~r~ " .. jl_players_data[i].seconds .. "~s~ secunde."
                end
                RageUI.Button(jl_players_data[i].name .. "[ID:" .. jl_players_data[i].dbid .. "]", text, {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                    end,
                });   
            end
            if(jl_players == 0) then
                RageUI.Button("Nici un jucator nu este in jail.", "", {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                    end,
                });   
            end
        end)
        if(menu_temp_status ~= menu_lawyer_status) then
            menu_lawyer_status = menu_temp_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_lawyer_status
    exports.playerdata:CheckActiveUI(status)
end)
