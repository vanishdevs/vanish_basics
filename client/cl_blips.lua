local blips = {
    { title = "Codeine Factory", colour = 27, id = 51, coords = vector3(-225.42, -2654.5, 6.0) },
    { title = "Codeine Sales", colour = 27, id = 51, coords = vector3(1274.2983, -1711.9562, 54.7715) },
    { title = "Coke Farm", colour = 3, id = 514, coords = vector3(1384.1650, -591.9813, 74.3389) },
    { title = "Coke Sales", colour = 3, id = 514, coords = vector3(-73.93, -1515.68, 34.25) },
    { title = "Fish Sales", colour = 3, id = 499, coords = vector3(-3420.1855, 968.8636, 8.3467) },
    { title = "Crack House", colour = 0, id = 403, coords = vector3(-1585.73, 198.65, 60.25) },
    { title = "Angel Dust Farm", colour = 0, id = 403, coords = vector3(4519.62, -4535.34, 3.28) },
    { title = "Acid Farm", colour = 2, id = 403, coords = vector3(2330.64, 2572.27, 46.68) },
    { title = "Fentanyl Farm", colour = 3, id = 403, coords = vector3(1575.25, 3588.81, 35.36) },
    { title = "La Mesa Projects", colour = 1, id = 403, coords = vector3(692.13, -918.26, 35.36) },
    { title = "Court House", colour = 4, id = 89, coords = vector3(243.4026, -1077.0171, 29.2941) },
    { title = "Loot Crates", colour = 71, id = 58, coords = vector3(13.97, -1823.77, 24.96) },
    { title = "The Law Firm", colour = 4, id = 408, coords = vector3(-116.79, -607.57, 74.6267) },
    -- Commented Out Blips
}


Citizen.CreateThread(function()
    for _, blipInfo in pairs(blips) do
        blipInfo.blip = AddBlipForCoord(blipInfo.coords.x, blipInfo.coords.y, blipInfo.coords.z)
        SetBlipSprite(blipInfo.blip, blipInfo.id)
        SetBlipDisplay(blipInfo.blip, 4)
        SetBlipScale(blipInfo.blip, 1.0)
        SetBlipColour(blipInfo.blip, blipInfo.colour)
        SetBlipAsShortRange(blipInfo.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipInfo.title)
        EndTextCommandSetBlipName(blipInfo.blip)
    end
end)



