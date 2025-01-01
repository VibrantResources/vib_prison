RegisterNetEvent('prison:client:VisitationRequestsMenu', function()
    local player = cache.ped
    local playerInfo = lib.callback.await('prison:server:GetPlayerInfo', false, player)
    local visitationRequests = lib.callback.await('prison:server:GetVisitationRequests', false)
    local headerMenu = {}

    for index, requestsData in pairs(visitationRequests) do
        if playerInfo.citizenid == requestsData.inmate.citizenid then
            headerMenu[#headerMenu + 1] = {
                title = "VISITATION REQUESTS",
                description = "You have a visitation request from: "..requestsData.visitor.charinfo.charname,
                serverEvent = 'prison:server:ActionVisitation',
                args = {
                    inmate = playerInfo.citizenid,
                    visitor = requestsData.visitor,
                },
                icon = "fa-solid fa-book",
                iconColor = "white",
            }
        end
    end

    lib.registerContext({
        id = 'visitors_menu',
        title = "Your visitation requests",
        options = headerMenu,
    })

    lib.showContext('visitors_menu')
end)