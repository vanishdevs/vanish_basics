local PlayerData   = {}
local notificationShown = false

-- Add the hash values for ambulance and police vehicles
local restrictedVehicles = {
    GetHashKey('firetruk'),
    -- EMS Vehicles
    GetHashKey('ambulance'),
    GetHashKey('fdnyambo'),
    GetHashKey('release2'),
    GetHashKey('pdcaprice'),
    GetHashKey('dodgeems'),
    GetHashKey('20explo'),
    -- Police Vehicles
    GetHashKey('14pdcharger'),
    GetHashKey('16explorer'),
    GetHashKey('16taurus'),
    GetHashKey('11caprice'),
    GetHashKey('18charger'),
    GetHashKey('18tahoe'),
    GetHashKey('19durango'),
    GetHashKey('R1CUSTOM'),
    GetHashKey('21ramtrx'),
    GetHashKey('20camaro'),
    GetHashKey('bear01'),
    GetHashKey('mraprb'),
    GetHashKey('21ramtrx'),
    GetHashKey('polp50'),
    GetHashKey('sou_chargerpd'),
    GetHashKey('sou_demonpd'),
    GetHashKey('segway'),
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local playerPed = GetPlayerPed(-1)
        PlayerData = ESX.GetPlayerData()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        if vehicle ~= nil then
            local driverSeat = GetPedInVehicleSeat(vehicle, -1)
            local vehicleModel = GetEntityModel(vehicle)
            
            -- Check if the vehicle model hash is in the restrictedVehicles table
            if IsModelInTable(vehicleModel, restrictedVehicles) and driverSeat == playerPed then
                -- Check if the player's job is not police or ambulance
                if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then
                    if not notificationShown then
                        TriggerEvent('esx:showNotification', "You are not allowed to drive this vehicle.")
                        notificationShown = true
                    end
                    TaskLeaveVehicle(playerPed, vehicle, 0)
                else
                    notificationShown = false
                end
            else
                notificationShown = false
            end
        end
    end
end)

function IsModelInTable(model, hashTable)
    for _, value in ipairs(hashTable) do
        if model == value then
            return true
        end
    end
    return false
end