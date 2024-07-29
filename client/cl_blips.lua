local Config = lib.load('shared/sh_blips')

local CreateCustomBlips(EnableBlips, BlipsTable)
    if EnableBlips then
        for _, blipInfo in pairs(BlipsTable) do
            blipInfo.blip = AddBlipForCoord(blipInfo.coords.x, blipInfo.coords.y, blipInfo.coords.z)
            SetBlipSprite(blipInfo.blip, blipInfo.id)
            SetBlipDisplay(blipInfo.blip, 4)
            SetBlipScale(blipInfo.blip, blipInfo.scale)
            SetBlipColour(blipInfo.blip, blipInfo.colour)
            SetBlipAsShortRange(blipInfo.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipInfo.title)
            EndTextCommandSetBlipName(blipInfo.blip)
        end
    end
end

CreateThread(CreateCustomBlips(Config.EnableCustomBlips, Config.Blips))
