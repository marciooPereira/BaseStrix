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
Tunnel.bindInterface("chest",Hensa)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local ChestItens = {
	["storage25"] = {
		["Slots"] = 25,
		["Weight"] = 25,
		["Block"] = true
	},
	["storage50"] = {
		["Slots"] = 25,
		["Weight"] = 50,
		["Block"] = true
	},
	["storage75"] = {
		["Slots"] = 25,
		["Weight"] = 75,
		["Block"] = true
	},
	["suitcase"] = {
		["Slots"] = 25,
		["Weight"] = 10,
		["Close"] = true,
		["Itens"] = {
			["dollar"] = true,
			["dirtydollar"] = true,
			["wetdollar"] = true,
			["promissory"] = true
		}
	},
	["medicbag"] = {
		["Permission"] = "Paramedico",
		["Slots"] = 25,
		["Weight"] = 10,
		["Close"] = true,
		["Itens"] = {
			["bandage"] = true,
			["gauze"] = true,
			["gdtkit"] = true,
			["medkit"] = true,
			["sinkalmy"] = true,
			["analgesic"] = true,
			["ritmoneury"] = true,
			["adrenaline"] = true
		}
	},
	["treasurebox"] = {
		["Slots"] = 25,
		["Weight"] = 50,
		["Close"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Check()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport, source) and not exports["hud"]:Wanted(Passport, source) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Permissions(Name,Mode,Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Personal" then
			local Name = SplitOne(Name)
			if vRP.HasPermission(Passport,Name) then
				Open[Passport] = {
					["Name"] = "Personal:"..Passport,
					["Weight"] = 50,
					["Save"] = true,
					["Slots"] = 25
				}

				return true
			else
				TriggerClientEvent("Notify",source,Name,"Você não possui permissões suficientes.","amarelo",5000)
			end
		elseif Mode == "Tray" then
			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 25,
				["Slots"] = 25
			}

			if Name == "Recycle" then
				Open[Passport]["Weight"] = 100
				Open[Passport]["Recycle"] = true
			end

			return true
		elseif Mode == "Custom" or Mode == "Trash" then
			if SplitBoolean(Name,"Helicrash",":") and Cooldown[Name] and Cooldown[Name] > os.time() then
				TriggerClientEvent("Notify",source,"Atenção","Aguarde até que esfrie o compartimento.","amarelo",10000)
				vRPC.DowngradeHealth(source,10)

				return false
			end

			if Mode == "Trash" then
				Name = "Trash:"..Name
			end

			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 50,
				["Slots"] = 25,
				["Mode"] = "Custom"
			}

			return true
		elseif Mode == "Item" then
			local Previous = SplitOne(Name,":")
			if ChestItens[Previous] then
				if ChestItens[Previous]["Permission"] then
					if not vRP.HasService(Passport,ChestItens[Previous]["Permission"]) then
						TriggerClientEvent("Notify",source,"Atenção","Você não possui permissões suficientes.","amarelo",5000)

						return false
					end
				end

				Open[Passport] = {
					["Name"] = Name,
					["Save"] = true,
					["Unique"] = Previous,
					["Slots"] = ChestItens[Previous]["Slots"],
					["Weight"] = ChestItens[Previous]["Weight"]
				}

				if Item then
					Open[Passport]["Item"] = Item
				end

				return true
			end
		else
			local Consult = vRP.Query("chests/GetChests",{ Name = Name })
			if not Consult[1] then
				vRP.Query("chests/AddChests",{ Name = Name })
				Consult = vRP.Query("chests/GetChests",{ Name = Name })
			end

			if Consult[1] and vRP.HasService(Passport,Consult[1]["Permission"]) then
				Open[Passport] = {
					["Slots"] = Consult[1]["Slots"],
					["Weight"] = Consult[1]["Weight"],
					["NameLogs"] = Name,
					["Name"] = "Chest:"..Name,
					["Logs"] = Consult[1]["Logs"],
					["Permission"] = Consult[1]["Permission"],
					["Save"] = true
				}

				return true
			else
				TriggerClientEvent("Notify",source,Name,"Você não possui permissões suficientes.","amarelo",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Mount()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		local Primary = {}
		local Inv = vRP.Inventory(Passport)

		for Index,v in pairs(Inv) do
			v["name"] = ItemName(v["item"])
			v["weight"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["amount"] = parseInt(v["amount"])
			v["rarity"] = ItemRarity(v["item"])
			v["economy"] = ItemEconomy(v["item"])
			v["desc"] = ItemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"])

			local Item = Split[1]
			if ChestItens[Item] and ChestItens[Item]["Close"] then
				v["block"] = true
			end

			if not v["desc"] then
				if Item == "vehkey" and Split[2] then
					v["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
				elseif ItemNamed(Item) and Split[2] then
					if Item == "identity" then
						v["desc"] = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Tipo Sangüineo: <rare>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</rare>"
					else
						v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
					end
				end
			end

			if Split[2] then
				local Loaded = ItemLoads(v["item"])
				if Loaded then
					v["charges"] = parseInt(Split[2] * (100 / Loaded))
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			Primary[Index] = v
		end

		local Secondary = {}
		local Result = vRP.GetServerData(Open[Passport]["Name"])
		for Index,v in pairs(Result) do
			v["name"] = ItemName(v["item"])
			v["weight"] = ItemWeight(v["item"])
			v["index"] = ItemIndex(v["item"])
			v["amount"] = parseInt(v["amount"])
			v["rarity"] = ItemRarity(v["item"])
			v["economy"] = ItemEconomy(v["item"])
			v["desc"] = ItemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"])

			if not v["desc"] then
				if Split[1] == "vehkey" and Split[2] then
					v["desc"] = "Placa do Veículo: <common>"..Split[2].."</common>"
				elseif ItemNamed(Split[1]) and Split[2] then
					if Split[1] == "identity" then
						v["desc"] = "Passaporte: <rare>"..Dotted(Split[2]).."</rare><br>Nome: <rare>"..vRP.FullName(Split[2]).."</rare><br>Tipo Sangüineo: <rare>"..Sanguine(vRP.Identity(Split[2])["Blood"]).."</rare>"
					else
						v["desc"] = "Propriedade: <common>"..vRP.FullName(Split[2]).."</common>"
					end
				end
			end

			if Split[2] then
				local Loaded = ItemLoads(v["item"])
				if Loaded then
					v["charges"] = parseInt(Split[2] * (100 / Loaded))
				end

				if ItemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = ItemDurability(v["item"])
				end
			end

			Secondary[Index] = v
		end

		return Primary,Secondary,vRP.GetWeight(Passport),Open[Passport]["Weight"],Open[Passport]["Slots"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Store(Item,Slot,Amount,Target,Inactived)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and not Inactived then
		if Open[Passport]["Recycle"] then
			local Recycled = ItemRecycle(Item)
			if Recycled then
				if vRP.TakeItem(Passport,Item,Amount) then
					for Index,Number in pairs(Recycled) do
						vRP.GenerateItem(Passport,Index,Number * Amount)
					end

					TriggerClientEvent("inventory:Update",source)
				end
			else
				TriggerClientEvent("inventory:Notify",source,"Atenção",ItemName(Item).." não pode ser reciclado.","amarelo")
				TriggerClientEvent("inventory:Update",source)
			end
		elseif Item == "diagram" and Open[Passport]["NameLogs"] then
			if vRP.TakeItem(Passport,Item,Amount) then
				vRP.Query("chests/UpdateWeight",{ Name = Open[Passport]["NameLogs"], Multiplier = Amount })
				TriggerClientEvent("inventory:Notify",source,"Sucesso","Armazenamento melhorado.","verde")
				Open[Passport]["Weight"] = Open[Passport]["Weight"] + (10 * Amount)
				TriggerClientEvent("inventory:Update",source)
			end
		else
			local Item = SplitOne(Item)
			local Unique = Open[Passport]["Unique"]
			if (ChestItens[Item] and ChestItens[Item]["Block"]) or (Unique and ChestItens[Unique] and ChestItens[Unique]["Itens"] and not ChestItens[Unique]["Itens"][Item]) then
				if Unique and Item == Unique then
                    TriggerClientEvent("inventory:Open",source,{
                        Action = "Open",
                        Type = "Inventory",
                        Resource = "inventory"
                    },true)
                else
					TriggerClientEvent("inventory:Notify",source,"Aviso","Você não pode guardar este item aqui.","vermelho")
                    TriggerClientEvent("inventory:Update",source)
                end

				return false
			end

			if vRP.StoreChest(Passport,Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target) then
				TriggerClientEvent("inventory:Update",source)

				if Open[Passport]["Logs"] then
					exports["discord"]:Embed(Open[Passport]["NameLogs"],"**Passaporte:** "..Passport.."\n**Guardou:** "..Amount.."x "..ItemName(Item),0xa3c846)
				end
			end
		end
	else
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Take(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and not vRP.TakeChest(Passport,Open[Passport]["Name"],Amount,Slot,Target) then
		local Result = vRP.GetServerData(Open[Passport]["Name"])
		if (Open[Passport]["Mode"] or Open[Passport]["Item"]) and json.encode(Result) == "[]" then
			if Open[Passport]["Item"] and vRP.TakeItem(Passport,Open[Passport]["Item"],Amount) then
				TriggerClientEvent("inventory:Open",source,{
					Action = "Open",
					Type = "Inventory",
					Resource = "inventory"
				},true)
			end

			if SplitBoolean(Open[Passport]["Name"],"Helicrash",":") then
				GlobalState["Helibox"] = GlobalState["Helibox"] - 1
			end

			if Open[Passport]["Logs"] then
				exports["discord"]:Embed(Open[Passport]["NameLogs"],"**Passaporte:** "..Passport.."\n**Retirou:** "..Amount.."x "..ItemName(Item),0xe84855)
			end
		end
	else
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and vRP.UpdateChest(Passport,Open[Passport]["Name"],Slot,Target,Amount) then
		TriggerClientEvent("inventory:Update",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Cooldown")
AddEventHandler("chest:Cooldown",function(Name)
	Cooldown[Name] = os.time() + 600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:ARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Armour")
AddEventHandler("chest:Armour",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") then
		vRP.SetArmour(source,100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)