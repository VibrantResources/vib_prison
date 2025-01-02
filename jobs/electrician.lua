-------------
--Variables--
-------------

local locationRepaired = false
local working = false

-----------
--Threads--
-----------

CreateThread(function()
    local electricianJob = Jobs.Electrician
    local pedModel = lib.requestModel(electricianJob.PedModel)
    
    local jobPed = CreatePed(1, pedModel, electricianJob.PedLocation, electricianJob.PedLocation.w, false, true)

    FreezeEntityPosition(jobPed, true)
    SetBlockingOfNonTemporaryEvents(jobPed, true)

    exports.ox_target:addSphereZone({
        coords = vec3(electricianJob.PedLocation.x, electricianJob.PedLocation.y, electricianJob.PedLocation.z+1),
        radius = 1.0,
        debug = Config.GenericStuff.Debug,
        options = {
            {
                onSelect = function()
                    BeginElectricianWork()
                end,
                label = "Start Electrical Work",
                icon = "fa-solid fa-wand-sparkles",
                iconColor = "orange",
                distance = 2,
            },
            {
                onSelect = function()
                    EndElectricalWork()
                end,
                label = "End Electrical Work",
                icon = "fa-solid fa-wand-sparkles",
                iconColor = "orange",
                distance = 2,
            },
        },
    })
end)

----------
--Events--
----------

-------------
--Functions--
-------------

function BeginElectricianWork()
    local remainingDuration = lib.callback.await('prison:CheckRemainingDuration', false)

    if remainingDuration <= 0 then
        lib.notify({
            title = 'Times up!',
            description = "Seems like your times up ... why are you still looking for work?",
            type = 'inform'
        })
        return
    end
    
    lib.notify({
        title = 'Attention',
        description = "You'll see sparks coming off the damaged equipment! Go repair it!",
        type = 'inform'
    })
    working = true

    local randomChoice = math.random(1, #Jobs.Electrician.RepairLocations)
    local randomLocation = Jobs.Electrician.RepairLocations[randomChoice]

    blip = AddBlipForCoord(randomLocation)
    SetBlipSprite (blip, 402)
    SetBlipDisplay(blip, 2)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 46)

    repairLocation = exports.ox_target:addSphereZone({
        coords = vec3(randomLocation.x, randomLocation.y, randomLocation.z),
        radius = 1.0,
        debug = Config.GenericStuff.Debug,
        options = {
            {
                onSelect = function()
                    DoElectricianWork()
                end,
                label = "Repair Electrical stuff",
                icon = "fa-solid fa-wrench",
                iconColor = "red",
                distance = 1,
            },
        },
    })
    ParticleEffects(randomLocation)
end

function EndElectricalWork()
    working = false
    if blip ~= nil then
        RemoveBlip(blip)
    end
    if repairLocation ~= nil then
        exports.ox_target:removeZone(repairLocation)
    end
    lib.notify({
        title = 'Finished Work',
        description = "You've stopped doing electrical work",
        type = 'inform'
    })
end

function DoElectricianWork()
    local player = cache.ped

    if lib.progressCircle({
        duration = math.random(5000, 10000),
        position = 'bottom',
        label = "Reparing electrical stuff",
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
        anim = {
            scenario = "WORLD_HUMAN_WELDING",
        },
    })
    then
        if math.random(1, 100) <= 70 then
            lib.notify({
                title = "Repaired",
                description = "Good job! I'm sure something else will break soon!",
                type = 'success',
            })
            TriggerServerEvent('prison:server:WorkReduceSentence')
        else
            lib.notify({
                title = "SHOCKING",
                description = "You touched the wrong wire!",
                type = 'error',
            })
            SetPedToRagdoll(player, 1500, 2000, 0, true, true, false)
            SetEntityHealth(player, GetEntityHealth(player) - 5)
        end

        locationRepaired = true
        if blip ~= nil then
            RemoveBlip(blip)
        end

        exports.ox_target:removeZone(repairLocation)
        StopParticleFxLooped(sparksEffect)

        Wait(5000)
        BeginElectricianWork()
    else
        lib.notify({
            title = 'Canceled',
            description = "Canceled",
            type = 'error',
        })
    end
end

function ParticleEffects(randomLocation)
    locationRepaired = false

    while not locationRepaired and working do
        if not inJail then
            return
        end

        lib.requestNamedPtfxAsset('core')
        SetPtfxAssetNextCall('core')

        Wait(math.random(500, 2000))
        
        StartParticleFxLoopedAtCoord('ent_brk_sparking_wires', randomLocation.x, randomLocation.y, randomLocation.z, 0.0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, 0)
    end
end