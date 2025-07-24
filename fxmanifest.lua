fx_version 'cerulean'
game 'gta5'

author 'Leon'
description 'View QBCore warnings via /warnings with ox_lib'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
