ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Coordinates where the player can spawn
local spawnLocation = vector3(449.2397, -981.1707, 43.6913)

function hasPoliceJob()
    local playerJob = ESX.GetPlayerData().job.name
    return playerJob == 'police'
end

function spawnHelicopter()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if hasPoliceJob() then
        local distance = #(playerCoords - spawnLocation)
        if distance <= 10.0 then
            RequestModel(GetHashKey("polmav"))
            while not HasModelLoaded(GetHashKey("polmav")) do
                Wait(10)
            end

            local heli = CreateVehicle(GetHashKey("polmav"), spawnLocation, GetEntityHeading(playerPed), true, false)
            SetEntityAsMissionEntity(heli, true, true)
            SetVehicleHasBeenOwnedByPlayer(heli, true)
            SetVehicleOnGroundProperly(heli)
            SetModelAsNoLongerNeeded(GetHashKey("polmav"))

            SetPedIntoVehicle(playerPed, heli, -1)
        end
    else
        exports.pNotify:SendNotification(
                {
                    text = "You must be a police officer to spawn a helicopter.",
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter"
                }
            )
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - spawnLocation)
        
        if distance <= 10.0 then
            DrawMarker(2, spawnLocation.x, spawnLocation.y, spawnLocation.z - 0.1, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 0, 255, 0, 200, false, true, 2, nil, nil, false)
        end

        if distance <= 5.0 and IsControlJustPressed(0, 38) then -- Change the control here if needed (default: 'E')
            spawnHelicopter()
        end
    end
end)