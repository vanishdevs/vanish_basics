local Config = lib.load('shared/sh_main')

local function performBasics()
    
    if Config.EnableCustomAbilities then
        StatSetInt('MP0_SHOOTING_ABILITY', Config.Abilities.Shooting, true)
        StatSetInt('MP0_STAMINA', Config.Abilities.Stamina, true)
        StatSetInt('MP0_LUNG_CAPACITY', Config.Abilities.LungCapacity, true)
        StatSetInt('MP0_STEALTH_ABILITY', Config.Abilities.Stealth, true)
    end

    if Config.EnableCustomMovement then
        SetPedMoveRateOverride(PlayerId(), Config.MovementSettings.MoveRate)
        SetRunSprintMultiplierForPlayer(PlayerId(), Config.MovementSettings.SprintMultiplier)
    end   
        
    while true do
        local playerPed = cache.ped
        local playerId = cache.playerId
    	local playerLocalisation = GetEntityCoords(playerPed)
        local playerVehicle = GetVehiclePedIsIn(playerPed)

        -- Disable the default GTA radio
        if Config.DisableGTAradio and playerVehicle ~= 0 then
            SetVehicleRadioEnabled(playerVehicle, false)
        end

        -- Disable Vehicle Rewards
        if Config.DisablePlayerRewards then
         DisablePlayerVehicleRewards(playerId)
        end
        
        -- Clearing the area from cops and any army personnel
        if Config.ClearCops then
            ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
        end

        -- Remove Pistol Whipping
        if Config.DisablePistolWhipping and IsPedArmed(playerPed, 6) then
	   		DisableControlAction(1, 140, true)
       	   	DisableControlAction(1, 141, true)
           	DisableControlAction(1, 142, true)
        end
        
        -- Disable dispatch service and wanted level
        if Config.DisableDispatchComponents then
            for i = 1, 12 do
                EnableDispatchService(i, false)
            end
        end
        
        -- Vehicle density settings
        if Config.CustomizeVehicleDamage then
            N_0x4757f00bc6323cfe(-1553120962, Config.VehicleDamagePerHit)
        end

        Wait(0)
    end
end

CreateThread(performBasics)