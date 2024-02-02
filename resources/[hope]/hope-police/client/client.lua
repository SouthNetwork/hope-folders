-------------------------------- [ VRP ] --------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")

-------------------------------- [ CONNECTION ] --------------------------------
tabletClient = {}
Tunnel.bindInterface("hope-police",tabletClient)
tabletServer = Tunnel.getInterface("hope-police")

-------------------------------- [ VARIABLES ] --------------------------------
local inSelect = 1
local inDeath = false
local inPrison = false
local inTimer = GetGameTimer()
local timeDeath = GetGameTimer()

-------------------------------- [ POLYZONE PRISON ] --------------------------------
local polyPrison = PolyZone:Create(Cfg.PolyPrison,{ name = "Prison" })

-------------------------------- [ NUI CALLBACKS ] --------------------------------
RegisterNUICallback('getUser', function(_, cb) 
  cb({ result = tabletServer.findUserConnecting() })
end)

RegisterNUICallback('getGraphicData', function(_, cb)
  cb({ result = tabletServer.findDate() })
end)

RegisterNUICallback('getUserByPassport', function(nuser_id, cb) 
  cb({ result = tabletServer.findUserByPassport(nuser_id) })
end)

RegisterNUICallback("applyFine",function(data, cb)
  cb({ result = tabletServer.applyFine(data["passport"],data["fines"],data["text"]) })
end)

RegisterNUICallback("applyPrison",function(data, cb)
  cb({ result = tabletServer.applyPrison(data["passport"],data["fines"],data["services"],data["text"],data["polices"],data["image"]) })
end)

RegisterNUICallback("setWanted",function(data, cb)
  cb({ result = tabletServer.setWanted(data["passport"],data["image"],data["text"]) })
end)

RegisterNUICallback("getWanted",function(data, cb)
  cb({ result = tabletServer.getWanted() })
end)

RegisterNUICallback("removeWanted",function(nuser_id, cb)
  cb({ result = tabletServer.removeWanted(nuser_id) })
end)

RegisterNUICallback("setCarry",function(nuser_id, cb)
  cb({ result = tabletServer.setCarry(nuser_id) })
end)

RegisterNUICallback("removeCarry",function(nuser_id, cb)
  cb({ result = tabletServer.removeCarry(nuser_id) })
end)

-------------------------------- [ OPEN TABLET ] --------------------------------
RegisterNetEvent(Cfg.CommandEventOpenNUI)
AddEventHandler(Cfg.CommandEventOpenNUI,function()
  local ped = PlayerPedId()
  if not IsPedSwimming(ped) then
		SetNuiFocus(true, true)
    SendReactMessage('open')

    if not IsPedInAnyVehicle(ped) then
      vRP.removeObjects()
      vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
    end
	end
end)


RegisterCommand(Cfg.CommandOpenNUI,function(source,args)
	local ped = PlayerPedId()
	if LocalPlayer["state"]["Police"] then
		if not IsPedSwimming(ped) then
			SetNuiFocus(true, true)
			SendReactMessage('open')
			
			if not IsPedInAnyVehicle(ped) then
				vRP.removeObjects()
				vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
			end
		end
	end
end) 

-------------------------------- [ CLOSE TABLET ] --------------------------------
RegisterNUICallback('closeTablet', function() 
  SetNuiFocus(false, false)
  SendReactMessage('close')
  vRP.removeObjects()
end)

-------------------------------- [ THREAD SYSTEM ] --------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vec3(Cfg.CoordsLeaver[1],Cfg.CoordsLeaver[2],Cfg.CoordsLeaver[3]))

			if not polyPrison:isPointInside(coords) then
				SetEntityCoords(ped,Cfg.CoordsIntern[1],Cfg.CoordsIntern[2],Cfg.CoordsIntern[3],1,0,0,0)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = Vdist(coords.x, coords.y, coords.z, Cfg.InLocates[inSelect][1],Cfg.InLocates[inSelect][2],Cfg.InLocates[inSelect][3])

			if distance <= 150 then
				timeDistance = 1
				DrawText3D(Cfg.InLocates[inSelect][1],Cfg.InLocates[inSelect][2],Cfg.InLocates[inSelect][3],"~g~E~w~   INTERAGIR")

				if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1,38) and not IsPedInAnyVehicle(ped) then
					inTimer = GetGameTimer() + 3000

					LocalPlayer["state"]["Cancel"] = true
					LocalPlayer["state"]["Commands"] = true
					SetEntityHeading(ped,Cfg.InLocates[inSelect][4])
					SetEntityCoords(ped,Cfg.InLocates[inSelect][1],Cfg.InLocates[inSelect][2],Cfg.InLocates[inSelect][3] - 1,1,0,0,0)
					vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					TriggerEvent("Progress","Interagindo",5000)

					Citizen.Wait(5000)

					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					tabletServer.reducePrison()
					vRP.removeObjects()

				if(Cfg.RunAwayPrision) then
						if math.random(1000) > 990 then
							tabletServer.giveKey()
						end
					end
		        end
	        end

			if GetEntityHealth(ped) <= 101 then
				if not inDeath then
					timeDeath = GetGameTimer() + 60000
					inDeath = true
				else
						if GetGameTimer() >= timeDeath then
							exports["survival"]:Revive(101)
						inDeath = false
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRUNAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if inPrison then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(Cfg.CoordsLeaver[1],Cfg.CoordsLeaver[2],Cfg.CoordsLeaver[3]))

			if distance <= 1.5 then
				timeDistance = 1
				DrawText3D(Cfg.CoordsLeaver[1],Cfg.CoordsLeaver[2],Cfg.CoordsLeaver[3],"~g~E~w~   FUGIR")

				if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1,38) then
					inTimer = GetGameTimer() + 3000

					if tabletServer.checkKey() then
						local rand = math.random(#Cfg.RunAway)
						SetEntityCoords(ped,Cfg.RunAway[rand][1],Cfg.RunAway[rand][2],Cfg.RunAway[rand][3],1,0,0,0)
						inPrison = false
						tabletServer.resetPrison()
					end
				end
			end
		end

		Wait(timeDistance)
	end
end)
-------------------------------- [ SYNC PRISON ] --------------------------------
function tabletClient.syncPrison(status,teleport)
	if teleport then
		if status then
			SetEntityCoords(PlayerPedId(),Cfg.CoordsIntern[1],Cfg.CoordsIntern[2],Cfg.CoordsIntern[3],1,0,0,0)
		else
			SetEntityCoords(PlayerPedId(),Cfg.CoordsExtern[1],Cfg.CoordsExtern[2],Cfg.CoordsExtern[3],1,0,0,0)
		end
	end
	
	inPrison = status
	inSelect = math.random(#Cfg.InLocates)
end

-------------------------------- [ ASYNC PRISON ] --------------------------------
function tabletClient.asyncServices()
	inSelect = math.random(#Cfg.InLocates)
end

-------------------------------- [ GENERATE TEXT ] --------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end

RegisterNetEvent("police:updateWanted")
AddEventHandler("police:updateWanted",function()
    SendReactMessage('updateWanted')
end)

RegisterNetEvent("police:updateSearch")
AddEventHandler("police:updateSearch",function()
    SendReactMessage('updateSearch')
end)

-------------------------------- [ KEY MAPPING TO OPEN TABLET ] --------------------------------
if Cfg.OpenNUIWithKey then
	RegisterKeyMapping(Cfg.CommandOpenNUI,"Abrir menu de grupos.","keyboard",Cfg.KeyOpenNUI)
end