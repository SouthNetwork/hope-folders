-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Khaos = {}
Tunnel.bindInterface("pdm",Khaos)
vCLIENT = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Khaos.Verify()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Você possui multas pendentes.",10000)
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Khaos.Buy(Name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not Active[user_id] then
			Active[user_id] = true

			if vehicleGems(Name) > 0 then
				if vehicleMode(Name) == "Rental" then
					local vehicle = vRP.query("vehicles/selectVehicles",{ user_id = user_id, vehicle = Name })
					if vehicle[1] then
						TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(Name).."</b>.",3000)
						Active[user_id] = nil
						return
					end

					local vehiclePrice = vehicleGems(Name)
					local Text = "Alugar o veículo <b>"..vehicleName(Name).."</b> por <b>"..vehiclePrice.."</b> gemas?"

					if vRP.consultItem(user_id,"mydick",1) then
						Text = "Alugar o veículo <b>"..vehicleName(Name).."</b> usando o vale?"
					end

					if vRP.request(source,Text,"Sim, concluír pagamento","Não, mudei de ideia") then
						if vRP.giveInventoryItem(user_id,"dukezaumNull",1,true) or vRP.paymentGems(user_id,vehiclePrice) then
							local vehicle = vRP.execute("vehicles/selectVehicles",{ user_id = user_id, vehicle = Name })
							if vehicle[1] then
								if vehicle[1]["rental"] <= os.time() then
									vRP.execute("vehicles/rentalVehiclesUpdate",{ user_id = user_id, vehicle = Name })
									TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(Name).."</b> atualizado.",5000)
								else
									vRP.execute("vehicles/rentalVehiclesDays",{ user_id = user_id, vehicle = Name })
									TriggerClientEvent("Notify",source,"verde","Adicionado <b>30 Dias</b> de aluguel no veículo <b>"..vehicleName(Name).."</b>.",5000)
								end
							else
								vRP.execute("vehicles/rentalVehicles",{ user_id = user_id, vehicle = Name, plate = vRP.generatePlate(), work = "false" })
								TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(Name).."</b> concluído.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
						end
					end
				else
					local vehicle = vRP.execute("vehicles/selectVehicles",{ user_id = user_id, vehicle = Name })
					if vehicle[1] then
						TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(Name).."</b>.",3000)
						Active[user_id] = nil
						return
					else
						local vehiclePrice = vehicleGems(Name)
						if vRP.request(source,"Comprar <b>"..vehicleName(Name).."</b> por <b>"..parseFormat(vehiclePrice).."</b> gemas?","Sim, concluír pagamento","Não, mudei de ideia") then
							if vRP.paymentGems(user_id,vehiclePrice) then
								vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = Name, plate = vRP.generatePlate(), work = "false" })
								TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
							end
						end
					end
				end
		Active[user_id] = nil
			else
				local vehicle = vRP.execute("vehicles/selectVehicles",{ user_id = user_id, vehicle = Name })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehicleName(Name).."</b>.",3000)
				Active[user_id] = nil
				return
			else
				if vehicleMode(Name) == "work" then
					if vRP.paymentFull(user_id,vehiclePrice(Name)) then
						vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = Name, plate = vRP.generatePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				else
					local vehiclePrice = vehiclePrice(Name)
					if vRP.request(source,"Comprar <b>"..vehicleName(Name).."</b> por <b>$"..parseFormat(vehiclePrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then
						if vRP.paymentFull(user_id,vehiclePrice) then
							vRP.execute("vehicles/addVehicles",{ user_id = user_id, vehicle = Name, plate = vRP.generatePlate(), work = "false" })
							TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					end
				end
			end

			Active[user_id] = nil
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local plateVehs = {}
local numberName = 1000
function Khaos.CheckDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] == nil then
			Active[user_id] = true
				if vRP.request(source,"Iniciar o teste por <b>$100</b> dólares?") then
					if vRP.paymentFull(user_id,100) then
						numberName = numberName + 1
						plateVehs[user_id] = "PDMS"..numberName

						TriggerEvent("engine:tryFuel",plateVehs[user_id],100)
						TriggerClientEvent("update:Route",source,user_id)
						TriggerEvent("plateEveryone",plateVehs[user_id])
						SetPlayerRoutingBucket(source,user_id)
						Active[user_id] = nil

						return true,plateVehs[user_id]
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end

			Active[user_id] = nil
		end
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Khaos.RemoveDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("plateReveryone",source)
		TriggerClientEvent("Notify",source,"azul","Eai, gostou do veículo que estava testando?",5000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if Active[user_id] then
		Active[user_id] = nil
	end
end)