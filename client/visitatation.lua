RegisterNetEvent('prison:client:RequestVisitation', function(data)
    local player = cache.ped

    local input = lib.inputDialog('Request Visitation ', {
        {
            type = 'checkbox',
            label = 'Are you sure you want to request visitation with '..data.inmateData.charinfo.charname,
            icon = 'hashtag',
            required = true, 
        },
    })

    if input == nil then
        return
    end

    TriggerServerEvent('prison:server:NotifyInmateOfVisitRequest', data.inmateData.citizenid)
end)

RegisterNetEvent('prison:client:InmateGoToVisitationRoom', function(inmateSource, inmate)
    local visitRoom = Config.Visitation.VisitationRoom
    local newInmate = GetPlayerPed(GetPlayerFromServerId(inmateSource))

    SpawnVisitationRoomPed()

    DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(10)
	end

    SetEntityCoordsNoOffset(newInmate, visitRoom.InmateLocation.x, visitRoom.InmateLocation.y, visitRoom.InmateLocation.z, false, false, false, false)
    Wait(1000)
    DoScreenFadeIn(1000)
end)