fx_version 'cerulean'
game 'gta5'

author 'D4rkst3r'
description 'Fire Department Custom Weapons'
version '1.0.1'

files {
    'meta/*.meta',
}

-- Alle Meta-Dateien registrieren
data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'
data_file 'WEAPONFX_FILE' 'meta/weaponfx.meta'
data_file 'LOADOUTS_FILE' 'meta/loadouts.meta'
data_file 'TEXTFILE_METAFILE' 'meta/dlctext.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'

client_scripts {
    'cl_weaponNames.lua',
    'client.lua'
}
