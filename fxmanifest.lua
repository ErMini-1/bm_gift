fx_version 'cerulean'
game 'gta5'

client_script 'client/cl_main.lua'
server_scripts {
    -- if u are using mysql-async uncomment the line below and comment the oxmysql import line
    
    -- '@mysql-async/lib/MySQL.lua'
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}

shared_script 'config.lua'