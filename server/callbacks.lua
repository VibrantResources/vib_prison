lib.callback.register('prison:server:GetPlayerInfo', function(player)
    local playerInfo = QBCore.Functions.GetPlayer(player)

    return playerInfo.PlayerData
end)

lib.callback.register('prison:server:GetPlayerByCitizenId', function(source, citizenId)
    local playerData = nil

    if QBCore.Functions.GetPlayerByCitizenId(citizenId) then
        playerData = QBCore.Functions.GetPlayerByCitizenId(citizenId)
    else
        playerData = QBCore.Functions.GetOfflinePlayerByCitizenId(citizenId)
    end

    return playerData
end)

lib.callback.register('prison:CheckRemainingDuration', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local jailTime = player.Functions.GetMetaData('injail')

    return jailTime
end)

lib.callback.register('prison:server:GetAllInmateData', function()
    local inmateData = MySQL.Sync.fetchAll('SELECT * FROM `vib_prison`')
    
    return inmateData
end)

lib.callback.register('prison:server:GetVisitationRequests', function()
    return visitationRequests
end)