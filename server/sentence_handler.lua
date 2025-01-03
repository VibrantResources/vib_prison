RegisterNetEvent('prison:server:UpdateRemainingSentence', function(newSentenceTime)
    local player = QBCore.Functions.GetPlayer(source)

    if player.PlayerData.job.name ~= Config.JobInformation.Jobs.Unemployed then
        player.Functions.SetJob(Config.JobInformation.Jobs.Unemployed)
        lib.notify(source, {
            title = 'Attention',
            description = "You've been fired! Seek employment when you leave again!",
            type = 'error'
        })
    end

    player.Functions.SetMetaData('injail', newSentenceTime)
    MySQL.Async.execute('UPDATE `vib_prison` SET `sentence_duration` = @sentence_duration WHERE `citizenid` = @citizenid', {
        ['@citizenid'] = player.PlayerData.citizenid,
        ['@sentence_duration'] = newSentenceTime,
    })
end)

RegisterNetEvent('prison:server:ReturnItemsAndclearDatabase', function()
    local player = QBCore.Functions.GetPlayer(source)
    local playersCitizenId = player.PlayerData.citizenid

    local inmateItems = MySQL.query.await('SELECT `inmate_items` FROM `vib_prison` WHERE `citizenid` = @citizenid', {
        ['@citizenid'] = playersCitizenId,
    })

    TriggerEvent('prison:server:ReturnPlayerItems', player.PlayerData.source, json.decode(inmateItems[1].inmate_items))

    player.Functions.SetMetaData('injail', 0)
    MySQL.Async.execute('DELETE FROM `vib_prison` WHERE `citizenid` = @citizenid', {
        ['@citizenid'] = playersCitizenId,
    })
end)