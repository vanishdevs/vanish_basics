local Config = lib.load('shared/sh_main')

local function performBasics()
    local playerPed = cache.ped
    local playerId = cache.playerId

    if Config.EnableCustomAbilities then
        StatSetInt('MP0_SHOOTING_ABILITY', Config.Abilities.Shooting, true)
        StatSetInt('MP0_STAMINA', Config.Abilities.Stamina, true)
        StatSetInt('MP0_LUNG_CAPACITY', Config.Abilities.LungCapacity, true)
        StatSetInt('MP0_STEALTH_ABILITY', Config.Abilities.Stealth, true)
    end

    if Config.EnableCustomMovement then
        SetPedMoveRateOverride(playerId, Config.MovementSettings.MoveRate)
        SetRunSprintMultiplierForPlayer(playerId, Config.MovementSettings.SprintMultiplier)
    end
    
    if Config.DisableDispatchComponents then
        for i = 1, 12 do
            EnableDispatchService(i, false)
        end
    end

    if Config.DisableHudComponents then
        for i = 1, #Config.HudComponents do
            local component = Config.HudComponents[i]

            if component then
                SetHudComponentPosition(i, 999999.0, 999999.0)
            end
        end
    end

    if Config.AdjustPopulationBudgets then
        SetPedPopulationBudget(Config.Budgets.PedPopulation)
        SetVehiclePopulationBudget(Config.Budgets.VehiclePopulation)
        SetNumberOfParkedVehicles(Config.Budgets.ParkedPopulation)
    end

    SetRandomBoats(not Config.ClearBoats)
    SetRandomTrains(not Config.ClearTrains)
    SetGarbageTrucks(not Config.ClearGarabageTrucks)

    SetCreateRandomCops(not Config.ClearCops)
    SetCreateRandomCopsNotOnScenarios(not Config.ClearCops)
    SetCreateRandomCopsOnScenarios(not Config.ClearCops)

    DisableIdleCamera(Config.DisableIdleCamera)
    DisableVehicleDistantlights(Config.DisableVehicleDistantlights)

    while true do
        playerPed = cache.ped
        playerId = cache.playerId

        if Config.DisableGTAradio and IsPedInAnyVehicle(playerPed, false) then
            SetVehicleRadioEnabled(GetVehiclePedIsIn(playerPed), false)
        end

        if Config.DisablePedLosingProps then
            SetPedCanLosePropsOnDamage(playerPed, false, 0)
        end
        
        if Config.CustomizeVehicleDamage then
            N_0x4757f00bc6323cfe(-1553120962, Config.VehicleDamagePerHit)
        end

        Wait(1000)
    end
end

CreateThread(performBasics)