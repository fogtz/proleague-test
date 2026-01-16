local instances = {}

--- Função para ativar/desativar a busca por uma partida.
--- @param source number
local function toggleSearch(source)
    local userPed = GetPlayerPed(source)
    local userId = NetworkGetNetworkIdFromEntity(userPed)

    if (not userId) then
        return false, 'Jogador não encontrado.'
    end

    local queueState = instances.Queue:isInQueue(userId)
    local success, message
    if queueState then
        success, message = instances.Queue:remove(userId)
    else
        success, message = instances.Queue:add(userId)
    end
    return success, message
end

--- Comando para ativar/desativar a busca por uma partida.
RegisterCommand("x1", function(source, args, rawCommand)
    local success, message = toggleSearch(source)
    print(success, message)
end, false)

--- Evento para reconhecer a morte de um jogador na arena.
RegisterNetEvent('onPlayerDeath', function(attackerId)
    local victimSource = source
    local victimPed = GetPlayerPed(victimSource)
    local victimId = NetworkGetNetworkIdFromEntity(victimPed)

    if (not victimId) then
        return
    end

    local matchInstance = Match.getPlayerMatch(victimId)
    if (not matchInstance) then
        return
    end

    matchInstance:endMatch(victimId)
end)

--- Evento para retornar informações da fila e partidas.
RegisterNetEvent('match:requestStats', function()
    local queueCount = instances.Queue:getQueueCount()
    local matchCount = Match.getMatchesCount()
    
    TriggerClientEvent('match:receiveStats', source, queueCount, matchCount)
end)

--- Thread inicial para definir instancias.
Citizen.CreateThread(function()
    if not instances.Queue then
        instances.Queue = Queue.new()
    end
end)