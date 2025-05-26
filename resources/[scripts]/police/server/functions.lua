-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARRESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ArrestItens")
AddEventHandler("police:ArrestItens", function(Entity)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and vRP.GetHealth(source) > 100 and vRP.HasService(Passport,"Policia") then
        local OtherPassport = vRP.Passport(Entity)
        if OtherPassport then
            local Inventory = vRP.Inventory(OtherPassport)
            if Inventory then
                for Slot,ItemData in pairs(Inventory) do
                    if ItemArrest(ItemData.item) then
                        vRP.RemoveItem(OtherPassport, ItemData.item, ItemData.amount, ArrestNotify)
						TriggerClientEvent("Notify",source,"Sucesso","Objetos apreendidos.","verde",5000)
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
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 59, texture = 1 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 5, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 5, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 61, texture = 1 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 3, texture = 0 },
		["torso"] = { item = 118, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 11, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Preset")
AddEventHandler("police:Preset",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 and vRP.HasService(Passport,"Policia") then
		local Hash = vRP.ModelPlayer(OtherSource)
		if Hash == "mp_m_freemode_01" or Hash == "mp_f_freemode_01" then
			TriggerClientEvent("skinshop:Apply",OtherSource,Preset[Hash])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:ARRESTVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:ArrestVehicles")
AddEventHandler("police:ArrestVehicles",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.Request(source,"Garagem","Apreender o veículo?") then
		local OtherPassport = vRP.PassportPlate(Entity[1])
		if OtherPassport then
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = OtherPassport, Vehicle = Entity[2] })
			if Vehicle[1] then
				if Vehicle[1]["Arrest"] == 0 then
					vRP.Query("vehicles/arrestVehicles",{ Passport = OtherPassport, Vehicle = Entity[2] })
					TriggerClientEvent("Notify",source,"Departamento Policial","Veículo apreendido.","policia",5000)
				else
					TriggerClientEvent("Notify",source,"Departamento Policial","Veículo já se encontra apreendido.","policia",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Plate")
AddEventHandler("police:Plate",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") then
		local Keyboard = vKEYBOARD.Primary(source,"Placa")
		if Keyboard and Keyboard[1] then
			local OtherPassport = vRP.PassportPlate(Keyboard[1])
			if OtherPassport then
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					TriggerClientEvent("Notify", source, "Emplacamento", "<b>Passaporte:</b> "..Identity["id"].."<br><b>Telefone:</b> "..vRP.GetPhone(OtherPassport).."<br><b>Nome:</b> "..Identity["Name"].." "..Identity["Lastname"], "policia", 10000)
				end
			else
				TriggerClientEvent("Notify", source, "Emplacamento", "Nada encontrado.", "policia", 5000)
			end
		end
	end
end)