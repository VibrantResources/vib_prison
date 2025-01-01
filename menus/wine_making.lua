RegisterNetEvent('prison:MainWineMenu', function(data)
    local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Brew Wine",
        description = "Begin producing your batch of wine",
        event = 'prison:WineMaking',
        args = data,
        icon = "fa-solid fa-hands-bubbles",
        iconColor = "white",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Ingredients",
        description = "Add ingredients to your batch",
        event = 'prison:WineIngredients',
        args = data,
        icon = "fa-solid fa-flask",
        iconColor = "yellow",
    }

    lib.registerContext({
        id = 'wine_menu',
        title = data.args.toiletInfo.WineName,
        options = headerMenu,
    })

    lib.showContext('wine_menu')
end)

RegisterNetEvent('prison:WineMaking', function(data)
    local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Begin",
        description = "Begin brewing wine",
        event = '',
        icon = "fa-solid fa-wine-glass-empty",
        iconColor = "white",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Collect",
        description = "Collect your brewed wine",
        event = '',
        icon = "fa-solid fa-wine-glass",
        iconColor = "orange",
    }

    lib.registerContext({
        id = 'wine_making_menu',
        title = "Wine Making",
        options = headerMenu,
        menu = 'wine_menu',
    })

    lib.showContext('wine_making_menu')
end)

RegisterNetEvent('prison:WineIngredients', function(data)
    local toiletData = lib.callback.await('prison:server:GetWineTableData', false, data.args.toiletNumber)
    print(json.encode(toiletData.ingredients, {indent = true}))
    local headerMenu = {}

    for item, amount in pairs(toiletData.ingredients) do
        headerMenu[#headerMenu + 1] = {
            title = exports.ox_inventory:Items(item).label,
            description = amount.." of "..exports.ox_inventory:Items(item).label.." added",
            event = '',
            icon = "fa-solid fa-wine-glass-empty",
            iconColor = "white",
        }
    end

    lib.registerContext({
        id = 'ingredients_menu',
        title = "Ingredients",
        options = headerMenu,
        menu = 'wine_making_menu',
    })

    lib.showContext('ingredients_menu')
end)