CreateThread(function()
    for wine, wineInfo in pairs(Config.WineMaking.Locations) do

        local wineZones = exports.ox_target:addSphereZone({
            coords = wineInfo.Location,
            radius = 0.7,
            debug = Config.GenericStuff.Debug,
            options = {
                {
                    label = "Create Wine",
                    event = 'prison:MainWineMenu',
                    args = {
                        wine = wineInfo,
                        wineType = wine,
                    },
                    icon = "fa-solid fa-wine-bottle",
                    iconColor = "red",
                    distance = 2,
                },
            },
        })

        TriggerServerEvent('prison:server:UpdateFreshWineTable', wine, wineInfo)
    end
end)