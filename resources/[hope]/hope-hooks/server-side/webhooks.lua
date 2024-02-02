-----------------------------------------------------------------------------------------------------------------------------------------
-- HOPEHOOKS
-----------------------------------------------------------------------------------------------------------------------------------------
local HopeHooks = {
	["Connect"] = "https://discord.com/api/webhooks/1202286145896198164/NWghxC4D0nqXnVbJtT7vfx0Dra9DKukVNLcg8Wm8Izr62XIYX8wpMFdq8QiMZfIdD_Tk",
	["Disconnect"] = "https://discord.com/api/webhooks/1202282181561679995/ccXuGRMBEuZt2XTT08XAfVKANBnMWcrnz4F3TpBHfmYtaLEdw6jCCRediS8m4EnVfHza",
	["Airport"] = "https://discord.com/api/webhooks/1202282279028932628/SW9FGxHcp0TYpT-edfPH68ufae3cN0iCvsy2F-2EMNp4T2SyxxmPFhPo7P1CMg8TVA-W",
	["Deaths"] = "https://discord.com/api/webhooks/1202282390693879829/I662AC5qvCoRiU6MQrHiUTkVBBBes_kC8-5Xc6w_nd1WLtQEoXy9gYf32RGF1oYdSCHc",
	["Police"] = "https://discord.com/api/webhooks/1202282732995227710/TP8Wocv8-Og-D-HCY-EPJbIHDJepnnACFlP1apMR8n-DA_Md8aVtHc-oXgrONuJXaSWb",
	["Lspd"] = "https://discord.com/api/webhooks/1202282844840263690/NnOUw0bjkkw2mkbZDBN615xVahWinKqq8zQnR8Ge_8JeagH3EK8UFGSajk3jxE1Nsr6K",
	["Paramedic"] = "https://discord.com/api/webhooks/1202282951681773588/qcWBG_YWJ2r5UPoj9fAylWcS4HAuLoxmLjxhT2fsIr_KiMtOUOPfFcxKUPbBk1Aozmzv",
	["Hackers"] = "https://discord.com/api/webhooks/1202283010846625872/LhnpIY6XjDxoL9gSs-m2lCE2SHi8i6Nyl7P0C_Po5umksq3FE2zo3Qy4O6rFYDrVnWL1",
	["Gemstones"] = "https://discord.com/api/webhooks/1202283107030683649/Uvej84-R7nRpX1fVEzvhJGVmg_BIIZJmBsrW4ORh76MCkBwKJQC2MW7kW80v3BoVN1T8",
	["Badges"] = "https://discord.com/api/webhooks/1202283172054974495/41CscuNNry2uy2Rn92hAJHx21gYyOEWlsvLXUo4Tf_tVnLynomuoZntRodPYoJ4LU3YR"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs",function(webhook,message,color)
	PerformHttpRequest(HopeHooks[webhook],function(err,text,headers) end,"POST",json.encode({
		username = "Hopezinha",
		embeds = { { color = color, description = message } }
	}),{ ["Content-Type"] = "application/json" })
end)