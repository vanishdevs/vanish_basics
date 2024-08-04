return {
    EnableCustomAbilities = true,
    Abilities = {
        Shooting = 120,
        Stamina = 100,
        Stealth = 100,
        LungCapacity = 100
    },

    EnableCustomMovement = true,
    MovementSettings = {
        MoveRate = 2.8,
        SprintMultiplier = 1.7
    },

    DisableHudComponents = true,
    HudComponents = {
        [1] = true,
        [2] = false,
        [3] = true,
        [4] = true,
        [5] = false,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = false,
        [11] = false,
        [12] = false,
        [13] = true,
        [14] = false,
        [15] = false,
        [16] = true,
        [17] = false,
        [18] = false,
        [19] = false,
        [20] = false,
        [21] = true,
        [22] = true
    },

    AdjustPopulationBudgets = true,
    Budgets = {
        PedPopulation = 0,
        VehiclePopulation = 0,
        ParkedPopulation = 0
    },

    CalmAI = true,
    Relationships = {
        `AMBIENT_GANG_HILLBILLY`,
        `AMBIENT_GANG_BALLAS`,
        `AMBIENT_GANG_MEXICAN`,
        `AMBIENT_GANG_FAMILY`,
        `AMBIENT_GANG_MARABUNTE`,
        `AMBIENT_GANG_SALVA`,
        `GANG_1`,
        `GANG_2`,
        `GANG_9`,
        `GANG_10`,
        `FIREMAN`,
        `MEDIC`,
        `COP`
    },

    ClearBoats = true,
    ClearTrains = true,
    ClearGarabageTrucks = true,
    ClearCops = true,

    DisableGTAradio = true,
    DisablePedLosingProps = true,
    DisableDispatchComponents = true,
    DisableIdleCamera = true,
    DisableVehicleDistantlights = true,
    DisableNPCWeaponDrops = true,

    CustomizeVehicleDamage = true,
    VehicleDamagePerHit = 20
}