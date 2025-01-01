-------------
--Variables--
-------------

toiletWine = {}

----------
--Events--
----------

RegisterNetEvent('prison:server:UpdateFreshWineTable', function(wine, wineInfo)
    toiletWine[wine] = {
        name = wine,
        isBrewing = false,
        isFinished = false,
        ingredients = wineInfo.ingredients,
    }
end)

lib.callback.register('prison:server:GetWineTableData', function(source, index)

    return toiletWine[index]
end)