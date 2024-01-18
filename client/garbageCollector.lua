viewcamforcer = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        collectgarbage("collect")
    end 
end)

Citizen.CreateThread(function()
    while true do
        globalPed = GetPlayerPed(-1)
        globalPlayerPedId = PlayerPedId()
        globalPlayerId = PlayerId()
        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
    while true do
        vehicleViewCam = GetFollowVehicleCamViewMode()
        viewCam = GetFollowPedCamViewMode()
        globalIsPedArmed = IsPedArmed(globalPlayerPedId, 6)
        globalIsPlayerFreeAiming = IsPlayerFreeAiming(globalPlayerId)
        Citizen.Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
    globalIsPedInAnyVehicle = IsPedInAnyVehicle(globalPed,false)
    Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
    _, globalGetCurrentWeapon = GetCurrentPedWeapon(globalPed, true)
    Citizen.Wait(200)
    end
end)

