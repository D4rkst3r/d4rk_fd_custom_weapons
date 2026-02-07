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


RegisterCommand('testmodel', function()
    local modelHash = GetHashKey('w_am_fire_exting_water')

    RequestModel(modelHash)
    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 100 do
        Citizen.Wait(10)
        timeout = timeout + 1
    end

    if HasModelLoaded(modelHash) then
        print("^2Model loaded successfully!^0")
    else
        print("^1Model FAILED to load!^0")
    end
end, false)



-- =============================================================================
-- MODEL SPAWN TEST COMMAND
-- =============================================================================

RegisterCommand('testextmodel', function(source, args, rawCommand)
    --[[
        Usage: /testextmodel [modelname]
        Examples:
            /testextmodel w_am_fire_exting_water
            /testextmodel w_am_fire_exting_foam
            /testextmodel w_am_fire_exting_co2
            /testextmodel w_am_fire_exting_powder
    ]]

    local modelName = args[1] or 'w_am_fire_exting_water' -- Default: Water
    local modelHash = GetHashKey(modelName)

    print(string.format("^3[Model Test] Testing model: %s^0", modelName))
    print(string.format("^3[Model Test] Hash: %s^0", modelHash))

    -- Check ob Model in CdImage existiert
    if not IsModelInCdimage(modelHash) then
        print(string.format("^1[Model Test] ERROR: Model '%s' NOT found in game files!^0", modelName))
        print("^1[Model Test] Your .ydr file is missing or has wrong filename!^0")
        return
    end

    print(string.format("^2[Model Test] ✓ Model found in game files!^0"))

    -- Request Model
    print("^3[Model Test] Requesting model...^0")
    RequestModel(modelHash)

    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 100 do
        Citizen.Wait(10)
        timeout = timeout + 1
    end

    -- Check ob Model geladen wurde
    if not HasModelLoaded(modelHash) then
        print(string.format("^1[Model Test] ERROR: Model '%s' failed to load!^0", modelName))
        print("^1[Model Test] Possible issues:^0")
        print("^1  - .ydr file corrupted^0")
        print("^1  - .ytd texture missing^0")
        print("^1  - Model has errors in structure^0")
        return
    end

    print(string.format("^2[Model Test] ✓ Model loaded successfully!^0"))

    -- Spieler Position holen
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Position 2 Meter VOR dem Spieler berechnen
    local forwardX = playerCoords.x + (math.sin(math.rad(-playerHeading)) * 2.0)
    local forwardY = playerCoords.y + (math.cos(math.rad(-playerHeading)) * 2.0)
    local forwardZ = playerCoords.z

    -- Object spawnen
    local spawnedObject = CreateObject(
        modelHash,
        forwardX,
        forwardY,
        forwardZ,
        true,  -- networkObject
        false, -- netMissionEntity
        true   -- doorFlag
    )

    -- Check ob Object erstellt wurde
    if not DoesEntityExist(spawnedObject) then
        print(string.format("^1[Model Test] ERROR: Failed to spawn object!^0"))
        SetModelAsNoLongerNeeded(modelHash)
        return
    end

    print(string.format("^2[Model Test] ✓ Object spawned successfully!^0"))
    print(string.format("^2[Model Test] Entity ID: %s^0", spawnedObject))
    print(string.format("^2[Model Test] Position: %.2f, %.2f, %.2f^0", forwardX, forwardY, forwardZ))

    -- Object am Boden platzieren (gravity)
    PlaceObjectOnGroundProperly(spawnedObject)

    -- Model kann jetzt freigegeben werden
    SetModelAsNoLongerNeeded(modelHash)

    -- Success-Nachricht
    print("^2========================================^0")
    print("^2[Model Test] SUCCESS!^0")
    print("^2Look in front of you!^0")
    print("^3Use /deleteobj to remove it^0")
    print("^2========================================^0")
end, false)

-- =============================================================================
-- CLEANUP COMMAND
-- =============================================================================

RegisterCommand('deleteobj', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Suche nach Objects in 5m Radius
    local object = GetClosestObjectOfType(
        playerCoords.x,
        playerCoords.y,
        playerCoords.z,
        5.0,   -- Radius
        0,     -- modelHash (0 = alle)
        false, -- isMission
        false, -- isNetwork
        true   -- isAnything
    )

    if DoesEntityExist(object) then
        local objectModel = GetEntityModel(object)
        local objectName = GetHashKey(objectModel)

        DeleteObject(object)
        print(string.format("^2[Cleanup] Object deleted (Model: %s)^0", objectName))
    else
        print("^3[Cleanup] No object found nearby^0")
    end
end, false)

-- =============================================================================
-- INFO COMMAND
-- =============================================================================

RegisterCommand('modelinfo', function(source, args, rawCommand)
    local modelName = args[1] or 'w_am_fire_exting_water'
    local modelHash = GetHashKey(modelName)

    print("^3========== MODEL INFO ==========^0")
    print(string.format("^2Model Name:^0 %s", modelName))
    print(string.format("^2Model Hash:^0 %s", modelHash))
    print(string.format("^2In CdImage:^0 %s", IsModelInCdimage(modelHash) and "✓ YES" or "✗ NO"))
    print(string.format("^2Is Valid:^0 %s", IsModelValid(modelHash) and "✓ YES" or "✗ NO"))
    print("^3=================================^0")
end, false)


RegisterCommand('testweaponmodel', function(source, args, rawCommand)
    local weaponName = args[1] or 'WEAPON_FIREEXTINGUISHER_WATER'
    local weaponHash = GetHashKey(weaponName)

    print("^3========== WEAPON MODEL TEST ==========^0")
    print(string.format("^2Weapon Name:^0 %s", weaponName))
    print(string.format("^2Weapon Hash:^0 %s", weaponHash))

    -- Check ob Waffe gültig ist
    local isValid = IsWeaponValid(weaponHash)
    print(string.format("^2Weapon Valid:^0 %s", isValid and "✓ YES" or "✗ NO"))

    if not isValid then
        print("^1[ERROR] Weapon not registered in weapons.meta!^0")
        return
    end

    -- Waffe dem Spieler geben
    local playerPed = PlayerPedId()
    GiveWeaponToPed(playerPed, weaponHash, 2000, false, true)

    print("^2[SUCCESS] Weapon given to player!^0")

    -- Warte kurz
    Citizen.Wait(500)

    -- Prüfe ob Spieler die Waffe hat
    local hasWeapon = HasPedGotWeapon(playerPed, weaponHash, false)
    print(string.format("^2Player Has Weapon:^0 %s", hasWeapon and "✓ YES" or "✗ NO"))

    -- Setze Waffe als aktiv
    SetCurrentPedWeapon(playerPed, weaponHash, true)

    -- Hole Weapon Entity
    local weaponObject = GetCurrentPedWeaponEntityIndex(playerPed)

    if weaponObject ~= 0 and DoesEntityExist(weaponObject) then
        local weaponModel = GetEntityModel(weaponObject)
        print(string.format("^2Weapon Entity Exists:^0 ✓ YES (ID: %s)", weaponObject))
        print(string.format("^2Weapon Model Hash:^0 %s", weaponModel))

        -- Model Name herausfinden
        -- Vergleiche mit deinen Models
        local modelNames = {
            [GetHashKey('w_am_fire_exting_water')] = 'w_am_fire_exting_water',
            [GetHashKey('w_am_fire_exting_foam')] = 'w_am_fire_exting_foam',
            [GetHashKey('w_am_fire_exting_co2')] = 'w_am_fire_exting_co2',
            [GetHashKey('w_am_fire_exting_powder')] = 'w_am_fire_exting_powder',
            [GetHashKey('w_am_fire_exting')] = 'w_am_fire_exting (VANILLA)',
        }

        local modelName = modelNames[weaponModel] or "UNKNOWN"
        print(string.format("^2Active Model:^0 %s", modelName))

        if modelName == "UNKNOWN" then
            print("^1[WARNING] Weapon is using an unexpected model!^0")
            print("^3This might be why it's invisible!^0")
        end
    else
        print("^1Weapon Entity:^0 ✗ NOT FOUND!")
        print("^1[ERROR] The weapon exists but has no 3D model attached!^0")
        print("^3Possible causes:^0")
        print("^3  1. Model file is missing weapon bones^0")
        print("^3  2. weaponarchetypes.meta not loaded^0")
        print("^3  3. Model structure is incompatible^0")
    end

    print("^3========================================^0")
end, false)
