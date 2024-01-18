SpecificGunRecoil = {}
GeneralGunRecoil = 1.00
gunHash = nil

function AlterSpecificGunRecoil(hash, value)

    if(hash ~=nil)then
        gunHash = hash
        if(value ~=nil)then
            SpecificGunRecoil[gunHash] = value
        end
    end

end

function AlterGeneralGunRecoil(value)

    if(value ~=nil)then
        GeneralGunRecoil = value
    end

end

function ResetAllGunRecoil()
    SpecificGunRecoil = {}
    GeneralGunRecoil = 1.00
end

function ViewCamForcerJoined()
    Recoilcfg.UseFirstJoinViewCamForcer = false
end