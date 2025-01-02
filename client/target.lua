CreateThread(function()
    local SentenceDurationLocation = Config.Prison.Locations.CheckSentenceDuration
    exports.ox_target:addSphereZone({
        coords = vec3(SentenceDurationLocation.x, SentenceDurationLocation.y, SentenceDurationLocation.z),
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

    local inmateMenu = Config.Prison.Locations.InmateMenu
    exports.ox_target:addSphereZone({
        coords = vec3(inmateMenu.MenuLocation.x, inmateMenu.MenuLocation.y, inmateMenu.MenuLocation.z),
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