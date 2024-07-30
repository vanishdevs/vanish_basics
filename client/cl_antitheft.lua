local Config = lib.load('shared/sh_antitheft')

local notificationShown = false

local function IsModelInTable(model, hashTable)
    for _, value in ipairs(hashTable) do
        if model == value then
            return true
        end
    end
    return false
end

local function antiTheft(EnableAntiTheft, RestrictedVehicles)
    while EnableAntiTheft do
        local playerPed = cache.ped
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
        
        if playerVehicle then
            local driverSeat = GetPedInVehicleSeat(playerVehicle, -1)
            local vehicleModel = GetEntityModel(playerVehicle)
            
            if IsModelInTable(vehicleModel, RestrictedVehicles) and driverSeat == playerPed then
                if not notificationShown then
                    ShowNotification('You are not allowed to be seated in this vehicle')
                    notificationShown = true
                end
                TaskLeaveVehicle(playerPed, playerVehicle, 0)
            else
                notificationShown = false
            end
        end

        Wait(500)
    end
end


CreateThread(function() antiTheft(Config.EnableAntiTheft, Config.RestrictedVehicles) end)