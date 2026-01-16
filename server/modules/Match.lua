Match = {}
Match.__index = Match

local instances = {}
local playersInMatch = {}

--- Cria uma nova partida.
--- @param players table
--- @return number, boolean, string
function Match.create(players)
    local self = setmetatable({}, Match)

    self.id = #instances + 1
    self.players = players
    self.savedData = {}

    local status, message = self:start()
    return self.id, status, message
end

--- Inicia a partida.
--- @return boolean, string
function Match:start()
    if (not self.players or #self.players < 2) then
        return false, 'Número insuficiente de jogadores para iniciar a partida.'
    end

    if (not instances[self.id]) then
        instances[self.id] = self
    end
    
    for _, playerId in ipairs(self.players) do
        playersInMatch[playerId] = self.id
    end

    self.arena = self:randomArena()

    for position = 1, #self.players do
        local playerId = self.players[position]
        if playerId then 
            local status = self:saveData(playerId)
            if status then 
                local playerPed = NetworkGetEntityFromNetworkId(playerId)
                local playerSource = NetworkGetEntityOwner(playerPed) 

                local spawnPoint = self.arena.spawnPoints[position]
                local weapons = MatchSettings.Weapons[self.arena.weaponLoadout]

                TriggerClientEvent('match:startMatch', playerSource, spawnPoint, weapons)
            end
        end
    end

    return true, 'Partida iniciada com sucesso na arena: ' .. self.arena.name
end

--- Salva os dados atuais do jogador antes do teleporte.
--- @param playerId number
--- @return boolean, string
function Match:saveData(playerId)
    if self.savedData[playerId] then
        return false, 'Dados do jogador já salvos.'
    end

    local playerPed = NetworkGetEntityFromNetworkId(playerId)
    local playerSource = NetworkGetEntityOwner(playerPed)
    
    local playerHealth = GetEntityHealth(playerPed)
    local playerArmor = GetPedArmour(playerPed)

    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    self.savedData[playerId] = {
        health = playerHealth,
        armor = playerArmor,
        coords = playerCoords,
        heading = playerHeading,
    }
    return true, 'Dados do jogador salvos com sucesso.'
end

function Match:restoreData(playerId)
    local savedData = self.savedData[playerId]
    if (not savedData) then
        return false, 'Nenhum dado salvo encontrado para o jogador.'
    end

    local playerPed = NetworkGetEntityFromNetworkId(playerId)
    local playerSource = NetworkGetEntityOwner(playerPed)

    TriggerClientEvent('health:update', playerSource, savedData.health)
    SetPedArmour(playerPed, savedData.armor)
    SetEntityCoords(playerPed, savedData.coords.x, savedData.coords.y, savedData.coords.z, false, false, false, true)
    SetEntityHeading(playerPed, savedData.heading)
    RemoveAllPedWeapons(playerPed, true)

    self.savedData[playerId] = nil
    playersInMatch[playerId] = nil
    return true, 'Dados do jogador restaurados com sucesso.'
end

--- Encerra a partida e restaura os dados dos jogadores.
--- @return boolean, string
function Match:endMatch()
    for _, playerId in ipairs(self.players) do
        self:restoreData(playerId)
    end

    instances[self.id] = nil
    return true, 'Partida encerrada com sucesso.'
end

--- Seleciona aleatoriamente uma arena disponível.
--- @return table
function Match:randomArena()
    local availableArenas = MatchSettings.Arenas
    local arenaKeys = {}
    for key, _ in pairs(availableArenas) do
        table.insert(arenaKeys, key)
    end

    local randomIndex = math.random(1, #arenaKeys)
    local selectedArenaKey = arenaKeys[randomIndex]
    return availableArenas[selectedArenaKey]
end

--- Retorna uma partida pelo ID.
--- @param matchId any
--- @return table
function Match.getMatchById(matchId)
    return instances[matchId]
end

--- Retorna todas as partidas em andamento.
--- @return table
function Match.getMatches()
    return instances
end

--- Retorna a contagem de partidas em andamento.
--- @return number
function Match.getMatchesCount()
    return #instances
end

--- Retorna a partida em que um jogador está participando.
--- @param playerId number
--- @return table | nil
function Match.getPlayerMatch(playerId)
    local matchId = playersInMatch[playerId]
    if matchId then
        return instances[matchId]
    end
    return nil
end