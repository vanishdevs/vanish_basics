--------------------------------------------------------------------------------
------------------------------------------------- Completed by JalalLinuX ------
--------------------------------------------------------------------------------

ESX = nil

while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj
	end)
end


ESX.RegisterServerCallback('CarLock:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)