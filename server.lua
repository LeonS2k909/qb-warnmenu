local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('warnings', function(source)
    local src = source

    local license = nil
    for _, id in ipairs(GetPlayerIdentifiers(src)) do
        if id:find("license:") then
            license = id
            break
        end
    end

    if not license then
        return
    end

    exports.oxmysql:execute('SELECT reason, senderIdentifier, warnId FROM player_warns WHERE targetIdentifier = ?', {
        license
    }, function(results)
        TriggerClientEvent('qb-warnings:client:ShowWarnings', src, results)
    end)
end)
