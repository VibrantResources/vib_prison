QBCore = exports["qb-core"]:GetCoreObject()

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

    local resolvedJailedPlayerItems = exports.ox_inventory:GetInventoryItems(inputData[1])

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