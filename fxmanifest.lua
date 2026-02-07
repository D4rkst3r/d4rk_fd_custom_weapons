fx_version 'cerulean'
game 'gta5'

author 'D4rkst3r'
description 'Fire Department Custom Weapons'
version '1.0.0'

-- Models & Textures
files {
    'stream/w_am_fire_exting.ytd',
    'stream/w_am_fire_exting_water.ydr',
    'stream/w_am_fire_exting_foam.ydr',
    'stream/w_am_fire_exting_co2.ydr',
    'stream/w_am_fire_exting_powder.ydr',

    -- Meta-Files
    'meta/*.meta'
}

-- Data Files registrieren
-- Weapon Info (Hauptdaten)
data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'

-- Weapon Animations
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'

-- Weapon Archetypes (Texture Links)
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'

-- Weapon Components (Attachments)
data_file 'WEAPON_METADATA_FILE' 'meta/weaponcomponents.meta'

-- Ped Personality (NPC Verhalten)
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'
data_file 'WEAPONFX_FILE' 'meta/weaponfx.meta'


client_script {
    'cl_weaponNames.lua',
    'client.lua' }
