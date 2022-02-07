local function OnPlayerConnecting(name, setKickReason, deferrals)
    deferrals.defer()
	deferrals.update("Checking Player Information. Please Wait.")
    local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    for _, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamIdentifier = v
            break
        end
    end
    
    --
    if not steamIdentifier then
        setKickReason("You are not connected to Steam.")
        CancelEvent()
        do return end
    end
   -- exports.ghmattimysql:execute("SELECT * FROM users WHERE steamid = @id", { ['@id'] =  steamIdentifier}, function(result)
   local p = promise:new()
   exports.ghmattimysql:execute("SELECT * FROM users WHERE steamid = @steam64id", { ['@steam64id'] =  steamIdentifier}, 
   function(result)
        print("[SQL_DATA]" .. json.encode(result))
        if #result > 0 then
            local var = exports.playerdata:LoadPlayerData(player, steamIdentifier)
            if(var ~= false) then
                p:resolve(var)
            else
                p:resolve(true)
            end

        else 
            exports.ghmattimysql:execute("INSERT INTO users (steamid) VALUES (@steam64id)", {['@steam64id'] = steamIdentifier})
            exports.playerdata:LoadPlayerData(player, steamIdentifier)
            p:resolve(true)
        end

    end)
    local banned = Citizen.Await(p)
    if(banned ~= true) then
        deferrals.done(banned)
    end
    deferrals.done()
end

AddEventHandler("playerConnecting", OnPlayerConnecting)