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
Tunnel.bindInterface("garages",Hope)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local searchBlip = nil
local spawnSelected = {}
local vehHotwired = false
local anim = "machinic_loop_mechandplayer"
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local garageLocates = {
	["1"] = { x = 55.44, y = -876.17, z = 30.67,
		["1"] = { 60.44,-866.47,30.23,340.16 },
		["2"] = { 57.26,-865.35,30.25,340.16 },
		["3"] = { 54.03,-864.21,30.25,340.16 },
		["4"] = { 50.73,-863.01,30.26,340.16 },
		["5"] = { 60.52,-866.53,30.14,340.16 },
		["6"] = { 50.73,-873.28,30.11,158.75 },
		["7"] = { 47.36,-872.07,30.13,158.75 },
		["8"] = { 44.15,-870.9,30.13,158.75 }
	},
	["2"] = { x = 599.04, y = 2745.33, z = 42.04,
		["1"] = { 604.82,2738.27,41.64,187.09 },
		["2"] = { 601.75,2738.08,41.65,184.26 },
		["3"] = { 598.63,2737.85,41.69,184.26 },
		["4"] = { 595.59,2737.55,41.7,184.26 }
	},
	["3"] = { x = -136.8, y = 6356.84, z = 31.49,
		["1"] = { -133.72,6349.01,31.16,42.52 },
		["2"] = { -136.1,6346.53,31.16,42.52 }
	},
	["4"] = { x = 275.23, y = -345.56, z = 45.17,
		["1"] = { 266.06,-332.07,44.58,252.29 },
		["2"] = { 267.18,-328.9,44.58,252.29 },
		["3"] = { 268.32,-325.67,44.58,252.29 },
		["4"] = { 269.53,-322.4,44.58,252.29 },
		["5"] = { 270.77,-319.14,44.58,252.29 }
	},
	["5"] = { x = 596.43, y = 90.68, z = 93.13,
		["1"] = { 599.82,102.03,92.57,249.45 },
		["2"] = { 598.69,98.42,92.57,249.45 }
	},
	["6"] = { x = -340.57, y = 266.04, z = 85.68,
		["1"] = { -349.47,272.54,84.77,272.13 },
		["2"] = { -349.5,275.91,84.69,272.13 },
		["3"] = { -349.56,279.3,84.62,272.13 },
		["4"] = { -349.67,282.6,84.59,274.97 },
		["5"] = { -349.74,286.16,84.59,272.13 },
		["6"] = { -349.8,289.76,84.6,272.13 },
		["7"] = { -349.85,293.28,84.6,272.13 },
		["8"] = { -349.87,296.72,84.6,272.13 }
	},
	["7"] = { x = -2030.03, y = -465.99, z = 11.59,
		["1"] = { -2037.4,-461.02,11.07,138.9 },
		["2"] = { -2039.78,-459.07,11.07,138.9 },
		["3"] = { -2042.12,-457.1,11.07,138.9 },
		["4"] = { -2044.47,-455.11,11.07,138.9 },
		["5"] = { -2046.85,-453.09,11.07,138.9 },
		["6"] = { -2049.12,-451.17,11.07,138.9 },
		["7"] = { -2051.51,-449.23,11.07,138.9 }
	},
	["8"] = { x = -1184.94, y = -1509.99, z = 4.65,
		["1"] = { -1183.29,-1495.81,4.04,121.89 },
		["2"] = { -1185.23,-1493.28,4.04,121.89 },
		["3"] = { -1186.87,-1490.71,4.04,121.89 },
		["4"] = { -1188.69,-1488.27,4.04,121.89 }
	},
	["9"] = { x = 101.23, y = -1073.64, z = 29.37,
		["1"] = { 105.9,-1063.14,28.88,246.62 },
		["2"] = { 107.42,-1059.61,28.88,246.62 },
		["3"] = { 108.88,-1056.23,28.88,246.62 },
		["4"] = { 110.27,-1052.86,28.88,246.62 }
	},
	["10"] = { x = 213.97, y = -808.43, z = 31.0,
		["1"] = { 221.93,-804.11,30.35,249.45 },
		["2"] = { 222.9,-801.61,30.33,249.45 },
		["3"] = { 223.92,-799.2,30.33,249.45 },
		["4"] = { 224.85,-796.69,30.33,249.45 }
	},
	["11"] = { x = -348.89, y = -874.02, z = 31.31,
		["1"] = { -343.62,-875.51,30.75,167.25 },
		["2"] = { -339.98,-876.27,30.75,167.25 },
		["3"] = { -336.35,-876.98,30.75,167.25 },
		["4"] = { -332.72,-877.71,30.75,167.25 }
	},
	["12"] = { x = 67.72, y = 12.3, z = 69.22,
		["1"] = { 63.87,16.5,68.87,340.16 },
		["2"] = { 60.78,17.6,68.92,340.16 },
		["3"] = { 57.76,18.76,69.03,340.16 },
		["4"] = { 54.8,19.92,69.25,340.16 }
	},
	["13"] = { x = 361.96, y = 297.8, z = 103.88,
		["1"] = { 371.06,284.68,102.94,340.16 },
		["2"] = { 374.8,283.39,102.85,340.16 },
		["3"] = { 378.62,282.06,102.78,340.16 }
	},
	["14"] = { x = 1035.84, y = -763.87, z = 58.0,
		["1"] = { 1046.56,-774.55,57.69,90.71 },
		["2"] = { 1046.56,-778.24,57.68,90.71 },
		["3"] = { 1046.55,-782.0,57.68,90.71 },
		["4"] = { 1046.54,-785.65,57.66,90.71 }
	},
	["15"] = { x = -796.69, y = -2022.85, z = 9.17,
		["1"] = { -779.77,-2040.03,8.56,314.65 },
		["2"] = { -777.36,-2042.58,8.56,314.65 },
		["3"] = { -774.92,-2044.9,8.56,314.65 }
	},
	["16"] = { x = 453.28, y = -1146.77, z = 29.5,
		["1"] = { 467.33,-1151.89,28.96,85.04 },
		["2"] = { 467.16,-1154.75,28.96,85.04 },
		["3"] = { 467.1,-1157.73,28.96,87.88 }
	},
	["17"] = { x = 528.65, y = -146.25, z = 58.37,
		["1"] = { 540.99,-136.2,59.13,178.59 },
		["2"] = { 544.84,-136.25,59.01,178.59 },
		["3"] = { 548.83,-136.31,59.01,181.42 },
		["4"] = { 552.81,-136.41,58.99,178.59 }
	},
	["18"] = { x = -1159.56, y = -739.39, z = 19.88,
		["1"] = { -1144.95,-745.49,19.34,104.89 },
		["2"] = { -1142.76,-748.44,19.19,107.72 },
		["3"] = { -1140.18,-751.41,19.06,107.72 },
		["4"] = { -1137.99,-754.36,18.91,107.72 },
		["5"] = { -1135.43,-757.3,18.75,107.72 },
		["6"] = { -1133.12,-760.4,18.59,107.72 },
		["7"] = { -1130.59,-763.27,18.43,107.72 }
	},
	["19"] = { x = -791.48, y = 336.48, z = 85.7,
		["1"] = { -791.64,331.67,85.38,181.42 }
	},
	["20"] = { x = -800.45, y = 336.61, z = 85.7,
		["1"] = { -800.38,331.9,85.38,181.42 }
	},
	["21"] = { x = 935.95, y = 0.36, z = 78.76,
		["1"] = { 933.29,-3.74,78.44,147.41 }
	},
	["22"] = { x = 1725.21, y = 4711.77, z = 42.11,
		["1"] = { 1722.82,4700.38,42.28,87.88 }
	},
	["23"] = { x = 1624.05, y = 3566.14, z = 35.15,
		["1"] = { 1633.27,3563.91,34.91,303.31 }
	},
	["24"] = { x = 1143.8, y = 2667.46, z = 38.15,
		["1"] = { 1137.41,2674.26,37.83,0.0 }
	},
	["25"] = { x = -73.35, y = -2004.6, z = 18.27,
		["1"] = { -59.61,-1990.85,17.69,155.91 },
		["2"] = { -63.69,-1989.71,17.69,167.25 },
		["3"] = { -67.6,-1989.01,17.69,170.08 },
		["4"] = { -71.34,-1988.57,17.69,172.92 },
		["5"] = { -74.96,-1988.07,17.69,170.08 },
		["6"] = { -78.64,-1987.63,17.69,170.08 },
		["7"] = { -82.27,-1987.19,17.69,170.08 }
	},
	["41"] = { x = 340.08, y = -576.19, z = 28.8,
		["1"] = { 333.34,-574.76,28.48,340.16 }
	},
	["42"] = { x = 338.19, y = -586.91, z = 74.16,
		["1"] = { 351.76,-588.19,74.16,337.33 }
	},
	["43"] = { x = 1836.32, y = 3671.52, z = 34.27,
		["1"] = { 1834.99,3665.03,33.41,212.6 },
		["2"] = { 1831.73,3663.18,33.51,212.6 },
		["3"] = { 1828.42,3661.31,33.56,212.6 }
	},
	["44"] = { x = 1845.6, y = 3642.89, z = 35.64,
		["1"] = { 1843.61,3636.48,35.64,5.0 }
	},
	["45"] = { x = -253.92, y = 6339.42, z = 32.42,
		["1"] = { -258.47,6347.58,32.1,269.3 },
		["2"] = { -261.6,6344.21,32.1,269.3 },
		["3"] = { -264.97,6340.84,32.1,272.13 }
	},
	["46"] = { x = -271.7, y = 6321.75, z = 32.42,
		["1"] = { -273.13,6329.85,32.1,133.23 }
	},
	["61"] = { x = 443.49, y = -974.47, z = 25.7,
		["1"] = { 436.84,-986.18,25.38,87.88 },
		["2"] = { 436.8,-988.86,25.38,87.88 },
		["3"] = { 436.86,-991.6,25.38,87.88 },
		["4"] = { 436.88,-994.28,25.38,87.88 },
		["5"] = { 436.9,-997.0,25.38,87.88 },
		["6"] = { 425.97,-997.08,25.38,272.13 },
		["7"] = { 425.98,-994.43,25.38,272.13 },
		["8"] = { 425.99,-991.7,25.38,272.13 },
		["9"] = { 425.94,-989.05,25.38,272.13 },
		["10"] = { 426.07,-984.27,25.38,269.3 },
		["11"] = { 426.06,-981.56,25.38,272.13 },
		["12"] = { 426.07,-978.93,25.38,272.13 },
		["13"] = { 426.0,-976.19,25.38,272.13 },
		["14"] = { 445.85,-986.14,25.38,269.3 },
		["15"] = { 445.88,-988.76,25.38,272.13 },
		["16"] = { 445.86,-991.56,25.38,272.13 },
		["17"] = { 445.93,-994.28,25.38,272.13 },
		["18"] = { 445.92,-997.01,25.38,272.13 }
	},
	["62"] = { x = 463.15, y = -982.33, z = 43.69,
		["1"] = { 449.27,-981.34,43.69,87.88 }
	},
	["63"] = { x = 1883.85, y = 3697.3, z = 33.53,
		["1"] = { 1877.4,3707.32,33.21,212.6 },
		["2"] = { 1874.37,3705.61,33.21,212.6 },
		["3"] = { 1871.24,3703.79,33.21,212.6 },
		["4"] = { 1879.31,3690.02,33.21,28.35 },
		["5"] = { 1882.29,3691.76,33.21,28.35 }
	},
	["64"] = { x = 1867.51, y = 3656.31, z = 35.6,
		["1"] = { 1865.32,3647.66,35.6,28.35 }
	},
	["65"] = { x = -459.37, y = 6016.01, z = 31.49,
		["1"] = { -469.04,6038.77,31.0,226.78 },
		["2"] = { -472.45,6035.42,31.0,226.78 },
		["3"] = { -476.09,6031.71,31.0,226.78 },
		["4"] = { -479.61,6028.09,31.0,226.78 },
		["5"] = { -482.7,6024.95,31.0,226.78 }
	},
	["66"] = { x = -479.48, y = 6011.12, z = 31.29,
		["1"] = { -475.04,5988.45,31.73,317.49 }
	},
	["67"] = { x = 1840.78, y = 2545.84, z = 45.66,
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["68"] = { x = 1840.79, y = 2538.28, z = 45.66,
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["69"] = { x = 377.58, y = 791.66, z = 187.64,
		["1"] = { 374.46,796.86,187.03,178.59 }
	},
	["70"] = { x = 382.12, y = -1617.63, z = 29.28,
		["1"] = { 386.96,-1615.25,28.96,232.45 },
		["2"] = { 388.99,-1612.91,28.96,229.61 },
		["3"] = { 390.91,-1610.57,28.96,232.45 },
		["4"] = { 392.96,-1608.22,28.96,229.61 }
	},
	["71"] = { x = 381.17, y = -1634.05, z = 29.28,
		["1"] = { 384.12,-1623.63,29.67,320.32 }
	},
	["72"] = { x = 392.56, y = -1632.1, z = 29.28,
		["1"] = { 397.13,-1622.63,29.55,320.32 }
	},
	["101"] = { x = 156.44, y = -1065.79, z = 30.04,
		["1"] = { 162.3,-1069.1,29.18,70.87 }
	},
	["102"] = { x = -1188.13, y = -1574.47, z = 4.35,
		["1"] = { -1188.48,-1572.54,4.33,306.15 },
		["2"] = { -1189.39,-1571.49,4.33,306.15 }
	},
	["103"] = { x = -777.44, y = 5593.64, z = 33.63,
		["1"] = { -776.98,5590.38,33.48,260.79 },
		["2"] = { -778.25,5586.74,33.48,255.12 }
	},
	["104"] = { x = 435.06, y = -647.39, z = 28.73,
		["1"] = { 430.22,-646.82,27.89,116.23 }
	},
	["105"] = { x = -896.38, y = -779.06, z = 15.91,
		["1"] = { -898.74,-779.98,15.22,113.39 }
	},
	["106"] = { x = -1668.56, y = -998.63, z = 7.38,
		["1"] = { -1670.4,-1000.79,6.77,138.9 }
	},
	["107"] = { x = 821.79, y = -786.84, z = 26.18,
		["1"] = { 824.47,-787.3,25.58,255.12 }
	},
	["108"] = { x = -1164.77, y = -896.74, z = 14.02,
		["1"] = { -1167.52,-897.2,13.33,34.02 }
	},
	["109"] = { x = 1576.12, y = 6464.71, z = 24.94,
		["1"] = { 1574.55,6462.57,24.28,161.58 }
	},
	["110"] = { x = 102.53, y = -1957.14, z = 20.74,
		["1"] = { 104.77,-1957.89,20.14,17.01 }
	},
	["111"] = { x = -161.23, y = -1623.57, z = 33.65,
		["1"] = { -162.25,-1626.75,33.65,130.4 }
	},
	["112"] = { x = 337.84, y = -2036.2, z = 21.37,
		["1"] = { 334.74,-2039.98,20.47,51.03 }
	},
	["113"] = { x = 524.05, y = -1829.38, z = 28.43,
		["1"] = { 525.55,-1831.05,27.58,141.74 }
	},
	["114"] = { x = 232.37, y = -1756.87, z = 29.0,
		["1"] = { 234.81,-1754.17,28.43,320.32 }
	},
	["115"] = { x = 143.91, y = 6653.49, z = 31.53,
		["1"] = { 139.73,6649.65,30.9,229.61 }
	},
	["116"] = { x = 1703.32, y = 4820.19, z = 41.97,
		["1"] = { 1706.85,4823.46,41.4,39.69 }
	},
	["117"] = { x = 958.53, y = 3618.86, z = 32.67,
		["1"] = { 952.0,3619.3,31.95,87.88 }
	},
	["118"] = { x = 1032.52, y = 2656.05, z = 39.55,
		["1"] = { 1030.05,2656.78,38.94,2.84 }
	},
	["121"] = { x = -1728.06, y = -1050.69, z = 1.7,
		["1"] = { -1734.05,-1057.01,0.94,133.23 }
	},
	["122"] = { x = 1966.55, y = 3976.15, z = 31.49,
		["1"] = { 1971.66,3985.42,30.13,331.66 }
	},
	["123"] = { x = -776.63, y = -1494.93, z = 2.29,
		["1"] = { -786.5,-1498.89,-0.57,110.56 }
	},
	["124"] = { x = -895.04, y = 5687.46, z = 3.03,
		["1"] = { -907.5,5684.52,0.76,102.05 }
	},
	["125"] = { x = 1509.64, y = 3788.7, z = 33.51,
		["1"] = { 1493.4,3797.23,29.89,50.19 }
	},
	["126"] = { x = 4971.79, y = -5170.93, z = 2.27,
		["1"] = { 4952.76,-5163.61,-0.39,65.2 }
	},
	["141"] = { x = -842.47, y = 5403.79, z = 34.61,
		["1"] = { -838.49,5405.64,33.78,345.83 }
	},
	["142"] = { x = 453.74, y = -600.6, z = 28.59,
		["1"] = { 462.81,-606.03,28.49,212.6 },
		["2"] = { 461.54,-612.34,28.49,215.44 },
		["3"] = { 460.98,-619.81,28.49,215.44 }
	},
	["143"] = { x = 84.18, y = -1552.0, z = 29.59,
		["1"] = { 80.56,-1541.11,29.17,48.19 },
		["2"] = { 76.58,-1545.85,29.17,48.19 },
		["3"] = { 72.59,-1550.58,29.17,48.19 }
	},
	["144"] = { x = 355.15, y = 275.79, z = 103.15,
		["1"] = { 359.95,272.31,102.72,340.16 },
		["2"] = { 364.05,270.74,102.68,340.16 },
		["3"] = { 368.1,269.31,102.67,340.16 }
	},
	["145"] = { x = 905.6, y = -165.08, z = 74.11,
		["1"] = { 916.21,-170.61,74.04,99.22 },
		["2"] = { 918.35,-167.18,74.22,99.22 },
		["3"] = { 920.64,-163.54,74.43,99.22 }
	},
	["146"] = { x = -154.58, y = -1174.61, z = 23.99,
		["1"] = { -141.94,-1180.86,23.86,87.88 }
	},
	["147"] = { x = 1731.42, y = 3708.32, z = 34.17,
		["1"] = { 1728.51,3715.11,34.26,19.85 }
	},
	["148"] = { x = -275.07, y = 6120.22, z = 31.32,
		["1"] = { -282.22,6133.17,31.59,226.78 }
	},
	["149"] = { x = 283.93, y = 2849.5, z = 43.64,
		["1"] = { 277.34,2840.0,43.29,28.35 }
	},
	["150"] = { x = -412.39, y = 6171.06, z = 31.48,
		["1"] = { -401.19,6167.31,31.24,317.49 }
	},
	["151"] = { x = 1695.55, y = 4787.69, z = 42.01,
		["1"] = { 1691.56,4782.3,41.52,87.88 },
		["2"] = { 1691.54,4778.38,41.53,87.88 },
		["3"] = { 1691.56,4774.37,41.53,87.88 },
		["4"] = { 1691.57,4770.32,41.53,87.88 },
		["5"] = { 1691.5,4766.35,41.53,87.88 },
		["6"] = { 1691.52,4762.46,41.52,87.88 }
	},
	["152"] = { x = 156.45, y = -3044.33, z = 7.03,
		["1"] = { 165.67,-3043.99,5.98,272.13 },
		["2"] = { 165.67,-3050.43,5.98,272.13 }
	},
	["153"] = { x = -593.07, y = -1058.59, z = 22.34,
		["1"] = { -596.71,-1059.2,22.31,87.88 }
	},
	["154"] = { x = -1924.44, y = 2060.51, z = 140.83,
		["1"] = { -1919.81,2067.46,140.17,226.78 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleMods(veh,vehCustom)
	if vehCustom then
		SetVehicleModKit(veh,0)

		if vehCustom["wheeltype"] ~= nil then
			SetVehicleWheelType(veh,vehCustom["wheeltype"])
		end

		if vehCustom["mods"] then
			for i = 0,16 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end

			for i = 17,22 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end

			for i = 23,24 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					if vehCustom["var"] == nil then
						vehCustom["var"] = {}
						vehCustom["var"][tostring(i)] = 0
					end

					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)],vehCustom["var"][tostring(i)])
				end
			end

			for i = 25,48 do
				if vehCustom["mods"][tostring(i)] ~= nil then
					SetVehicleMod(veh,i,vehCustom["mods"][tostring(i)])
				end
			end
		end

		if vehCustom["neon"] ~= nil then
			for i = 0,3 do
				SetVehicleNeonLightEnabled(veh,i,vehCustom["neon"][tostring(i)])
			end
		end

		if vehCustom["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(vehCustom["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(veh,i,0)
				else
					SetVehicleExtra(veh,i,1)
				end
			end
		end

		if vehCustom["liverys"] ~= nil and vehCustom["liverys"] ~= 24  then
			SetVehicleLivery(veh,vehCustom["liverys"])
		end

		if vehCustom["plateIndex"] ~= nil and vehCustom["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(veh,vehCustom["plateIndex"])
		end

		SetVehicleXenonLightsColour(veh,vehCustom["xenonColor"])
		SetVehicleColours(veh,vehCustom["colors"][1],vehCustom["colors"][2])
		SetVehicleExtraColours(veh,vehCustom["extracolors"][1],vehCustom["extracolors"][2])
		SetVehicleNeonLightsColour(veh,vehCustom["lights"][1],vehCustom["lights"][2],vehCustom["lights"][3])
		SetVehicleTyreSmokeColor(veh,vehCustom["smokecolor"][1],vehCustom["smokecolor"][2],vehCustom["smokecolor"][3])

		if vehCustom["tint"] ~= nil then
			SetVehicleWindowTint(veh,vehCustom["tint"])
		end

		if vehCustom["dashColour"] ~= nil then
			SetVehicleInteriorColour(veh,vehCustom["dashColour"])
		end

		if vehCustom["interColour"] ~= nil then
			SetVehicleDashboardColour(veh,vehCustom["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.spawnPosition(openGarage)
	local checkSlot = 0
	local checkPos = nil

	repeat
		checkSlot = checkSlot + 1

		if garageLocates[openGarage][tostring(checkSlot)] ~= nil then
			local _,groundZ = GetGroundZAndNormalFor_3dCoord(garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],garageLocates[openGarage][tostring(checkSlot)][3])
			spawnSelected = { garageLocates[openGarage][tostring(checkSlot)][1],garageLocates[openGarage][tostring(checkSlot)][2],groundZ,garageLocates[openGarage][tostring(checkSlot)][4] }
			checkPos = GetClosestVehicle(spawnSelected[1],spawnSelected[2],spawnSelected[3],2.501,0,71)
		end
	until not DoesEntityExist(checkPos) or garageLocates[openGarage][tostring(checkSlot)] == nil

	if garageLocates[openGarage][tostring(checkSlot)] == nil then
		TriggerEvent("Notify","amarelo","Vagas estão ocupadas.",5000)
		return false
	end

	return spawnSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.createVehicle(vehModel,vehNet,vehEngine,vehCustom,vehWindows,vehTyres)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		local MaxSpeed = 186,411
		if DoesEntityExist(Vehicle) then

			if vehCustom ~= nil then
				local vehMods = json.decode(vehCustom)
				vehicleMods(Vehicle,vehMods)
			end

			SetVehicleMaxSpeed(Vehicle, (MaxSpeed / 2.236936))
			SetVehicleEngineHealth(Vehicle,vehEngine + 0.0)

			if vehWindows then
				local vehWindows = json.decode(vehWindows)
				if vehWindows ~= nil then
					for k,v in pairs(vehWindows) do
						if not v then
							RemoveVehicleWindow(Vehicle,parseInt(k))
						end
					end
				end
			end

			if vehTyres then
				local vehTyres = json.decode(vehTyres)
				if vehTyres ~= nil then
					for k,Burst in pairs(vehTyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle,parseInt(k),true,1000.0)
						end
					end
				end
			end

			SetModelAsNoLongerNeeded(vehModel)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle)
	if Vehicle == nil or Vehicle == "" then
		Vehicle = vRP.nearVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0,5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle,i)
		end

		for i = 0,5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle,i)
		end

		for i = 0,7 do
			local Status = false

			if GetTyreHealth(Vehicle,i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		vSERVER.tryDelete(VehToNet(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),GetVehicleFuelLevel(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.searchBlip(vehCoords)
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end

	searchBlip = AddBlipForCoord(vehCoords["x"],vehCoords["y"],vehCoords["z"])
	SetBlipSprite(searchBlip,225)
	SetBlipColour(searchBlip,2)
	SetBlipScale(searchBlip,0.6)
	SetBlipAsShortRange(searchBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(searchBlip)

	SetTimeout(30000,function()
		RemoveBlip(searchBlip)
		searchBlip = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.startAnimHotwired()
	vehHotwired = true

	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	TaskPlayAnim(PlayerPedId(),animDict,anim,3.0,3.0,-1,49,5.0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.stopAnimHotwired(vehicle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(1)
	end

	vehHotwired = false
	StopAnimTask(PlayerPedId(),animDict,anim,2.0)

	if vehicle ~= nil then
		local netVeh = VehToNet(vehicle)

		SetNetworkIdCanMigrate(netVeh,true)

		SetEntityAsMissionEntity(vehicle,true,false)
		SetVehicleHasBeenOwnedByPlayer(vehicle,true)
		SetVehicleNeedsToBeHotwired(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Hope.updateHotwired(status)
	vehHotwired = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local platext = GetVehicleNumberPlateText(vehicle)
			if GetPedInVehicleSeat(vehicle,-1) == ped and not GlobalState["vehPlates"][platext] then
				SetVehicleEngineOn(vehicle,false,true,true)
				DisablePlayerFiring(ped,true)
				timeDistance = 1
			end

			if vehHotwired and vehicle then
				DisableControlAction(1,75,true)
				DisableControlAction(1,20,true)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATELOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateLocs")
AddEventHandler("garages:updateLocs",function(homeName,homeInfos)
	garageLocates[homeName] = homeInfos
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:UPDATEREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:updateRemove")
AddEventHandler("garages:updateRemove",function(homeName,homeInfos)
	if garageLocates[homeName] then
		garageLocates[homeName] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:ALLLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:allLocs")
AddEventHandler("garages:allLocs",function(garageTable)
	for k,v in pairs(garageTable) do
		garageLocates[k] = v
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound",function()
	if not menuOpen then
		local Impound = vSERVER.Impound()
		if parseInt(#Impound) > 0 then
			for k,v in pairs(Impound) do
				exports["dynamic"]:AddButton(v["name"],"Clique para iniciar a liberação.","garages:Impound",v["model"],false,true)
			end

			exports["dynamic"]:openMenu()
		else
			TriggerEvent("Notify","amarelo","Não possui veículos apreendidos.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(garageLocates) do
				local distance = #(coords - vector3(v["x"],v["y"],v["z"]))
				if distance <= 15 then
					timeDistance = 1
					DrawMarker(23,v["x"],v["y"],v["z"] - 0.95,0.0,0.0,0.0,0.0,0.0,0.0,1.75,1.75,0.0,46,110,76,100,0,0,0,0)

					if IsControlJustPressed(1,38) and distance <= 1.0 and MumbleIsConnected() then
						local Vehicles = vSERVER.Vehicles(k)
						if Vehicles then
							if parseInt(#Vehicles) > 0 then
								exports["dynamic"]:SubMenu("Retirar","Mostrar sua lista de veículos.","vehicles")

								for _,v in pairs(Vehicles) do
									exports["dynamic"]:AddButton(v["name"],"Clique para retira-lo.","garages:Spawn",v["model"].."-"..k,"vehicles",true)
								end
							end

							exports["dynamic"]:AddButton("Guardar","Guardar o veículo mais próximo.","garages:Delete","",false,false)

							exports["dynamic"]:openMenu()
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)