RegisterServerEvent("player_tags-s::getPlayersTable")
AddEventHandler("player_tags-s::getPlayersTable", function(source)
    for _, playerId in ipairs(GetPlayers()) do
        local target_dbid = exports.playerdata:getSqlID(playerId)
        local target_admin = exports.playerdata:getAdminLevel(playerId)
        local target_faction = exports.playerdata:getFaction(playerId)
        local spec_status = exports.sis_admin:CheckSpecStatus(tonumber(playerId))
        TriggerClientEvent("playe_tags-c::updateDBID", source, tonumber(playerId),  target_dbid, target_faction, target_admin, spec_status)    
    end
    TriggerClientEvent("playe_tags-c::setPlayersTable", source)
end)

AddEventHandler("playerConnecting", function()
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
    end
end)
AddEventHandler('playerDropped', function ()
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
    end
end) 
RegisterNetEvent("player_tags::update")
AddEventHandler('player_tags::update', function ()
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("playe_tags-c::updatePlayersTable", playerId)
    end
end)
RegisterCommand("shownames", function(source, args)
    TriggerClientEvent("player_tags-c::shownames", source)
end, false)