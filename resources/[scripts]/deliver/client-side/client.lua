-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hope = {}
Tunnel.bindInterface("deliver",Hope)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Locate = ""
local Selected = 1
local Starting = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local initList = {
		{ -1191.55,-900.61,14.97,"BurgerShot",1.0,1.5,"Trabalhar" },
		{ 1588.67,6455.92,25.69,"PopsDiner",1.0,1.0,"Trabalhar" },
		{ 811.29,-751.93,26.85,"PizzaThis",0.25,1.0,"Trabalhar" }
	}

	for k,v in pairs(initList) do
		exports["target"]:AddCircleZone("deliver:"..v[4],vector3(v[1],v[2],v[3]),v[5],{
			name = "deliver:"..v[4],
			heading = 3374176
		},{
			shop = v[4],
			distance = v[6],
			options = {
				{
					event = "deliver:Starting",
					tunnel = "shop",
					label = v[7]
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Cds = {
	["BurgerShot"] = {
		{ -1754.11,-708.92,10.4 },
		{ -1756.32,-692.6,10.15 },
		{ -1777.07,-701.48,10.53 },
		{ -1771.12,-677.5,10.39 },
		{ -1787.98,-672.06,10.66 },
		{ -1793.33,-663.88,10.61 },
		{ -1803.88,-661.77,10.73 },
		{ -1814.05,-656.68,10.89 },
		{ -1812.28,-640.74,10.95 },
		{ -1836.41,-631.81,10.76 },
		{ -1838.87,-629.36,11.25 },
		{ -1864.88,-594.5,11.84 },
		{ -1876.99,-584.45,11.86 },
		{ -1883.36,-578.99,11.86 },
		{ -1901.25,-586.09,11.88 },
		{ -1913.46,-574.11,11.44 },
		{ -1919.96,-569.72,11.92 },
		{ -1918.68,-542.64,11.83 },
		{ -1945.77,-544.81,11.87 },
		{ -1947.02,-543.98,11.87 },
		{ -1944.61,-527.77,11.83 },
		{ -1957.81,-528.1,12.19 },
		{ -1965.99,-509.78,11.84 },
		{ -1979.92,-520.13,11.89 },
		{ -1068.01,-1163.61,2.75 },
		{ -1074.19,-1152.64,2.16 },
		{ -1063.54,-1160.33,2.75 },
		{ -1045.96,-1159.92,2.16 },
		{ -1040.55,-1135.88,2.16 },
		{ -1034.62,-1147.16,2.16 },
		{ -1034.1,-1128.0,2.16 },
		{ -1024.44,-1139.9,2.75 },
		{ -991.78,-1103.41,2.14 },
		{ -985.81,-1121.73,4.55 },
		{ -978.1,-1108.4,2.14 },
		{ -982.82,-1083.65,2.54 },
		{ -970.33,-1093.08,2.14 },
		{ -959.81,-1109.92,2.14 },
		{ -952.45,-1077.56,2.66 },
		{ -938.63,-1087.92,2.14 },
		{ -943.12,-1075.31,2.75 },
		{ -1122.65,-1089.33,2.54 },
		{ -1114.1,-1069.37,2.14 },
		{ -1104.05,-1059.99,2.73 },
		{ -1108.74,-1040.9,2.14 },
		{ -1099.68,-1046.84,2.14 },
		{ -1091.96,-1039.88,2.14 },
		{ -1080.58,-1035.98,2.14 },
		{ -1041.7,-1025.84,2.75 },
		{ -1022.3,-1023.12,2.14 },
		{ -1023.21,-997.93,2.14 },
		{ -1014.32,-997.08,2.14 },
		{ -1007.18,-989.48,2.14 },
		{ -989.19,-989.67,2.06 },
		{ -995.49,-967.27,2.54 },
		{ -1667.72,-441.13,40.36 },
		{ -1643.14,-411.65,42.07 },
		{ -1622.87,-379.78,43.71 },
		{ -1597.22,-352.08,45.97 },
		{ -1098.1,-1678.65,4.35 },
		{ -1097.49,-1673.1,8.39 },
		{ -1058.41,-1657.39,4.67 },
		{ -1059.87,-1658.71,4.67 },
		{ -1069.8,-1653.19,4.41 },
		{ -1075.3,-1645.05,4.5 },
		{ -1071.7,-1636.56,8.19 },
		{ -1077.21,-1621.09,4.48 },
		{ -1078.8,-1616.4,4.43 },
		{ -1093.58,-1608.22,8.46 },
		{ -1105.56,-1596.97,4.62 },
		{ -1114.83,-1577.78,4.53 },
		{ -1120.16,-1583.05,8.68 },
		{ -1114.1,-1579.74,8.68 },
		{ -1112.32,-1578.44,8.68 },
		{ -1039.21,-1610.32,5.11 },
		{ -1030.12,-1604.25,4.95 },
		{ -1056.93,-1587.3,4.62 },
		{ -1041.53,-1590.48,4.99 },
		{ -1027.72,-1575.45,5.26 },
		{ -1057.71,-1540.73,5.11 },
		{ -1065.92,-1545.87,4.9 },
		{ -1076.92,-1554.06,4.63 },
		{ -1084.43,-1559.28,4.79 },
		{ -1108.28,-1527.19,6.77 },
		{ -1087.35,-1529.28,4.7 },
		{ -1078.54,-1524.01,5.09 },
		{ -1070.43,-1515.19,5.29 },
		{ -1085.88,-1504.0,5.71 },
		{ -1086.22,-1492.37,5.12 },
		{ -1102.43,-1491.95,4.89 },
		{ -1111.02,-1497.96,4.67 },
		{ -1116.92,-1505.61,4.4 },
		{ -1130.09,-1496.76,4.43 },
		{ -1117.79,-1488.46,4.73 },
		{ -1109.09,-1482.42,4.92 },
		{ -1135.16,-1468.29,4.62 },
		{ -1142.29,-1461.15,4.62 },
		{ -1146.19,-1466.4,4.5 },
		{ -1146.25,-1466.47,7.75 },
		{ -1142.3,-1461.13,7.68 },
		{ -1136.53,-1466.25,7.68 },
		{ -1150.1,-1473.54,4.38 },
		{ -1247.02,-1358.29,7.82 },
		{ -1256.24,-1359.98,4.03 },
		{ -1256.38,-1330.98,4.08 },
		{ -1271.8,-1297.47,8.29 },
		{ -1272.55,-1295.41,8.29 },
		{ -1270.08,-1296.32,3.99 },
		{ -1308.23,-1227.87,4.89 },
		{ -1305.61,-1228.66,8.98 },
		{ -1306.43,-1226.55,8.98 },
		{ -1309.35,-1220.5,8.98 },
		{ -1352.58,-1184.54,4.5 },
		{ -1352.5,-1176.88,4.5 },
		{ -1349.67,-1161.59,4.5 },
		{ -1335.95,-1146.94,6.72 },
		{ -1221.16,-1240.65,7.03 },
		{ -1222.94,-1241.2,7.03 },
		{ -1229.28,-1243.51,7.03 },
		{ -1230.92,-1244.17,7.03 },
		{ -1237.23,-1246.48,7.03 },
		{ -1238.86,-1247.15,7.03 },
		{ -1243.87,-1241.11,11.02 },
		{ -1237.52,-1238.76,11.02 },
		{ -1235.88,-1238.17,11.02 },
		{ -1229.6,-1235.82,11.02 },
		{ -1227.89,-1235.27,11.02 },
		{ -1221.27,-1232.82,11.02 },
		{ -1241.65,-1208.66,8.51 },
		{ -1343.16,-1091.27,6.93 },
		{ -1348.56,-1081.81,6.94 },
		{ -1372.32,-901.26,12.47 },
		{ -1354.16,-907.68,12.65 },
		{ -1364.25,-915.32,12.65 },
		{ -1317.07,-903.92,11.31 },
		{ -1332.98,-907.54,11.49 },
		{ -1328.66,-919.42,11.49 },
		{ -1493.8,-668.34,29.02 },
		{ -1498.18,-664.72,29.02 },
		{ -1495.35,-661.56,29.02 },
		{ -1490.74,-658.23,29.02 },
		{ -1486.74,-655.34,29.57 },
		{ -1482.15,-652.02,29.57 },
		{ -1478.2,-649.12,29.57 },
		{ -1473.62,-645.79,29.57 },
		{ -1469.64,-642.9,29.57 },
		{ -1465.02,-639.58,29.57 },
		{ -1461.2,-640.91,29.57 },
		{ -1452.34,-653.26,29.57 },
		{ -1454.41,-656.01,29.57 },
		{ -1459.0,-659.35,29.57 },
		{ -1462.97,-662.21,29.57 },
		{ -1467.56,-665.56,29.57 },
		{ -1471.51,-668.41,29.57 },
		{ -1489.96,-671.39,33.38 },
		{ -1493.78,-668.26,33.38 },
		{ -1498.18,-664.64,33.38 },
		{ -1495.33,-661.56,33.38 },
		{ -1490.74,-658.21,33.38 },
		{ -1486.73,-655.35,33.38 },
		{ -1482.19,-652.02,33.38 },
		{ -1478.2,-649.14,33.38 },
		{ -1473.62,-645.79,33.38 },
		{ -1469.61,-642.88,33.38 },
		{ -1465.04,-639.54,33.38 },
		{ -1461.21,-640.89,33.38 },
		{ -1457.88,-645.48,33.38 },
		{ -1455.62,-648.58,33.38 },
		{ -1452.32,-653.23,33.38 },
		{ -1454.41,-655.93,33.38 },
		{ -1459.01,-659.35,33.38 },
		{ -1462.97,-662.21,33.38 },
		{ -1467.54,-665.55,33.38 },
		{ -1471.51,-668.42,33.38 },
		{ -1476.11,-671.77,33.38 },
		{ -1564.48,-300.31,48.22 },
		{ -1569.73,-295.26,48.27 },
		{ -1574.92,-290.2,48.27 },
		{ -1582.57,-278.07,48.27 },
		{ -1583.76,-265.71,48.27 },
		{ -1555.04,-290.0,48.27 },
		{ -1560.63,-285.24,48.27 },
		{ -1566.03,-280.2,48.27 },
		{ -1560.93,-274.72,48.27 },
		{ -1555.74,-279.57,48.27 },
		{ -1550.33,-284.2,48.27 },
		{ -1542.68,-278.65,48.27 },
		{ -1541.2,-276.69,48.27 },
		{ -1538.0,-272.51,48.27 },
		{ -1536.52,-270.58,48.27 },
		{ -1533.13,-260.21,48.27 },
		{ -1538.18,-254.71,48.27 },
		{ -1542.93,-249.0,48.27 },
		{ -1084.37,-951.7,2.36 },
		{ -1085.15,-935.63,3.08 },
		{ -1074.83,-939.04,2.38 },
		{ -1053.94,-932.45,3.35 },
		{ -1043.57,-923.76,3.15 },
		{ -1031.22,-902.99,3.69 },
		{ -1022.58,-896.95,5.41 },
		{ -987.41,-891.54,2.14 },
		{ -971.34,-885.67,2.14 },
		{ -951.49,-906.02,2.75 },
		{ -948.25,-910.41,2.75 },
		{ -947.72,-928.0,2.14 },
		{ -934.99,-939.37,2.14 },
		{ -927.75,-949.64,2.75 },
		{ -908.65,-975.89,2.14 },
		{ -900.77,-982.5,2.24 },
		{ -903.17,-1005.9,2.14 },
		{ -884.28,-1072.58,2.53 },
		{ -869.09,-1105.39,2.48 },
		{ -869.47,-1103.38,6.44 }
	},
	["PopsDiner"] = {
		{ 35.36,6662.98,32.18 },
		{ -9.61,6654.22,31.69 },
		{ -41.67,6637.43,31.09 },
		{ -130.72,6551.93,29.87 },
		{ -214.93,6444.22,31.31 },
		{ -245.93,6414.41,31.46 },
		{ -272.43,6400.8,31.49 },
		{ -363.99,6339.7,29.84 },
		{ -407.38,6314.18,28.93 },
		{ -437.88,6272.34,30.06 },
		{ -442.52,6197.86,29.55 },
		{ -374.54,6191.04,31.73 },
		{ -356.87,6207.43,31.85 },
		{ -347.47,6225.41,31.88 },
		{ -379.89,6252.89,31.85 },
		{ -371.06,6266.77,31.88 },
		{ -332.76,6302.38,33.09 },
		{ -302.24,6327.03,32.89 },
		{ -280.64,6350.75,32.6 },
		{ -247.83,6370.12,31.85 },
		{ -227.39,6377.58,31.76 },
		{ -213.78,6396.32,33.08 },
		{ -188.86,6409.55,32.3 },
		{ -105.53,6528.76,30.16 },
		{ -44.34,6582.06,32.17 },
		{ -26.74,6597.33,31.86 },
		{ 1.63,6612.62,32.08 },
		{ 31.19,6596.67,32.82 },
		{ 11.52,6578.27,33.06 },
		{ -15.24,6557.58,33.24 }
	},
	["PizzaThis"] = {
		{ 952.8,-252.47,67.96 },
		{ 930.62,-245.06,69.0 },
		{ 920.99,-238.29,70.36 },
		{ 895.76,-202.14,71.97 },
		{ 840.55,-182.1,74.39 },
		{ 808.77,-163.79,75.87 },
		{ 798.53,-158.84,74.9 },
		{ 773.71,-150.13,75.62 },
		{ 1060.5,-378.17,68.22 },
		{ 1028.8,-408.26,66.34 },
		{ 1010.38,-423.4,65.34 },
		{ 987.58,-433.01,64.05 },
		{ 967.27,-451.79,62.78 },
		{ 944.46,-463.22,61.55 },
		{ 921.88,-477.9,61.08 },
		{ 906.45,-489.69,59.43 },
		{ 878.6,-498.13,58.08 },
		{ 861.51,-509.03,57.71 },
		{ 850.48,-532.66,57.93 },
		{ 844.13,-562.74,58.0 },
		{ 861.63,-583.55,58.15 },
		{ 886.78,-608.21,58.45 },
		{ 903.01,-615.54,58.45 },
		{ 928.88,-639.7,58.23 },
		{ 943.52,-653.47,58.42 },
		{ 960.31,-669.67,58.45 },
		{ 970.82,-701.28,58.49 },
		{ 979.18,-716.24,58.22 },
		{ 996.91,-729.44,57.81 },
		{ 980.19,-627.61,59.23 },
		{ 965.19,-541.92,59.72 },
		{ 1006.44,-511.06,61.0 },
		{ 1090.42,-484.36,65.66 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER:STARTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("deliver:Starting")
AddEventHandler("deliver:Starting",function(Init)
	if Cds[Init] then
		if Starting then
			Starting = false
			exports["target"]:LabelText("deliver:"..Init,"Trabalhar")

			if DoesBlipExist(Blip) then
				RemoveBlip(Blip)
				Blip = nil
			end

			if Locate ~= Init then
				Selected = 1
			end
		else
			if Locate ~= Init then
				Selected = math.random(#Cds[Init])
			end

			Locate = Init
			Starting = true
			exports["target"]:LabelText("deliver:"..Init,"Finalizar")
			Marker(Cds[Locate][Selected][1],Cds[Locate][Selected][2],Cds[Locate][Selected][3])

			while Starting do
				local timeDistance = 999
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local Coords = GetEntityCoords(ped)
					local Vector = vector3(Cds[Locate][Selected][1],Cds[Locate][Selected][2],Cds[Locate][Selected][3])
					local distance = #(Coords - Vector)

					if distance <= 15.0 then
						timeDistance = 1

						if distance <= 1.0 then
							DrawText(Vector["x"],Vector["y"],Vector["z"],"E N T R E G A R",true)
						else
							DrawText(Vector["x"],Vector["y"],Vector["z"],"E N T R E G A R",false)
						end
					end
				end

				Citizen.Wait(timeDistance)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Deliver()
	if Starting then
		local ped = PlayerPedId()
		local Coords = GetEntityCoords(ped)
		local Vector = vector3(Cds[Locate][Selected][1],Cds[Locate][Selected][2],Cds[Locate][Selected][3])
		local distance = #(Coords - Vector)

		if distance <= 1.0 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.Update()
	Selected = math.random(#Cds[Locate])
	Marker(Cds[Locate][Selected][1],Cds[Locate][Selected][2],Cds[Locate][Selected][3])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(x,y,z,text,color)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)

		if color then
			SetTextColour(150,196,172,255)
		else
			SetTextColour(204,204,204,175)
		end

		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 300

		if color then
			DrawRect(_x,_y + 0.0125,width,0.03,46,110,76,200)
		else
			DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKER
-----------------------------------------------------------------------------------------------------------------------------------------
function Marker(x,y,z)
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(Blip,1)
	SetBlipColour(Blip,2)
	SetBlipScale(Blip,0.5)
	SetBlipRoute(Blip,true)
	SetBlipAsShortRange(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega do "..Locate)
	EndTextCommandSetBlipName(Blip)
end