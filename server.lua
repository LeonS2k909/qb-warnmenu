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

RegisterCommand('delwarning', function(source, args)
    local src = source
    if src == 0 then return end

    -- Basic ace permission check. `command` is granted to admins in server.cfg
    if not IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('QBCore:Notify', src, 'No permission to run this command.', 'error')
        return
    end

    local warnId = tonumber(args[1])
    if not warnId then
        TriggerClientEvent('QBCore:Notify', src, 'You must provide a warning ID.', 'error')
        return
    end

    exports.oxmysql:execute('DELETE FROM player_warns WHERE warnId = ?', { warnId }, function()
        TriggerClientEvent('QBCore:Notify', src, 'Warning deleted.', 'success')
    end)
end, false)
