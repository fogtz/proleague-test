fx_version 'cerulean'
game 'gta5'

author 'Fogtz'
description 'Sistema de PvP com fila.'
version '1.0.0'

shared_script 'shared/config.lua'

server_scripts {
    'server/modules/Queue.lua',
    'server/modules/Match.lua',
    'server/main.lua'
}

client_scripts {
    'client/modules/health.lua',
    'client/main.lua'
}