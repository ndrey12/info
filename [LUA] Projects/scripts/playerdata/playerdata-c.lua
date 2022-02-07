
RegisterNetEvent("playerdata-c::forceRespawn")
AddEventHandler("playerdata-c::forceRespawn", function()
    exports.spawnmanager:forceRespawn()
end)

local activeui 
local activeui_cnt 
local semafor_menu 
function CheckActiveUI(status)
    
    while(semafor_menu ~= 0) do
        Wait(1)
    end
    semafor_menu = 1
    activeui = activeui + status
    activeui_cnt = activeui_cnt - 1
    semafor_menu = 0
end
function CheckActiveMenu()
    while(activeui_cnt ~= nil) do
        Wait(1)
    end
    semafor_menu = 0
    activeui = 0
    activeui_cnt = 12

    TriggerEvent("CheckActiveUI")
    --[[TriggerClientEvent("sis_admin::CheckActiveUI", source)
    TriggerClientEvent("job_arms::CheckActiveUI", source)
    TriggerClientEvent("job_lawer::CheckActiveUI", source)
    TriggerClientEvent("sis_jobs::CheckActiveUI", source)
    TriggerClientEvent("sis_club::CheckActiveUI", source)
    TriggerClientEvent("sis_wanted-level::CheckActiveUI", source)
    TriggerClientEvent("sis_showroom::CheckActiveUI", source)
    TriggerClientEvent("sis_personal-vehicles::CheckActiveUI", source)
    TriggerClientEvent("sis_faction-cars::CheckActiveUI", source)
    TriggerClientEvent("sis_war::CheckActiveUI", source)]]--
    local semafor_timer = 0
    while activeui_cnt > 0 do

        semafor_timer = semafor_timer + 1
        if(semafor_timer == 100) then
            activeui_cnt = nil
            return true
        end
        Wait(1)
    end
    if(activeui == 0) then
        activeui_cnt = nil
        return false
    else
        activeui_cnt = nil
        return true
    end
end
local active_stats = 0
local player_level
local player_admin_level 
local player_warn 
local player_faction 
local player_faction_rank 
local player_fwarn 
local player_lwarn
local player_acwarn 
local player_pills 
local player_total_playing_seconds
local player_job 
local player_mats
local player_drugs 
local player_club 
local player_club_rank
local player_bpoints
local player_cwarns
local player_rob_points
local player_respect_points

RegisterNetEvent("playerdata-c::showStats")
AddEventHandler("playerdata-c::showStats", function(_player_level, _player_admin_level, _player_warn, _player_faction, _player_faction_rank, _player_fwarn, _player_lwarn, _player_acwarn, _player_pills, _player_total_playing_seconds, _player_job, _player_mats, _player_drugs, _player_club, _player_club_rank, _player_bpoints, _player_cwarns, _player_rob_points, _player_respect_points)
    if(active_stats == 1) then
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja stats activ.")
    else
        player_level = _player_level
        player_admin_level = _player_admin_level
        player_warn = _player_warn
        player_faction = _player_faction
        player_faction_rank = _player_faction_rank
        player_fwarn = _player_fwarn
        player_lwarn = _player_lwarn
        player_acwarn = _player_acwarn
        player_pills = _player_pills
        player_total_playing_seconds = _player_total_playing_seconds
        player_job = _player_job
        player_mats = _player_mats
        player_drugs = _player_drugs
        player_club = _player_club
        player_club_rank = _player_club_rank
        player_bpoints = _player_bpoints
        player_cwarns = _player_cwarns
        player_rob_points = _player_rob_points
        player_respect_points = _player_respect_points
        active_stats = 1
    end
end)

RegisterNetEvent("playerdata-c::hideStats")
AddEventHandler("playerdata-c::hideStats", function()
    if(active_stats == 0) then
        TriggerEvent("chatMessage", "", {255,0,0}, "^1[Info] ^7Ai deja stats inactiv.")
    else
        active_stats = 0
    end
end)
 --====================[TDE by APPI]======================
 --                26/12/2021 01:31:05 AM
 --                Thanks Disquse for help
 --=======================================================
 
 
 
 local Width, Height = GetActiveScreenResolution()
 
 
 Citizen.CreateThread(function()
     while true do
         Width, Height = GetActiveScreenResolution()
         Wait(100)
     end
 end)
 
 
 local function ToHorizontalAlignment(atype, x)
     if atype == 2 then
         return Width - x
     elseif atype == 1 then
         return Width / 2 + x
     end
     return x
 end
 
 local function ToVerticalAlignment(atype, y)
     if atype == 2 then
         return Height - y
     elseif atype == 1 then
         return Height / 2 + y
     end
     return y
 end
 
 function DrawText(caption, xPos, yPos, scale, r, g, b, alpha, font, justify, shadow, outline, wordWrap, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local x = ToHorizontalAlignment(hAlig, xPos) / Width
     local y = ToVerticalAlignment(vAlig, yPos) / Height
 
     SetTextFont(font);
     SetTextScale(1.0, scale);
     SetTextColour(r, g, b, alpha);
 
     if shadow then SetTextDropShadow() end
     if outline then SetTextOutline() end
 
     if justify == 1 then
         SetTextCentre(true)
     elseif justify == 2 then
         SetTextRightJustify(true)
         SetTextWrap(0, x)
     end
 
     if wordWrap ~= 0 then
         SetTextWrap(x, (xPos + wordWrap) / Width)
     end
 
     BeginTextCommandDisplayText("STRING")
     local maxStringLength = 99
     for i = 0, #caption, maxStringLength do
         AddTextComponentSubstringPlayerName(string.sub(caption, i, #caption))
     end
     EndTextCommandDisplayText(x, y)
 end
 
 function DrawGameSprite(dict, txtName, xPos, yPos, width, height, heading, r, g, b, alpha, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local x = ToHorizontalAlignment(hAlig, xPos) / Width
     local y = ToVerticalAlignment(vAlig, yPos) / Height
 
     if not HasStreamedTextureDictLoaded(dict) then
         RequestStreamedTextureDict(dict, true)
     end
 
     local w = wSize / Width
     local h = hSize / Height
     local x = ToHorizontalAlignment(hAlig, xPos) / Width + w * 0.5
     local y = ToVerticalAlignment(vAlig, yPos) / Height + h * 0.5
 
     DrawSprite(dict, txtName, x, y, w, h, heading, r, g, b, alpha)
 end
 
 function DrawRectangle(xPos, yPos, wSize, hSize, r, g, b, alpha, vAlig, hAlig)
     vAlig = vAlig or 0
     hAlig = hAlig or 0
 
 
     if not IsHudPreferenceSwitchedOn() or IsHudHidden() then
         return
     end
 
     local w = wSize / Width
     local h = hSize / Height
     local x = ToHorizontalAlignment(hAlig, xPos) / Width + w * 0.5
     local y = ToVerticalAlignment(vAlig, yPos) / Height + h * 0.5
 
     DrawRect(x, y, w, h, r, g, b, alpha)
 end
 
 
 
 Citizen.CreateThread(function()
     while true do
        if(active_stats == 1) then
            DrawRectangle(702, 105, 500, 360, 0, 0, 0, 100, 0, 0)
            DrawText("Stats", 946, 108, 0.9, 181, 27, 173, 255, 1, 1, true, true, 0, 0, 0)
            DrawText("Level: " .. player_level, 715, 166, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Admin Level: " .. player_admin_level, 715, 195, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Warn: " .. player_warn .. "/5", 714, 226, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Faction: " .. player_faction, 714, 256, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Faction Rank: " .. player_faction_rank, 713, 283, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("FWarn: " .. player_fwarn .. "/3", 713, 311, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("LWarn: " .. player_lwarn .. "/3", 712, 336, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("ACWarn: " .. player_acwarn .. "/3", 710, 365, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Pills: " .. player_pills, 710, 394, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Job: " .. player_job, 1009, 163, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Mats: " .. player_mats, 1005, 192, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Drugs: " .. player_drugs, 1002, 221, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Club: " .. player_club, 1003, 253, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Club Rank: " .. player_club_rank, 1002, 280, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("BPoints: " .. player_bpoints, 1001, 308, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("CWarns: " .. player_cwarns, 1001, 334, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Rob Points: " .. player_rob_points, 999, 363, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Respect Points: " .. player_respect_points, 997, 391, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
            DrawText("Total Playing Time: " .. math.floor(player_total_playing_seconds / 3600), 707, 424, 0.5, 255, 255, 255, 255, 1, 0, true, true, 0, 0, 0)
        end
         Wait(0)
     end
 end)
 
 
 
 --=====================[Count 21]======================
