-------------
--Variables--
-------------

visitationRequests = {}

----------
--Events--
----------

RegisterNetEvent('prison:server:NotifyInmateOfVisitRequest', function(data)
    local player = QBCore.Functions.GetPlayer(source)
    local inmate = QBCore.Functions.GetPlayerByCitizenId(data)

    table.insert(visitationRequests, {
        inmate = inmate.PlayerData,
        visitor = player.PlayerData,
    })

    lib.notify(inmate.PlayerData.source, {
        title = 'Visitation',
        description = "You've had a visitation request, speak to the guard in the canteen to see who it's from!",
        type = 'inform'
    })
end)

RegisterNetEvent('prison:server:ActionVisitation', function(data)
    local inmate = QBCore.Functions.GetPlayerByCitizenId(data.inmate)
    local visitor = QBCore.Functions.GetPlayerByCitizenId(data.visitor.citizenid)

    lib.notify(visitor.PlayerData.source, {
        title = 'Accepted',
        description = 'Your visitation request has been accepted, speak to the guard in the lobby again to be let into the visitation room',
        type = 'success'
    })

    lib.notify(inmate.PlayerData.source, {
        title = 'Accepted',
        description = "I'll take you to the visitors room now!",
        type = 'success'
    })

    TriggerClientEvent('prison:client:InmateGoToVisitationRoom', inmate.PlayerData.source, inmate.PlayerData.source, inmate)
end)