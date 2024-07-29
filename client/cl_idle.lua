local Config = lib.load('shared/sh_idle')
local isIdlePlaying = false
local lastActionTime = 0
local idleTimeout = 30000

local performIdleFunctions(EnableCustomIdle)
    while EnableCustomIdle do
        local playerPed = cache.ped

        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
            if IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35) then

                lastActionTime = GetGameTimer()
            end
            
            if GetGameTimer() - lastActionTime > idleTimeout then
                if not isIdlePlaying then
                    RequestAnimDict("move_m@generic_idles@std")
                    if HasAnimDictLoaded("move_m@generic_idles@std") then
                        TaskPlayAnim(playerPed, "move_m@generic_idles@std", "idle", 8.0, -8, -1, 49, 0, false, false, false)
                        isIdlePlaying = true
                    end
                end
            end
        
        Wait(0)
    end
end

CreateThread(performIdleFunctions(Config.EnableCustomIdle))