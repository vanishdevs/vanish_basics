local ControlKey = 303
local NotCarFound = "Your vehicle was not ~r~detected~w~"
local CarLocked = "Your vehicle is ~r~Locked~s~"
local CarOpen = "Your vehicle is ~g~Open~s~"
local SearchAreaRadius = 20.0
local BlinkingLightsON = true
local CarBleepOnOpen = true
local CarBleepOnClose = true
local CarBleepDistance = 5.0
local CarBleepVolume = 0.5

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- need for next version
function VehicleInFront(checkDistance)
	local vehicle, distance = ESX.Game.GetClosestVehicle()
	Citizen.Wait(10)
    if vehicle ~= nil and distance < (checkDistance and checkDistance or CheckVehicleDistance) then
		return vehicle
    else 
        return 0 
    end
end


-- Lock and Unlock Event
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
  	local dict = "anim@mp_player_intmenu@key_fob@"
  	RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
  end
  while true do
    Citizen.Wait(0)
	if (IsControlJustPressed(1, ControlKey)) then
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local hasAlreadyLocked = false
		cars = ESX.Game.GetVehiclesInArea(coords, SearchAreaRadius)
		local carstrie = {}
		local cars_dist = {}		
		notowned = 0
		if #cars == 0 then
			ESX.ShowHelpNotification(NotCarFound)
		else
			for j=1, #cars, 1 do
				local coordscar = GetEntityCoords(cars[j])
				local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				table.insert(cars_dist, {cars[j], distance})
			end
			for k=1, #cars_dist, 1 do
				local z = -1
				local distance, car = 999
				for l=1, #cars_dist, 1 do
					if cars_dist[l][2] < distance then
						distance = cars_dist[l][2]
						car = cars_dist[l][1]
						z = l
					end
				end
				if z ~= -1 then
					table.remove(cars_dist, z)
					table.insert(carstrie, car)
				end
			end
			for i=1, #carstrie, 1 do
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
				ESX.TriggerServerCallback('CarLock:isVehicleOwner', function(owner)
					if owner and hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(carstrie[i])
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(carstrie[i], 0, false)
							SetVehicleDoorShut(carstrie[i], 1, false)
							SetVehicleDoorShut(carstrie[i], 2, false)
							SetVehicleDoorShut(carstrie[i], 3, false)
							SetVehicleDoorsLocked(carstrie[i], 2)
							PlayVehicleDoorCloseSound(carstrie[i], 1)
							
							ESX.ShowHelpNotification("~BLIP_134~ " .. CarLocked)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							if CarBleepOnOpen then
								TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', CarBleepVolume) 
							end
							if BlinkingLightsON then
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(200)
								SetVehicleLights(carstrie[i], 0)
							end
							hasAlreadyLocked = true
						elseif lock == 2 then
							SetVehicleDoorsLocked(carstrie[i], 1)
							PlayVehicleDoorOpenSound(carstrie[i], 0)
							
							ESX.ShowHelpNotification("~BLIP_134~ " .. CarOpen)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							if CarBleepOnClose then
								TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', CarBleepVolume)
							end 
							if BlinkingLightsON then
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 1)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(100)
								SetVehicleLights(carstrie[i], 0)
							end
							hasAlreadyLocked = true
						end
					else
						notowned = notowned + 1
					end
					if notowned == #carstrie then
						ESX.ShowHelpNotification("~BLIP_INFO_ICON~ " .. NotCarFound)
					end	
				end, plate)
			end			
		end
	end
  end
end)