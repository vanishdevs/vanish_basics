local Config = lib.load('shared.sh_antitheft')

local notificationShown = false

---@param model (number) The model to check if it is in the table
---@param hashTable (table) The table to check if the model is in
local function IsModelInTable(model, hashTable)
    for _, value in ipairs(hashTable) do
        if model == value then
            Debug('IsModelInTable: Model found in table ' .. model)
            return true
        end
    end

    Debug('IsModelInTable: Model not found in table')
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
                Debug('AntiTheft: Player has been kicked out of the vehicle')
            else
                notificationShown = false
                Debug('AntiTheft: Player is allowed to sit in the vehicle')
            end
        end

        Wait(500)
    end
end


CreateThread(function() antiTheft(Config.EnableAntiTheft, Config.RestrictedVehicles) end)