CreateThread(function()
    exports.ox_target:addSphereZone({
        coords = vec3(Config.MainPrison.CheckSentenceDuration.x, Config.MainPrison.CheckSentenceDuration.y, Config.MainPrison.CheckSentenceDuration.z),
        radius = 0.3,
        debug = Config.GenericStuff.Debug,
        options = {
            {
                event = 'prison:CheckJailDuration',
                label = "Check Remaining Time",
                icon = "fa-solid fa-clipboard",
                iconColor = "orange",
                distance = 2,
            },
        },
    })

    exports.ox_target:addSphereZone({
        coords = vec3(Config.MainPrison.InmateMenu.MenuLocation.x, Config.MainPrison.InmateMenu.MenuLocation.y, Config.MainPrison.InmateMenu.MenuLocation.z),
        radius = 0.5,
        debug = Config.GenericStuff.Debug,
        options = {
            {
                event = 'prison:client:InmateMenu',
                label = "Check current Inmates",
                icon = "fa-solid fa-person",
                iconColor = "orange",
                distance = 2,
            },
        },
    })
end)