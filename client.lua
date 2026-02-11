-- 1. PARTIKEL LADEN (mit Timeout-Schutz)
local ptfxAssets = {
    "core",
    "veh_extinguish"     -- Falls das fehlt, überspringt er es jetzt nach 2 Sekunden
}

for _, asset in ipairs(ptfxAssets) do
    RequestNamedPtfxAsset(asset)
    local timeout = 0
    while not HasNamedPtfxAssetLoaded(asset) and timeout < 200 do     -- max 2 Sekunden warten
        Citizen.Wait(10)
        timeout = timeout + 1
    end

    if HasNamedPtfxAssetLoaded(asset) then
        print(string.format("^5[FD Custom Weapons] Partikel geladen: %s^0", asset))
    else
        print(string.format("^3[FD Custom Weapons] Partikel übersprungen (nicht gefunden): %s^0", asset))
    end
end
