--[[
    GetPlayerSteamID(source) return steamIdentifier returneaza steam64id
    GetFreeID(steamid) seteaza un id intre 1 si max_slots pentru a memora datele jucatorului (id[steamid] = i, idToSteamID[i] = steamid)
    LoadPlayerData(source, steam64id) incarca playerdata din db
    IsSqlIdConnected(dbid) returneaza true/false 
    addLog(log_string) insereaza log_string in db
    ---GET---
    getSqlID(source) return sqlID[ id[steamid] ]
    getSteamIdFromSqlID(dbid) return sqlIdToSteamID[dbid]
    getAdminLevel(source) return adminlevel[ id[steamid] ]
    getMoney(source) return money[ id[steamid] ]
    getBankMoney(source) return bankmoney[ id[steamid] ]
    getSourceFromDBID(dbid) return 

    ---SET---
    setAdminLevel(source, level) 
    setMoney(source, amount)
    setBankMoney(source, amount)

    ---UPDATE---(in functie de steam64id)
    updateAdminLevel(source)
    updateMoney(source)
    updateBankMoney(source)
]]--
local id = {} --[[id[steamid]= id ]]--
local idToSteamID = {} --[[idToSteamID[pos] = steamid daca id[steamid] = pos ]]--
local adminlevel = {}
local money = {}
local bankmoney = {}
local sqlID = {} --[[sqlID[i(1-max_slots)] = sqlID id()]]--
local sqlIdToSteamID = {}
local warn = {}
local faction = {}
local factionRank = {}
local wanted_level = {}
local wanted_reason = {}
local faction_punish = {}
local fwarn = {}
local lwarn = {}
local acwarn = {}
local jail_time = {}
local job = {}
local mats = {}
local drugs = {}
local skill_drugs = {}
local sales_drugs = {}
local skill_lawer = {}
local free_lawer = {}
local club = {}
local club_rank = {}
local bpoints = {}
local cwarn = {}
local kills = {}
local arrests = {}
local tickets = {}
local assists = {}
local personal_vehicles = {}
local house = {}
local spawn_location = {}
local safe_drugs = {}
local safe_mats = {}
local taxa1 = {}
local taxa2 = {}
local taxa3 = {}
local taxa4 = {}
local rp = {}
local last_payday = {}
local last_payday_seconds = {}
local total_playing_seconds = {}
local level = {}
local rob_points = {}
local war_kills = {}
local war_deaths = {}
local war_lastid = {}
local turf_kills = {}
local turf_deaths = {}
local turf_lastid = {}
local total_kills = {}
local total_deaths = {}
local business = {}
local fmute = {}
local mute = {}
local pills = {}
local sold_pills = {}
local contract_price = {}
local contracts = {}
function dbid_exist(dbid)
    if(dbid == nil) then
         return false
    else
        local p = promise:new()
        exports.ghmattimysql:execute("SELECT `id` FROM users WHERE id = @dbid", { ['@dbid'] =  dbid}, 
        function(result)
            if #result > 0 then
                p:resolve(true)
            else 
                p:resolve(false)
            end
        end) 
        return Citizen.Await(p)
    end
end

function addLog(log_string)
    exports.ghmattimysql:execute("INSERT INTO logs (text) VALUES (@log_string)", {['@log_string'] = log_string})
end
function GetPlayerSteamID(source)
    local player = source
    local steamIdentifier 
    local identifiers = GetPlayerIdentifiers(player)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    return steamIdentifier
end
function IsSqlIdConnected(dbid)
    local player_source = getSourceFromDBID(dbid)
    if(player_source) then
        if(GetPlayerPing(player_source) > 0) then
            return true
        end
    end
    return false
end 
local free_id_semafor = 0
function GetFreeID(steamid)
    local found = false
    local maxplayers = GetConvarInt('sv_maxclients', 32)
    while(free_id_semafor ~= 0) do
        Citizen.Wait(1.0)
    end
    free_id_semafor = 1
    for i = 1, maxplayers do
        found = false
        for _, playerId in ipairs(GetPlayers()) do
            if GetPlayerSteamID(playerId) == idToSteamID[i] then
                found = true
                break
            end
        end
        if found == false then
            id[steamid] = i
            idToSteamID[i] = steamid
            break;
        end
    end
    free_id_semafor = 0
end
--[[get]]--
function getSteamID_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `steamid` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].steamid)
    end)
    return Citizen.Await(p)
end
function getAdminLevel_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `adminlevel` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].adminlevel)
    end)
    return Citizen.Await(p)
end
function getMoney_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `money` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].money)
    end)
    return Citizen.Await(p)
end
function getBankMoney_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `bankmoney` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].bankmoney)
    end)
    return Citizen.Await(p)
end
function getWarn_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `warn` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].warn)
    end)
    return Citizen.Await(p)
end
function getName_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `name` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].name)
    end)
    return Citizen.Await(p)
end
function getFaction_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `faction` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].faction)
    end)
    return Citizen.Await(p)
end
function getFactionRank_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `factionrank` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].factionrank)
    end)
    return Citizen.Await(p)
end
function getWantedLevel_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `wanted_level` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].wanted_level)
    end)
    return Citizen.Await(p)
end
function getWantedReason_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `wanted_reason` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].wanted_reason)
    end)
    return Citizen.Await(p)
end
function getFactionPunish_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `faction_punish` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        if(result[1].faction_push ~= 0 and result[1].faction_punish < os.time()) then
            if(IsSqlIdConnected(dbid)) then
                local target_source = getSourceFromDBID(dbid)
                setFactionPunish(target_source, 0)
                updateFactionPunish(target_source)
            else
                updateFactionPunish_DBID(dbid, 0)
            end
            p:resolve(0)
        else
            p:resolve(result[1].faction_punish)
        end
    end)
    return Citizen.Await(p)
end
function getFWarn_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `fwarn` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].fwarn)
    end)
    return Citizen.Await(p)
end
function getLWarn_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `lwarn` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].lwarn)
    end)
    return Citizen.Await(p)
end
function getACWarn_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `acwarn` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].acwarn)
    end)
    return Citizen.Await(p)
end
function getJailTime_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `jail_time` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].jail_time)
    end)
    return Citizen.Await(p)
end
function getJob_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `job` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].job)
    end)
    return Citizen.Await(p)
end
function getMats_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `mats` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].mats)
    end)
    return Citizen.Await(p)
end
function getDrugs_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `drugs` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].drugs)
    end)
    return Citizen.Await(p)
end
function getSkillDrugs_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `skill_drugs` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].skill_drugs)
    end)
    return Citizen.Await(p)
end
function getSalesDrugs_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `sales_drugs` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].sales_drugs)
    end)
    return Citizen.Await(p)
end
function getSkillLawer_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `skill_lawer` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].skill_lawer)
    end)
    return Citizen.Await(p)
end
function getFreeLawer_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `free_lawer` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].free_lawer)
    end)
    return Citizen.Await(p)
end
function getClub_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `club` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].club)
    end)
    return Citizen.Await(p)
end
function getClubRank_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `club_rank` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].club_rank)
    end)
    return Citizen.Await(p)
end
function getBPoints_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `bpoints` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].bpoints)
    end)
    return Citizen.Await(p)
end
function getClubWarn_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `club_warn` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].club_warn)
    end)
    return Citizen.Await(p)
end
function getArrests_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `arrests` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].arrests)
    end)
    return Citizen.Await(p)
end
function getTickets_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `tickets` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].tickets)
    end)
    return Citizen.Await(p)
end
function getKills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `kills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].kills)
    end)
    return Citizen.Await(p)
end
function getAssists_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `assists` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].assists)
    end)
    return Citizen.Await(p)
end
function getHouse_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `house` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].house)
    end)
    return Citizen.Await(p)
end
function getSpawnLocation_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `spawn_location` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].spawn_location)
    end)
    return Citizen.Await(p)
end
function getSafeMats_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `safe_mats` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].safe_mats)
    end)
    return Citizen.Await(p)
end
function getSafeDrugs_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `safe_drugs` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].safe_drugs)
    end)
    return Citizen.Await(p)
end
function getTaxa1_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `taxa1` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].taxa1)
    end)
    return Citizen.Await(p)
end
function getTaxa2_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `taxa2` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].taxa2)
    end)
    return Citizen.Await(p)
end
function getTaxa3_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `taxa3` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].taxa3)
    end)
    return Citizen.Await(p)
end
function getTaxa4_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `taxa4` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].taxa4)
    end)
    return Citizen.Await(p)
end
function getRespectPoints_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `rp` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].rp)
    end)
    return Citizen.Await(p)
end
function getLastPayday_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `last_payday` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].last_payday)
    end)
    return Citizen.Await(p)
end
function getLastPaydaySeconds_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `last_payday_seconds` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].last_payday_seconds)
    end)
    return Citizen.Await(p)
end
function getLevel_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `level` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].level)
    end)
    return Citizen.Await(p)
end
function getRobPoints_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `rob_points` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].rob_points)
    end)
    return Citizen.Await(p)
end
function getWarKills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `war_kills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].war_kills)
    end)
    return Citizen.Await(p)
end
function getWarDeaths_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `war_deaths` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].war_deaths)
    end)
    return Citizen.Await(p)
end
function getWarLastId_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `war_lastid` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].war_lastid)
    end)
    return Citizen.Await(p)
end
function getTotalKills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `total_kills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].total_kills)
    end)
    return Citizen.Await(p)
end
function getTotalDeaths_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `total_deaths` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].total_deaths)
    end)
    return Citizen.Await(p)
end
function getTurfKills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `turf_kills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].turf_kills)
    end)
    return Citizen.Await(p)
end
function getTurfDeaths_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `turf_deaths` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].turf_deaths)
    end)
    return Citizen.Await(p)
end
function getTurfLastId_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `turf_lastid` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].turf_lastid)
    end)
    return Citizen.Await(p)
end
function getTotalPlayingSeconds_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `total_playing_seconds` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].total_playing_seconds)
    end)
    return Citizen.Await(p)
end
function getBusiness_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `business` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].business)
    end)
    return Citizen.Await(p)
end
function getMute_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `mute` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].mute)
    end)
    return Citizen.Await(p)
end
function getFMute_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `fmute` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].fmute)
    end)
    return Citizen.Await(p)
end
function getPills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `pills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].pills)
    end)
    return Citizen.Await(p)
end
function getSoldPills_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `sold_pills` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].sold_pills)
    end)
    return Citizen.Await(p)
end
function getContractPrice_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `contract_price` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].contract_price)
    end)
    return Citizen.Await(p)
end
function getContracts_DBID(dbid)
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT `contracts` FROM users WHERE id = @id", {["@id"] = dbid}, 
    function(result)
        p:resolve(result[1].contracts)
    end)
    return Citizen.Await(p)
end
function getSourceFromDBID(dbid)
    local player_source = nil
    for _, playerId in ipairs(GetPlayers()) do
        if (getSqlID(playerId) == dbid) then
            player_source = playerId
            break
        end
    end
    return player_source
end
function getWarn(source)
    steamid = GetPlayerSteamID(source)
    return warn[ id[steamid] ]
end
function getSqlID(source)
    steamid = GetPlayerSteamID(source)
    return sqlID[ id[steamid] ]
end
function getSteamIdFromSqlID(dbid)
    return sqlIdToSteamID[dbid]
end
function getAdminLevel(source)
    steamid = GetPlayerSteamID(source)
    return adminlevel[ id[steamid] ]
end
function getMoney(source)
    steamid = GetPlayerSteamID(source)
    return money[ id[steamid] ]
end
function getBankMoney(source)
    steamid = GetPlayerSteamID(source)
    return bankmoney[ id[steamid] ]
end
function getFaction(source)
    steamid = GetPlayerSteamID(source)
    return faction[ id[steamid] ]
end
function getFactionRank(source)
    steamid = GetPlayerSteamID(source)
    return factionRank[ id[steamid] ]
end
function getWantedLevel(source)
    steamid = GetPlayerSteamID(source)
    return wanted_level[ id[steamid] ]
end
function getWantedReason(source)
    steamid = GetPlayerSteamID(source)
    return wanted_reason[ id[steamid] ]
end
function getFactionPunish(source)
    steamid = GetPlayerSteamID(source)
    if(faction_punish[id[steamid]] ~= 0 and os.time() >= faction_punish[id[steamid]]) then
        faction_punish[id[steamid]] = 0
    end
    return faction_punish[ id[steamid] ]
end
function getFWarn(source)
    steamid = GetPlayerSteamID(source)
    return fwarn[ id[steamid] ]
end
function getLWarn(source)
    steamid = GetPlayerSteamID(source)
    return lwarn[ id[steamid] ]
end
function getACWarn(source)
    steamid = GetPlayerSteamID(source)
    return acwarn[ id[steamid] ]
end
function getJailTime(source)
    steamid = GetPlayerSteamID(source)
    return jail_time[ id[steamid] ]
end
function getJob(source)
    steamid = GetPlayerSteamID(source)
    return job[ id[steamid] ]
end
function getMats(source)
    steamid = GetPlayerSteamID(source)
    return mats[ id[steamid] ]
end
function getDrugs(source)
    steamid = GetPlayerSteamID(source)
    return drugs[ id[steamid] ]
end
function getSkillDrugs(source)
    steamid = GetPlayerSteamID(source)
    return skill_drugs[ id[steamid] ]
end
function getSalesDrugs(source)
    steamid = GetPlayerSteamID(source)
    return sales_drugs[ id[steamid] ]
end
function getSkillLawer(source)
    steamid = GetPlayerSteamID(source)
    return skill_lawer[ id[steamid] ]
end
function getFreeLawer(source)
    steamid = GetPlayerSteamID(source)
    return free_lawer[ id[steamid] ]
end
function getClub(source)
    steamid = GetPlayerSteamID(source)
    return club[ id[steamid] ]
end
function getClubRank(source)
    steamid = GetPlayerSteamID(source)
    return club_rank[ id[steamid] ]
end
function getBPoints(source)
    steamid = GetPlayerSteamID(source)
    return bpoints[ id[steamid] ]
end
function getClubWarn(source)
    steamid = GetPlayerSteamID(source)
    return cwarn[ id[steamid] ]
end
function getArrests(source)
    steamid = GetPlayerSteamID(source)
    return arrests[ id[steamid] ]
end
function getTickets(source)
    steamid = GetPlayerSteamID(source)
    return tickets[ id[steamid] ]
end
function getKills(source)
    steamid = GetPlayerSteamID(source)
    return kills[ id[steamid] ]
end
function getAssists(source)
    steamid = GetPlayerSteamID(source)
    return assists[ id[steamid] ]
end
function getHouse(source)
    steamid = GetPlayerSteamID(source)
    return house[ id[steamid] ]
end
function getSpawnLocation(source)
    steamid = GetPlayerSteamID(source)
    return spawn_location[ id[steamid] ]
end
function getSafeMats(source)
    steamid = GetPlayerSteamID(source)
    return safe_mats[ id[steamid] ]
end
function getSafeDrugs(source)
    steamid = GetPlayerSteamID(source)
    return safe_drugs[ id[steamid] ]
end
function getTaxa1(source)
    steamid = GetPlayerSteamID(source)
    return taxa1[ id[steamid] ]
end
function getTaxa2(source)
    steamid = GetPlayerSteamID(source)
    return taxa2[ id[steamid] ]
end
function getTaxa3(source)
    steamid = GetPlayerSteamID(source)
    return taxa3[ id[steamid] ]
end
function getTaxa4(source)
    steamid = GetPlayerSteamID(source)
    return taxa4[ id[steamid] ]
end
function getRespectPoints(source)
    steamid = GetPlayerSteamID(source)
    return rp[ id[steamid] ]
end
function getLastPayday(source)
    steamid = GetPlayerSteamID(source)
    return last_payday[ id[steamid] ]
end
function getLastPaydaySeconds(source)
    steamid = GetPlayerSteamID(source)
    return last_payday_seconds[ id[steamid] ]
end
function getLevel(source)
    steamid = GetPlayerSteamID(source)
    return level[ id[steamid] ]
end
function getRobPoints(source)
    steamid = GetPlayerSteamID(source)
    return rob_points[ id[steamid] ]
end
function getWarKills(source)
    steamid = GetPlayerSteamID(source)
    return war_kills[ id[steamid] ]
end
function getWarDeaths(source)
    steamid = GetPlayerSteamID(source)
    return war_deaths[ id[steamid] ]
end
function getWarLastId(source)
    steamid = GetPlayerSteamID(source)
    return war_lastid[ id[steamid] ]
end
function getTotalKills(source)
    steamid = GetPlayerSteamID(source)
    return total_kills[ id[steamid] ]
end
function getTotalDeaths(source)
    steamid = GetPlayerSteamID(source)
    return total_deaths[ id[steamid] ]
end
function getTurfKills(source)
    steamid = GetPlayerSteamID(source)
    return turf_kills[ id[steamid] ]
end
function getTurfDeaths(source)
    steamid = GetPlayerSteamID(source)
    return turf_deaths[ id[steamid] ]
end
function getTurfLastId(source)
    steamid = GetPlayerSteamID(source)
    return turf_lastid[ id[steamid] ]
end
function getTotalPlayingSeconds(source)
    steamid = GetPlayerSteamID(source)
    return total_playing_seconds[ id[steamid] ]
end
function getBusiness(source)
    steamid = GetPlayerSteamID(source)
    return business[ id[steamid] ]
end
function getMute(source)
    steamid = GetPlayerSteamID(source)
    local sec_mute = math.max(mute[id[steamid]] - os.time(), 0)
    return sec_mute
end
function getFMute(source)
    steamid = GetPlayerSteamID(source)
    local sec_mute = math.max(fmute[id[steamid]] - os.time(), 0)
    return sec_mute
end
function getPills(source)
    steamid = GetPlayerSteamID(source)
    return pills[ id[steamid] ]
end
function getSoldPills(source)
    steamid = GetPlayerSteamID(source)
    return sold_pills[ id[steamid] ]
end
function getContractPrice(source)
    steamid = GetPlayerSteamID(source)
    return contract_price[ id[steamid] ]
end
function getContracts(source)
    steamid = GetPlayerSteamID(source)
    return contracts[ id[steamid] ]
end
--[[set]]--
function setAdminLevel(source, level)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    adminlevel[sourceID] = level
end
function setWarn(source, var)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    warn[sourceID] = var
end
function setMoney(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    money[sourceID] = amount
end
function setBankMoney(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    bankmoney[sourceID] = amount
end
function setFaction(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    faction[sourceID] = amount
end
function setFactionRank(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    factionRank[sourceID] = amount
end
function setWantedLevel(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    wanted_level[sourceID] = amount
end
function setWantedReason(source, reason)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    wanted_reason[sourceID] = reason
end
function setFactionPunish(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    faction_punish[sourceID] = amount
end
function setFWarn(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    fwarn[sourceID] = amount
end
function setLWarn(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    lwarn[sourceID] = amount
end
function setACWarn(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    acwarn[sourceID] = amount
end
function setJailTime(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    jail_time[sourceID] = amount
end
function setJob(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    job[sourceID] = amount
end
function setMats(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    mats[sourceID] = amount
end
function setDrugs(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    drugs[sourceID] = amount
end
function setSkillDrugs(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    skill_drugs[sourceID] = amount
end
function setSalesDrugs(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    sales_drugs[sourceID] = amount
end
function setSkillLawer(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    skill_lawer[sourceID] = amount
end
function setFreeLawer(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    free_lawer[sourceID] = amount
end
function setClub(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    club[sourceID] = amount
end
function setClubRank(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    club_rank[sourceID] = amount
end
function setBPoints(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    bpoints[sourceID] = amount
end
function setClubWarn(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    cwarn[sourceID] = amount
end
function setArrests(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    arrests[sourceID] = amount
end
function setTickets(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    tickets[sourceID] = amount
end
function setKills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    kills[sourceID] = amount
end
function setAssists(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    assists[sourceID] = amount
end
function setHouse(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    house[sourceID] = amount
end
function setSpawnLocation(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    spawn_location[sourceID] = amount
end
function setSafeMats(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    safe_mats[sourceID] = amount
end
function setSafeDrugs(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    safe_drugs[sourceID] = amount
end
function setTaxa1(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    taxa1[sourceID] = amount
end
function setTaxa2(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    taxa2[sourceID] = amount
end
function setTaxa3(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    taxa3[sourceID] = amount
end
function setTaxa4(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    taxa4[sourceID] = amount
end
function setRespectPoints(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    rp[sourceID] = amount
end
function setLastPayday(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    last_payday[sourceID] = amount
end
function setLastPaydaySeconds(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    last_payday_seconds[sourceID] = amount
end
function setLevel(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    level[sourceID] = amount
end
function setRobPoints(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    rob_points[sourceID] = amount
end
function setWarKills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    war_kills[sourceID] = amount
end
function setWarDeaths(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    war_deaths[sourceID] = amount
end
function setWarLastId(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    war_lastid[sourceID] = amount
end
function setTotalKills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    total_kills[sourceID] = amount
end
function setTotalDeaths(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    total_deaths[sourceID] = amount
end
function setTurfKills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    turf_kills[sourceID] = amount
end
function setTurfDeaths(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    turf_deaths[sourceID] = amount
end
function setTurfLastId(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    turf_lastid[sourceID] = amount
end
function setTotalPlayingSeconds(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    total_playing_seconds[sourceID] = amount
end
function setBusiness(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    business[sourceID] = amount
end
function setMute(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    mute[sourceID] = os.time() + amount
end
function setFMute(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    fmute[sourceID] = os.time() + amount
end
function setPills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    pills[sourceID] = amount
end
function setSoldPills(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    sold_pills[sourceID] = amount
end
function setContractPrice(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    contract_price[sourceID] = amount
end
function setContracts(source, amount)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    contracts[sourceID] = amount
end
--[[update]]--

function updateAdminLevel(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `adminlevel`= @adminlvl WHERE steamid = @steam64id', {["@adminlvl"] = getAdminLevel(source), ["@steam64id"] = steamid})
end
function updateAdminLevel_DBID(dbid, a_lvl)
    exports.ghmattimysql:execute('UPDATE `users` SET `adminlevel`= @adminlvl WHERE id = @id', {["@adminlvl"] = a_lvl, ["@id"] = dbid})
end

function updateMoney(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `money`= @amount WHERE steamid = @steam64id', {["@amount"] = getMoney(source), ["@steam64id"] = steamid})
end
function updateMoney_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `money`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateBankMoney(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `bankmoney`= @amount WHERE steamid = @steam64id', {["@amount"] = getBankMoney(source), ["@steam64id"] = steamid})
end
function updateMoney_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `money`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateWarn(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `warn`= @amount WHERE steamid = @steam64id', {["@amount"] = getWarn(source), ["@steam64id"] = steamid})
end
function updateWarn_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `warn`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateFaction(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `faction`= @amount WHERE steamid = @steam64id', {["@amount"] = getFaction(source), ["@steam64id"] = steamid})
end
function updateFaction_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `faction`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateFactionRank(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `factionrank`= @amount WHERE steamid = @steam64id', {["@amount"] = getFactionRank(source), ["@steam64id"] = steamid})
end
function updateFactionRank_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `factionrank`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateWantedLevel(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `wanted_level`= @amount WHERE steamid = @steam64id', {["@amount"] = getWantedLevel(source), ["@steam64id"] = steamid})
end
function updateWantedLevel_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `wanted_level`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateWantedReason(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `wanted_reason`= @amount WHERE steamid = @steam64id', {["@amount"] = getWantedReason(source), ["@steam64id"] = steamid})
end
function updateWantedReason_DBID(dbid, reason)
    exports.ghmattimysql:execute('UPDATE `users` SET `wanted_reason`= @amount WHERE id = @id', {["@amount"] = reason, ["@id"] = dbid})
end
function updateFactionPunish(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `faction_punish`= @amount WHERE steamid = @steam64id', {["@amount"] = getFactionPunish(source), ["@steam64id"] = steamid})
end
function updateFactionPunish_DBID(dbid, reason)
    exports.ghmattimysql:execute('UPDATE `users` SET `faction_punish`= @amount WHERE id = @id', {["@amount"] = reason, ["@id"] = dbid})
end
function updateFWarn(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `fwarn`= @amount WHERE steamid = @steam64id', {["@amount"] = getFWarn(source), ["@steam64id"] = steamid})
end
function updateFWarn_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `fwarn`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateLWarn(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `lwarn`= @amount WHERE steamid = @steam64id', {["@amount"] = getLWarn(source), ["@steam64id"] = steamid})
end
function updateLWarn_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `lwarn`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateJailTime(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `jail_time`= @amount WHERE steamid = @steam64id', {["@amount"] = getJailTime(source), ["@steam64id"] = steamid})
end
function updateJailTime_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `jail_time`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateJob(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `job`= @amount WHERE steamid = @steam64id', {["@amount"] = getJob(source), ["@steam64id"] = steamid})
end
function updateJob_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `job`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateMats(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `mats`= @amount WHERE steamid = @steam64id', {["@amount"] = getMats(source), ["@steam64id"] = steamid})
end
function updateMats_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `mats`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateDrugs(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `drugs`= @amount WHERE steamid = @steam64id', {["@amount"] = getDrugs(source), ["@steam64id"] = steamid})
end
function updateDrugs_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `drugs`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSkillDrugs(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `skill_drugs`= @amount WHERE steamid = @steam64id', {["@amount"] = getSkillDrugs(source), ["@steam64id"] = steamid})
end
function updateSkillDrugs_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `skill_drugs`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSalesDrugs(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `sales_drugs`= @amount WHERE steamid = @steam64id', {["@amount"] = getSalesDrugs(source), ["@steam64id"] = steamid})
end
function updateSalesDrugs_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `sales_drugs`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateSkillLawer(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `skill_lawer`= @amount WHERE steamid = @steam64id', {["@amount"] = getSkillLawer(source), ["@steam64id"] = steamid})
end
function updateSkillLawer_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `skill_lawer`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateFreeLawer(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `free_lawer`= @amount WHERE steamid = @steam64id', {["@amount"] = getFreeLawer(source), ["@steam64id"] = steamid})
end
function updateFreeLawer_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `free_lawer`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateClub(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `club`= @amount WHERE steamid = @steam64id', {["@amount"] = getClub(source), ["@steam64id"] = steamid})
end
function updateClub_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `club`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateClubRank(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `club_rank`= @amount WHERE steamid = @steam64id', {["@amount"] = getClubRank(source), ["@steam64id"] = steamid})
end
function updateClubRank_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `club_rank`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateBPoints(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `bpoints`= @amount WHERE steamid = @steam64id', {["@amount"] = getBPoints(source), ["@steam64id"] = steamid})
end
function updateBPoints_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `bpoints`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateClubWarn(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `club_warn`= @amount WHERE steamid = @steam64id', {["@amount"] = getClubWarn(source), ["@steam64id"] = steamid})
end
function updateClubWarn_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `club_warn`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateArrests(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `arrests`= @amount WHERE steamid = @steam64id', {["@amount"] = getArrests(source), ["@steam64id"] = steamid})
end
function updateArrests_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `arrests`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTickets(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `tickets`= @amount WHERE steamid = @steam64id', {["@amount"] = getTickets(source), ["@steam64id"] = steamid})
end
function updateTickets_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `tickets`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateKills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `kills`= @amount WHERE steamid = @steam64id', {["@amount"] = getKills(source), ["@steam64id"] = steamid})
end
function updateKills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `kills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateAssists(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `assists`= @amount WHERE steamid = @steam64id', {["@amount"] = getAssists(source), ["@steam64id"] = steamid})
end
function updateAssists_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `assists`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateHouse(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `house`= @amount WHERE steamid = @steam64id', {["@amount"] = getHouse(source), ["@steam64id"] = steamid})
end
function updateHouse_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `house`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSpawnLocation(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `spawn_location`= @amount WHERE steamid = @steam64id', {["@amount"] = getSpawnLocation(source), ["@steam64id"] = steamid})
end
function updateSpawnLocation_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `spawn_location`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSafeMats(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `safe_mats`= @amount WHERE steamid = @steam64id', {["@amount"] = getSafeMats(source), ["@steam64id"] = steamid})
end
function updateSafeMats_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `safe_mats`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSafeDrugs(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `safe_drugs`= @amount WHERE steamid = @steam64id', {["@amount"] = getSafeDrugs(source), ["@steam64id"] = steamid})
end
function updateSafeDrugs_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `safe_drugs`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateTaxa1(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa1`= @amount WHERE steamid = @steam64id', {["@amount"] = getTaxa1(source), ["@steam64id"] = steamid})
end
function updateTaxa1_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa1`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateTaxa2(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa2`= @amount WHERE steamid = @steam64id', {["@amount"] = getTaxa2(source), ["@steam64id"] = steamid})
end
function updateTaxa2_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa2`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateTaxa3(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa3`= @amount WHERE steamid = @steam64id', {["@amount"] = getTaxa3(source), ["@steam64id"] = steamid})
end
function updateTaxa3_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa3`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateTaxa4(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa4`= @amount WHERE steamid = @steam64id', {["@amount"] = getTaxa4(source), ["@steam64id"] = steamid})
end
function updateTaxa4_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `taxa4`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateRespectPoints(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `rp`= @amount WHERE steamid = @steam64id', {["@amount"] = getRespectPoints(source), ["@steam64id"] = steamid})
end
function updateRespectPoints_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `rp`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateLastPayday(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `last_payday`= @amount WHERE steamid = @steam64id', {["@amount"] = getLastPayday(source), ["@steam64id"] = steamid})
end
function updateLastPayday_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `last_payday`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateLastPaydaySeconds(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `last_payday_seconds`= @amount WHERE steamid = @steam64id', {["@amount"] = getLastPaydaySeconds(source), ["@steam64id"] = steamid})
end
function updateLastPaydaySeconds_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `last_payday_seconds`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateLevel(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `level`= @amount WHERE steamid = @steam64id', {["@amount"] = getLevel(source), ["@steam64id"] = steamid})
end
function updateLevel_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `level`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateRobPoints(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `rob_points`= @amount WHERE steamid = @steam64id', {["@amount"] = getRobPoints(source), ["@steam64id"] = steamid})
end
function updateRobPoints_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `rob_points`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end

function updateWarKills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_kills`= @amount WHERE steamid = @steam64id', {["@amount"] = getWarKills(source), ["@steam64id"] = steamid})
end
function updateWarKills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_kills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateWarDeaths(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_deaths`= @amount WHERE steamid = @steam64id', {["@amount"] = getWarDeaths(source), ["@steam64id"] = steamid})
end
function updateWarDeaths_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_deaths`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateWarLastId(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_lastid`= @amount WHERE steamid = @steam64id', {["@amount"] = getWarLastId(source), ["@steam64id"] = steamid})
end
function updateWarLastId_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `war_lastid`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTotalKills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_kills`= @amount WHERE steamid = @steam64id', {["@amount"] = getTotalKills(source), ["@steam64id"] = steamid})
end
function updateTotalKills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_kills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTotalDeaths(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_deaths`= @amount WHERE steamid = @steam64id', {["@amount"] = getTotalDeaths(source), ["@steam64id"] = steamid})
end
function updateTotalKills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_deaths`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTurfKills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_kills`= @amount WHERE steamid = @steam64id', {["@amount"] = getTurfKills(source), ["@steam64id"] = steamid})
end
function updateTurfKills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_kills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTurfDeaths(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_deaths`= @amount WHERE steamid = @steam64id', {["@amount"] = getTurfDeaths(source), ["@steam64id"] = steamid})
end
function updateTurfDeaths_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_deaths`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTurfLastId(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_lastid`= @amount WHERE steamid = @steam64id', {["@amount"] = getTurfLastId(source), ["@steam64id"] = steamid})
end
function updateTurfLastId_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `turf_lastid`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateTotalPlayingSeconds(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_playing_seconds`= @amount WHERE steamid = @steam64id', {["@amount"] = getTotalPlayingSeconds(source), ["@steam64id"] = steamid})
end
function updateTotalPlayingSeconds_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `total_playing_seconds`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateBusiness(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `business`= @amount WHERE steamid = @steam64id', {["@amount"] = getBusiness(source), ["@steam64id"] = steamid})
end
function updateBusiness_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `business`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateMute(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `mute`= @amount WHERE steamid = @steam64id', {["@amount"] = getMute(source), ["@steam64id"] = steamid})
end
function updateMute_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `mute`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateFMute(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `fmute`= @amount WHERE steamid = @steam64id', {["@amount"] = getMute(source), ["@steam64id"] = steamid})
end
function updateFMute_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `fmute`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updatePills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `pills`= @amount WHERE steamid = @steam64id', {["@amount"] = getPills(source), ["@steam64id"] = steamid})
end
function updatePills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `pills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateSoldPills(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `sold_pills`= @amount WHERE steamid = @steam64id', {["@amount"] = getSoldPills(source), ["@steam64id"] = steamid})
end
function updateSoldPills_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `sold_pills`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateContractPrice(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `contract_price`= @amount WHERE steamid = @steam64id', {["@amount"] = getContractPrice(source), ["@steam64id"] = steamid})
end
function updateContractPrice_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `contract_price`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function updateContracts(source)
    steamid = GetPlayerSteamID(source)
    exports.ghmattimysql:execute('UPDATE `users` SET `contracts`= @amount WHERE steamid = @steam64id', {["@amount"] = getContracts(source), ["@steam64id"] = steamid})
end
function updateContracts_DBID(dbid, amount)
    exports.ghmattimysql:execute('UPDATE `users` SET `contracts`= @amount WHERE id = @id', {["@amount"] = amount, ["@id"] = dbid})
end
function SendFactionMSG(faction_id, message)
    for _, playerId in ipairs(GetPlayers()) do
        if (faction_id == getFaction(playerId)) then
            TriggerClientEvent("chatMessage", playerId, "", {0,0,0}, message)
        end
    end
end
function SendClubMSG(club_id, message)
    for _, playerId in ipairs(GetPlayers()) do
        if (club_id == getClub(playerId)) then
            TriggerClientEvent("chatMessage", playerId, "", {0,0,0}, message)
        end
    end
end
function SendAdminMSG(admin_id, message)
    for _, playerId in ipairs(GetPlayers()) do
        if (admin_id <= getAdminLevel(playerId)) then
            TriggerClientEvent("chatMessage", playerId, "", {0,0,0}, message)
        end
    end
end
--[[load]]--
function IsPlayerBanned(dbid) --[[returnam result]]--
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM bans WHERE dbid = @dbid", {["@dbid"] = dbid}, 
    function(result) 
        p:resolve(result)
    end)
    return Citizen.Await(p)
end
--- de actualizat numele, ip si data la care se conecteaza
function LoadPlayerData(source, steam64id)
    GetFreeID(steam64id)
    local posID = id[steam64id]
    local p = promise:new()
    local banReason
    exports.ghmattimysql:execute("SELECT * FROM users WHERE steamid = @steam64id", {["@steam64id"] = steam64id}, 
    function(result)
        local var = IsPlayerBanned(result[1].id)
        local banned = false
        if(#var > 0) then
            if(var[1].date > os.time() or var[1].date == 0) then
                banned = true
                local expireDateString
                if(var[1].date == 0) then
                    expireDateString = "Permanent"
                else
                    expireDateString = os.date("%c", var[1].date)
                end
                banReason = "You were banned by " .. getName_DBID(var[1].admin_dbid) .. "[ID:"  .. var[1].admin_dbid  .. "]\nExpire date: "  .. expireDateString  .. "\nReason: "  .. var[1].text
                p:resolve(false)
                return false
            else
                exports.ghmattimysql:execute("DELETE FROM `bans` WHERE dbid = @dbid", {["@dbid"] = result[1].id})
            end
        end
        sqlID[posID] = result[1].id
        adminlevel[posID] = result[1].adminlevel
        money[posID] = result[1].money
        bankmoney[posID] = result[1].bankmoney
        warn[posID] = result[1].warn
        faction[posID] = result[1].faction
        factionRank[posID] = result[1].factionrank
        sqlIdToSteamID[sqlID[posID]] = steam64id
        wanted_level[posID] = result[1].wanted_level
        wanted_reason[posID] = result[1].wanted_reason
        if(wanted_level[posID] > 0) then
            SendFactionMSG(1, "^4[PD]^1Jucatorul " .. GetPlayerName(source) .. "[".. sqlID[posID] .. "] s-a conectat cu wanted " .. wanted_level[posID] .. " Reason: " ..  wanted_reason[posID])
        end
        faction_punish[posID] = result[1].faction_punish
        fwarn[posID] = result[1].fwarn
        lwarn[posID] = result[1].lwarn
        acwarn[posID] = result[1].acwarn
        jail_time[posID] = result[1].jail_time
        TriggerEvent("sis_jail-s::setJailTime", source, jail_time[posID])
        if(faction_punish[posID] ~= 0 and faction_punish[posID] < os.time()) then
            faction_punish[posID] = 0
            updateFactionPunish_DBID(sqlID[posID], 0)
        end
        job[posID] = result[1].job
        mats[posID] = result[1].mats
        drugs[posID] = result[1].drugs
        skill_drugs[posID] = result[1].skill_drugs
        sales_drugs[posID] = result[1].sales_drugs
        skill_lawer[posID] = result[1].skill_lawer
        free_lawer[posID] = result[1].free_lawer
        club[posID] = result[1].club
        club_rank[posID] = result[1].club_rank
        cwarn[posID] = result[1].club_warn
        bpoints[posID] = result[1].bpoints
        arrests[posID] = result[1].arrests
        kills[posID] = result[1].kills
        tickets[posID] = result[1].tickets
        assists[posID] = result[1].assists
        safe_drugs[posID] = result[1].safe_drugs
        safe_mats[posID] = result[1].safe_mats
        house[posID] = result[1].house
        if(house[posID] ~= nil and house[posID] > 0) then
            TriggerEvent("sis_houses-s::setOwnerName", house[posID], GetPlayerName(source))
            exports.ghmattimysql:execute('UPDATE `houses` SET `owner_name`=@owner_name WHERE `id` = @id', {["@owner_name"] = GetPlayerName(source), ["@id"] = house[posID]})
        end
        business[posID] = result[1].business
        if(business[posID] ~= nil and business[posID] > 0) then
            TriggerEvent("sis_business-s::setOwnerName", business[posID], GetPlayerName(source))
            exports.ghmattimysql:execute('UPDATE `business` SET `owner_name`=@owner_name WHERE `id` = @id', {["@owner_name"] = GetPlayerName(source), ["@id"] = business[posID]})
        end
        spawn_location[posID] = result[1].spawn_location
        taxa1[posID] = result[1].taxa1
        taxa2[posID] = result[1].taxa2
        taxa3[posID] = result[1].taxa3
        taxa4[posID] = result[1].taxa4
        war_kills[posID] = result[1].war_kills
        war_deaths[posID] = result[1].war_deaths
        war_lastid[posID] = result[1].war_lastid
        total_kills[posID] = result[1].total_kills
        total_deaths[posID] = result[1].total_deaths
        turf_kills[posID] = result[1].turf_kills
        turf_deaths[posID] = result[1].turf_deaths
        turf_lastid[posID] = result[1].turf_lastid
        total_playing_seconds[posID] = result[1].total_playing_seconds
        last_payday[posID] = result[1].last_payday
        last_payday_seconds[posID] = result[1].last_payday_seconds
        level[posID] = result[1].level
        rp[posID] = result[1].rp
        rob_points[posID] = result[1].rob_points
        mute[posID] = 0
        fmute[posID] = 0 
        pills[posID] = result[1].pills
        sold_pills[posID] = result[1].sold_pills
        contract_price[posID] = result[1].contract_price
        contracts[posID] = result[1].contracts
        if(result[1].mute > 0) then
            mute[posID] = os.time() + result[1].mute
        end
        if(result[1].fmute > 0) then
            fmute[posID] = os.time() +  result[1].fmute
        end
        personal_vehicles[posID] = {}
        TriggerEvent("sis_personal-vehicles-s::LoadPersonalVehicle", source, sqlID[posID])
        ---de trigaruit functie care sa incarce masinile jucatorului
        p:resolve(true)
    end)
    if(Citizen.Await(p) == true) then
        exports.ghmattimysql:execute("UPDATE `users` SET `ip`= @ip,`name`= @name WHERE id = @id", {["@ip"] = GetPlayerEndpoint(source), ["@name"] = GetPlayerName(source), ["@id"] = sqlID[posID]})
        return false
    else 
        return banReason
    end
end
function AddPersonalVehicle(source, veh_id)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid]
    local car_pos 
    for i = 1, #personal_vehicles[sourceID] do
        if(personal_vehicles[sourceID][i] == veh_id) then
            car_pos = i
            break
        end
    end
    if(car_pos == nil) then
        table.insert(personal_vehicles[sourceID], veh_id)
    end
end
function RemovePersonalVehicle(source, veh_id)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    local car_pos
    for i = 1, #personal_vehicles[sourceID] do
        if(personal_vehicles[sourceID][i] == veh_id) then
            car_pos = i
            break
        end
    end
    if(car_pos ~= nil) then
        table.remove(personal_vehicles[sourceID], car_pos)
    end
end
function GetPersonalVehicle(source)
    steamid = GetPlayerSteamID(source)
    local sourceID = id[steamid] 
    return personal_vehicles[sourceID]
end

function WarnPlayer(dbid, admin_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        setWarn(player_source, getWarn(player_source) + 1)
        updateWarn(player_source)
    else
        updateWarn_DBID(dbid, getWarn_DBID(dbid) + 1)
    end
    addLog("[Warn] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a dat warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
end
function UnWarnPlayer(dbid, admin_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        local warns = getWarn(player_source)
        if(warns == 0) then
            return false
        end
        setWarn(player_source, warns - 1)
        updateWarn(player_source)
    else
        local warns = getWarn_DBID(dbid)
        if(warns == 0) then
            return false
        end
        updateWarn_DBID(dbid, warns - 1)
    end
    addLog("[UnWarn] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a scos un warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return true
end
--[[returneaza true daca a reusit sa il baneze si false in caz contrar]]--
function BanPlayer(dbid, admin_dbid, days, reason)
    local canBanPlayer 
    local p = promise:new()
    exports.ghmattimysql:execute("SELECT * FROM bans WHERE dbid = @dbid", {["@dbid"] = dbid}, 
    function(result)
        if #result > 0 then
            if(result[1].date > os.time()) then
                p:resolve(false)
            else 
                exports.ghmattimysql:execute("DELETE FROM `bans` WHERE dbid = @dbid", {["@dbid"] = dbid})
                p:resolve(true)
            end
        else
            p:resolve(true)
        end
    end)
    canBanPlayer = Citizen.Await(p)
    if(canBanPlayer == false) then
        return false
    end
    local var = days
    if(days == 0) then
        days = 0
    else
        days = os.time() + days * 24 * 3600
    end
    exports.ghmattimysql:execute("INSERT INTO bans (dbid, admin_dbid, date, text) VALUES (@dbid, @admin_dbid, @date, @text)", {['@dbid'] = dbid, ['@admin_dbid'] = admin_dbid, ['@date'] = days, ['@text'] = reason})
    --[[verificam daca jucatorul este online ca sa ii futem un kick]]--
    if(IsSqlIdConnected(dbid)) then
        if(days == 0) then
            DropPlayer(getSourceFromDBID(dbid), "You were permanently banned by " .. getName_DBID(admin_dbid) .."[ID:".. admin_dbid .. "]" ..  "\nREASON: " .. reason)
        else
            DropPlayer(getSourceFromDBID(dbid), "You were temporarily (".. var .. " days) banned by " .. getName_DBID(admin_dbid) .."[ID:".. admin_dbid .. "]" .. "\nREASON: " .. reason)
        end
    end
    if(var == 0) then
        addLog("[Ban] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " l-a banat permanent pe " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    else
        addLog("[Ban] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " l-a banat pentru " .. var .. " zile pe " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    end
    return true
end
function UnBanPlayer(dbid, admin_dbid, reason)
    if(dbid_exist(dbid) == true) then
        local canUnBanPlayer 
        local p = promise:new()
        exports.ghmattimysql:execute("SELECT * FROM bans WHERE dbid = @dbid", {["@dbid"] = dbid}, 
        function(result)
            if #result > 0 then
                if(result[1].date < os.time()) then
                    p:resolve(false)
                end 
                exports.ghmattimysql:execute("DELETE FROM `bans` WHERE dbid = @dbid", {["@dbid"] = dbid})
                p:resolve(true)
            else
                p:resolve(false)
            end
        end)
        canUnBanPlayer = Citizen.Await(p)
        if(canUnBanPlayer == false) then
            return false
        end
        addLog("[UnBan] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a scos banul lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
        return true
    else
        TriggerClientEvent("chatMessage", getSourceFromDBID(admin_dbid), "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
        return nil
    end
end
function UnInvitePlayerFromFaction(dbid, admin_dbid, reason, fp_days) --[[]]-- de adaugat sistem de fpunishment
    --[[de adaugat de reset functii la chestii gen kills la war/cop kill etc]]--
    if(dbid_exist(dbid) == true) then
        if(getFaction_DBID(dbid) > 0) then
            if(IsSqlIdConnected(dbid) == true) then
                local target_source = getSourceFromDBID(dbid)
                SetPlayerRoutingBucket(target_source, 0)
                setFaction(target_source, 0)
                setFactionRank(target_source, 0)
                setFWarn(target_source, 0)
                setLWarn(target_source, 0)
                --pd
                setArrests(target_source, 0)
                setTickets(target_source, 0)
                setKills(target_source, 0)
                setAssists(target_source, 0)
                --gang
                setTotalKills(target_source, 0)
                setTotalDeaths(target_source, 0)
                setWarKills(target_source, 0)
                setWarDeaths(target_source, 0)
                setWarLastId(target_source, 0)
                setFMute(target_source, 0)
                --medics
                setSoldPills(target_source, 0)
                --hitman
                setContracts(target_source, 0)

                updateFaction(target_source)
                updateFactionRank(target_source)
                updateFWarn(target_source)
                updateLWarn(target_source)
                updateArrests(target_source)
                updateTickets(target_source)
                updateKills(target_source)
                updateAssists(target_source)
                updateWarKills(target_source)
                updateWarDeaths(target_source)
                updateWarLastId(target_source)
                updateFMute(target_source)
                updateSoldPills(target_source)
                updateContracts(target_source)
                if(fp_days > 0) then
                    local days = os.time() + fp_days * 24 * 3600
                    setFactionPunish(target_source, days)
                    updateFactionPunish(target_source)
                end
                TriggerEvent("player_tags::update")
            else
                updateFaction_DBID(dbid, 0)
                updateFactionRank_DBID(dbid, 0)
                updateFWarn_DBID(dbid, 0)
                updateLWarn_DBID(dbid, 0)
                updateArrests_DBID(dbid, 0)
                updateTickets_DBID(dbid, 0)
                updateKills_DBID(dbid, 0)
                updateAssists_DBID(dbid, 0)
                updateTotalKills_DBID(dbid, 0)
                updateTotalDeaths_DBID(dbid, 0)
                updateWarKills_DBID(dbid, 0)
                updateWarDeaths_DBID(dbid, 0)
                updateWarLastId_DBID(dbid, 0)
                updateFMute_DBID(dbid, 0)
                updateSoldPills_DBID(dbid, 0)
                updateContracts_DBID(dbid, 0)
                if(fp_days > 0) then
                    local days = os.time() + fp_days * 24 * 3600
                    updateFactionPunish_DBID(dbid, days)
                end
            end
            addLog("[FPK/UNINVITE] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " l-a scos din factiune pe " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
            return true
        else
            return false
        end
    else
        TriggerClientEvent("chatMessage", getSourceFromDBID(admin_dbid), "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
        return nil
    end
end
function FWarnPlayer(dbid, leader_dbid, reason)
    local fwarns
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        fwarns = getFWarn(player_source)
        fwarns = fwarns + 1
        setFWarn(player_source, fwarns)
        updateFWarn(player_source)
    else
        fwarns = getFWarn_DBID(dbid) 
        fwarns = fwarns + 1
        updateFWarn_DBID(dbid, fwarns)
    end
    addLog("[FWarn] " .. getName_DBID(leader_dbid) .. "[ID:".. leader_dbid .. "]" .. " i-a dat faction warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return fwarns
end
function FUnWarnPlayer(dbid, leader_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        local warns = getFWarn(player_source)
        if(warns == 0) then
            return false
        end
        setFWarn(player_source, warns - 1)
        updateFWarn(player_source)
    else
        local warns = getFWarn_DBID(dbid)
        if(warns == 0) then
            return false
        end
        updateFWarn_DBID(dbid, warns - 1)
    end
    addLog("[FUnWarn] " .. getName_DBID(leader_dbid) .. "[ID:".. leader_dbid .. "]" .. " i-a scos un faction warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return true
end

function LWarnPlayer(dbid, admin_dbid, reason)
    local lwarns
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        lwarns = getLWarn(player_source)
        lwarns = lwarns + 1
        setLWarn(player_source, lwarns)
        updateLWarn(player_source)
    else
        lwarns = getLWarn_DBID(dbid) 
        lwarns = lwarns + 1
        updateLWarn_DBID(dbid, lwarns)
    end
    addLog("[LWarn] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a dat leader warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return lwarns
end
function LUnWarnPlayer(dbid, admin_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        local warns = getLWarn(player_source)
        if(warns == 0) then
            return false
        end
        setLWarn(player_source, warns - 1)
        updateLWarn(player_source)
    else
        local warns = getLWarn_DBID(dbid)
        if(warns == 0) then
            return false
        end
        updateLWarn_DBID(dbid, warns - 1)
    end
    addLog("[LUnWarn] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a scos un leader warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return true
end
function SendFactionMessage(faction_id, message)
    for _, playerId in ipairs(GetPlayers()) do
        if getFaction(playerId) == faction_id then
            if(faction_id == 1) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[PD]^7 ", message}, color = {27, 72, 250} })
            elseif(faction_id == 2) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[GROVE]^7 ", message}, color = {35, 135, 34} })
            elseif(faction_id == 3) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[BALLAS]^7 ", message}, color = {163, 30, 186} })
            elseif(faction_id == 4) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[The Triads]^7 ", message}, color = {92, 56, 17} })
            elseif(faction_id == 5) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[The Mafia]^7 ", message}, color = {156, 12, 17} })
            elseif(faction_id == 6) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[Medics]^7 ", message}, color = {230, 94, 114} })
            elseif(faction_id == 7) then
                TriggerClientEvent('chat:addMessage', playerId, { args = { "[Hitman]^7 ", message}, color = {115, 114, 114} })
            end
        end
    end
end
function ACWarnPlayer(dbid, admin_dbid, reason)
    local acwarns
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        acwarns = getACWarn(player_source)
        acwarns = acwarns + 1
        setACWarn(player_source, acwarns)
        updateACWarn(player_source)
    else
        acwarns = getACWarn_DBID(dbid) 
        acwarns = acwarns + 1
        updateACWarn_DBID(dbid, acwarns)
    end
    addLog("[ACWarn] " .. getName_DBID(leader_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a dat acces warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return acwarns
end
function ACUnWarnPlayer(dbid, admin_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        local warns = getACWarn(player_source)
        if(warns == 0) then
            return false
        end
        setACWarn(player_source, warns - 1)
        updateACWarn(player_source)
    else
        local warns = getACWarn_DBID(dbid)
        if(warns == 0) then
            return false
        end
        updateACWarn_DBID(dbid, warns - 1)
    end
    addLog("[LUnWarn] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " i-a scos un leader warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return true
end

function CheckDistance(distance, pos1_x, pos1_y, pos1_z, pos2_x, pos2_y, pos2_z)
    local d = math.floor(math.sqrt((math.pow(pos1_x - pos2_x, 2) + math.pow(pos1_y - pos2_y, 2) + math.pow(pos1_z - pos2_z, 2))))
    if(d <= distance) then
        return true
    end
    return false
end

function ForceRespawn(source)
    TriggerClientEvent("playerdata-c::forceRespawn", source)
end


AddEventHandler('playerDropped', function (reason)
    local player_src = source
    updateMute(player_src)
    updateFMute(player_src)
  end)
--807
function UnInvitePlayerFromClub(dbid, admin_dbid, reason) 
    if(dbid_exist(dbid) == true) then
        if(getClub_DBID(dbid) > 0) then
            if(IsSqlIdConnected(dbid) == true) then
                local target_source = getSourceFromDBID(dbid)
                setClub(target_source, 0)
                setClubRank(target_source, 0)
                setBPoints(target_source, 0)
                setClubWarn(target_source, 0)
                --setLWarn(target_source, 0)
                updateClub(target_source)
                updateClubRank(target_source)
                updateBPoints(target_source)
                updateClubWarn(target_source)
                --updateLWarn(target_source)
            else
                updateClub_DBID(dbid, 0)
                updateClubRank_DBID(dbid, 0)
                updateBPoints_DBID(dbid, 0)
                --updateFWarn_DBID(dbid, 0)
                --updateLWarn(dbid, 0)

            end
            addLog("[CPK/UNINVITE] " .. getName_DBID(admin_dbid) .. "[ID:".. admin_dbid .. "]" .. " l-a scos din club pe " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
            return true
        else
            return false
        end
    else
        TriggerClientEvent("chatMessage", getSourceFromDBID(admin_dbid), "^1[AdmCmd]", {0,0,0}, "^7DBID inexistent in baza de date!")
        return nil
    end
end
function CWarnPlayer(dbid, leader_dbid, reason)
    local cwarns
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        cwarns = getClubWarn(player_source)
        cwarns = cwarns + 1
        setClubWarn(player_source, cwarns)
        updateClubWarn(player_source)
    else
        cwarns = getClubWarn_DBID(dbid) 
        cwarns = cwarns + 1
        updateClubWarn_DBID(dbid, cwarns)
    end
    addLog("[CWarns] " .. getName_DBID(leader_dbid) .. "[ID:".. leader_dbid .. "]" .. " i-a dat club warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return cwarns
end
function CUnWarnPlayer(dbid, leader_dbid, reason)
    if(IsSqlIdConnected(dbid) == true) then
        local player_source = getSourceFromDBID(dbid)
        local warns = getClubWarn(player_source)
        if(warns == 0) then
            return false
        end
        setClubWarn(player_source, warns - 1)
        updateClubWarn(player_source)
    else
        local warns = getClubWarn_DBID(dbid)
        if(warns == 0) then
            return false
        end
        updateClubWarn_DBID(dbid, warns - 1)
    end
    addLog("[CUnWarn] " .. getName_DBID(leader_dbid) .. "[ID:".. leader_dbid .. "]" .. " i-a scos un club warn lui " .. getName_DBID(dbid) .. "[ID:".. dbid .. "]" .. " REASON: " .. reason)
    return true
end
RegisterCommand("showstats", function(source, args)
    local player_level = getLevel(source)
    local player_admin_level = getAdminLevel(source)
    local player_warn = getWarn(source)
    local player_faction = getFaction(source)
    local player_faction_rank = getFactionRank(source)
    local player_fwarn = getFWarn(source)
    local player_lwarn = getLWarn(source)
    local player_acwarn = getACWarn(source)
    local player_pills = getPills(source)
    local player_total_playing_seconds = getTotalPlayingSeconds(source)
    local player_job = getJob(source)
    local player_mats = getMats(source)
    local player_drugs = getDrugs(source)
    local player_club = getClub(source)
    local player_club_rank = getClubRank(source)
    local player_bpoints = getBPoints(source)
    local player_cwarns = getClubWarn(source)
    local player_rob_points = getRobPoints(source)
    local player_respect_points = getRespectPoints(source)
    TriggerClientEvent("playerdata-c::showStats", source, player_level, player_admin_level, player_warn, player_faction, player_faction_rank, player_fwarn, player_lwarn, player_acwarn, player_pills, player_total_playing_seconds, player_job, player_mats, player_drugs, player_club, player_club_rank, player_bpoints, player_cwarns, player_rob_points, player_respect_points)
end, false)
RegisterCommand("hidestats", function(source, args)
    TriggerClientEvent("playerdata-c::hideStats", source)
end, false)