description 'Cinematic Script By KOV'

client_script {
    'client.lua',
    'config.lua',
}
server_script {
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua'
}

export "TalkEnded"
export "PedRelationShip"