RegisterNetEvent('health:update', function(health)
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, health)
end)