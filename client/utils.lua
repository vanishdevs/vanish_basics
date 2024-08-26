-- @param x (number) The x coordinate.
-- @param y (number) The y coordinate.
-- @param z (number) The z coordinate.
-- @param text (string) The text to display.
-- @param player (number) The player id.
function Draw3DText(x, y, z, text, player)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8 * (1 / dist) * (1 / GetGameplayCamFov()) * 100

        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        if NetworkIsPlayerTalking(player) then 
            SetTextColour(255, 0, 0, 255)
        else
            SetTextColour(255, 255, 255, 255)
        end
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
