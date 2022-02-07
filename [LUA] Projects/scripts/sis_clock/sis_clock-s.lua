
local weather_type = 1
local weather_names = {"CLEAR", "XMAS"}
RegisterCommand("snow", function(source, args) 
    local adminlevel = exports.playerdata:getAdminLevel(source)
    if(adminlevel >= 5) then
        if(weather_type == 1) then
            weather_type = 2
            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Snow Mode ^4[ON]")
        else
            weather_type = 1
            TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7Snow Mode ^4[OFF]")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1[AdmCmd]", {0,0,0}, "^7You don't have permission to use this command!")
    end
end, false) 
Citizen.CreateThread(function()
    while true do
        local timp = os.time()
        local ora = os.date("%H:%M", timp)
        local int_ora = os.date("%H", timp)
        local int_minut = os.date("%M", timp)
        local data = os.date("%d.%m.%Y", timp)
        for _, i in ipairs(GetPlayers()) do
            local cash_money = exports.playerdata:getMoney(i)
            local bank_money = exports.playerdata:getBankMoney(i)
            TriggerClientEvent("sis_clock-c::updateClock", i, data, ora, cash_money, bank_money, tonumber(int_ora), tonumber(int_minut), weather_names[weather_type])
        end
        Citizen.Wait(1000)
    end
end)