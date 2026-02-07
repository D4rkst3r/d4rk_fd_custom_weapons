fx_version 'cerulean'
game 'gta5'

author 'D4rkst3r'
description 'Fire Department Custom Weapons'
version '1.0.0'

-- KEIN this_is_a_map 'yes' hier!

files {
    'meta/weapons.meta',
    'meta/weaponanimations.meta',
    'meta/weaponarchetypes.meta',
    'meta/pedpersonality.meta',
    'meta/loadouts.meta',
}

-- WICHTIG: Die Reihenfolge und die richtigen Keywords
data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'
-- Archetypes müssen als METADATA_FILE registriert werden, damit das Modell geladen wird
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'
data_file 'LOADOUTS_FILE' 'meta/loadouts.meta'

client_scripts {
    'cl_weaponNames.lua',
    'client.lua'
}
