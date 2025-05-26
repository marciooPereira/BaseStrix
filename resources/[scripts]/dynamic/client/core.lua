-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dynamic = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
local Services = {
	{
		["Permission"] = "Policia",
		["Coords"] = vec3(445.05, -982.08, 30.68),
		["Distance"] = 2.0
	}, {
		["Permission"] = "Paramedico",
		["Coords"] = vec3(312.35, -597.52, 43.29),
		["Distance"] = 2.0
	}, {
		["Permission"] = "Mecanico",
		["Coords"] = vec3(949.69, -957.4, 39.83),
		["Distance"] = 2.0
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,param,parent_id,server,back)
	SendNUIMessage({ Action = "AddButton", Payload = { title,description,trigger,param,parent_id,server,back } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddMenu",function(title,description,id,parent_id)
	SendNUIMessage({ Action = "AddMenu", Payload = { title,description,id,parent_id } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:AddButton")
AddEventHandler("dynamic:AddButton",function(title,description,trigger,param,parent_id,server,back)
	SendNUIMessage({ Action = "AddButton", Payload = { title,description,trigger,param,parent_id,server,back } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ADDMENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:AddMenu")
AddEventHandler("dynamic:AddMenu",function(title,description,id,parent_id)
	SendNUIMessage({ Action = "AddMenu", Payload = { title,description,id,parent_id } })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Open",function()
	SendNUIMessage({ Action = "Open" })
	TriggerEvent("hud:Active",false)
	SetNuiFocus(true,true)
	Dynamic = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Clicked",function(Data,Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] then
			TriggerServerEvent(Data["trigger"],Data["param"])
		else
			TriggerEvent(Data["trigger"],Data["param"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("hud:Active",true)
	SetNuiFocus(false,false)
	Dynamic = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:Close")
AddEventHandler("dynamic:Close",function()
	if Dynamic then
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)
		Dynamic = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("PlayerFunctions",function()
	local Ped = PlayerPedId()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic and not IsPauseMenuActive() and GetEntityHealth(Ped) > 100 then
		exports["dynamic"]:AddMenu("Armário","Abrir lista com todas as vestimentas.","wardrobe")
		exports["dynamic"]:AddButton("Guardar","Salvar vestimentas do corpo.","dynamic:Clothes","Save","wardrobe",true)

		local Clothes = vSERVER.Clothes()
		if parseInt(#Clothes) > 0 then
			for Index,v in pairs(Clothes) do
				exports["dynamic"]:AddMenu(v, "Informações da vestimenta.", Index, "wardrobe")
				exports["dynamic"]:AddButton("Aplicar", "Vestir-se com as vestimentas.", "dynamic:Clothes", "Apply-"..v, Index, true)
				exports["dynamic"]:AddButton("Remover", "Deletar a vestimenta do armário.", "dynamic:Clothes", "Delete-"..v, Index, true, true)
			end
		end

		exports["dynamic"]:AddMenu("Roupas", "Colocar/Retirar roupas.", "clothes")
		exports["dynamic"]:AddButton("Chapéu", "Colocar/Retirar o chapéu.", "player:Outfit", "Hat", "clothes", true)
		exports["dynamic"]:AddButton("Máscara", "Colocar/Retirar a máscara.", "player:Outfit", "Mask", "clothes", true)
		exports["dynamic"]:AddButton("Óculos", "Colocar/Retirar o óculos.", "player:Outfit", "Glasses", "clothes", true)
		exports["dynamic"]:AddButton("Camisa", "Colocar/Retirar a camisa.", "player:Outfit", "Shirt", "clothes", true)
		exports["dynamic"]:AddButton("Jaqueta", "Colocar/Retirar a jaqueta.", "player:Outfit", "Torso", "clothes", true)
		exports["dynamic"]:AddButton("Luvas", "Colocar/Retirar as luvas.", "player:Outfit", "Arms", "clothes", true)
		exports["dynamic"]:AddButton("Colete", "Colocar/Retirar o colete.", "player:Outfit", "Vest", "clothes", true)
		exports["dynamic"]:AddButton("Calça", "Colocar/Retirar a calça.", "player:Outfit", "Pants", "clothes", true)
		exports["dynamic"]:AddButton("Sapatos", "Colocar/Retirar o sapato.", "player:Outfit", "Shoes", "clothes", true)
		exports["dynamic"]:AddButton("Acessórios", "Colocar/Retirar os acessórios.", "player:Outfit", "Accessory", "clothes", true)

		local Vehicle = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			if not IsPedInAnyVehicle(Ped) then
				if vRP.ClosestPed(3) then
					exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "closestpeds")
					exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "closestpeds", true)
					exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "closestpeds", true)
				end
			else
				exports["dynamic"]:AddMenu("Veículo", "Funções do veículo.", "vehicle")
				exports["dynamic"]:AddButton("Sentar no Motorista", "Sentar no banco do motorista.", "player:seatPlayer", "0", "vehicle", false)
				exports["dynamic"]:AddButton("Sentar no Passageiro", "Sentar no banco do passageiro.", "player:seatPlayer", "1", "vehicle", false)
				exports["dynamic"]:AddButton("Sentar em Outros", "Sentar no banco do passageiro.", "player:seatPlayer", "2", "vehicle", false)
				exports["dynamic"]:AddButton("Mexer nos Vidros", "Levantar/Abaixar os vidros.", "player:Windows", "", "vehicle", false)
			end

			exports["dynamic"]:AddMenu("Portas", "Portas do veículo.", "doors")
			exports["dynamic"]:AddButton("Porta do Motorista", "Abrir porta do motorista.", "player:Doors", "1", "doors", true)
			exports["dynamic"]:AddButton("Porta do Passageiro", "Abrir porta do passageiro.", "player:Doors", "2", "doors", true)
			exports["dynamic"]:AddButton("Porta Traseira Esquerda", "Abrir porta traseira esquerda.", "player:Doors", "3", "doors", true)
			exports["dynamic"]:AddButton("Porta Traseira Direita", "Abrir porta traseira direita.", "player:Doors", "4", "doors", true)
			exports["dynamic"]:AddButton("Porta-Malas", "Abrir porta-malas.", "player:Doors", "5", "doors", true)
			exports["dynamic"]:AddButton("Capô", "Abrir capô.", "player:Doors", "6", "doors", true)
		end

		exports["dynamic"]:AddMenu("Outros", "Todas as funções do personagem.", "others")
		exports["dynamic"]:AddButton("Estatísticas da Cidade", "Tudo sobre nossa cidade.", "admin:Dynamic", "stats", "others", true)
		exports["dynamic"]:AddButton("Propriedades", "Marcar/Desmarcar propriedades no mapa.", "propertys:Blips", "", "others", false)
		exports["dynamic"]:AddButton("Ferimentos", "Verificar ferimentos no corpo.", "paramedic:Injuries", "", "others", false)
		exports["dynamic"]:AddButton("Desbugar", "Recarregar o personagem.", "player:Debug", "", "others", true)

		local Stats = vSERVER.PedStats()
		if Stats then
			exports["dynamic"]:AddMenu("Estatísticas", "Estatísticas do seu personagem.", "Stats")

			for Name,Points in pairs(Stats) do
				exports["dynamic"]:AddButton(Name, "Você possuí um total de <rare>"..Points.." "..Name.."</rare>.", "", "", "Stats", false)
			end
		end

		exports["dynamic"]:Open()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("EmergencyFunctions",function()
	if not IsPauseMenuActive() and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Prison"] and not Dynamic then
		local Ped = PlayerPedId()
		local Health = GetEntityHealth(Ped)

		if CheckPolice() then
			exports["dynamic"]:AddButton("Placa", "Verificar emplacamento.", "police:Plate", "", false, true)

			exports["dynamic"]:AddButton("Serviço", "Finalizar expediente de trabalho.", "dynamic:ExitService", "Policia", false, true)

			exports["dynamic"]:AddButton("Companheiros", "Verifique seus companheiros em serviço.", "admin:Dynamic", "statsPolicia", false, true)

			exports["dynamic"]:AddMenu("Emergência", "Avisos emergenciais.", "tencode")
			exports["dynamic"]:AddButton("10-13", "Oficial desmaiado/ferido.", "dynamic:Tencode", "13", "tencode", true)
			exports["dynamic"]:AddButton("10-20", "Localização.", "dynamic:Tencode", "20", "tencode", true)
			exports["dynamic"]:AddButton("10-38", "Abordagem de trânsito.", "dynamic:Tencode", "38", "tencode", true)
			exports["dynamic"]:AddButton("10-78", "Apoio com prioridade.", "dynamic:Tencode", "78", "tencode", true)

			if Health > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "player")
				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)

				exports["dynamic"]:AddMenu("Fardamentos", "Todos os fardamentos policiais.", "prePolice")
				exports["dynamic"]:AddButton("Principal", "Fardamento de oficial.", "player:Preset", "1", "prePolice",true)

				exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Open", "", false, false)
			end

			exports["dynamic"]:Open()
		elseif LocalPlayer["state"]["Paramedico"] then
			if Health > 100 and not IsPedInAnyVehicle(Ped) then
				exports["dynamic"]:AddButton("Serviço", "Finalizar expediente de trabalho.", "dynamic:Service", "Paramedico", false, true)

				exports["dynamic"]:AddButton("Companheiros", "Verifique seus companheiros em serviço.", "admin:Dynamic", "statsParamedico", false, true)

				exports["dynamic"]:AddMenu("Jogador", "Pessoa mais próxima de você.", "player")
				exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "inventory:Carry", "", "player", true)
				exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
				exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
				exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
				exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
				exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)

				exports["dynamic"]:AddMenu("Fardamentos", "Todos os fardamentos médicos.", "preMedic")
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de doutor.", "player:Preset", "5", "preMedic", true)
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de paramédico.", "player:Preset", "6", "preMedic", true)
				exports["dynamic"]:AddButton("Medical Center", "Fardamento de paramédico interno.", "player:Preset", "7", "preMedic", true)

				exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "paramedic:Open", "", false, false)

				exports["dynamic"]:Open()
			end
		elseif LocalPlayer["state"]["Mecanico"] then
			exports["dynamic"]:AddButton("Serviço", "Finalizar expediente de trabalho.", "dynamic:ExitService", "Mecanico", false, true)
			exports["dynamic"]:Open()
		else
			local Coords = GetEntityCoords(Ped)
			for Permission,v in pairs(Services) do
				if #(Coords - v["Coords"]) <= v["Distance"] then
					exports["dynamic"]:AddButton("Serviço", "Iniciar expediente de trabalho.", "dynamic:Service", v["Permission"], false, true)
					exports["dynamic"]:Open()

					break
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("AdminFunctions", function()
	if LocalPlayer["state"]["Admin"] and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not Dynamic and not LocalPlayer["state"]["Bennys"] and MumbleIsConnected() then
			if GlobalState["Commands"] then
				TriggerEvent("Notify", "default", "O menu <b>Insert</b> está desativado pois os comandos via <b>Chat</b> estão habilitados.", false, 10000)
			else
				exports["dynamic"]:AddMenu("Gerênciamento", "Clique para mais informações.", "admin")
				exports["dynamic"]:AddButton("God", "Deixar o ID com tudo 100%.", "admin:Dynamic", "god", "admin", true)
				exports["dynamic"]:AddButton("God All", "Deixar Todos com tudo 100%.", "admin:Dynamic", "godall", "admin", true)
				exports["dynamic"]:AddButton("Armour", "Deixar o ID com tudo Colete 100%.", "admin:Dynamic", "armour", "admin", true)
				exports["dynamic"]:AddButton("Commands", "Ativar/Desativar os Comandos por Chat.", "admin:Dynamic", "commands", "admin", true)
				exports["dynamic"]:AddButton("Whitelist", "Editar Whitelist de um ID.", "admin:Dynamic", "wl", "admin", true)
				exports["dynamic"]:AddButton("Announce", "Enviar anúncio para todos.", "admin:Dynamic", "announce", "admin", true)
				exports["dynamic"]:AddButton("Chat Announce", "Enviar anúncio no chat para todos.", "admin:Dynamic", "chatannounce", "admin", true)
				exports["dynamic"]:AddButton("Clear Prison", "Limpar prisão do ID.", "admin:Dynamic", "clearprison", "admin", true)
				exports["dynamic"]:AddButton("Rename", "Renomeie algum ID.", "admin:Dynamic", "rename", "admin", true)
				exports["dynamic"]:AddButton("Kick", "Expuldar o ID.", "admin:Dynamic", "kick", "admin", true)
				exports["dynamic"]:AddButton("Ban", "Banir o ID.", "admin:Dynamic", "ban", "admin", true)
				exports["dynamic"]:AddButton("Unban", "Desbanir o ID.", "admin:Dynamic", "unban", "admin", true)

				exports["dynamic"]:AddMenu("Clima", "Clique para mais informações.", "sky")
				exports["dynamic"]:AddButton("Change Time", "Mudar a Hora do jogo.", "admin:Dynamic", "timeset", "sky", true)
				exports["dynamic"]:AddButton("Change Weather", "Mudar o Clima do jogo.", "admin:Dynamic", "weatherset", "sky", true)

				exports["dynamic"]:AddMenu("Grupos", "Clique para mais informações.", "groups")
				exports["dynamic"]:AddButton("See Groups", "Veja quais grupos do ID.", "admin:Dynamic", "ugroups", "groups", true)
				exports["dynamic"]:AddButton("Give Group", "Dar um grupo para o ID.", "admin:Dynamic", "group", "groups", true)
				exports["dynamic"]:AddButton("Remove Group", "Remover o grupo de um ID.", "admin:Dynamic", "ungroup", "groups", true)

				exports["dynamic"]:AddMenu("Personagens", "Clique para mais informações.", "peds")
				exports["dynamic"]:AddButton("Barbershop", "Abra a Barbearia.", "barbershop:Open", "", "peds", false)
				exports["dynamic"]:AddButton("Reset Skin", "Resete a Skin do ID.", "admin:Dynamic", "resetskin", "peds", true)
				exports["dynamic"]:AddButton("Skin", "Mude a Skin do ID.", "admin:Dynamic", "skin", "peds", true)
				exports["dynamic"]:AddButton("Delete", "Delete a conta do ID.", "admin:Dynamic", "delete", "peds", true)

				exports["dynamic"]:AddMenu("Veículos", "Clique para mais informações.", "vehicles")
				exports["dynamic"]:AddButton("Fix", "Arrumar o veículo atual.", "admin:Dynamic", "fix", "vehicles", true)
				exports["dynamic"]:AddButton("Tuning", "Tunar o veículo atual.", "admin:Dynamic", "tuning", "vehicles", true)
				exports["dynamic"]:AddButton("LsCustoms", "Tunar o veículo atual.", "lscustoms:Open", "", "vehicles", false)
				exports["dynamic"]:AddButton("Nitro", "Defina o Nitro no veículo atual.", "admin:Dynamic", "nitro", "vehicles", true)
				exports["dynamic"]:AddButton("Fuel", "Defina a Gasolina no veículo atual.", "admin:Dynamic", "fuel", "vehicles", true)
				exports["dynamic"]:AddButton("Lockpick", "Desbloqueia o veículo atual.", "admin:Dynamic", "lockpick", "vehicles", true)
				exports["dynamic"]:AddButton("Hash", "Pegar a Hash do veículo atual.", "admin:Dynamic", "hash", "vehicles", true)
				exports["dynamic"]:AddButton("Give Car", "Envie um veículo para o ID.", "admin:Dynamic", "setcar", "vehicles", true)
				exports["dynamic"]:AddButton("Remove Car", "Remove um veículo do ID.", "admin:Dynamic", "remcar", "vehicles", true)

				exports["dynamic"]:AddMenu("Financeiros", "Clique para mais informações.", "wallet")
				exports["dynamic"]:AddButton("Give Bank", "Dar dinheiro para o ID.", "admin:Dynamic", "setbank", "wallet", true)
				exports["dynamic"]:AddButton("Remove Bank", "Remover dinheiro do ID.", "admin:Dynamic", "rembank", "wallet", true)
				exports["dynamic"]:AddButton(""..ItemName("gemstone").."s.", "Inserir "..ItemName("gemstone").."s no ID.", "admin:Dynamic", "gem", "wallet", true)

				exports["dynamic"]:AddMenu("Itens", "Clique para mais informações.", "item")
				exports["dynamic"]:AddButton("Clearinv", "Limpe o inventário do ID.", "admin:Dynamic", "clearinv", "item", true)
				exports["dynamic"]:AddButton("Item", "Pegar Itens para você.", "admin:Dynamic", "item", "item", true)
				exports["dynamic"]:AddButton("Item 2", "Dar Itens para o ID.", "admin:Dynamic", "item2", "item", true)
				exports["dynamic"]:AddButton("Item All", "Dar Itens para todos conectados.", "admin:Dynamic", "itemall", "item", true)

				exports["dynamic"]:AddMenu("Básicos", "Clique para mais informações.", "basic")
				exports["dynamic"]:AddButton("Nc", "Ativar/Desativar o NoClip.", "admin:Dynamic", "nc", "basic", true)
				exports["dynamic"]:AddButton("Debug", "Ativar/Desativar o modo Desenvolvedor.", "admin:Dynamic", "debug", "basic", true)
				exports["dynamic"]:AddButton("Blips", "Ativar/Desativar os Blips.", "admin:Dynamic", "blips", "basic", true)
				exports["dynamic"]:AddButton("Cds", "Pegue sua coordenada atual.", "admin:Dynamic", "cds", "basic", true)
				exports["dynamic"]:AddButton("Tpcds", "Teletransporte para uma coordenada.", "admin:Dynamic", "tpcds", "basic", true)
				exports["dynamic"]:AddButton("Tptome", "Teletransporte um ID para você.", "admin:Dynamic", "tptome", "basic", true)
				exports["dynamic"]:AddButton("Tpto", "Teletransporte para um ID.", "admin:Dynamic", "tpto", "basic", true)
				exports["dynamic"]:AddButton("Tpway", "Teletransporte para uma marcação no GPS.", "admin:Dynamic", "tpway", "basic", true)
				exports["dynamic"]:AddButton("Limpar Área", "Limpar a área próxima a você.", "admin:Dynamic", "limparea", "basic", true)
				exports["dynamic"]:AddButton("Players", "Verifique quantos onlines existem.", "admin:Dynamic", "players", "basic", true)
				exports["dynamic"]:AddButton("Players Conectados", "Verifique os players onlines.", "admin:Dynamic", "playersconnected", "basic", true)

				exports["dynamic"]:AddMenu("Divertidos", "Clique para mais informações.", "fun")
				exports["dynamic"]:AddButton("Magneto", "Ativar/Desativar o efeito Magneto.", "admin:Dynamic", "magneto", "fun", true)
				exports["dynamic"]:AddButton("Flash", "Ativar/Desativar o efeito Flash.", "admin:Dynamic", "flash", "fun", true)
				exports["dynamic"]:AddButton("Vehicle Speed", "Mude a velocidade do veículo.", "admin:Dynamic", "vehiclespeed", "fun", true)
				exports["dynamic"]:AddButton("Tyre Burst", "Exploda o pneu do veículo do ID.", "admin:Dynamic", "tyreburst", "fun", true)
				exports["dynamic"]:AddButton("Create Lightning", "Crie diversos raios pela cidade.", "admin:Dynamic", "createlightning", "fun", true)

				exports["dynamic"]:Open()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Carregar",function()
	if LocalPlayer["state"]["Admin"] or LocalPlayer["state"]["Paramedico"] or CheckPolice() then
		local Ped = PlayerPedId()
		local Health = GetEntityHealth(Ped)
		if Health > 100 and not IsPedInAnyVehicle(Ped) then
			TriggerServerEvent("inventory:Carry")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Carregar","Carregar personagem.","keyboard","H")
RegisterKeyMapping("PlayerFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("EmergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
RegisterKeyMapping("AdminFunctions","Abrir menu de administração.","keyboard","INSERT")