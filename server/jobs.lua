-------------
--Variables--
-------------

----------
--Events--
----------

RegisterNetEvent('prison:server:WorkReduceSentence', function()
    local player = QBCore.Functions.GetPlayer(source)
    local jailDuration = player.Functions.GetMetaData('injail')

    player.Functions.SetMetaData('injail', (jailDuration - Jobs.Electrician.SentenceReductionOnJobSuccess))
    lib.notify(source, {
        title = 'Well done',
        description = "You're good work has helped reduce your sentence!",
        type = 'success'
    })
end)