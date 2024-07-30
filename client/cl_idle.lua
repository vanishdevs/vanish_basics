local Config = lib.load('shared/sh_idle')

local isIdlePlaying = false
local lastActionTime = 0
local idleTimeout = 30000
local controlKeys = { 32, 33, 34, 35 }

local idleAnimDict = Config.AnimSettings.Dict
local idleAnim = Config.AnimSettings.Anim
local idleAnimFlag = Config.AnimSettings.Flag

local function controlPressed()
    for _, v in ipairs(controlKeys) do
        if IsControlPressed(0, v) then
            return true
        end
    end
    return false
end

local function performIdleFunctions(EnableCustomIdle)
    lib.requestAnimDict(idleAnimDict, 500)

    while EnableCustomIdle do
        local playerPed = cache.ped

        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if controlPressed() then
                lastActionTime = GetGameTimer()
            end
            
            if GetGameTimer() - lastActionTime > idleTimeout then
                if not isIdlePlaying then
                    TaskPlayAnim(playerPed, idleAnimDict, idleAnim, 8.0, -8, -1, idleAnimFlag, 0, false, false, false)
                    isIdlePlaying = true
                end
            end
        end

        Wait(0)
    end
end

CreateThread(function() performIdleFunctions(Config.EnableCustomIdle) end)