local Config = lib.load('shared/sh_idle')

local isIdlePlaying = false
local lastActionTime = 0
local idleTimeout = 30000
local controlKeys = { 32, 33, 34, 35 }

local function getAnimationSettings(modelType)
    local animSettings = Config.AnimSettings[modelType]
    return animSettings.Dict, animSettings.Anim, animSettings.Flag
end

local function controlPressed()
    for _, key in ipairs(controlKeys) do
        if IsControlPressed(0, key) then
            return true
        end
    end
    return false
end

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
            Wait(5000)
        else
            if determineModel == `mp_m_freemode_01` then
                mainAnimDict, mainAnim, mainAnimFlag = maleAnimDict, maleAnim, maleAnimFlag
            else
                mainAnimDict, mainAnim, mainAnimFlag  = femaleAnimDict, femaleAnim, femaleAnimFlag
            end
        end

        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if controlPressed() then
                lastActionTime = GetGameTimer()
            end
            
            if GetGameTimer() - lastActionTime > idleTimeout and not isIdlePlaying then
                TaskPlayAnim(playerPed, mainAnimDict, mainAnim, 8.0, -8, -1, mainAnimFlag, 0, false, false, false)
                isIdlePlaying = true
            end
        end

        Wait(0)
    end
end

CreateThread(function() performIdleFunctions(Config.EnableCustomIdle) end)