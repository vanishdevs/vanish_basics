local rightleft = 3

local function update_rightleft(value)
    rightleft = value
end

Citizen.CreateThread(function()
	while Recoilcfg.UseRecoil do 
        Citizen.Wait(7)
            local ply = globalPlayerPedId
            
            if IsPedShooting(globalPed) then      
                local wep = GetCurrentPedWeapon(ply)
                local _,cAmmo = GetAmmoInClip(ply, wep)
                

                local GamePlayCam = viewCam
                local Vehicled = globalIsPedInAnyVehicle
                local MovementSpeed = math.ceil(GetEntitySpeed(ply))

                if MovementSpeed > 69 then
                    MovementSpeed = 69
                end
                Citizen.Wait(50)
                local wep = globalGetCurrentWeapon
                
                
                if wep ~= 126349499 then
                    local group = GetWeapontypeGroup(wep)
                

                    local p = GetGameplayCamRelativePitch()
                    local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

                    local recoil = math.random(100,140+MovementSpeed)/100
                    local vehicleRecoil = math.random(100,140+MovementSpeed)/100

                    for k, v in pairs(Recoilcfg.BetterFight) do
                        if(wep == v.hash)then

                            recoil = recoil * v.recoil * GeneralGunRecoil
                            vehicleRecoil = recoil * v.vehicleRecoil * GeneralGunRecoil
                            
                            if (not Vehicled) then
                                shaker = v.rightLeftRecoil * GeneralGunRecoil
                            else
                                shaker = v.vehicleRightLeftRecoil * GeneralGunRecoil
                            end

                            if(SpecificGunRecoil[v.hash] ~= nil)then
                                recoil = recoil * SpecificGunRecoil[v.hash]
                                vehicleRecoil = vehicleRecoil * SpecificGunRecoil[v.hash]
                                shaker = shaker * SpecificGunRecoil[v.hash]
                            end

                            if(Recoilcfg.GripMultiplier)then
                                if(components[v.hash] ~= nil)then
                                    if(components[v.hash]['grip'] ~= nil)then
                                        if(HasPedGotWeaponComponent(globalPed, v.hash, components[v.hash]['grip']))then
                                            recoil = recoil * v.gripMultiplier
                                            vehicleRecoil = vehicleRecoil * v.gripMultiplier
                                            shaker = shaker * v.gripMultiplier
                                        end
                                    end
                                end
                            end

                            if(Recoilcfg.SuppressorMultiplier)then
                                if(components[v.hash] ~= nil)then
                                    if(components[v.hash]['suppressor'] ~= nil)then
                                        if(HasPedGotWeaponComponent(globalPed, v.hash, components[v.hash]['suppressor']))then
                                            recoil = recoil * v.suppressorMultiplier
                                            vehicleRecoil = vehicleRecoil * v.suppressorMultiplier 
                                            shaker = shaker * v.suppressorMultiplier 
                                        end
                                    end
                                end
                            end



                            break;
                        end
                    end

                    if cameraDistance < 5.3 then
                        cameraDistance = 1.5
                    else
                        if cameraDistance < 8.0 then
                            cameraDistance = 4.0
                        else
                            cameraDistance = 7.0
                        end
                    end

                    if Vehicled then
                        recoil = vehicleRecoil * cameraDistance
                    else
                        recoil = recoil * 0.8
                    end

                    if GamePlayCam == 4 and Recoilcfg.LoweredFirstPersonRecoil then
                        recoil = recoil * Recoilcfg.LoweredFirstPersonRecoilValue
                    end

                    if(Recoilcfg.RightLeftRecoil)then
                        if(Recoilcfg.RightLeftRecoilRandomiser)then
                            if(Recoilcfg.RightLeftRecoilRandomiserChance > math.random(1,100))then
                                update_rightleft(math.random(1,2))
                            else
                                update_rightleft(3)
                            end
                        else
                            update_rightleft(math.random(1,2))
                        end

                        local h = GetGameplayCamRelativeHeading()
                        local hf = math.random(10,40+MovementSpeed)/100

                        if Vehicled then
                            hf = hf * 2.00
                        end
                        
                        if(shaker == nil)then
                            shaker = 1.00
                        end

                        if Recoilcfg.UseVehicleRecoil then
                            if rightleft == 1 then
                                SetGameplayCamRelativeHeading(h+hf * shaker)
                            elseif rightleft == 2 then
                                SetGameplayCamRelativeHeading(h-hf * shaker)
                            end
                        elseif not Vehicled then
                            if rightleft == 1 then
                                SetGameplayCamRelativeHeading(h+hf * shaker)
                            elseif rightleft == 2 then
                                SetGameplayCamRelativeHeading(h-hf * shaker)
                            end
                        end
                    end
                    
                    if Recoilcfg.UseScreenExplosions then
                        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', recoil/100)
                    end

                    if Recoilcfg.UseVehicleRecoil then
                        local set = p+recoil
                        SetGameplayCamRelativePitch(set,0.8)
                    elseif not Vehicled then
                        local set = p+recoil
                        SetGameplayCamRelativePitch(set,0.8)
                    end
                end 	       	
            end

            if not globalIsPedArmed then
                Citizen.Wait(1500)
            end  
	end
end)

