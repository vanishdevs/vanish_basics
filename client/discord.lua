local playerCount = 0
RegisterNetEvent('vanishdev:client:GetActivePlayers', function(count)
    playerCount = count
end)

local function DiscordStatus()
    local player = cache.playerId
    local name = GetPlayerName(player)

    while Config.EnableDiscordStatus do
        ---@diagnostic disable-next-line: param-type-mismatch
		SetDiscordAppId(1258642836849430538)
        TriggerServerEvent('vanishdev:server:GetActivePlayers')
        SetRichPresence(playerCount .. " players")
		SetDiscordRichPresenceAsset('paradiselogo')
        SetDiscordRichPresenceAssetText('[' .. cache.serverId .. '] ' .. name)
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/lostparadise")
        SetDiscordRichPresenceAction(1, "Store", "https://lostparadise.tebex.io")
		Wait(60000)
    end
end

CreateThread(DiscordStatus)