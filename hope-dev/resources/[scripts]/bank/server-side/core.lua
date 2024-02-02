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
Tunnel.bindInterface("bank",Hope)
vCLIENT = Tunnel.getInterface("bank")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local yield = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.GetName()
	local source = source
	local user_id = vRP.getUserId(source)
	local Identity = vRP.userIdentity(user_id)
	if Identity then
		return Identity["name"].." "..Identity["name2"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.verifyBank()
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
-- BANKTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local next_time = GetGameTimer()
	while true do
	  if os.time() >= next_time then
		next_time = os.time() + 3600
		vRP.query("investments/Actives")
	  end
	  Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Home()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local check = vRP.query("investments/Check", {user_id = user_id})
		if check[1] then
			yield = check[1].Monthly
		end
		local balance = vRP.userIdentity(user_id).bank
		local transactions = Transactions(user_id)
	  return {
		user_id = user_id,
		yield = yield,
		balance = balance,
		transactions = transactions,
	  }
	end
  end

  CreateThread(function()
	while true do
		Wait(1)
		Hope.Home()
	end
  end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.TransactionHistory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return Transactions(user_id, 50)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Deposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil and parseInt(amount) > 0 then
		Active[user_id] = true

	    if parseInt(amount) > 0 then
			if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
				vRP.addBank(user_id,amount,"Private")
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
		Active[user_id] = nil
		local balance = vRP.userIdentity(user_id).bank
		local transactions = Transactions(user_id)

		return {balance = balance, transactions = transactions}

	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Withdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil and parseInt(amount) > 0 then
		Active[user_id] = true
			vRP.withdrawCash(user_id, amount)
		Active[user_id] = nil
		local balance = vRP.userIdentity(user_id).bank
		local transactions = Transactions(user_id)
		return {balance = balance, transactions = transactions}
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Transfer(ClosestPed,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil and parseInt(amount) > 0 then
		Active[user_id] = true
			if vRP.userIdentity(ClosestPed) and vRP.paymentBank(user_id, amount, true) then
				vRP.addBank(ClosestPed, amount,"Private")
			end
		Active[user_id] = nil
		local balance = vRP.userIdentity(user_id).bank
		local transactions = Transactions(user_id)
		return {balance = balance, transactions = transactions}
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
function Transactions(user_id, Limit)
	local user_id = user_id
	local transactions = {}
	if not Limit then
		Limit = 4
	end
	local result = vRP.query('transactions/List',{ user_id = user_id, Limit = Limit })
	if result[1] then
		for i, transaction in pairs(result) do
		    local type = transaction.Type
			local date = transaction.Date
			local value = transaction.Value
			local balance = transaction.Balance
			transactions[#transactions + 1] = {
				type = type,
				date = date,
				value = value,
				balance = balance
			}
		end
	end
	return transactions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Taxs(user_id)
	local user_id = user_id
	local taxs = {}
	local result = vRP.query('taxs/List',{ user_id = user_id })
	if result[1] then
		for i, tax in pairs(result) do
			taxs[i] = {
				id = tax.id,
				name = tax.Name,
				value = tax.Value,
				date = tax.Date,
				hour = tax.Hour,
				message = tax.Message
			}
		end
	end
	return taxs
end

function Hope.TaxList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	  return Taxs(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.TaxPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local id = id
	if user_id and Active[user_id] == nil then
		Active[user_id] = true
		local result = vRP.query('taxs/Check',{ user_id = user_id, id = id })
		if result[1] then
			if vRP.paymentBank(user_id, result[1].Value) then
				vRP.query("taxs/Remove",{ user_id = user_id, id = id })
				Active[user_id] = nil
				return true
			end
		end
		Active[user_id] = nil
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoices(user_id)
	local user_id = user_id
	local invoices = {}

	local result = vRP.query('invoices/List',{ user_id = user_id })
	if result[1] then
		for i, invoice in pairs(result) do
			if not invoices[invoice.Type] then
				invoices[invoice.Type] = {}
			end
			local id = invoice.id
			local reason = invoice.Reason
			local holder = invoice.Holder
			invoices[invoice.Type][#invoices[invoice.Type] + 1] = {id = id, reason = reason, holder = holder, value = invoice.Value}
		end
	end
	return invoices
end

function Hope.InvoiceList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return Invoices(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.InvoicePayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	local id = id
	if user_id and Active[user_id] == nil then
		Active[user_id] = true
		local result = vRP.query('invoices/Check',{ user_id = user_id, id = id })
		if result[1] then
			if vRP.paymentBank(user_id, result[1].Value) then
				vRP.query("invoices/Remove",{ user_id = user_id, id = id })
				Active[user_id] = nil
				return true
			end
		end
		Active[user_id] = nil
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.MakeInvoice(nuser_id, value, reason)
	local source = source
	local user_id = vRP.getUserId(source)
	local nuser_id = nuser_id
	if user_id and not Active[user_id]  and parseInt(value) > 0 then
		Active[user_id] = true
			local ClosestPed = vRP.userSource(nuser_id)
			if ClosestPed then
				if vRP.request(ClosestPed,"Banco","<b>" .. vRP.userIdentity(user_id).name .. "	" .. vRP.userIdentity(user_id).name2 .. "</b> lhe enviou uma fatura de <b>R$" .. parseFormat(value) .. "</b>, deseja aceita-la?") then
				local Received = nuser_id
				local Type = "received"
    			local Reason = reason
				local Holder = vRP.userIdentity(user_id).name .. " " .. vRP.userIdentity(user_id).name2
				local Value = value
				vRP.query('invoices/Add',{ user_id = user_id,Received = Received,Type = Type,Reason = Reason,Holder = Holder ,Value = Value})
				local Type = "sent"
				local Holder = "Você"
				vRP.query('invoices/Add',{ user_id = user_id,Received = Received,Type = Type,Reason = Reason,Holder = Holder ,Value = Value})
				return Invoices(user_id)
				end
			end
		Active[user_id] = nil
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--  INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Investments()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local investment = vRP.query('investments/Check',{ user_id = user_id })
		if investment[1] then
			local deposit = investment[1].Deposit
			local liquid = investment[1].Liquid
			local brute = deposit
			local total = deposit + liquid
			return {
				["deposit"] = deposit,
				["liquid"] = liquid,
				["brute"] = brute,
				["total"] = total
			}
		end
		return {
			["deposit"] = 0,
			["liquid"] = 0,
			["brute"] = 0,
			["total"] = 0
		}
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD INVESTMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Invest(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not Active[user_id] and parseInt(amount) > 0 then
		Active[user_id] = true
		if vRP.paymentBank(user_id, amount, true) then
			local investment = vRP.query('investments/Check',{ user_id = user_id })
			if  investment[1] then
				local Value = amount
				vRP.query("investments/Invest",{ user_id = user_id, Value = Value })
			else
				local Deposit = amount
				vRP.query("investments/Add",{ user_id = user_id, Deposit = Deposit })
			end
			Active[user_id] = nil
			return true
		end
		Active[user_id] = nil
		end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM INVESTMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.InvestRescue()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local investment = vRP.query('investments/Check', { user_id = user_id })

        if investment[1] then
            local deposit = investment[1].Deposit
            local liquid = investment[1].Liquid
            local totalAmount = deposit + liquid

            vRP.query("investments/Remove", { user_id = user_id })
            vRP.addBank(user_id, totalAmount,"Private")

			TriggerClientEvent("Notify",source,"verde","Você resgatou <b>$" .. totalAmount .. "</b> do seu investimento.",6000)
        else
			TriggerClientEvent("Notify",source,"amarelo","Nenhum investimento encontrado para saque.",6000)
        end
    else
		TriggerClientEvent("Notify",source,"vermelho","Identidade inválida para saque.",6000)
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTransactions",function(user_id,Type,amount)
	if vRP.userIdentity(user_id) then
	  local user_id = user_id
	  local Type = Type
	  local Date = os.date("%d/%m/%Y")
	  local Value = amount
	  local Balance = vRP.userIdentity(user_id).bank
	  vRP.query("transactions/Add", {user_id = user_id,Type = Type,Date = Date,Value = Value,Balance = Balance})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTaxs", function(user_id, Name, Value, Message)
	if vRP.userIdentity(user_id) then
		local user_id = user_id
		local Name = Name
		local Date = os.date("%d/%m/%Y")
		local Hour = os.date("%H:%M")
		local Value = Value
		local Message = Message
	  vRP.query("taxs/Add", {user_id = user_id,Name = Name,Date = Date,Hour = Hour,Value = Value,Message = Message}) 
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect", function(user_id)
	if Active[user_id] then
	  Active[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Taxs", Taxs)
exports("Invoices", Invoices)
exports("Transactions", Transactions)