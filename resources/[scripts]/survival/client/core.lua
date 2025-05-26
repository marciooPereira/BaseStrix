-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("survival",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Crawl",false,true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Login = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
local Death = {
	["Timer"] = 0,
	["Pressed"] = 0,
	["Default"] = 300,
	["Status"] = false,
	["Cooldown"] = GetGameTimer(),
	["Title"] = "Nocauteado",
	["Text"] = "Aguarde os primeiros socorros"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAWL
-----------------------------------------------------------------------------------------------------------------------------------------
local Crawl = {
	["Timer"] = 0,
	["Minute"] = 60,
	["Default"] = 60,
	["Status"] = false,
	["Mode"] = "onfront",
	["Stand"] = GetGameTimer(),
	["Cooldown"] = GetGameTimer(),
	["Title"] = "Ferido",
	["Text"] = "Aguarde os primeiros socorros"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMECRAWLING
-----------------------------------------------------------------------------------------------------------------------------------------
local TimeCrawling = {
	["onfront"] = {
		["fwd"] = 820,
		["bwd"] = 990
	},
	["onback"] = {
		["fwd"] = 1200,
		["bwd"] = 1200
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STANDCRAWLING
-----------------------------------------------------------------------------------------------------------------------------------------
function StandCrawling(Ped,Init,Mode)
	Crawl["Status"] = true
	Crawl["Stand"] = GetGameTimer() + 60000

	TaskPlayAnim(Ped,"move_crawl",Init.."_"..Mode,8.0,-8.0,-1,2,0.0,false,false,false)

	SetTimeout(TimeCrawling[Init][Mode],function()
		Crawl["Stand"] = GetGameTimer() + 1000
		Crawl["Status"] = false
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event == "CEventNetworkEntityDamage" and PlayerPedId() == Message[1] and Death["Status"] and Crawl["Timer"] > 0 then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		NetworkResurrectLocalPlayer(Coords,0.0)

		Crawl["Timer"] = 1
		SetEntityHealth(Ped,100)
		Death["Cooldown"] = GetGameTimer()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadAnim("dead")
	LoadAnim("move_crawl")
	LoadAnim("amb@world_human_sunbathe@male@front@idle_a")

	while true do
		local TimeDistance = 100

		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) <= 100 then
				if not Death["Status"] then
					local Coords = GetEntityCoords(Ped)
					NetworkResurrectLocalPlayer(Coords,0.0)

					SetEntityHealth(Ped,100)
					Death["Status"] = true
					Death["Pressed"] = 0

					if not Login then
						LocalPlayer["state"]:set("Crawl",true,true)
						Crawl["Timer"] = Crawl["Default"]
					else
						Login = false
						Crawl["Timer"] = 1
						Death["Cooldown"] = GetGameTimer()
					end

					SendNUIMessage({ Action = "Open" })
					TriggerServerEvent("paramedic:bloodDeath")
					TriggerEvent("player:DeathUpdate",true)
					TriggerEvent("inventory:CleanWeapons")
					TriggerServerEvent("inventory:Cancel")
					TriggerEvent("inventory:ScubaRemove")
					TriggerEvent("radio:RadioClean")
					TriggerEvent("hud:Active",false)
					TriggerEvent("inventory:Close")
					TriggerEvent("hud:RemoveHood")
				else
					TimeDistance = 1

					DisableControlAction(0,18,true)
					DisableControlAction(0,22,true)
					DisableControlAction(0,24,true)
					DisableControlAction(0,25,true)
					DisableControlAction(0,68,true)
					DisableControlAction(0,70,true)
					DisableControlAction(0,91,true)
					DisableControlAction(0,69,true)
					DisableControlAction(0,75,true)
					DisableControlAction(0,140,true)
					DisableControlAction(0,142,true)
					DisableControlAction(0,257,true)
					DisablePlayerFiring(Ped,true)
					SetEntityHealth(Ped,100)

					if GetGameTimer() >= Death["Cooldown"] then
						Death["Cooldown"] = GetGameTimer() + 1000

						if Crawl["Timer"] > 0 then
							Crawl["Timer"] = Crawl["Timer"] - 1
							SendNUIMessage({ Action = "Update", Payload = { Crawl["Title"],Crawl["Text"],Crawl["Timer"] } })

							if Crawl["Timer"] <= 0 then
								exports["pma-voice"]:Mute(true)

								local DeathTimer = Death["Default"]
								if LocalPlayer["state"]["Premium"] then
									DeathTimer = (LocalPlayer["state"]["Premium"] and (DeathTimer * 0.3))
								end

								Death["Timer"] = DeathTimer
								LocalPlayer["state"]:set("Crawl",false,true)
								SendNUIMessage({ Action = "Update", Payload = { Death["Title"],Death["Text"],Death["Timer"] } })
								LocalPlayer["state"]:set("Blastoise",true,false)
								NetworkSetFriendlyFireOption(false)
								SetEntityInvincible(Ped,false)
								SetLocalPlayerAsGhost(true)
							end
						elseif Death["Timer"] > 0 then
							Death["Timer"] = Death["Timer"] - 1
							SendNUIMessage({ Action = "Update", Payload = { Death["Title"],Death["Text"],Death["Timer"] } })

							if Death["Timer"] <= 0 then
								SendNUIMessage({ Action = "Update", Payload = { Death["Title"],Death["Text"],Death["Timer"],"Segure [E] por 10 segundos" } })
								SetFacialIdleAnimOverride(Ped,"mood_sleeping_1",0)
							end
						end
					end

					if IsPedInAnyVehicle(Ped) then
						local Vehicle = GetVehiclePedIsUsing(Ped)
						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							SetVehicleEngineOn(Vehicle,false,true,true)
						end
					else
						if Crawl["Timer"] > 0 then
							local Forward,Backward = IsControlPressed(0,32),IsControlPressed(0,33)

							if not Crawl["Status"] then
								if Forward then
									StandCrawling(Ped,Crawl["Mode"],"fwd")
								elseif Backward then
									StandCrawling(Ped,Crawl["Mode"],"bwd")
								elseif GetGameTimer() >= Crawl["Stand"] and not IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",3) then
									TaskPlayAnim(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",8.0,8.0,-1,1,1,0,0,0)
								end
							else
								if IsControlPressed(0,34) then
									local Heading = Forward and 1.0 or -1.0
									SetEntityHeading(Ped,GetEntityHeading(Ped) + Heading)
								elseif IsControlPressed(0,35) then
									local Heading = Backward and 1.0 or -1.0
									SetEntityHeading(Ped,GetEntityHeading(Ped) + Heading)
								end
							end
						else
							if not IsEntityPlayingAnim(Ped,"dead","dead_a",3) and not LocalPlayer["state"]["Carry"] then
								TaskPlayAnim(Ped,"dead","dead_a",8.0,8.0,-1,1,1,0,0,0)
							end
						end
					end

					if Death["Status"] and Death["Timer"] <= 0 and Crawl["Timer"] <= 0 and not LocalPlayer["state"]["Carry"] and IsControlPressed(0,38) then
						Death["Pressed"] = Death["Pressed"] + 1

						if Death["Pressed"] >= 1000 then
							TriggerServerEvent("player:Survival")
							FinishSurvival()
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRAWL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.CheckCrawl()
	return Death["Status"] and Crawl["Timer"] > 0 and GetGameTimer() >= Crawl["Cooldown"] and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECRAWL
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.UpdateCrawl(Health)
	if Health then
		exports["survival"]:Revive(Health)
		Crawl["Cooldown"] = GetGameTimer() + (Crawl["Minute"] * 60000)
	else
		Crawl["Cooldown"] = GetGameTimer()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHSURVIVAL
-----------------------------------------------------------------------------------------------------------------------------------------
function FinishSurvival()
	if Death["Status"] and Crawl["Timer"] > 0 then
		LocalPlayer["state"]:set("Crawl",false,true)
	end

	Death["Status"] = false
	Death["Timer"] = 0

	Crawl["Status"] = false
	Crawl["Timer"] = 0

	local Ped = PlayerPedId()

	ClearPedTasks(Ped)
	SetEntityHealth(Ped,160)
	SetLocalPlayerAsGhost(false)
	SetEntityInvincible(Ped,false)
	ClearFacialIdleAnimOverride(Ped)
	NetworkSetFriendlyFireOption(true)
	LocalPlayer["state"]:set("Blastoise",false,false)

	TriggerEvent("paramedic:Reset")
	exports["pma-voice"]:Mute(false)
	SendNUIMessage({ Action = "Close" })
	TriggerEvent("inventory:CleanWeapons")

	if LocalPlayer["state"]["Handcuff"] then
		LocalPlayer["state"]:set("Handcuff",false,true)
	end

	DoScreenFadeOut(0)

	SetTimeout(5000,function()
		TriggerEvent("player:DeathUpdate",false)
		TriggerEvent("hud:Active",true)
		DoScreenFadeIn(2500)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Revive",function(Health)
	local Ped = PlayerPedId()

	SetEntityInvincible(Ped,false)
	SetEntityHealth(Ped,Health or 101)
	LocalPlayer["state"]:set("Blastoise",false,false)

	if Death["Status"] then
		if Crawl["Timer"] > 0 then
			LocalPlayer["state"]:set("Crawl",false,true)
		end

		Death["Status"] = false
		Death["Timer"] = 0

		Crawl["Status"] = false
		Crawl["Timer"] = 0

		ClearPedTasks(Ped)
		SetLocalPlayerAsGhost(false)
		ClearFacialIdleAnimOverride(Ped)
		NetworkSetFriendlyFireOption(true)

		TriggerEvent("paramedic:Reset")
		TriggerEvent("hud:Active",true)
		exports["pma-voice"]:Mute(false)
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("player:DeathUpdate",false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Revive(Health)
	exports["survival"]:Revive(Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Login",function()
	Login = true
end)