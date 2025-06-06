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
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Recycled = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RECYCLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Recycle")
AddEventHandler("player:Recycle",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Recycled[Passport] and not exports["hud"]:Reposed(Passport, source) and not exports["hud"]:Wanted(Passport, source) and vRP.Request(source,"Recicladora","Está apenas com itens que deseja reciclar em sua mochila?") then
		local Notify = false
		Recycled[Passport] = true
		local Inv = vRP.Inventory(Passport)

		for Slot = 1,5 do
			local Slot = tostring(Slot)
			if Inv[Slot] and Inv[Slot]["item"] and Inv[Slot]["amount"] > 0 then
				for Item,Amount in pairs(ItemRecycle(Inv[Slot]["item"])) do
					if vRP.TakeItem(Passport,Inv[Slot]["item"],Inv[Slot]["amount"],false,Slot) then
						vRP.GenerateItem(Passport,Item,Inv[Slot]["amount"] * Amount,true,Slot)
						Notify = true
					end
				end
			end
		end

		if Notify then
			TriggerClientEvent("Notify",source,"Recicladora","Processo concluído.","ilegal",5000)
		else
			TriggerClientEvent("Notify",source,"Recicladora","Nenhum item encontrado.","vermelho",5000)
		end

		Recycled[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:SURVIVAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Survival")
AddEventHandler("player:Survival",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.ClearInventory(Passport)
		vRP.UpgradeThirst(Passport,100)
		vRP.UpgradeHunger(Passport,100)
		vRP.DowngradeStress(Passport,100)
		exports["discord"]:Embed("Airport","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Coords:** "..vRP.GetEntityCoords(source),0xa3c846)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local Message = string.sub(History:sub(4),1,100)

		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,Message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Demand")
AddEventHandler("player:Demand",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and OtherPassport and not exports["bank"]:CheckFines(OtherPassport) then
		local Keyboard = vKEYBOARD.Primary(source,"Valor da Cobrança.")
		if Keyboard and vRP.Passport(OtherSource) then
			if vRP.Request(OtherSource,"Cobrança","Aceitar a cobrança de <b>$"..Dotted(Keyboard[1]).."</b> feita por <b>"..vRP.FullName(Passport).."</b>.") then
				if vRP.PaymentBank(OtherPassport,Keyboard[1],true) then
					vRP.GiveBank(Passport,Keyboard[1],true)
				end
			else
				TriggerClientEvent("Notify",source,"Cobrança","Pedido recusado.","vermelho",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
RegisterServerEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Debug[Passport] or os.time() > Debug[Passport] then
		TriggerClientEvent("target:Debug",source)
		TriggerEvent("DebugObjects",Passport)
		Debug[Passport] = os.time() + 300
		vRPC.ReloadCharacter(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Stress")
AddEventHandler("player:Stress",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeStress(Passport,Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if Message[2] == "friend" then
			local ClosestPed = vRPC.ClosestPed(source)
			if ClosestPed and vRP.GetHealth(ClosestPed) > 100 and not Player(ClosestPed)["state"]["Handcuff"] then
				if vRP.Request(ClosestPed,"Animação","Pedido de <b>"..vRP.FullName(Passport).."</b> da animação <b>"..Message[1].."</b>?") then
					TriggerClientEvent("emotes",ClosestPed,Message[1])
					TriggerClientEvent("emotes",source,Message[1])
				end
			end
		else
			TriggerClientEvent("emotes",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source)
		if ClosestPed then
			if vRP.HasService(Passport,"Paramedico") then
				TriggerClientEvent("emotes",ClosestPed,Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Players = vRPC.ClosestPeds(source,50)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes",v,Message[1])
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle,Network = vRPC.VehicleList(source)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,Network,Number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	if Mode == "rv" then
		Distance = 10
	end

	local source = source
	local Passport = vRP.Passport(source)
	local OtherSource = vRPC.ClosestPed(source,Distance)
	if Passport and OtherSource then
		if vRP.HasService(Passport,"Emergencia") or vRP.ConsultItem(Passport,"rope",1) then
			local Vehicle,Network = vRPC.VehicleList(source)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)
				if DoesEntityExist(Networked) and GetVehicleDoorLockStatus(Networked) <= 1 then
					if Mode == "rv" then
						vCLIENT.RemoveVehicle(OtherSource)
					elseif Mode == "cv" then
						vCLIENT.PlaceVehicle(OtherSource,Network)
						TriggerEvent("inventory:CarryDetach",source,Passport)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
	["1"] = {
        ["mp_m_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },
            ["pants"] = { item = 195, texture = 0 },
            ["vest"] = { item = 65, texture = 0 },
            ["bracelet"] = { item = -1, texture = 0 },
            ["backpack"] = { item = 0, texture = 0 },
            ["decals"] = { item = 197, texture = 12 },
            ["mask"] = { item = 0, texture = 0 },
            ["shoes"] = { item = 25, texture = 0 },
            ["tshirt"] = { item = 15, texture = 0 },
            ["torso"] = { item = 548, texture = 0 },
            ["accessory"] = { item = 183, texture = 0 },
            ["watch"] = { item = -1, texture = 0 },
            ["arms"] = { item = 22, texture = 0 },
            ["glass"] = { item = 0, texture = 0 },
            ["ear"] = { item = -1, texture = 0 }
        },
        ["mp_f_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },
            ["pants"] = { item = 209, texture = 0 },
            ["vest"] = { item = 63, texture = 0 },
            ["bracelet"] = { item = -1, texture = 0 },
            ["backpack"] = { item = 0, texture = 0 },
            ["decals"] = { item = 209, texture = 12 },
            ["mask"] = { item = 0, texture = 0 },
            ["shoes"] = { item = 25, texture = 0 },
            ["tshirt"] = { item = 254, texture = 0 },
            ["torso"] = { item = 584, texture = 0 },
            ["accessory"] = { item = 148, texture = 0 },
            ["watch"] = { item = -1, texture = 0 },
            ["arms"] = { item = 21, texture = 0 },
            ["glass"] = { item = 0, texture = 0 },
            ["ear"] = { item = -1, texture = 0 }
        }
	},
	["2"] = {
        ["mp_m_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },
            ["pants"] = { item = 31, texture = 0 },
            ["vest"] = { item = 0, texture = 0 },
            ["bracelet"] = { item = -1, texture = 0 },
            ["backpack"] = { item = 0, texture = 0 },
            ["decals"] = { item = 58, texture = 1 },
            ["mask"] = { item = 0, texture = 0 },
            ["shoes"] = { item = 25, texture = 0 },
            ["tshirt"] = { item = 154, texture = 0 },
            ["torso"] = { item = 250, texture = 0 },
            ["accessory"] = { item = 171, texture = 0 },
            ["watch"] = { item = -1, texture = 0 },
            ["arms"] = { item = 85, texture = 0 },
            ["glass"] = { item = 0, texture = 0 },
            ["ear"] = { item = -1, texture = 0 }
        },
        ["mp_f_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },
            ["pants"] = { item = 30, texture = 0 },
            ["vest"] = { item = 0, texture = 0 },
            ["bracelet"] = { item = -1, texture = 0 },
            ["backpack"] = { item = 0, texture = 0 },
            ["decals"] = { item = 66, texture = 1 },
            ["mask"] = { item = 0, texture = 0 },
            ["shoes"] = { item = 25, texture = 0 },
            ["tshirt"] = { item = 190, texture = 0 },
            ["torso"] = { item = 258, texture = 0 },
            ["accessory"] = { item = 96, texture = 0 },
            ["watch"] = { item = -1, texture = 0 },
            ["arms"] = { item = 109, texture = 0 },
            ["glass"] = { item = 0, texture = 0 },
            ["ear"] = { item = -1, texture = 0 }
        }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Emergencia") and Preset[Number] then
		local Model = vRP.ModelPlayer(source)

		if Preset[Number][Model] then
			TriggerClientEvent("skinshop:Apply",source,Preset[Number][Model])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] and vSKINSHOP.checkShoes(Entity) then
			vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
			UniqueShoes[Entity] = os.time() + 300
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVIT
-----------------------------------------------------------------------------------------------------------------------------------------
local Removit = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport,source) and not exports["hud"]:Wanted(Passport,source) then
		if Mode == "aplicar" then
			local Result = vRP.GetServerData("Outfit:"..Passport)
			if Result["pants"] then
				TriggerClientEvent("skinshop:Apply",source,Result)
				TriggerClientEvent("Notify",source,"Sucesso","Roupas aplicadas.","verde",5000)
			else
				TriggerClientEvent("Notify",source,"Aviso","Roupas não encontradas.","amarelo",5000)
			end
		elseif Mode == "salvar" then
			local Custom = vSKINSHOP.Customization(source)
			if Custom then
				vRP.SetServerData("Outfit:"..Passport,Custom)
				TriggerClientEvent("Notify",source,"Sucesso","Roupas salvas.","verde",5000)
			end
		elseif Mode == "aplicarpre" then
			local Result = vRP.GetServerData("Premiumfit:"..Passport)
			if Result["pants"] then
				TriggerClientEvent("skinshop:Apply",source,Result)
				TriggerClientEvent("Notify",source,"Sucesso","Roupas aplicadas.","verde",5000)
			else
				TriggerClientEvent("Notify",source,"Aviso","Roupas não encontradas.","amarelo",5000)
			end
		elseif Mode == "salvarpre" then
			local Custom = vSKINSHOP.Customization(source)
			if Custom then
				vRP.SetServerData("Premiumfit:"..Passport,Custom)
				TriggerClientEvent("Notify",source,"Sucesso","Roupas salvas.","verde",5000)
			end
		elseif Mode == "remover" then
			local Model = vRP.ModelPlayer(source)

			if Removit[Model] then
				TriggerClientEvent("skinshop:Apply",source,Removit[Model])
			end
		else
			TriggerClientEvent("skinshop:set"..Mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and OtherPassport and Passport ~= OtherPassport and vRP.DoesEntityExist(source) and vRP.DoesEntityExist(OtherSource) then
		exports["discord"]:Embed("Deaths","**Passaporte do Assassino:** "..OtherPassport.."\n**Localização do Assassino:** "..vRP.GetEntityCoords(OtherSource).."\n\n**Passaporte da Vítima:** "..Passport.."\n**Localização da Vítima:** "..vRP.GetEntityCoords(source).."\n\n**Data & Hora:** "..os.date("%d/%m/%Y").." às "..os.date("%H:%M"),0xa3c846)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("player:DuiTable",source,DuiTextures)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Debug[Passport] then
		Debug[Passport] = nil
	end

	if Recycled[Passport] then
		Recycled[Passport] = nil
	end
end)