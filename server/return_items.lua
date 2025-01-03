RegisterNetEvent('prison:server:ReturnPlayerItems', function(source, playerItems)
    local player = QBCore.Functions.GetPlayer(source)

    for index, itemInfo in pairs(playerItems) do
        if exports.ox_inventory:CanCarryItem(source, itemInfo.name, itemInfo.count) then
            exports.ox_inventory:AddItem(source, itemInfo.name, itemInfo.count, itemInfo.metadata)
        else
            lib.notify(source, {
                title = "Attention",
                description = "Inventory is full!",
                type = 'inform'
            })
        end
    end
end)