fx_version 'cerulean'
game 'gta5'

description 'Prison System'
author 'Vibrant Resources'
version '1.0'

shared_scripts {
    '@ox_lib/init.lua',
	'shared/*.lua',
}

server_scripts  {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
	'menus/*.lua',
	'jobs/*.lua',
}

lua54 'yes'