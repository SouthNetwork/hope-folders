-------------------------------- [ VRP ] --------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
vTASKBAR = Tunnel.getInterface("taskbar")
-------------------------------- [ CONNECTION ] --------------------------------
tabletServer = {}
Tunnel.bindInterface("hope-police",tabletServer)
tabletClient = Tunnel.getInterface("hope-police")

-------------------------------- [ PREPARES ] --------------------------------
vRP.prepare("prison/dukezaumGetDate","SELECT date FROM almirante_prison")
vRP.prepare("prison/dukezaumCleanRecords","DELETE FROM almirante_prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/dukezaumGetRecords","SELECT * FROM almirante_prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/dukezaumInsertPrison","INSERT INTO almirante_prison(police,nuser_id,services,fines,text,ongoingServices,date) VALUES(@police,@nuser_id,@services,@fines,@text,@ongoingServices,@date)")
vRP.prepare("prison/dukezaumRemovePrison","UPDATE almirante_prison SET ongoingServices = ongoingServices - @services WHERE nuser_id = @nuser_id AND ongoingServices > 0")
vRP.prepare("prison/dukezaumGetCurrentService","SELECT * FROM almirante_prison WHERE nuser_id = @nuser_id AND ongoingServices > 0")
vRP.prepare("prison/dukezaumUpdatePrison","UPDATE almirante_prison SET ongoingServices = 0 WHERE nuser_id = @nuser_id AND id = @id")

vRP.prepare("prison/dukezaumInsertWanted","INSERT INTO almirante_wanted(police,nuser_id,nuser_name,description,image,date) VALUES(@police,@nuser_id,@nuser_name,@description,@image,@date)")
vRP.prepare("prison/dukezaumDeleteWanted","DELETE FROM almirante_wanted WHERE nuser_id = @nuser_id")
vRP.prepare("prison/dukezaumGetWanteds","SELECT * FROM almirante_wanted")
vRP.prepare("prison/dukezaumGetWantedById","SELECT * FROM almirante_wanted WHERE nuser_id = @nuser_id")

vRP.prepare("prison/dukezaumInsertCarry","INSERT INTO almirante_carry(police,nuser_id,nuser_name,date) VALUES(@police,@nuser_id,@nuser_name,@date)")
vRP.prepare("prison/dukezaumGetCarryById","SELECT * FROM almirante_carry WHERE nuser_id = @nuser_id")
vRP.prepare("prison/dukezaumDeleteCarry","DELETE FROM almirante_carry WHERE nuser_id = @nuser_id")
-------------------------------- [ VARIABLES ] --------------------------------
local actived = {}
local prisonMarkers = {}
local monthNames = {
  [1] = "Jan",
  [2] = "Fev",
  [3] = "Mar",
  [4] = "Abr",
  [5] = "Mai",
  [6] = "Jun",
  [7] = "Jul",
  [8] = "Ago",
  [9] = "Set",
  [10] = "Out",
  [11] = "Nov",
  [12] = "Dez"
}

local function compare(a, b)
  return tonumber(a.monthNumber) < tonumber(b.monthNumber)
end

-------------------------------- [ FIND USER CONNECTING ] --------------------------------
function tabletServer.findUserConnecting()
  local source = source
	local Passport = vRP.getUserId(source)
  if Passport then
    local identity = vRP.userIdentity(Passport)
    
    return { identity["name"].." "..identity["name2"], identity["id"]  }
  end
end

-------------------------------- [ FIND USER BY PASSPORT ] --------------------------------
function tabletServer.findUserByPassport(nuser_id)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local nuser_id = parseInt(nuser_id)
		local Identity = vRP.userIdentity(nuser_id)
		if Identity then
			local fines = vRP.getFines(nuser_id)
			local records = vRP.query("prison/dukezaumGetRecords",{ nuser_id = parseInt(nuser_id) })
			local wanted = vRP.query("prison/dukezaumGetWantedById", { nuser_id = parseInt(nuser_id) })
			local carry = vRP.query("prison/dukezaumGetCarryById", { nuser_id = parseInt(nuser_id) })
			return { true,Identity["name"].." "..Identity["name2"],Identity["phone"],fines,records, wanted, Identity["id"], carry }
		end
	end

	return { false }
end

-------------------------------- [ FIND DATE ] --------------------------------
function tabletServer.findDate()
  local countByMonth = {}
	local rows = vRP.query("prison/dukezaumGetDate")
	local list = {}

	for _, row in ipairs(rows) do
		local date = row.date
	
		local month = date:sub(4, 5)
		local monthFormatted = 0
		if parseInt(month) < 10 then
			monthFormatted = string.sub(month, 2)
		else
			monthFormatted = month
		end
	
		countByMonth[monthFormatted] = (countByMonth[monthFormatted] or 0) + 1
	end

	for month, count in pairs(countByMonth) do
		local monthNumber = parseInt(month)
		local monthName = monthNames[monthNumber]

		table.insert(list, { monthNumber = month, quantity = count, monthName = monthName })
	end

	table.sort(list, compare)

	return list
end

-------------------------------- [ APPLY FINE ] --------------------------------
function tabletServer.applyFine(nuser_id,fines,text)
 local source = source
 local Passport = vRP.getUserId(source)
  local nuser_id = parseInt(nuser_id)
  local identity = vRP.userIdentity(nuser_id)
  
	if Passport and fines > 0 then
    if identity then
      if actived[Passport] == nil then
        actived[Passport] = true
        
        TriggerClientEvent("Notify",source,"verde","Multa aplicada, vai doer no bolso do vagabundo.",5000)
		vRP.addFines(nuser_id,fines)
  
        actived[Passport] = nil
        return true
      end
    else
      TriggerClientEvent("Notify",source,"vermelho","Passaporte do pilantra não foi encontrado.",5000)
			actived[Passport] = nil
      return false
    end
	end
end

-------------------------------- [ APPLY PRISON ] --------------------------------
function tabletServer.applyPrison(nuser_id,fines,services,text,polices,image)
  local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		if actived[Passport] == nil then
			actived[Passport] = true
			
			local identity = vRP.userIdentity(Passport)
			if identity then
				local otherPlayer = vRP.userSource(nuser_id)
				local ongoingServices = vRP.query("prison/dukezaumGetCurrentService",{ nuser_id = parseInt(Passport) })
				if otherPlayer then
					tabletClient.syncPrison(otherPlayer,true,false)
					TriggerClientEvent("hud:RadioClean",otherPlayer)
					
					if ongoingServices[1] then
						vRP.query("prison/dukezaumUpdatePrison",{ nuser_id = parseInt(Passport), id = parseInt(ongoingServices[1]['id']) })
					end

					vRP.query("prison/dukezaumInsertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = services, fines = fines, text = text, ongoingServices = services, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
					vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"verde","Prisão efetuada, menos 1 vagabundo na rua.",5000)
					TriggerEvent("DiscordTablet","TabletPolice","**RG do vagabundo:** "..parseInt(nuser_id).."\n\n**Policial envolvidos:** \n"..polices.."\n\n**Total de meses/multa aplicado: \n** "..services.." meses / "..fines.." de multa".."\n\n**Descrição da prisão:** \n"..text,3092790, image)
					
					if fines > 0 then
						vRP.addFines(nuser_id,fines)
					end

					actived[Passport] = nil
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","Passaporte do pilantra não foi encontrado.",5000)
					actived[Passport] = nil
					return false
				end
			end
		end
	end
end

-------------------------------- [ MARKERS ] --------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.userSource(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

-------------------------------- [ RESET PRISON ] --------------------------------
function tabletServer.resetPrison()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		prisonMarkers[source] = { 60,parseInt(Passport) }
		local ongoingServices = vRP.query("prison/dukezaumGetCurrentService",{ nuser_id = parseInt(Passport) })

		if ongoingServices[1] then
			vRP.query("prison/dukezaumUpdatePrison",{ nuser_id = parseInt(Passport), id = parseInt(ongoingServices[1]['id']) })
		end

		local policeResult = vRP.NumPermission("Cop")
		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("Notify",v,"amarelo","Recebemos a informação de um vagabundo fugindo da penitenciária.",5000)
				vRPC.playSound(v,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS")
			end)
		end

		TriggerEvent("blipsystem:Enter",source,"Prisioneiro",48)
	end
end

-------------------------------- [ REDUCE PRISON ] --------------------------------
function tabletServer.reducePrison()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local ongoingServicesBefore = vRP.query("prison/dukezaumGetCurrentService",{ nuser_id = parseInt(Passport) })
		local random = math.random(Cfg.QuantityServices[1], Cfg.QuantityServices[2])

		if ongoingServicesBefore[1] then
			if parseInt(ongoingServicesBefore[1]['ongoingServices']) <= 3 then
				vRP.query("prison/dukezaumRemovePrison",{ nuser_id = parseInt(Passport), services = parseInt(ongoingServicesBefore[1]['ongoingServices']) })
			else
				vRP.query("prison/dukezaumRemovePrison",{ nuser_id = parseInt(Passport), services = parseInt(random) })
			end
		end
		
		local ongoingServices = vRP.query("prison/dukezaumGetCurrentService",{ nuser_id = parseInt(Passport) })
		if ongoingServices[1] then
			tabletClient.asyncServices(source)
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(ongoingServices[1]['ongoingServices']).." serviços</b>.",5000)
		else
			TriggerClientEvent("Notify",source,"verde","Pena finalizada, se liga vagabundo!",5000)
			vRPC.playSound(source,"sounds:Private","prisondoors",1.0)
			tabletClient.syncPrison(source,false,true)
		end
	end
end

-------------------------------- [ CHECK KEY ] --------------------------------
function tabletServer.checkKey()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then

		local consultItem = vRP.getInventoryItemAmount(Passport,Cfg.ItemKey)
		if consultItem[1] > 0 then
			if not vRP.Brokenpick(consultItem[2]) then
				if vRP.tryGetInventoryItem(Passport,consultItem[2],1,true) then
					local taskResult = vTASKBAR.taskLockpick(source)
					if taskResult then
						return true
					end
				end
			end
		end

		return false
	end
end

-------------------------------- [ GIVE KEY ] --------------------------------
function tabletServer.giveKey()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		vRP.generateItem(Passport,Cfg.ItemKey,1,true)
	end
end

-------------------------------- [ SET WANTED ] --------------------------------
function tabletServer.setWanted(nuser_id,image,text)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local identity = vRP.userIdentity(Passport)
		local identityPlayerWanted = vRP.userIdentity(nuser_id)
		if identityPlayerWanted then
			if vRP.hasGroup(Passport, "Lspd") then
				vRP.query("prison/dukezaumInsertWanted",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), nuser_name = identityPlayerWanted["name"].." "..identityPlayerWanted["name2"], description = text, image = image, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
				TriggerClientEvent("Notify",source,"azul","O vagabundo foi cadastrado como procurado no nosso banco de dados!",5000)
				TriggerClientEvent("police:updateWanted", source)
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para executar essa ação",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Bandindin não encontrado!",5000)
		end
	end
end

-------------------------------- [ REMOVE WANTED ] --------------------------------
function tabletServer.removeWanted(nuser_id)
	local source = source
	local Passport = vRP.getUserId(source)
	if nuser_id then
		if vRP.hasGroup(Passport, "Lspd") then
			vRP.query("prison/dukezaumDeleteWanted",{ nuser_id = parseInt(nuser_id) })
			TriggerClientEvent("police:updateWanted", source)
			TriggerClientEvent("Notify",source,"azul","Procuração removida!!",5000)
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para executar essa ação",5000)
		end
	end
end

-------------------------------- [ SET CARRY ] --------------------------------
function tabletServer.setCarry(nuser_id)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local identity = vRP.userIdentity(Passport)
		local identityPlayerCarry = vRP.userIdentity(nuser_id)
		if identityPlayerCarry then
			if vRP.hasGroup(Passport, "Lspd") then
				vRP.query("prison/dukezaumInsertCarry",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), nuser_name = identityPlayerCarry["name"].." "..identityPlayerCarry["name2"], date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
				TriggerClientEvent("Notify",source,"azul","Porte de armas foi adicionado!",5000)
				TriggerClientEvent("police:updateSearch", source)
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para executar essa ação",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Não encontrado",5000)
		end
	end
end

-------------------------------- [ REMOVE CARRY ] --------------------------------
function tabletServer.removeCarry(nuser_id)
	local source = source
	local Passport = vRP.getUserId(source)
	if nuser_id then
		if vRP.hasGroup(Passport, "Lspd") then
			vRP.query("prison/dukezaumDeleteCarry",{ nuser_id = parseInt(nuser_id) })
			TriggerClientEvent("police:updateSearch", source)
			TriggerClientEvent("Notify",source,"azul","Porte de armas foi removido!",5000)
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para executar essa ação",5000)
		end
	end
end

-------------------------------- [ GET WANTED ] --------------------------------
function tabletServer.getWanted()
		local wanteds = vRP.query("prison/dukezaumGetWanteds")
		return wanteds
end

-------------------------------- [ CLEAN RECS ] --------------------------------
RegisterCommand(Cfg.CleanRec,function(source,args,rawCommand)
	local Passport = vRP.getUserId(source)
	if Passport and args[1] then
		if vRP.hasGroup(Passport, "Lspd") or vRP.HasGroup(Passport, "OAB") then
			local nuser_id = parseInt(args[1])
			if nuser_id > 0 then
				vRP.query("prison/dukezaumCleanRecords",{ nuser_id = nuser_id })
				TriggerClientEvent("Notify",source,"verde","A ficha da pessoa foi limpa.",5000)
				TriggerClientEvent("sendNotifyMission",source,"Ficha limpa, não me enche mais o saco.", 10000)
				TriggerEvent("DiscordTablet","Ficha","**Quem limpou:** "..Passport.."\n**Ficha limpa:** "..args[1],3092790)
			end
		end
	end
end)

-------------------------------- [ CLOTHES PRISON ] --------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport and vRP.getHealth(source) > 100 then
		local mHash = vRP.modelPlayer(entity[1])
		if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
			TriggerClientEvent("updateRoupas",entity[1],Cfg.Preset[mHash])
		end
	end
end)

-------------------------------- [ PLAYER CONNECT ] --------------------------------
AddEventHandler("Connect",function(Passport,source)
	local ongoingServices = vRP.query("prison/dukezaumGetCurrentService",{ nuser_id = parseInt(Passport) })
	if ongoingServices[1] then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(ongoingServices[1]['ongoingServices']).." serviços</b>.",5000)
		tabletClient.syncPrison(source,true,true)
	end
end)