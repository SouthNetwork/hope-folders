-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hope = {}
Tunnel.bindInterface("tattoos",Hope)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHARES
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.checkShares()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Wanted(user_id,source) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.updateTattoo(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Tatuagens", value = json.encode(status) })
	end
end