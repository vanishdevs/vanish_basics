fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '1.0.1'

author 'vanishdev'
description 'Basic Server Management System with Customization Options'

client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@ox_lib/init.lua', 'shared/*.lua' }

files { 'meta/weapons.meta' }
data_file 'WEAPONINFO_FILE_PATCH' 'meta/weapons.meta'
