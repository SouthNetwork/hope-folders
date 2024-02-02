-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERTABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:enterTablet")
AddEventHandler("tablet:enterTablet",function()
	local ped = PlayerPedId()
	if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(ped) > 101 and MumbleIsConnected() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "openSystem" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	cb({ result = GlobalState["Cars"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	cb({ result = GlobalState["Bikes"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestAluguel",function(data,cb)
	cb({ result = GlobalState["Rental"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	cb({ result = vSERVER.requestPossuidos() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestBuy",function(data)
	if MumbleIsConnected() then
		vSERVER.requestBuy(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestRental",function(data)
	if MumbleIsConnected() then
		vSERVER.requestRental(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTALMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rentalMoney",function(data)
	if MumbleIsConnected() then
		vSERVER.rentalMoney(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTax",function(data)
	if MumbleIsConnected() then
		vSERVER.requestTax(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTRANSF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTransf",function(data)
	if MumbleIsConnected() then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		vSERVER.requestTransf(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestSell",function(data)
	if MumbleIsConnected() then
		vSERVER.requestSell(data["name"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { 0.0,0.0,0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestDrive",function(data)
	local driveIn,vehPlate = vSERVER.startDrive()
	if driveIn then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "closeSystem" })

		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		benCoords = { coords["x"],coords["y"],coords["z"] }

		TriggerEvent("races:insertList",true)
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

		Citizen.Wait(1000)

		vehCreate(data["name"],vehPlate)

		Citizen.Wait(1000)

		SetPedIntoVehicle(ped,vehDrive,-1)
		benDrive = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName,vehPlate)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	if HasModelLoaded(mHash) then
		vehDrive = CreateVehicle(mHash,-53.9,-1110.5,26.34,68.04,false,false)

		SetEntityInvincible(vehDrive,true)
		SetVehicleNumberPlateText(vehDrive,vehPlate)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if benDrive then
			timeDistance = 1
			DisableControlAction(1,69,false)

			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				Citizen.Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				TriggerEvent("races:insertList",false)
				LocalPlayer["state"]["Commands"] = false
				SetEntityCoords(ped,benCoords[1],benCoords[2],benCoords[3],1,0,0,0)
				DeleteEntity(vehDrive)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local initVehicles = {}