-------------
--Functions--
-------------

function SpawnHealthCheckPed(jailDuration) -- Ped that goes through confirmations when first entering prison with player
    local player = cache.ped
    local healthCheck = Config.MainPrison.Enteringprison.ArrivalPed
    local playerCoords = GetEntityCoords(player)
    local playerInfo = lib.callback.await('prison:server:GetPlayerInfo', false, player)

    local arrivalModel = lib.requestModel(healthCheck.Model)
    local arrivalPed = CreatePed(0, arrivalModel, healthCheck.Location.x, healthCheck.Location.y, healthCheck.Location.z, healthCheck.Location.w, false, true)
    SetModelAsNoLongerNeeded(arrivalModel)

    TaskGoStraightToCoord(arrivalPed, playerCoords.x, playerCoords.y, playerCoords.z, 1.0, -1, 0.0, 0.0)

    Wait(3000)

    TaskStartScenarioInPlace(arrivalPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)

	lib.alertDialog({
		header = "Welcome to Boiling Broke Infirmary",
		content = "Hello "..playerInfo.charinfo.charname.."!\n\nSeems you've been locked up for "..jailDuration.." month/s. Now I know it doesn't look pretty but this is your new home so deal with it\n\n"..
		"We've got to do a quick health check on you, so sit still and shut up!\n\nDon't forget your prison clothes!\n\n Oh don't be surprised that we also confiscated anything you shouldn't have!",
		centered = true,
	})

    lib.requestAnimDict('mp_cp_welcome_tutthink')
    TaskPlayAnim(arrivalPed, 'mp_cp_welcome_tutthink', 'b_think', 1.0, 1.0, -1, 1, 1, false, false, false)
    Wait(2000)
    RemoveAnimDict('mp_cp_welcome_tutthink')

    lib.requestAnimDict('random@train_tracks')
    TaskPlayAnim(arrivalPed, 'random@train_tracks', 'idle_e', 1.0, 1.0, -1, 1, 1, false, false, false)
    Wait(10000)
    RemoveAnimDict('random@train_tracks')

    SetEntityAsNoLongerNeeded(arrivalPed)
    FreezeEntityPosition(cache.ped, false)

    Wait(4000)
    
    DeleteEntity(arrivalPed)
end

function SpawnVisitationRoomPed()
    local visitationRoom = Config.Visitation.VisitationRoom

    local visitationModel = lib.requestModel(Config.Visitation.VisitationPed.Model)
    local visitationPed = CreatePed(0, visitationModel, visitationRoom.GuardPedLocation, visitationRoom.GuardPedLocation.w, false, true)

    exports.ox_target:addLocalEntity(visitationPed, {
        {
            label = 'Bribe Guard',
            onSelect = function()
                lib.notify({
                    title = 'Good job',
                    description = "You interacted with the guard",
                    type = 'success'
                })
            end,
            icon = 'fa-solid fa-box-archive',
            iconColor = "yellow",
            distance = 2, 
        },
    })
    SetModelAsNoLongerNeeded(visitationModel)
end

-----------
--Threads--
-----------

CreateThread(function()
    local visits = Config.Visitation.VisitationPed
    lib.requestModel(visits.Model)

    local visitationPed = CreatePed(1, visits.Model, visits.Location, visits.Location.w, false, true)

    FreezeEntityPosition(visitationPed, true)
    SetBlockingOfNonTemporaryEvents(visitationPed, true)

    exports.ox_target:addSphereZone({
        coords = vec3(visits.Location.x, visits.Location.y, visits.Location.z+1),
        radius = 1.0,
        debug = Config.GenericStuff.Debug,
        options = {
            {
                label = "Check visitation requests",
                event = 'prison:client:VisitationRequestsMenu',
                icon = "fa-solid fa-phone",
                iconColor = "orange",
                distance = 2,
            },
        },
    })
end)