RegisterNetEvent('qb-warnings:client:ShowWarnings', function(warnings)
    local options = {}

    for _, warn in ipairs(warnings) do
        local warnId = warn.warnId or "N/A"

        table.insert(options, {
            title = warn.reason,
            description = string.format("ID: %s", warnId),
            icon = 'triangle-exclamation',
            onSelect = function()
                local confirm = lib.alertDialog({
                    header = 'Delete Warning',
                    content = 'Would you like to delete this warning?',
                    centered = true,
                    cancel = true
                })

                if confirm == 'confirm' then
                    TriggerServerEvent('qb-warnings:server:DeleteWarning', warnId)
                end
            end
        })
    end

    if #options == 0 then
        table.insert(options, {
            title = "No Warnings Found",
            icon = 'circle-check'
        })
    end

    lib.registerContext({
        id = 'player_warnings',
        title = 'Your Warnings',
        options = options
    })

    lib.showContext('player_warnings')
end)

RegisterNetEvent('qb-warnings:client:NotifyDeleted', function(success)
    if success then
        lib.notify({
            title = 'Warning Deleted',
            type = 'success'
        })
        -- Refresh the menu
        TriggerServerEvent('qb-warnings:server:RequestWarnings')
    else
        lib.notify({
            title = 'Permission Denied or Error',
            type = 'error'
        })
    end
end)

-- Request warnings again if deleted
RegisterCommand('warnings', function()
    TriggerServerEvent('qb-warnings:server:RequestWarnings')
end, false)
