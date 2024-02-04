-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mount = nil
local Camera = nil
local LastModel = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,-49.14,-1099.56,26.42 + 0.5)
	RenderScriptCams(true,true,100,true,true)
	SetCamRot(Camera,0.0,0.0,294.81)
	SetCamActive(Camera,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:enterTablet")
AddEventHandler("tablet:enterTablet",function()
	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	local Ped = PlayerPedId()
	if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and GetEntityHealth(Ped) > 100 and vSERVER.Verify() then
		CameraActive()
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("dynamic:closeSystem")
		TriggerEvent("hud:Actived", false)
		SendNUIMessage({ name = "Open", payload = vehicleGlobal() })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)

	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
		TriggerEvent("hudActived", true)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	if LoadModel(Data) and LastModel ~= Data then
		if DoesEntityExist(Mount) then
			DeleteEntity(Mount)
		end

		Mount = CreateVehicle(Data,-44.42,-1097.44,26.23,28.35,false,false)
		SetVehicleNumberPlateText(Mount,"PDMSPORT")
		SetEntityCollision(Mount,false,false)
		FreezeEntityPosition(Mount,true)
		SetEntityInvincible(Mount,true)
		SetVehicleDirtLevel(Mount,0.0)
		SetModelAsNoLongerNeeded(Data)
		LastModel = Data
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	vSERVER.Buy(Data)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	if DoesEntityExist(Mount) then
		if Data == "Left" then
			SetEntityHeading(Mount,GetEntityHeading(Mount) - 5)
		else
			SetEntityHeading(Mount,GetEntityHeading(Mount) + 5)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive",function(Data,Callback)
	local Driving,vehPlate = vSERVER.CheckDrive()
	if Driving then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)

		if LoadModel(Data) then
			if DoesEntityExist(Mount) then
				DeleteEntity(Mount)
			end

			Mount = CreateVehicle(Data,-53.28,-1110.93,26.47,68.04,false,false)

			SetVehicleModKit(Mount,0)
			ToggleVehicleMod(Mount,18,true)
			SetVehicleExtraColours(Mount,147,147)
			SetVehicleMod(Mount,11,GetNumVehicleMods(Mount,11) - 1,false)
			SetVehicleMod(Mount,12,GetNumVehicleMods(Mount,12) - 1,false)
			SetVehicleMod(Mount,13,GetNumVehicleMods(Mount,13) - 1,false)
			SetVehicleMod(Mount,15,GetNumVehicleMods(Mount,15) - 1,false)

			SetVehicleNumberPlateText(Mount,vehPlate)
			SetEntityAsMissionEntity(Mount,true,true)
       	    SetVehicleHasBeenOwnedByPlayer(Mount,true)
        	SetVehicleNeedsToBeHotwired(Mount,false)
			SetPedIntoVehicle(PlayerPedId(),Mount,-1)
			SetEntityInvincible(Mount,true)
			SetModelAsNoLongerNeeded(Data)

			LocalPlayer["state"]:set("Commands",true,true)
			LocalPlayer["state"]:set("TestDrive",true,false)

			while true do
				local Ped = PlayerPedId()
				if not IsPedInAnyVehicle(Ped) then
					vSERVER.RemoveDrive()
					SetEntityCoords(Ped,-58.03,-1096.94,26.42)
					LocalPlayer["state"]:set("Commands",false,true)
					LocalPlayer["state"]:set("TestDrive",false,false)

					if DoesEntityExist(Mount) then
						DeleteEntity(Mount)

						break
					end
				end

				Wait(1)
			end
		end
	end

	Callback("Ok")
end)