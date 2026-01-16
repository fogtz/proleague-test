Queue = {}
Queue.__index = Queue

--- Instancia a fila.
--- @return table
function Queue.new()
    local self = setmetatable({}, Queue)
    self.queuedPlayers = {}
    return self
end

--- Adiciona um jogador à fila.
--- @param userId number
--- @return boolean, string 
function Queue:add(userId)
    if self.queuedPlayers[userId] then
        return false, 'O jogador já está na fila.'
    end

    self.queuedPlayers[userId] = true
    
    local canMatch, matchPlayers = self:checkMatch()
    if canMatch then
        Match.create(matchPlayers)
    end
    return true, 'Jogador adicionado à fila com sucesso.'
end

--- Remove um jogador da fila.
--- @param userId number
--- @return boolean, string
function Queue:remove(userId)
    if not self.queuedPlayers[userId] then
        return false, 'O jogador não está na fila.'
    end

    self.queuedPlayers[userId] = nil
    return true, 'Jogador removido da fila com sucesso.'
end

--- Função para verificar se há jogadores suficientes para iniciar uma partida.
--- @return boolean, table | nil
function Queue:checkMatch()
    if (not self.queuedPlayers) then
        return false, {}
    end

    local players = {}
    for userId, _ in pairs(self.queuedPlayers) do
        table.insert(players, userId)

        if #players >= 2 then
            return true, players
        end
    end
    return false, {}
end

--- Verifica se um jogador está na fila.
--- @param userId number
function Queue:isInQueue(userId)
    return self.queuedPlayers[userId] ~= nil
end