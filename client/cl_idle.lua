local Config = lib.load('shared/sh_idle')
local isIdlePlaying = false
local lastActionTime = 0
local idleTimeout = 30000

local function performIdleFunctions(EnableCustomIdle)
    lib.requestAnimDict("move_m@generic_idles@std", 500)
    while EnableCustomIdle do
        local playerPed = cache.ped
        local sleepThread = 0

        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35) then
                lastActionTime = GetGameTimer()
            end
            
            if GetGameTimer() - lastActionTime > idleTimeout then
                if not isIdlePlaying then
                    TaskPlayAnim(playerPed, "move_m@generic_idles@std", "idle", 8.0, -8, -1, 49, 0, false, false, false)
                    isIdlePlaying = true
                end
            else
                sleepThread = 5000
            end
        end

        Wait(sleepThread)
    end
end

CreateThread(function() performIdleFunctions(Config.EnableCustomIdle) end)