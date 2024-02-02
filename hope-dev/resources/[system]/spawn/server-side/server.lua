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
Tunnel.bindInterface("spawn",Hope)
vCLIENT = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local charActived = {}
local discordWebhook = "https://discord.com/api/webhooks/1202299653232791552/q5ytXmm-_utylee1-hjFAYkTXr_CdWxxfqgfvrPEsfMEKXMc8uER8bA2DZODWS53jGwE"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("accounts/GetDiscord", "SELECT discord FROM accounts WHERE steam = @steam")
vRP.prepare("Exploit","SELECT steam FROM characters WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDDISCORDWEB
-----------------------------------------------------------------------------------------------------------------------------------------
function sendDiscordWebhook(message)
    local data = {
        ["content"] = message
    }
    PerformHttpRequest(discordWebhook, function(statusCode, response, headers)
    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDISCORDID
-----------------------------------------------------------------------------------------------------------------------------------------
function getDiscordId(steam)
    local rows = vRP.query("accounts/GetDiscord", { steam = steam })
    if rows[1] and rows[1].discord then
        return rows[1].discord
    end
    return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.initSystem()
	local source = source
	local characterList = {}
	local steam = vRP.getIdentities(source)
	local consult = vRP.query("characters/getCharacters",{ steam = steam })

	if consult[1] then
		for k,v in pairs(consult) do
			table.insert(characterList,{ user_id = v["id"], name = v["name"].." "..v["name2"], locate = v["locate"] })
		end
	end

	return characterList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.characterChosen(user_id)
    local source = source
    local consult = vRP.query("Exploit",{ id = user_id})
    local steam = vRP.getIdentities(source)
    if consult[1] then
        if steam == consult[1]["steam"] then
            vRP.characterChosen(source,parseInt(user_id),nil)
			local discordId = getDiscordId(steam) -- NINGUEM MEXE
			if discordId then -- NINGUEM MEXE
				local webhookMessage = string.format("%s", discordId) -- NINGUEM MEXE
				sendDiscordWebhook(webhookMessage) -- NINGUEM MEXE
			end -- NINGUEM MEXE
        else
            vRP.execute("banneds/insertBanned",{ steam = steam, days = 999 })
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.newCharacter(name,name2,sex,locate)
	local source = source
	if charActived[source] == nil then
		charActived[source] = true

		local steam = vRP.getIdentities(source)
		local infoAccount = vRP.infoAccount(steam)
		local amountCharacters = parseInt(infoAccount["chars"])
		local myChars = vRP.query("characters/countPersons",{ steam = steam })

		if vRP.steamPremium(steam) then
			amountCharacters = amountCharacters + 1
		end

		if parseInt(amountCharacters) <= parseInt(myChars[1]["qtd"]) then
			TriggerClientEvent("Notify",source,"amarelo","Limite de personagens atingido.",3000)
			charActived[source] = nil
			return
		end

		if sex == "mp_m_freemode_01" then
			vRP.execute("characters/newCharacter",{ steam = steam, name = name, name2 = name2, locate = locate, sex = "M", phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
		else
			vRP.execute("characters/newCharacter",{ steam = steam, name = name, name2 = name2, locate = locate, sex = "F", phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
		end

		local consult = vRP.query("characters/lastCharacters",{ steam = steam })
		if consult[1] then
			vRP.execute("bank/newAccount",{ user_id = consult[1]["id"], value = 2000, mode = "Private", owner = 1 })
			vRP.characterChosen(source,consult[1]["id"],sex,locate)
			local discordId = getDiscordId(steam) -- NINGUEM MEXE
			if discordId then -- NINGUEM MEXE
				local webhookMessage = string.format("%s", discordId) -- NINGUEM MEXE
				sendDiscordWebhook(webhookMessage) -- NINGUEM MEXE
			end -- NINGUEM MEXE
			vCLIENT.closeNew(source)
		end

		charActived[source] = nil
	end
end