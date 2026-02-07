fx_version 'cerulean'
game 'gta5'

author 'D4rkst3r'
description 'Fire Department Custom Weapons'
version '1.0.0'

this_is_a_map 'yes'

-- ============================================================================
-- META FILES ONLY (Models werden automatisch aus stream/ geladen!)
-- ============================================================================

files {
    'meta/weapons.meta',
    'meta/weaponanimations.meta',
    'meta/weaponarchetypes.meta',
    'meta/weaponcomponents.meta',
    'meta/pedpersonality.meta',
    'meta/weaponfx.meta'
}

-- ============================================================================
-- DATA FILE REGISTRATIONS
-- ============================================================================

-- Weapon Info
data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'

-- Weapon Animations
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'

-- Weapon Archetypes + Components (BEIDE in einer Registrierung!)
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'

data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/weaponcomponents.meta'

-- Ped Personality
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'

-- Weapon FX
data_file 'WEAPONFX_FILE_METADATA' 'meta/weaponfx.meta'

-- ============================================================================
-- CLIENT SCRIPTS
-- ============================================================================

client_scripts {
    'cl_weaponNames.lua',
    'client.lua'
}
