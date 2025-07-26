local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-warnings:server:RequestWarnings', function()
    local src = source
    local license = nil

    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if id:find("license:") then
            license = id
            break
        end
    end

    if not license then return end

    exports.oxmysql:execute('SELECT reason, senderIdentifier, warnId FROM player_warns WHERE targetIdentifier = ?', {
        license
    }, function(results)
        TriggerClientEvent('qb-warnings:client:ShowWarnings', src, results)
    end)
end)

RegisterNetEvent('qb-warnings:server:DeleteWarning', function(warnId)
    local src = source

    -- ACE permission check
    if not IsPlayerAceAllowed(src, "command") then
        TriggerClientEvent('qb-warnings:client:NotifyDeleted', src, false)
        return
    end

    exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', {
        warnId
    }, function(rowsChanged)
        TriggerClientEvent('qb-warnings:client:NotifyDeleted', src, rowsChanged > 0)
    end)
end)
