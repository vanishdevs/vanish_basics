local Config = lib.load('shared/sh_idle')

local isIdlePlaying = false
local lastActionTime = 0
local idleTimeout = 30000
local controlKeys = { 32, 33, 34, 35 }

---@param modelType (string) The model type to get the animation settings for
---@return (string, string, number) The animation dictionary, animation name, and animation flag
local function getAnimationSettings(modelType)
    local animSettings = Config.AnimSettings[modelType]
    return animSettings.Dict, animSettings.Anim, animSettings.Flag
end

---@return (boolean) Check if the control keys are pressed
local function controlPressed()
    for _, key in ipairs(controlKeys) do
        if IsControlPressed(0, key) then
            return true
        end
    end
    return false
end

---@param EnableCustomIdle (boolean) Enable or disable the custom idle
local function performIdleFunctions(EnableCustomIdle)
    local maleAnimDict, maleAnim, maleAnimFlag = getAnimationSettings('Male')
    local femaleAnimDict, femaleAnim, femaleAnimFlag = getAnimationSettings('Female')

    lib.requestAnimDict(maleAnimDict, 500)
    lib.requestAnimDict(femaleAnimDict, 500)

    while EnableCustomIdle do
        local playerPed = cache.ped
        local playerModel = GetEntityModel(playerPed)
        local determineModel = playerModel == `mp_m_freemode_01` and `mp_m_freemode_01` or playerModel == `mp_f_freemode_01` and `mp_f_freemode_01` or false
        local mainAnimDict, mainAnim, mainAnimFlag

        if not determineModel then
            Debug('performIdleFunctions: Proper player model not found, waiting...' .. '\nCurrent model: ' .. playerModel)
            Wait(5000)
        else
            if determineModel == `mp_m_freemode_01` then
                mainAnimDict, mainAnim, mainAnimFlag = maleAnimDict, maleAnim, maleAnimFlag
                Debug('performIdleFunctions: Player model is male, successfully loaded needed variables')
            else
                mainAnimDict, mainAnim, mainAnimFlag  = femaleAnimDict, femaleAnim, femaleAnimFlag
                Debug('performIdleFunctions: Player model is female, successfully loaded needed variables')
            end
        end

        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if controlPressed() then
                lastActionTime = GetGameTimer()
            end
            
            if GetGameTimer() - lastActionTime > idleTimeout and not isIdlePlaying then
                TaskPlayAnim(playerPed, mainAnimDict, mainAnim, 8.0, -8, -1, mainAnimFlag, 0, false, false, false)
                isIdlePlaying = true
                Debug('performIdleFunctions: Idle animation started')
            end
        end

        Wait(0)
    end
end

CreateThread(function() performIdleFunctions(Config.EnableCustomIdle) end)