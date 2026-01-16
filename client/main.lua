local displayStats = false
local stats = {
    queueCount = 0,
    matchCount = 0
}

--- Função para alternar a exibição das estatísticas.
local function toggleStatsDisplay()
    displayStats = not displayStats
end

--- Evento para receber as estatísticas do servidor.
RegisterNetEvent('match:receiveStats', function(queueCount, matchCount)
    stats.queueCount = queueCount
    stats.matchCount = matchCount
end)

--- Thread para desenhar as estatísticas na tela.
Citizen.CreateThread(function()
    while true do
        if displayStats then
            local text = string.format(
                "~b~Jogadores na fila:~w~ %d~n~~g~Partidas em andamento:~w~ %d",
                stats.queueCount,
                stats.matchCount
            )
            
            SetTextFont(4)
            SetTextScale(0.5, 0.5)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(text)
            DrawText(0.85, 0.90)
        end
        Citizen.Wait(0)
    end
end)

--- Evento para iniciar a partida no cliente.
RegisterNetEvent('match:startMatch', function(spawnPoint, weapons)
    local playerPed = PlayerPedId()
    
    SetEntityCoords(playerPed, spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
    SetEntityHeading(playerPed, spawnPoint.heading)
    
    RemoveAllPedWeapons(playerPed, true)
    
    for _, weapon in ipairs(weapons) do
        GiveWeaponToPed(playerPed, GetHashKey(weapon), 250, false, true)
    end
end)

--- Comando para alternar a exibição das estatísticas.
RegisterCommand("stats", function(source, args, rawCommand)
    toggleStatsDisplay()
end, false)
