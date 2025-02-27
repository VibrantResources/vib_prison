QBCore = exports["qb-core"]:GetCoreObject()

-------------
--Variables--
-------------

local reloaded = false
local unJailed = false
inJail = false

----------
--Events--
----------

RegisterNetEvent('prison:client:SendToJailInput', function()
    local playerId, player, playerCoords = lib.getClosestPlayer(GetEntityCoords(cache.ped), 2.0, false)
    local distance = playerCoords and #(playerCoords - GetEntityCoords(cache.ped))

    playerId = GetPlayerServerId(playerId)

    -- if player == nil or distance == nil then
    --     lib.notify({
    --         title = "No one found",
    --         description = "Couldn't find anyone nearby",
    --         type = 'inform'
    --     })
    --     return
    -- end

    -- if player ~= -1 and distance < 2.5 then
        local input = lib.inputDialog('Jailing ', {
            {
                type = 'number',
                label = 'Targets City ID',
                description = 'Who are you jailing?',
                icon = 'hashtag',
                required = true, 
            },
            {
                type = 'number',
                label = 'Sentence Duration',
                description = 'How many months will they spend in jail?',
                icon = 'hashtag',
                required = true, 
            },
            {
                type = 'input', 
                label = 'Text input', 
                description = 'Why are they being jailed? (20 char max)', 
                required = false,
                min = 2, 
                max = 20,
            },
        })

		if input == nil then
			return
		end
        
        TriggerServerEvent('prison:server:JailPlayer', input)
    -- else
    --     lib.notify({
    --         title = "Attention",
    --         description = "No one nearby",
    --         type = 'inform'
    --     })
    -- end
end)

RegisterNetEvent('prison:client:UnjailPlayer', function()
	local player = cache.ped
	local remainingDuration = lib.callback.await('prison:CheckRemainingDuration', false)
	local unJailed = true

	if remainingDuration > 0 then
		TriggerServerEvent("prison:server:SetJailStatus", 0, unJailed)

		inJail = false

		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end

		TriggerServerEvent('qb-clothes:loadPlayerSkin')
		SetEntityCoords(player, Config.Prison.Locations.LeavingPrison, 0, 0, 0, false)
		SetEntityHeading(player, Config.Prison.Locations.LeavingPrison.w)
		Wait(500)
		DoScreenFadeIn(1000)
	end

	unJailed = false
end)

RegisterNetEvent('prison:client:Enter', function(jailDuration, reloaded)
	local enteringPrison = Config.Prison.Locations.Enteringprison
	local randomLocation = enteringPrison.EnterLocations[math.random(1, #enteringPrison.EnterLocations)]

	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(10)
	end

	if not reloaded then
		SetEntityCoordsNoOffset(cache.ped, randomLocation.x, randomLocation.y, randomLocation.z, false, false, false, false)
		SetEntityHeading(cache.ped, randomLocation.w)

		DoScreenFadeIn(1000)
		FreezeEntityPosition(cache.ped, true)
		SpawnHealthCheckPed(jailDuration)
	else
		SetEntityCoordsNoOffset(cache.ped, randomLocation.x, randomLocation.y, randomLocation.z, false, false, false, false)
		SetEntityHeading(cache.ped, randomLocation.w)

		DoScreenFadeIn(1000)

		lib.alertDialog({
			header = "Incarcerated",
			content = "You've still got "..jailDuration.." month/s left!\n\n"..
			"Keep working hard to reduce your sentence ... or sit and sob in your cell... criminal!\n\nDon't forget your prison clothes!",
			centered = true,
		})
	end

	local playerGender = QBCore.Functions.GetPlayerData().charinfo.gender
	if playerGender == 0 then
		TriggerEvent('qb-clothing:client:loadOutfit', PrisonClothes.Male)
	else
		TriggerEvent('qb-clothing:client:loadOutfit', PrisonClothes.Female)
	end

	if not reloaded then
		PrisonDurationTimer()
	end
end)

RegisterNetEvent('prison:CheckJailDuration', function()
	if not inJail then
		lib.notify({
			title = 'Attention',
			description = "You're not locked up ... don't be silly",
			type = 'error'
		})
		return
	end

	local remainingDuration = lib.callback.await('prison:CheckRemainingDuration', false)

	if remainingDuration == nil or remainingDuration <= 0 then
		FreedomFromJail()
	else
		lib.notify({
			title = 'Attention',
			description = "You've still got "..remainingDuration.." month/s left",
			type = 'inform'
		})
	end
end)

-------------------------------
--Player Load/Unload Controls--
-------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then -- Send player back into jail, in a random location, if they logged off whilst they have a remaining duration
			local reloaded = true

			TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"], reloaded)

			PrisonDurationTimer()
		end
	end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	inJail = false
	reloaded = false
end)