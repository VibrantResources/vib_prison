function PrisonDurationTimer()
	inJail = true
	
	CreateThread(function()
		while true do
			local remainingTime = lib.callback.await('prison:CheckRemainingDuration', source)
	
			if remainingTime <= 0 then
				lib.notify({
					title = 'Attention',
					description = "Your time's up! Head to the check out area to be free!",
					type = 'success'
				})
				return
			end

			Wait(10000) -- This needs to be set to 60000 when complete

			local newSentenceTime = (remainingTime - 1)
			TriggerServerEvent('prison:server:UpdateRemainingSentence', newSentenceTime)
		end
	end)
end

function FreedomFromJail() -- Function that runs when checking time whilst remainingDuration <= 0
	local leaving = Config.Prison.Locations.LeavingPrison

	DoScreenFadeOut(2000)
	while not IsScreenFadedOut() do
		Wait(10)
	end

	Wait(1000)

	SetEntityCoords(cache.ped, leaving.x, leaving.y, leaving.z)
	SetEntityHeading(cache.ped, leaving.w)
	Wait(500)

	inJail = false

	DoScreenFadeIn(2000)

	TriggerServerEvent('prison:server:ReturnItemsAndclearDatabase')
end