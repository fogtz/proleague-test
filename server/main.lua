--- Função para ativar/desativar a busca por uma partida.
--- @param source number
local function toggleSearch(source)
    
end

--- Comando para ativar/desativar a busca por uma partida.
RegisterCommand("x1", function(source, args, rawCommand)
    toggleSearch(source)
end, false)