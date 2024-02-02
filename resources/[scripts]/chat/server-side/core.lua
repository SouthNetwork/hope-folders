-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage",function(Tag,Message)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local Identity = vRP.userIdentity(Passport)
		local Messages = Message:gsub("[<>]","")

        if Tag == "Lspd" or Tag == "Paramedic" or Tag == "Mechanic" then
            local Service = vRP.numPermission(Tag)
            for Passports,Sources in pairs(Service) do
                async(function()
                    TriggerClientEvent("chat:ClientMessage",Sources,Identity["name"],Messages,Tag)
                end)
            end
        else
            TriggerClientEvent("chat:ClientMessage",source,Identity["name"].." "..Identity["name2"],Messages,Tag)

            local Players = vRPC.nearestPlayers(source,10)
            for _,v in pairs(Players) do
                async(function()
                    TriggerClientEvent("chat:ClientMessage",v[2],Identity["name"].." "..Identity["name2"],Messages,Tag)
                end)
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("statusChat",function(source)
	return vCLIENT.statusChat(source)
end)