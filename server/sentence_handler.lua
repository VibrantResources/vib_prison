RegisterNetEvent('prison:server:UpdateRemainingSentence', function(newSentenceTime)
    local player = QBCore.Functions.GetPlayer(source)

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