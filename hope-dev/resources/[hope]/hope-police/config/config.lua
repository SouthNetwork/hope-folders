Cfg = {}

Cfg.OpenNUIWithKey = false -- Abrir painel por tecla
Cfg.KeyOpenNUI = "F11" -- Tecla para abrir painel caso a função acima esteja habilitada
Cfg.CommandOpenNUI = "tabletp" -- Comando para abrir painel
Cfg.CommandEventOpenNUI = 'police:MdtHope' -- Comando para abrir painel pelo dynamic

Cfg.CleanRec = "cleanrec" -- Comando para limpar ficha

Cfg.ItemKey = "keyprison" -- Nome do item para fugir da prisão

Cfg.Preset = { -- Roupa do detento
	["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 7, texture = 15 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 127, texture = 1 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 0, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 3, texture = 15 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 16, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 135, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
	}
}

Cfg.QuantityServices = {2, 5}

Cfg.InLocates = { -- Locais dos serviços
  { 1772.89,2536.78,45.56,246.62 },
  { 1760.7,2519.03,45.56,260.79 },
  { 1758.27,2508.99,45.56,260.79 },
  { 1757.89,2507.81,45.56,255.12 },
  { 1737.37,2504.68,45.56,170.08 },
  { 1719.86,2502.73,45.56,260.79 },
  { 1706.99,2481.05,45.56,226.78 },
  { 1700.22,2474.79,45.56,229.61 },
  { 1679.53,2480.26,45.56,136.07 },
  { 1643.86,2490.76,45.56,187.09 },
  { 1635.7,2490.19,45.56,189.93 },
  { 1634.68,2490.11,45.56,181.42 },
  { 1622.39,2507.78,45.56,96.38 },
  { 1618.41,2521.4,45.56,141.74 },
  { 1609.77,2539.59,45.56,133.23 },
  { 1607.37,2541.43,45.56,102.05 },
  { 1606.28,2542.57,45.56,136.07 },
  { 1608.95,2567.03,45.56,48.19 },
  { 1624.83,2567.9,45.56,274.97 },
  { 1624.78,2567.15,45.56,263.63 },
  { 1629.9,2564.37,45.56,5.67 },
  { 1642.2,2565.22,45.56,2.84 },
  { 1643.98,2565.08,45.56,31.19 },
  { 1652.52,2564.39,45.56,2.84 },
  { 1665.09,2567.66,45.56,5.67 },
  { 1716.03,2568.78,45.56,85.04 },
  { 1715.95,2567.97,45.56,85.04 },
  { 1715.97,2567.13,45.56,85.04 },
  { 1768.78,2565.74,45.56,5.67 },
  { 1695.25,2506.62,45.56,53.86 },
  { 1630.53,2526.15,45.56,325.99 },
  { 1627.89,2543.56,45.56,226.78 },
  { 1636.13,2553.62,45.56,0.0 },
  { 1657.59,2549.32,45.56,138.9 },
  { 1649.73,2538.35,45.56,62.37 },
  { 1699.07,2535.87,45.56,153.08 },
  { 1699.63,2534.6,45.56,87.88 },
  { 1699.35,2532.08,45.56,93.55 }
}

Cfg.CoordsIntern = { 1679.94,2513.07,45.56 } -- Coordenadas de onde o detento vai quando for preso
Cfg.CoordsExtern = { 1849.93,2586.2,45.66 } -- Coordenadas de onde o detento vai quando for solto

Cfg.PolyPrison = {
	vector2(1599.45,2431.56),
	vector2(1543.26,2466.83),
	vector2(1540.58,2465.89),
	vector2(1537.80,2466.93),
	vector2(1536.79,2469.65),
	vector2(1537.92,2472.23),
	vector2(1540.80,2473.48),
	vector2(1536.07,2581.75),
	vector2(1533.29,2581.75),
	vector2(1531.35,2583.62),
	vector2(1531.15,2586.77),
	vector2(1533.02,2588.79),
	vector2(1536.04,2588.89),
	vector2(1568.57,2676.85),
	vector2(1566.71,2678.22),
	vector2(1566.08,2681.34),
	vector2(1567.89,2683.63),
	vector2(1570.29,2684.16),
	vector2(1572.85,2682.63),
	vector2(1647.19,2755.03),
	vector2(1645.70,2757.99),
	vector2(1646.85,2760.73),
	vector2(1649.50,2761.82),
	vector2(1652.07,2760.78),
	vector2(1653.18,2758.50),
	vector2(1769.56,2762.85),
	vector2(1770.16,2765.12),
	vector2(1772.76,2766.68),
	vector2(1775.47,2765.86),
	vector2(1777.09,2763.44),
	vector2(1776.01,2760.06),
	vector2(1836.80,2711.40),
	vector2(1846.36,2702.30),
	vector2(1847.30,2702.94),
	vector2(1849.87,2703.27),
	vector2(1852.21,2701.25),
	vector2(1852.37,2698.60),
	vector2(1850.69,2696.25),
	vector2(1848.18,2695.90),
	vector2(1823.39,2624.75),
	vector2(1825.63,2624.59),
	vector2(1827.44,2622.50),
	vector2(1827.38,2619.79),
	vector2(1823.81,2616.74),
	vector2(1827.65,2612.55),
	vector2(1851.68,2612.47),
	vector2(1851.87,2567.91),
	vector2(1832.34,2567.99),
	vector2(1819.15,2568.87),
	vector2(1817.03,2532.44),
	vector2(1824.94,2479.18),
	vector2(1826.98,2478.19),
	vector2(1828.07,2475.56),
	vector2(1826.83,2472.86),
	vector2(1824.38,2471.87),
	vector2(1821.40,2472.90),
	vector2(1764.08,2413.05),
	vector2(1765.36,2410.49),
	vector2(1764.36,2407.72),
	vector2(1761.70,2406.47),
	vector2(1758.85,2407.50),
	vector2(1757.83,2410.91),
	vector2(1662.19,2396.35),
	vector2(1662.43,2392.94),
	vector2(1660.08,2390.91),
	vector2(1657.42,2391.12),
	vector2(1655.45,2393.29),
	vector2(1655.68,2396.55)
}

Cfg.RunAwayPrision = true -- Se colocar true, precisa ter o item ''key'' no inventory
Cfg.CoordsLeaver = { 1760.6,2541.37,45.56 } -- Coordenadas de onde usa a taskbar pra fugir ----- [DESATIVADA]
Cfg.RunAway = { -- Coordenadas de lugares para onde o detento foge
	{ 1647.26,2763.14,45.76 },
	{ 1565.97,2682.8,45.53 },
	{ 1529.94,2585.13,45.53 },
	{ 1535.6,2467.81,45.58 },
	{ 1658.73,2390.01,45.51 },
	{ 1763.9,2405.9,45.6 },
	{ 1829.03,2473.42,45.31 },
	{ 1851.78,2703.64,45.76 },
	{ 1774.36,2767.32,45.66 }
}