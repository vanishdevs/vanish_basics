local Config = lib.load('shared/sh_toggleid')
local showID = false

local function GetNeareastPlayers()
	local playerPed = cache.ped
	local players_clean = {}

	for _, player in pairs(GetActivePlayers()) do
		local playerCoords = GetEntityCoords(GetPlayerPed(player))
		if #(playerCoords - GetEntityCoords(playerPed)) <= 30.0 then
			players_clean[#players_clean + 1] = {
				playerName = GetPlayerName(player),
				player = player,
				playerId = GetPlayerServerId(player),
				coords = playerCoords
			}
		end
	end
	return players_clean
end

-- @param EnableToggleId (boolean) Enable or disable the toggle id in while loop
local function performToggleId(EnableToggleId)
    while EnableToggleId do
        if showID then              
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local x, y, z = table.unpack(v.coords)
                
                if Config.DisableAllControls then
                    DisableAllControlActions(0)
                    EnableControlAction(0, 166, true)
                    Debug('PerformToggleId: Disabling all controls')
                end

                Draw3DText(x, y, z + 1.1, v.playerId, v.player)
            end
        end

        Wait(0)
    end
end

CreateThread(function() performToggleId(Config.EnableToggleId) end)

if Config.EnableToggleId then
    RegisterCommand('+' .. Config.CommandName, function() showID = true if Config.SoundSettings.play then PlaySoundFrontend(Config.SoundSettings.soundId, Config.SoundSettings.audioName, Config.SoundSettings.audioRef, true) end end, false)
    RegisterCommand('-' .. Config.CommandName, function() showID = false end, false)
    RegisterKeyMapping('+' .. Config.CommandName, 'Show IDs above peoples head', 'keyboard', Config.Keybind)
    Debug('Command ' .. Config.CommandName .. ' has been registered and its keybind has been set to ' .. Config.Keybind)
end
