local reviveCoords = {x = 424.4551, y = -978.4716, z = 30.7117} -- Set your desired coordinates here

RegisterCommand("gotopd", function(source, args)
    if args[1] then
        local playerId = tonumber(args[1])
        if playerId and playerId ~= PlayerId() then
            local isPlayerDead = exports["ufg-ambulance"]:isPlayerDead(playerId)
            if isPlayerDead then
                local playerData = ESX.GetPlayerData(GetPlayerServerId(playerId))
                local job = playerData.job
                if job and job.name == "police" then
                    NetworkResurrectLocalPlayer(reviveCoords.x, reviveCoords.y, reviveCoords.z, true, true, false)
                    -- ADD your own revive trigger  or use TriggerEvent('wasabi_ambulance:revive', playerId)
                    TriggerEvent("chatMessage", "^*^4[Police System]^0^r", {255, 255, 255}, "You have been revived and transported to the police department.")
                else
                    TriggerEvent("chatMessage", "^*^4[Police System]^0^r", {255, 255, 255}, "The specified player does not have the police job.")
                end
            else
                TriggerEvent("chatMessage", "^*^4[Police System]^0^r", {255, 255, 255}, "The specified player is not dead.")
            end
        else
            TriggerEvent("chatMessage", "^*^4[Police System]^0^r", {255, 255, 255}, "Invalid player ID.")
        end
    else
        TriggerEvent("chatMessage", "^*^4[Police System]^0^r", {255, 255, 255}, "Please specify a player ID.")
    end
end)


