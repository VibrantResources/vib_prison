QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

----------
--Events--
----------

RegisterNetEvent('prison:server:SetJailStatus', function(jailSentenceDuration, unJailed)
    local player = QBCore.Functions.GetPlayer(source)
    local jailTime = player.Functions.GetMetaData('injail')
    
    player.Functions.SetMetaData('injail', jailSentenceDuration)

    if not unJailed then
        MySQL.Async.execute('UPDATE `vib_prison` SET `sentence_duration` = @sentence_duration WHERE `citizenid` = @citizenid', {
            ['@citizenid'] = player.PlayerData.citizenid,
            ['@sentence_duration'] = jailSentenceDuration
        })
    else
        if jailTime <= 0 then
            print("First block check: jailTime reached 0: ", jailTime)
            return
        end

        local inmateItems = MySQL.Sync.fetchAll('SELECT inmate_items FROM vib_prison WHERE citizenid = ?', { 
            player.PlayerData.citizenid 
        })

        TriggerEvent('prison:server:ReturnPlayerItems', player.PlayerData.source, json.decode(inmateItems[1].inmate_items))

        player.Functions.SetMetaData('injail', 0)

        MySQL.Async.execute('DELETE FROM `vib_prison` WHERE `citizenid` = @citizenid', {
            ['@citizenid'] = player.PlayerData.citizenid,
        })
        return
    end

    if jailSentenceDuration <= 0 then
        if jailTime <= 0 then
            print("Second block check: jailTime reached 0: ", jailTime)
            return
        end

        if unJailed then
            return
        end

        local inmateItems = MySQL.Sync.fetchAll('SELECT inmate_items FROM vib_prison WHERE citizenid = ?', { 
            player.PlayerData.citizenid 
        })

        TriggerEvent('prison:server:ReturnPlayerItems', player.PlayerData.source, json.decode(inmateItems[1].inmate_items))
        player.Functions.SetMetaData('injail', 0)
        
        MySQL.Async.execute('DELETE FROM `vib_prison` WHERE `citizenid` = @citizenid', {
            ['@citizenid'] = player.PlayerData.citizenid,
        })

        if jailTime <= 0 then
            print("Second block check: jailTime reached 0: ", jailTime)
            return
        end

        return
    end

    if not player then
        return
    end

    if player.PlayerData.job.name ~= 'unemployed' then
        player.Functions.SetJob('unemployed')
        lib.notify(source, {
            title = 'Attention',
            description = "You've been fired! Seek employment when you leave again!",
            type = 'error'
        })
    end

    Wait(10000)
    TriggerClientEvent('prison:CreateSentenceDuration', player.PlayerData.source, (jailSentenceDuration -1))
end)

RegisterNetEvent('prison:server:JailPlayer', function(inputData)
    local copPlayer = GetPlayerPed(source)
    local targetPlayer = GetPlayerPed(inputData[1])
    local copPlayerCoords = GetEntityCoords(copPlayer)
    local jailedTargetCoords = GetEntityCoords(targetPlayer)
    local jailedPlayer = QBCore.Functions.GetPlayer(inputData[1])

    if #(copPlayerCoords - jailedTargetCoords) > 2.5 then 
        lib.notify({
            title = 'Attention',
            description = 'Person is too far away ... are you insane?',
            type = 'error'
        })
        return
    end

    local player = QBCore.Functions.GetPlayer(source)

    if not player or not jailedPlayer or player.PlayerData.job.type ~= 'leo' then 
        return 
    end

    jailedPlayer.Functions.SetMetaData('injail', inputData[2])

    TriggerClientEvent('prison:client:Enter', inputData[1], inputData[2])

    MySQL.Async.execute('INSERT INTO vib_prison (citizenid, sentence_duration, reason) VALUES (@citizenid, @sentence_duration, @reason)', {
        ['@citizenid'] = jailedPlayer.PlayerData.citizenid,
        ['@sentence_duration'] = inputData[2],
        ['@reason'] = inputData[3],
    })

    local initialJailedPlayerItems = exports.ox_inventory:GetInventoryItems(inputData[1])

    for _, v in pairs(initialJailedPlayerItems) do
        local isBlacklisted = CheckIfBlackListedItem(v.name)

        if isBlacklisted then
            exports.ox_inventory:RemoveItem(inputData[1], v.name, v.count)
        end
        Wait(300)
    end

    resolvedJailedPlayerItems = exports.ox_inventory:GetInventoryItems(inputData[1])

    exports.ox_inventory:ClearInventory(inputData[1], false)

    MySQL.Async.execute('UPDATE `vib_prison` SET `inmate_items` = @inmate_items WHERE `citizenid` = @citizenid', {
        ['@citizenid'] = jailedPlayer.PlayerData.citizenid,
        ['@inmate_items'] = json.encode(resolvedJailedPlayerItems),
    })
end)

-------------
--Functions--
-------------

function CheckIfBlackListedItem(item)
    for _, v in pairs(Config.ContrabandItems) do
        if string.lower(item) == v then
            return true
        end

        return false
    end
end

-------------
--Callbacks--
-------------

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

lib.callback.register('prison:CheckRemainingDuration', function()
    local player = QBCore.Functions.GetPlayer(source)
    local jailTime = player.Functions.GetMetaData('injail')

    return jailTime
end)

lib.callback.register('prison:server:GetAllInmateData', function()
    local inmateData = MySQL.Sync.fetchAll('SELECT * FROM `vib_prison`')
    
    return inmateData
end)

-----------
--Threads--
-----------