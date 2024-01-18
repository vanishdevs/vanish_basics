Citizen.CreateThread(function()

    if(Recoilcfg.UseCustomWeaponDamages)then
        for k, v in pairs(Recoilcfg.BetterFight) do
            Citizen.Wait(50)
            SetWeaponDamageModifier(v.hash, v.damageMultiplier) 
        end
    end

end)