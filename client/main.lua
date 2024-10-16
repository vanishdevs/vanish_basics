local Config = lib.load('shared.sh_main')

local function performBasics()
    local playerPed = cache.ped
    local playerId = cache.playerId
    local pedindex = {}

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

    if Config.CalmAI then
        for i = 1, #Config.Relationships do
            SetRelationshipBetweenGroups(1, Config.Relationships[i], `PLAYER`)
        end
    end

    if Config.DisableWantedLevel then
        SetMaxWantedLevel(0)
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
        local pedIterator, currentPed = FindFirstPed()
        local hasFinished = false

        playerPed = cache.ped
        playerId = cache.playerId

        if Config.DisableGTAradio and IsPedInAnyVehicle(playerPed, false) then
            SetVehicleRadioEnabled(GetVehiclePedIsIn(playerPed), false)
        end

        if Config.DisablePedLosingProps then
            SetPedCanLosePropsOnDamage(playerPed, false, 0)
        end

        if Config.DisableNPCWeaponDrops then
            repeat 
                if not IsEntityDead(currentPed) then
                    pedindex[currentPed] = {}
                end
                hasFinished, currentPed = FindNextPed(pedIterator)
            until not hasFinished

            EndFindPed(pedIterator)

            for _, ped in pairs(pedindex) do
                if ped then
                    SetPedDropsWeaponsWhenDead(ped, false) 
                end
            end
        end
        
        if Config.DisableScenerios then
            for i = 1, #Config.Scenerios.Groups do
                SetScenarioGroupEnabled(Config.Scenerios.Groups[i], false)
            end
            for i = 1, #Config.Scenerios.Types do
                SetScenarioTypeEnabled(Config.Scenerios.Types[i], false)
            end
        end

        if Config.SuppressCarModels then
            for i = 1, #Config.SuppressedCarModels do
                SetVehicleModelIsSuppressed(Config.SuppressedCarModels[i], true)
            end
        end

        Wait(1000)
    end
end

CreateThread(performBasics)