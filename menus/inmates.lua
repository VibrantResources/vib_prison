RegisterNetEvent('prison:client:InmateMenu', function()
    local player = cache.ped
    local inmateData = lib.callback.await('prison:server:GetInmateData', false)
    local headerMenu = {}

    for _, inmate in pairs(inmateData) do
        local player = lib.callback.await('prison:server:GetPlayerByCitizenId', false, inmate.citizenid)
        local unavailable = false
        local avilableForVisitation = nil

        if not player.Offline then
            avilableForVisitation = "Visitation available"
            unavailable = false
        else
            avilableForVisitation = "This person isn't available right now"
            unavailable = true
        end

        headerMenu[#headerMenu + 1] = {
            title = player.PlayerData.charinfo.charname,
            description = "Sentence Duration: "..inmate.sentence_duration.."\n\nReason for incarceration: "..inmate.reason.."\n\n"..avilableForVisitation,
            event = 'prison:client:RequestVisitation',
            args = {
                inmateCitizenId = inmate.citizenId,
                inmateData = player.PlayerData,
            },
            icon = "fa-solid fa-person",
            iconColor = "white",
            readOnly = unavailable,
        }
    end

    lib.registerContext({
        id = 'inmates_menu',
        title = "Current Inmates",
        options = headerMenu,
    })

    lib.showContext('inmates_menu')
end)