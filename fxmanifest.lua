fx_version 'cerulean'
game 'gta5'

author 'D4rkst3r'
description 'Fire Department Custom Weapons'
version '1.0.0'

files {
    'meta/*.meta',
}

data_file 'WEAPONINFO_FILE' 'meta/fire_weapons.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/fire_weaponanimations.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/fire_weaponarchetypes.meta'


client_scripts {
    'cl_weaponNames.lua',
    'client.lua'
}
