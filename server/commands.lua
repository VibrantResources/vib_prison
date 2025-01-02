QBCore = exports["qb-core"]:GetCoreObject()

lib.addCommand('jail', {
    help = 'Open the Jailing input',
}, function(source, args, raw)
    local player = QBCore.Functions.GetPlayer(source)
    local playerJobType = player.PlayerData.job.type

    if CheckPlayersJob(source, playerJobType, Config.GenericStuff.PoliceJobType) then
        TriggerClientEvent('prison:client:SendToJailInput', source)
    end
end)

QBCore.Commands.Add('unjail', "Unjail person", { {name = 'id', help = "ID of person to unjail", } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.type == 'leo' and Player.PlayerData.job.onduty then
        TriggerClientEvent('prison:client:UnjailPlayer', tonumber(args[1]))
    else
        lib.notify(src, {
            title = 'Attention',
            description = 'You need to be actively on duty to do this',
            type = 'error'
        })
    end
end)

QBCore.Commands.Add('checktime', "Check remaining jail sentence", {}, false, function(source)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local jailDuration = player.Functions.GetMetaData('injail')

    if jailDuration > 0 then
        lib.notify(src, {
            title = 'Attention',
            description = "You've got "..jailDuration.." months left!",
            type = 'inform'
        })
    else
        lib.notify(src, {
            title = 'Attention',
            description = "You don't have a remaining jail sentence",
            type = 'inform'
        })
    end
end)