-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bank:openSystem")
AddEventHandler("bank:openSystem",function()
	if vSERVER.verifyBank() then
		SetNuiFocus(true,true)
		SendNUIMessage({ Action = "Open", name = vSERVER.GetName() })
		vRP.playAnim(false,{"amb@prop_human_atm@male@idle_a","idle_a"},false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	SendNUIMessage({ Action = "Hide" })
	vRP.stopAnim()
	Callback(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Home",function(Data,Callback)
	Callback(vSERVER.Home())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Deposit",function(Data,Callback)
	Callback(vSERVER.Deposit(Data["value"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Withdraw",function(Data,Callback)
	Callback(vSERVER.Withdraw(Data["value"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Transfer",function(Data,Callback)
	if Data["targetId"] and Data["value"] then
		Callback(vSERVER.Transfer(Data["targetId"],Data["value"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDDEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("AddDependents",function(Data,Callback)
	TriggerClientEvent("Notify",source,"Atenção","Sistema indisponível.",5000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RemoveDependents",function(Data,Callback)
	TriggerClientEvent("Notify",source,"Atenção","Sistema indisponível.",5000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Investments",function(Data,Callback)
	Callback(vSERVER.Investments())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Invest",function(Data,Callback)
	if Data["value"] then
		Callback(vSERVER.Invest(Data["value"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvestRescue",function(Data,Callback)
	vSERVER.InvestRescue()

	Callback(true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONHISTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("TransactionHistory",function(Data,Callback)
	Callback(vSERVER.TransactionHistory())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MakeInvoice",function(Data,Callback)
	if Data["user_id"] and Data["value"] and Data["reason"] then
		Callback(vSERVER.MakeInvoice(Data["user_id"],Data["value"],Data["reason"]))
	else
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvoicePayment",function(Data,Callback)
	Callback(vSERVER.InvoicePayment(Data["id"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("InvoiceList",function(Data,Callback)
	Callback(vSERVER.InvoiceList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FineList",function(Data,Callback)
	Callback(vSERVER.FineList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FinePayment",function(Data,Callback)
	Callback(vSERVER.FinePayment(Data["id"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("FinePaymentAll",function(Data,Callback)
	Callback(vSERVER.FinePaymentAll())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Taxes",function(Data,Callback)
	Callback(vSERVER.TaxList())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("TaxPayment",function(Data,Callback)
	Callback(vSERVER.TaxPayment(Data["id"]))
end)