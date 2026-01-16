AddEventHandler('gameEventTriggered', function(eventName, args)
	if (eventName ~= 'CEventNetworkEntityDamage') then return end
	local victim, attacker = args[1], args[2]
	local attackerId = NetworkGetPlayerIndexFromPed(args[2])

	if victim ~= PlayerPedId() then return end
	if (IsEntityAPed(victim) and GetEntityHealth(victim) <= 100) and NetworkIsPlayerConnected(attackerId) then
		TriggerServerEvent('onPlayerDeath', GetPlayerServerId(attackerId))
	end
end)