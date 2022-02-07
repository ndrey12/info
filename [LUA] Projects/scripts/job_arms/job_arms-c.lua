exports.motiontext:Draw3DTextPermanent({
    xyz={x = 1224.4088134766, y = -2976.8308105469, z = 5.9091796875},
    text={
        content= "[JOB] ~y~Arms Dealer~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 1238.188964843, y = -2969.68359375, z = 9.312866210937},
    text={
        content= "[JOB] ~y~Arms Dealer~n~~c~/getmats",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = 3615.3229980469, y = 3735.9033203125, z = 28.673217773438},
    text={
        content= "[JOB] ~y~Arms Dealer~n~~c~/delivermats",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})

RMenu.Add('showcase', 'main_job_arms', RageUI.CreateMenu("Arms Dealer", "Undefined for using SetSubtitle", 1430, 150))
RMenu:Get('showcase', 'main_job_arms'):SetSubtitle("Number")
RMenu:Get('showcase', 'main_job_arms'):DisplayGlare(false);
RMenu:Get('showcase', 'main_job_arms').EnableMouse = false
local menu_status = 0
local target_name = ""
local target_dbid = 0
local player_dbid = 0
local weapon_name = {}
weapon_name[1] = "Knife"
weapon_name[2] = "Machete"
weapon_name[3] = "Bat"
weapon_name[4] = "Pistol"
weapon_name[5] = "AP Pistol"
weapon_name[6] = "Heavy Revolver"
weapon_name[7] = "Micro SMG"
weapon_name[8] = "SMG"
weapon_name[9] = "Assault SMG"
weapon_name[10] = "Pump Shotgun"
weapon_name[11] = "Assault Rifle"
weapon_name[12] = "Carbine Rifle"
weapon_name[13] = "Special Carbine"
weapon_name[14] = "Combat MG"
local weapon_cost = {}
weapon_cost[1] = 400
weapon_cost[2] = 500
weapon_cost[3] = 400
weapon_cost[4] = 1500
weapon_cost[5] = 3000
weapon_cost[6] = 3000
weapon_cost[7] = 4000
weapon_cost[8] = 4000
weapon_cost[9] = 5000
weapon_cost[10] = 4000
weapon_cost[11] = 6000
weapon_cost[12] = 6000
weapon_cost[13] = 6000
weapon_cost[14] = 10000
RegisterNetEvent("job_arms::GiveGun_EnableMenu")
AddEventHandler("job_arms::GiveGun_EnableMenu", function(_target_name, _target_dbid, _player_dbid)
    if(exports.playerdata:CheckActiveMenu() == false) then
        target_name = _target_name
        target_dbid = _target_dbid
        player_dbid = _player_dbid
        print(target_name)
        RageUI.Visible(RMenu:Get('showcase', 'main_job_arms'), not RageUI.Visible(RMenu:Get('showcase', 'main_job_arms')))  
    else
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja un meniu deschis.")
    end
end)

Citizen.CreateThread(function()
    local temp_menu_status = 0
    while (true) do
        Citizen.Wait(1.0)
        temp_menu_status = 0
        RageUI.IsVisible(RMenu:Get('showcase', 'main_job_arms'), function()
            temp_menu_status = 1
            for i = 1, 14 do
                RageUI.Button(weapon_name[i], "Cost materiale: " .. weapon_cost[i], {}, true, {
                    onHovered = function()
                    end,
                    onSelected = function()
                        TriggerServerEvent("job_arms-s::giveWeapon", target_dbid, i, weapon_cost[i], player_dbid)
                    end,
                });   
            end

        end)
        if(temp_menu_status ~= menu_status) then
            menu_status = temp_menu_status
        end
    end
end)
RegisterNetEvent("CheckActiveUI")
AddEventHandler("CheckActiveUI", function()
    local status = menu_status
    exports.playerdata:CheckActiveUI(status)
end)