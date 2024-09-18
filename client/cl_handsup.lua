local Config = lib.load('shared.sh_handsup')

local animDict = 'random@mugging3'
local animName = 'handsup_standing_base'
local handsUp = false

---@param playerPed (number) The specified player
---@return (boolean) Whether the player is allowed to raise their hands
local function IsPlayerAllowedToRaiseHands(playerPed)
    return not IsPedInAnyVehicle(playerPed, false) and
           not IsPedSwimming(playerPed) and
           not IsPedShooting(playerPed) and
           not IsPedClimbing(playerPed) and
           not IsPedCuffed(playerPed) and
           not IsPedDiving(playerPed) and
           not IsPedFalling(playerPed) and
           not IsPedJumping(playerPed) and
           not IsPedJumpingOutOfVehicle(playerPed) and
           IsPedOnFoot(playerPed) and
           not IsPedRunning(playerPed) and
           not IsPedUsingAnyScenario(playerPed) and
           not IsPedInParachuteFreeFall(playerPed)
end

---@param EnableHandsUp (boolean) Enable or disable the hands up
local function performHandsUp(EnableHandsUp)
    lib.requestAnimDict(animDict, 500)

    while EnableHandsUp do
        local playerPed = cache.ped

        if handsUp then
            if IsPlayerAllowedToRaiseHands(playerPed) then
                if not IsEntityPlayingAnim(playerPed, animDict, animName, 3) then
                    TaskPlayAnim(playerPed, animDict, animName, 2.5, -2.5, -1, 49, 0, 0, 0, 0)
                end
            end
        else
            if IsEntityPlayingAnim(playerPed, animDict, animName, 3) then
                ClearPedTasks(playerPed)
            end
        end

        Wait(0)
    end
end

CreateThread(function() performHandsUp(Config.EnableHandsUp) end)

if Config.EnableHandsUp then
    RegisterCommand('+' .. Config.CommandName, function() handsUp = true end, false)
    RegisterCommand('-' .. Config.CommandName, function() handsUp = false end, false)
    RegisterKeyMapping('+' .. Config.CommandName, 'Hands Up', 'keyboard', Config.Keybind)
    Debug('Command handsup has been registered and its keybind has been set to ' .. Config.Keybind)
end