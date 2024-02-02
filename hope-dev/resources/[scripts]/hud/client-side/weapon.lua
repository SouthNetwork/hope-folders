-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local AmmoMax = -1
local AmmoMin = -1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Hash = GetSelectedPedWeapon(Ped)
		local HypeeCore = 1000
		if Hash ~= -1569615261 then
			local _,Min = GetAmmoInClip(Ped,Hash)
			local Max = GetAmmoInPedWeapon(Ped,Hash)
			
			if AmmoMax ~= Max or AmmoMin ~= Min then
				AmmoMax = Max
				AmmoMin = Min

				if (Max - Min) <= 0 then
					Max = 0
				else
					Max = Max - Min
				end

			end
			HideHudComponentThisFrame(5)  -- Munição
			SendNUIMessage({ Action = "Weapons", Status = true, Photo = 'glock', Min = Min, Max = Max, Name = Hash, Vehicle = IsPedInAnyVehicle(Ped) })
			HypeeCore = 1
		else
			HypeeCore = 1000
			SendNUIMessage({ Action = "Weapons", Status = false, Vehicle = IsPedInAnyVehicle(Ped) })
			Active = false
			AmmoMax = -1
			AmmoMin = -1
		end
		Wait(HypeeCore)
	end
end)