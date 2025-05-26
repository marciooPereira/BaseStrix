-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("bus",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Locations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"bus") or #(Coords - Locations[Selected]) > 25 then
			exports["discord"]:Embed("Hackers","**[PASSAPORTE]:** "..Passport.."\n**[FUNÇÃO]:** Payment do Motorista\n**[DATA & HORA]:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"),source)
		end

		local GainExperience = 1
		local Amount = math.random(75,95)
		local Experience = vRP.GetExperience(Passport,"Driver")
		local Valuation = Amount + Amount * (0.05 * Experience)

		if exports["party"]:DoesExist(Passport,4) then
			Valuation = Valuation + (Valuation * 0.1)

			TriggerClientEvent("Notify",source,"Central de Empregos","Você ganhou uma bonificação por estar em um <b>Grupo</b>.","money",5000)
		end

		if exports["inventory"]:Buffs("Dexterity",Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if vRP.UserPremium(Passport) then
			local Hierarchy = vRP.LevelPremium(Passport)
			local Bonification = (Hierarchy == 1 and 0.100) or (Hierarchy == 2 and 0.075) or (Hierarchy >= 3 and 0.050)

			Valuation = Valuation + (Valuation * Bonification)
			GainExperience = GainExperience + 1
		end

		vRP.PutExperience(Passport,"Driver",GainExperience)
		vRP.GenerateItem(Passport,"dollar",Valuation,true)
		vRP.UpgradeStress(Passport,1)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)