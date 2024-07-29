local Config = lib.load('shared/sh_discord')

local function DiscordStatus(EnableDiscordStatus)
    local player = cache.playerId
    local name = GetPlayerName(player)

    while EnableDiscordStatus do
        local playerCount = lib.callback.await('vanishdev:server:getNumIndices', false)
		SetDiscordAppId(Config.ApplicationId)
        SetRichPresence(playerCount .. " players")
		SetDiscordRichPresenceAsset(Config.LargeImageName)
        SetDiscordRichPresenceAssetText('[' .. cache.serverId .. '] ' .. name)
        SetDiscordRichPresenceAction(0, "Discord", Config.DiscordInvite)
        SetDiscordRichPresenceAction(1, "Store", Config.StoreLink)
		Wait(60000)
    end
end

CreateThread(DiscordStatus(Config.EnableDiscordStatus))