local ambulanceSpawnLocation = vector3(352.0959, -587.9178, 74.1617) -- Replace with actual coordinates
local policeSpawnLocation = vector3(449.2397, -981.1707, 43.6913) -- Replace with actual coordinates

local ambulanceSpawned = false
local policeSpawned = false

local ambulanceModel = "polmav"
local policeModel = "polmav"


local function loadModels()
    RequestModel(ambulanceModel)
    RequestModel(policeModel)
    while not HasModelLoaded(ambulanceModel) or not HasModelLoaded(policeModel) do
        Wait(500) -- Increased wait time to 500 milliseconds
    end
end

local function spawnVehicle(model, spawnLocation)
    local playerPed = PlayerPedId()
    local heli = CreateVehicle(GetHashKey(model), spawnLocation.x, spawnLocation.y, spawnLocation.z, GetEntityHeading(playerPed), true, false)
    SetEntityAsMissionEntity(heli, true, true)
    SetVehicleHasBeenOwnedByPlayer(heli, true)
    SetVehicleOnGroundProperly(heli)
    SetModelAsNoLongerNeeded(GetHashKey(model))
    SetPedIntoVehicle(playerPed, heli, -1)
end

function hasAmbulanceJob()
    local playerJob = ESX.GetPlayerData().job.name
    return playerJob == 'ambulance'
end

function hasPoliceJob()
    local playerJob = ESX.GetPlayerData().job.name
    return playerJob == 'police'
end

Citizen.CreateThread(function()
    loadModels()

    while true do
        Citizen.Wait(10) -- Increased wait time to 1000 milliseconds (1 second)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local ambulanceDistance = #(playerCoords - ambulanceSpawnLocation)
        local policeDistance = #(playerCoords - policeSpawnLocation)

        if ambulanceDistance <= 10.0 then
            DrawMarker(2, ambulanceSpawnLocation.x, ambulanceSpawnLocation.y, ambulanceSpawnLocation.z - 0.1, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 0, 255, 0, 200, false, true, 2, nil, nil, false)
            if ambulanceDistance <= 5.0 then
                ShowHelpNotification("Press ~INPUT_CONTEXT~ to retrieve an ambulance helicopter")
                if IsControlJustPressed(0, 38) and hasAmbulanceJob() and not ambulanceSpawned then
                    spawnVehicle(ambulanceModel, ambulanceSpawnLocation)
                    ambulanceSpawned = true
                end
            end
        end

        if policeDistance <= 10.0 then
            DrawMarker(2, policeSpawnLocation.x, policeSpawnLocation.y, policeSpawnLocation.z - 0.1, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 255, 0, 0, 200, false, true, 2, nil, nil, false)
            if policeDistance <= 5.0 then
                ShowHelpNotification("Press ~INPUT_CONTEXT~ to retrieve a police helicopter")
                if IsControlJustPressed(0, 38) and hasPoliceJob() and not policeSpawned then
                    spawnVehicle(policeModel, policeSpawnLocation)
                    policeSpawned = true
                end
            end
        end
        
        -- Reset spawned flags when the player is far enough from the helicopters
        if ambulanceDistance > 5.0 then
            ambulanceSpawned = false
        end
        if policeDistance > 5.0 then
            policeSpawned = false
        end
    end
end)


function ShowHelpNotification(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
