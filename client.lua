-- =============================================================================
-- FD CUSTOM WEAPONS - CLIENT LOADER
-- =============================================================================

Citizen.CreateThread(function()
    print("^2[FD Custom Weapons] Loading...^0")

    -- Check ob Models existieren
    local weapons = {
        'WEAPON_FIREEXTINGUISHER_WATER',
        'WEAPON_FIREEXTINGUISHER_FOAM',
        'WEAPON_FIREEXTINGUISHER_CO2',
        'WEAPON_FIREEXTINGUISHER_POWDER'
    }

    for _, weaponName in ipairs(weapons) do
        local hash = GetHashKey(weaponName)

        if IsWeaponValid(hash) then
            print(string.format("^2[FD Custom Weapons] ✓ %s loaded (Hash: %s)^0", weaponName, hash))
        else
            print(string.format("^1[FD Custom Weapons] ✗ %s FAILED to load!^0", weaponName))
        end
    end

    print("^2[FD Custom Weapons] Ready!^0")
end)

-- Debug Command
RegisterCommand('fdweaponcheck', function()
    print("^3========== FD WEAPONS CHECK ==========^0")

    local weapons = {
        { name = 'WEAPON_FIREEXTINGUISHER_WATER',  model = 'w_am_fire_exting_water' },
        { name = 'WEAPON_FIREEXTINGUISHER_FOAM',   model = 'w_am_fire_exting_foam' },
        { name = 'WEAPON_FIREEXTINGUISHER_CO2',    model = 'w_am_fire_exting_co2' },
        { name = 'WEAPON_FIREEXTINGUISHER_POWDER', model = 'w_am_fire_exting_powder' },
    }

    for _, weapon in ipairs(weapons) do
        local weaponHash = GetHashKey(weapon.name)
        local modelHash = GetHashKey(weapon.model)

        local weaponValid = IsWeaponValid(weaponHash)
        local modelValid = IsModelInCdimage(modelHash)

        print(string.format("^2%s:^0", weapon.name))
        print(string.format("  Weapon Valid: %s", weaponValid and "✓" or "✗"))
        print(string.format("  Model Valid: %s", modelValid and "✓" or "✗"))
        print(string.format("  Weapon Hash: %s", weaponHash))
        print(string.format("  Model Hash: %s", modelHash))
    end

    print("^3=====================================^0")
end, false)
