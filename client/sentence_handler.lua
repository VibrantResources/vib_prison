RegisterNetEvent('prison:CreateSentenceDuration', function(jailSentenceDuration)
	if jailSentenceDuration <= 0 and inJail then
		lib.notify({
			title = 'Attention',
			description = "You're time's up! Head to the check out area to be free!",
			type = 'success'
		})
	end
	TriggerServerEvent("prison:server:SetJailStatus", jailSentenceDuration)
end)