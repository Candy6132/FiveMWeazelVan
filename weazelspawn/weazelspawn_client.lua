Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		local distance = GetDistanceBetweenCoords(-275.522, 6635.835, 7.425, x, y, z, true)
	
		--DRAW NARKER WHEN PLAYER IS OUTSIDE VEHICLE
		if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then     
			DrawMarker(27, -275.522, 6635.835, 7.425, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 2.0, 0, 0, 255, 100, false, true, 1, false, false, false, false)
		end
		
		--SHOW TIP AND ALLOW SPAWN IF PLAYER IS ON THE MARKER
		if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and distance <= 4.0 then
			ShowHelp()
			if IsControlPressed(1, 38) then
				SpawnWeazel()
			end
		end
    end
end)


function SpawnWeazel()

	RequestModel('rumpo')

	while not HasModelLoaded('rumpo') do
		Wait(500)
	end

	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)

	local vehicle = CreateVehicle('rumpo', pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

	SetVehicleLivery(vehicle, 1)

	SetPedIntoVehicle(playerPed, vehicle, -1)

	SetEntityAsNoLongerNeeded(vehicle)

	SetModelAsNoLongerNeeded('rumpo')

end


function ShowHelp()
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName("Press ~INPUT_PICKUP~ to get your Weazel News Van!")
    EndTextCommandDisplayHelp(0, false, true, -1)
end