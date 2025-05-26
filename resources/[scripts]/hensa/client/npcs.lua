-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawned = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	{ -- Cow
		["Distance"] = 50,
		["Coords"] = vec4(957.99,-2207.26,30.6,266.46),
		["Model"] = "a_c_cow",
		["Collision"] = true
	},{ -- Cow
		["Distance"] = 50,
		["Coords"] = vec4(956.66,-2220.51,30.58,266.46),
		["Model"] = "a_c_cow",
		["Collision"] = true
	},{ -- Cow
		["Distance"] = 50,
		["Coords"] = vec4(955.6,-2233.52,30.58,266.46),
		["Model"] = "a_c_cow",
		["Collision"] = true
	},{ -- Cow
		["Distance"] = 50,
		["Coords"] = vec4(954.49,-2247.07,30.58,266.46),
		["Model"] = "a_c_cow",
		["Collision"] = true
	},{ -- Bank Norte
		["Distance"] = 30,
		["Coords"] = vec4(-112.25, 6471.08, 31.63, 133.23),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Norte
		["Distance"] = 30,
		["Coords"] = vec4(-111.21, 6469.98, 31.63, 133.23),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Norte
		["Distance"] = 30,
		["Coords"] = vec4(-110.16, 6468.93, 31.63, 133.23),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(242.02, 227.11, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(243.82, 226.46, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(247.15, 225.25, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(248.95, 224.59, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(252.26, 223.39, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(254.05, 222.73, 106.30, 158.75),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(149.45,-1042.08,29.37,345.83),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(313.75,-280.41,54.16,343.0),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(-351.37,-51.33,49.03,343.0),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Middle
		["Distance"] = 30,
		["Coords"] = vec4(-2961.17,482.91,15.69,87.88),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Norte
		["Distance"] = 30,
		["Coords"] = vec4(1174.92,2708.21,38.08,181.42),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- Bank Sul
		["Distance"] = 30,
		["Coords"] = vec4(-1211.92,-331.91,37.78,22.68),
		["Model"] =  "s_f_y_airhostess_01",
		["Anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" },
		["Collision"] = true
	},{ -- PawnShop
		["Distance"] = 15,
		["Coords"] = vec4(174.88,-1323.7,29.35,331.66),
		["Model"] = "s_f_y_shop_mid",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Mechanic
		["Distance"] = 15,
		["Coords"] = vec4(949.93,-957.36,39.5,93.55),
		["Model"] = "mp_m_waremech_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 1
		["Distance"] = 100,
		["Coords"] = vec4(76.99,-194.58,54.49,249.45),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 2
		["Distance"] = 100,
		["Coords"] = vec4(-1686.58,26.39,64.38,314.65),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 3
		["Distance"] = 100,
		["Coords"] = vec4(-616.03,-1209.16,14.2,320.32),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 4
		["Distance"] = 100,
		["Coords"] = vec4(964.11,-1035.85,40.83,277.8),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 5
		["Distance"] = 100,
		["Coords"] = vec4(453.0,-1917.46,24.7,209.77),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 6
		["Distance"] = 100,
		["Coords"] = vec4(1700.43,3766.2,34.42,314.65),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 7
		["Distance"] = 100,
		["Coords"] = vec4(-197.57,6233.16,31.49,229.61),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Garagem 8
		["Distance"] = 100,
		["Coords"] = vec4(1109.02,2660.88,37.98,0.0),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Desmanche
		["Distance"] = 100,
		["Coords"] = vec4(778.49,-395.89,33.43,99.22),
		["Model"] = "g_m_y_salvagoon_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" },
		["Collision"] = true
	},{ -- Towed
		["Distance"] = 50,
		["Coords"] = vec4(408.91,-1622.75,29.28,232.45),
		["Model"] = "u_m_o_finguru_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Towed Impound
		["Distance"] = 50,
		["Coords"] = vec4(392.31,-1645.23,29.28,323.15),
		["Model"] = "s_m_m_gardener_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Concessionária
		["Distance"] = 25,
		["Coords"] = vec4(-56.98,-1098.79,26.42,25.52),
		["Model"] = "player_zero",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Lixeiro
		["Distance"] = 50,
		["Coords"] = vec4(-322.25,-1545.87,31.02,272.13),
		["Model"] = "s_m_y_winclean_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Transporter Garagem
		["Distance"] = 50,
		["Coords"] = vec4(233.4,201.1,105.38,164.41),
		["Model"] = "cs_casey",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Bus
		["Distance"] = 50,
		["Coords"] = vec4(453.47,-602.34,28.59,266.46),
		["Model"] = "a_m_y_business_02",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Hotel
		["Distance"] = 50,
		["Coords"] = vec4(-772.76,312.81,85.7,181.42),
		["Model"] = "s_m_y_doorman_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- GoPostal
		["Distance"] = 50,
		["Coords"] = vec4(68.99,127.46,79.21,158.75),
		["Model"] = "s_m_m_postal_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Megamall
		["Distance"] = 50,
		["Coords"] = vec4(46.7,-1749.71,29.62,51.03),
		["Model"] = "ig_dale",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Clandestine
		["Distance"] = 50,
		["Coords"] = vec4(179.9,2779.98,45.7,189.93),
		["Model"] = "csb_paige",
		["Anim"] = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},{ -- MoneyWash
		["Distance"] = 50,
		["Coords"] = vec4(457.09,-916.82,26.4,280.63),
		["Model"] = "ig_money",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Taxi
		["Distance"] = 50,
		["Coords"] = vec4(901.97,-167.97,74.07,238.12),
		["Model"] = "ig_dale",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Caminhoneiro Garagem
		["Distance"] = 100,
		["Coords"] = vec4(1265.03,-3278.42,5.9,87.88),
		["Model"] = "s_m_m_trucker_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Caminhoneiro
		["Distance"] = 100,
		["Coords"] = vec4(1239.87,-3257.2,7.09,274.97),
		["Model"] = "s_m_m_trucker_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Cemitery
		["Distance"] = 100,
		["Coords"] = vec4(-1741.52,-219.85,56.14,255.12),
		["Model"] = "g_m_m_armboss_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(24.51,-1346.75,29.49,272.13),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(2556.77,380.87,108.61,0.0),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1164.81,-323.61,69.2,99.22),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-706.16,-914.55,19.21,87.88),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-47.35,-1758.59,29.42,45.36),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(372.7,326.89,103.56,255.12),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-3242.7,1000.05,12.82,357.17),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1728.08,6415.6,35.03,243.78),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(549.09,2670.89,42.16,93.55),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1959.87,3740.44,32.33,300.48),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(2677.65,3279.66,55.23,331.66),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1697.32,4923.46,42.06,323.15),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-1819.52,793.48,138.08,130.4),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1391.62,3605.95,34.98,198.43),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-2966.41,391.52,15.05,82.21),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-3039.42,584.42,7.9,14.18),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1134.32,-983.09,46.4,277.8),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(1165.32,2710.79,38.15,175.75),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-1486.72,-377.61,40.15,130.4),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Departament Store
		["Distance"] = 15,
		["Coords"] = vec4(-1221.48,-907.93,12.32,31.19),
		["Model"] = "mp_m_shopkeep_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(1693.89,3754.45,34.69,323.15),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(249.64,-45.08,69.94,155.91),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(846.1,-1029.52,28.19,90.71),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(-330.13,6078.26,31.46,314.65),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(-665.97,-939.37,21.82,272.13),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(-1308.83,-389.64,36.7,164.41),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(-1117.89,2693.02,18.55,314.65),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(2571.63,298.38,108.73,93.55),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(-3169.68,1082.68,20.84,343.0),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(17.13,-1109.64,29.79,249.45),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Craft
		["Distance"] = 15,
		["Coords"] = vec4(813.9,-2153.2,29.62,90.71),
		["Model"] = "s_m_m_ammucountry",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(1692.27,3760.91,34.69,226.78),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(253.8,-50.47,69.94,65.2),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(842.54,-1035.25,28.19,0.0),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(-331.67,6084.86,31.46,223.94),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(-662.37,-933.58,21.82,181.42),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(-1304.12,-394.56,36.7,73.71),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(-1118.98,2699.73,18.55,221.11),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(2567.98,292.62,108.73,0.0),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(-3173.51,1088.35,20.84,246.62),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(22.53,-1105.52,29.79,155.91),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Ammu-Nation Store
		["Distance"] = 15,
		["Coords"] = vec4(810.22,-2158.99,29.62,0.0),
		["Model"] = "s_m_y_ammucity_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Pharmacy Store
		["Distance"] = 30,
		["Coords"] = vec4(-172.89,6381.32,31.48,223.94),
		["Model"] = "u_m_y_baygor",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Pharmacy Store
		["Distance"] = 30,
		["Coords"] = vec4(1690.07,3581.68,35.62,212.6),
		["Model"] = "u_m_y_baygor",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Pharmacy Store
		["Distance"] = 15,
		["Coords"] = vec4(114.49,-5.03,67.82,206.93),
		["Model"] = "u_m_y_baygor",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Jewelry
		["Distance"] = 15,
		["Coords"] = vec4(-628.79,-238.7,38.05,311.82),
		["Model"] = "cs_gurk",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Transporter
		["Distance"] = 20,
		["Coords"] = vec4(264.74,219.99,101.67,343.0),
		["Model"] = "ig_casey",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Leiteiro
		["Distance"] = 50,
		["Coords"] = vec4(963.13,-2215.33,30.55,272.13),
		["Model"] = "cs_manuel",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Lenhador
		["Distance"] = 50,
		["Coords"] = vec4(1961.61,5179.26,47.94,277.8),
		["Model"] = "a_m_o_ktown_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Pescador
		["Distance"] = 30,
		["Coords"] = vec4(-1816.64,-1193.73,14.31,334.49),
		["Model"] = "a_f_y_eastsa_03",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Hospital
		["Distance"] = 30,
		["Coords"] = vec4(341.32,-578.82,28.8,167.25),
		["Model"] = "s_m_m_paramedic_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Hospital Service
		["Distance"] = 30,
		["Coords"] = vec4(312.35,-597.52,43.29,73.71),
		["Model"] = "s_m_m_paramedic_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Policia Service
		["Distance"] = 30,
		["Coords"] = vec4(445.05,-982.08,30.68,90.71),
		["Model"] = "mp_m_securoguard_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Prisão
		["Distance"] = 50,
		["Coords"] = vec4(1839.86,2545.76,45.66,269.3),
		["Model"] = "mp_m_securoguard_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Prisão
		["Distance"] = 50,
		["Coords"] = vec4(1839.86,2537.97,45.66,272.13),
		["Model"] = "mp_m_securoguard_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Polícia
		["Distance"] = 30,
		["Coords"] = vec4(443.68,-974.3,25.7,181.42),
		["Model"] = "mp_m_securoguard_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Polícia
		["Distance"] = 30,
		["Coords"] = vec4(455.97,-986.07,43.69,0.0),
		["Model"] = "s_m_y_airworker",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Ballas
		["Distance"] = 20,
		["Coords"] = vec4(86.33,-1964.12,20.74,240.95),
		["Model"] = "ig_ballasog",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Families
		["Distance"] = 20,
		["Coords"] = vec4(-20.07,-1436.9,30.65,90.71),
		["Model"] = "g_f_y_families_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Vagos
		["Distance"] = 20,
		["Coords"] = vec4(335.86,-2031.24,21.42,147.41),
		["Model"] = "g_f_y_vagos_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Aztecas
		["Distance"] = 50,
		["Coords"] = vec4(503.23,-1801.84,28.49,62.37),
		["Model"] = "g_m_y_azteca_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},{ -- Garagem Bloods
		["Distance"] = 50,
		["Coords"] = vec4(235.36,-1761.56,29.0,311.82),
		["Model"] = "g_m_m_armlieut_01",
		["Anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number = 1,#List do
			local Distance = #(Coords - List[Number]["Coords"]["xyz"])
			if Distance <= List[Number]["Distance"] then
				if not Spawned[Number] and LoadModel(List[Number]["Model"]) then
					Spawned[Number] = CreatePed(4,List[Number]["Model"],List[Number]["Coords"]["x"],List[Number]["Coords"]["y"],List[Number]["Coords"]["z"] - 1,List[Number]["Coords"]["w"],false,false)
					SetPedArmour(Spawned[Number],100)
					SetEntityInvincible(Spawned[Number],true)
					FreezeEntityPosition(Spawned[Number],true)

					if not List[Number]["Collision"] then
						SetEntityNoCollisionEntity(Spawned[Number],Ped,false)
					end

					SetBlockingOfNonTemporaryEvents(Spawned[Number],true)
					SetModelAsNoLongerNeeded(List[Number]["Model"])

					if List[Number]["Model"] == "s_f_y_casino_01" then
						SetPedDefaultComponentVariation(Spawned[Number])
						SetPedComponentVariation(Spawned[Number],0,3,0,0)
						SetPedComponentVariation(Spawned[Number],1,0,0,0)
						SetPedComponentVariation(Spawned[Number],2,3,0,0)
						SetPedComponentVariation(Spawned[Number],3,0,1,0)
						SetPedComponentVariation(Spawned[Number],4,1,0,0)
						SetPedComponentVariation(Spawned[Number],6,1,0,0)
						SetPedComponentVariation(Spawned[Number],7,1,0,0)
						SetPedComponentVariation(Spawned[Number],8,0,0,0)
						SetPedComponentVariation(Spawned[Number],10,0,0,0)
						SetPedComponentVariation(Spawned[Number],11,0,0,0)
						SetPedPropIndex(Spawned[Number],1,0,0,false)
					end

					if List[Number]["Anim"] and LoadAnim(List[Number]["Anim"][1]) then
						TaskPlayAnim(Spawned[Number],List[Number]["Anim"][1],List[Number]["Anim"][2],8.0,8.0,-1,1,1,0,0,0)
					end
				end
			else
				if Spawned[Number] then
					if DoesEntityExist(Spawned[Number]) then
						DeleteEntity(Spawned[Number])
					end

					Spawned[Number] = nil
				end
			end
		end

		Wait(1000)
	end
end)