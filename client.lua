RegisterNetEvent('qb-warnings:client:ShowWarnings', function(warnings)
    local options = {}

    for _, warn in ipairs(warnings) do
        local warnId = warn.warnId or "N/A"

        table.insert(options, {
            title = warn.reason,
            description = string.format("ID: %s", warnId),
            icon = 'triangle-exclamation'
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
