function CheckPlayersJob(source, playerJobType, requiredJobType)
    if playerJobType ~= requiredJobType then
        lib.notify(source, {
            title = 'Unable',
            description = "You don't have the correct permissions to do this",
            type = 'error'
        })
        return false
    end

    return true
end