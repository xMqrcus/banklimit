fx_version 'cerulean'
game 'gta5'

version '1.0.0'

dependency "vrp"

client_scripts {
	"lib/Proxy.lua",
    "lib/Tunnel.lua",
}

server_scripts {
    'lib/Proxy.lua',
    "@vrp/lib/utils.lua",
    'config.lua',
    'server.lua'
}