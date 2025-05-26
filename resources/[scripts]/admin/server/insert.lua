-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DYNAMIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Dynamic")
AddEventHandler("admin:Dynamic", function(Mode)
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "wl" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Keyboard = vKEYBOARD.Options(source,"ID da Whitelist:",{ "Liberar", "Negar" })
				if Keyboard then
					local WhitelistResult = 0
					if Keyboard[2] == "Liberar" then
						WhitelistResult = 1
					elseif Keyboard[2] == "Negar" then
						WhitelistResult = 0
					end

					TriggerClientEvent("Notify",source,"Sucesso","Whitelist editada.","verde",5000)
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** wl "..Keyboard[1].." "..WhitelistResult,0xa3c846)

					vRP.Query("accounts/SetWhitelist",{ Whitelist = WhitelistResult, id = Keyboard[1] })
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "rename" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Tertiary(source,"Passaporte:","Nome:","Sobrenome:")
				if Keyboard then
					vRP.UpgradeNames(Keyboard[1],Keyboard[2],Keyboard[3])
					TriggerClientEvent("Notify",source,"Sucesso","Nome atualizado.","verde",5000)
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** rename "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "clearinv" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					TriggerClientEvent("dynamic:Close",source)

					local FullName = vRP.Identity(Keyboard[1])["Name"].." "..vRP.Identity(Keyboard[1])["Lastname"]
					if vRP.Request(Passport, "Inventário", "Você realmente deseja limpar o inventário de <b>"..FullName.."</b>?") then
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearinv "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"Sucesso","Limpeza concluída.","verde",5000)
						vRP.ClearInventory(Keyboard[1])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "gem" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Quantidade:")
				if Keyboard then
					local Amount = parseInt(Keyboard[2])
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						TriggerClientEvent("Notify",source,"Sucesso",""..ItemName(DefaultMoneySpecial).." entregue.","verde",5000)
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** gem "..Keyboard[1].." "..Keyboard[2],0xa3c846)

						vRP.UpgradeGemstone(OtherPassport,Amount)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "blips" then
			if vRP.HasGroup(Passport,"Admin",2) then
				vRPC.BlipAdmin(source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "flash" then
			if vRP.HasGroup(Passport,"Admin",2) then
				vCLIENT.Flash(source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "god" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** god "..Keyboard[1],0xa3c846)

					local OtherPassport = parseInt(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPassport,100)
						vRP.UpgradeHunger(OtherPassport,100)
						vRP.DowngradeStress(OtherPassport,100)
						vRP.Revive(ClosestPed,200)

						TriggerClientEvent("paramedic:Reset",ClosestPed)

						vRPC.Destroy(ClosestPed)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "godall" then
			if vRP.HasGroup(Passport,"Admin",2) then
				exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** godall",0xa3c846)

				local UsersList = vRP.Players()
				for k,v in pairs(UsersList) do
					local OtherPassport = parseInt(k)
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPassport,100)
						vRP.UpgradeHunger(OtherPassport,100)
						vRP.DowngradeStress(OtherPassport,100)
						vRP.Revive(ClosestPed,200)

						TriggerClientEvent("paramedic:Reset",ClosestPed)

						vRPC.Destroy(ClosestPed)

						TriggerClientEvent("Notify", ClosestPed, "Saúde", "Você recebeu uma cura divina.", "blood", 5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "armour" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** armour "..Keyboard[1],0xa3c846)

					local OtherPassport = parseInt(Keyboard[1])
					local ClosestPed = vRP.Source(OtherPassport)
					if ClosestPed then
						vRP.SetArmour(ClosestPed,100)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "item" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source,"Nome do Item:","Quantidade:")
				if Keyboard then
					if ItemIndex(Keyboard[1]) ~= nil then
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						vRP.GenerateItem(Passport,Keyboard[1],parseInt(Keyboard[2]),true)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "item2" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Tertiary(source,"Passaporte:","Nome do Item:","Quantidade:")
				if Keyboard then
					if ItemIndex(Keyboard[2]) ~= nil then
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** item2 "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3],0xa3c846)
						vRP.GenerateItem(parseInt(Keyboard[1]),Keyboard[2],parseInt(Keyboard[3]),true)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "itemall" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source,"Nome do Item:","Quantidade:")
				if Keyboard then
					if ItemIndex(Keyboard[1]) ~= nil then
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** itemall "..Keyboard[1].." "..Keyboard[2],0xa3c846)

						local List = vRP.Players()
						for AllPlayers,_ in pairs(List) do
							async(function()
								vRP.GenerateItem(AllPlayers,Keyboard[1],parseInt(Keyboard[2]),true)
							end)
						end

						TriggerClientEvent("Notify",source,"Sucesso","Envio concluído.","verde",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "delete" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)

					TriggerClientEvent("dynamic:Close",source)

					if vRP.Request(source,"Deletar Conta","Você tem certeza?") then
						local OtherPassport = parseInt(Keyboard[1])
						vRP.Query("characters/Delete",{ Passport = OtherPassport })
						TriggerClientEvent("Notify",source,"Sucesso","Personagem <b>"..OtherPassport.."</b> deletado.","verde",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "skin" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Skin:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						vRPC.Skin(ClosestPed,Keyboard[2])
						vRP.SkinCharacter(parseInt(Keyboard[1]),Keyboard[2])
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** skin "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						TriggerClientEvent("Notify",source,"Sucesso","Skin <b>"..Keyboard[2].."</b> setada no ID "..parseInt(Keyboard[1])..".","verde",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "resetskin" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local OtherPassport = parseInt(Keyboard[1])
						local Identity = vRP.Identity(OtherPassport)
						if Identity then
							if Identity["Sex"] == "M" then
								vRPC.Skin(ClosestPed,"mp_m_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_m_freemode_01")
							elseif Identity["Sex"] == "F" then
								vRPC.Skin(ClosestPed,"mp_f_freemode_01")
								vRP.SkinCharacter(parseInt(Keyboard[1]),"mp_f_freemode_01")
							end

							exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** resetskin "..Keyboard[1],0xa3c846)
							TriggerClientEvent("Notify",source,"Sucesso","Skin do ID "..parseInt(Keyboard[1]).." foi resetada.","verde",5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "nc" then
			if vRP.HasGroup(Passport,"Admin",2) then
				vRPC.NoClip(source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "kick" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					local OtherSource = vRP.Source(Keyboard[1])
					if OtherSource then
						TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..Keyboard[1].."</b> expulso.","verde",5000)
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** kick "..Keyboard[1],0xa3c846)
						vRP.Kick(OtherSource,"Expulso da cidade.")
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "ban" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Ban(source,"Passaporte:","Dias:","Motivo:")
				if Keyboard then
					local Days = parseInt(Keyboard[2],true)
					local OtherPassport = parseInt(Keyboard[1])
					if OtherPassport == Passport then
						TriggerClientEvent("Notify",source,"Aviso","Você não pode banir você mesmo.","vermelho",5000)
					else
						local Identity = vRP.Identity(OtherPassport)
						if Identity then
							local OtherSource = vRP.Source(OtherPassport)
							if OtherSource then
								if Days > 999 then
									Days = 999
								end

								local Token = GetPlayerTokens(OtherSource)
								for k,v in pairs(Token) do
									vRP.Kick(OtherPassport,"Banido.")
									vRP.Query("banneds/InsertBanned",{ License = Identity["License"], Token = v, Time = Days, Reason = Keyboard[3] })
								end

								exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ban "..Keyboard[1].." "..Keyboard[2],0xa3c846)
								TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.","verde",5000)
							end
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "unban" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					if Identity then
						vRP.Query("banneds/RemoveBanned",{ License = Identity["License"] })
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** unban "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"Sucesso","Passaporte <b>"..OtherPassport.."</b> desbanido.","verde",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "timeset" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Hours = { "00" ,"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23" }
				local Minutes = { "00" ,"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59" }

				local Keyboard = vKEYBOARD.Timeset(source,Hours,Minutes)
				if Keyboard then
					GlobalState["Hours"] = parseInt(Keyboard[1])
					GlobalState["Minutes"] = parseInt(Keyboard[2])
					TriggerClientEvent("Notify",source,"Sucesso","Você mudou o <b>Horário</b>.","verde",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "weatherset" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Location = { "Sul", "Norte" }
				local Weathers = { "EXTRASUNNY", "CLEAR", "CLOUDS", "SMOG", "FOGGY", "OVERCAST", "RAIN", "THUNDER", "CLEARING", "NEUTRAL", "SNOW", "BLIZZARD", "SNOWLIGHT", "XMAS", "HALLOWEEN" }

				local Keyboard = vKEYBOARD.Weather(source,Location,Weathers)
				if Keyboard then
					if Keyboard[1] == "Sul" then
						GlobalState["WeatherS"] = Keyboard[2]
						TriggerClientEvent("Notify",source,"Atenção","Você mudou o clima do <b>Sul</b>.","amarelo",5000)
					elseif Keyboard[1] == "Norte" then
						GlobalState["WeatherN"] = Keyboard[2]
						TriggerClientEvent("Notify",source,"Atenção","Você mudou o clima do <b>Norte</b>.","amarelo",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "cds" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Heading = GetEntityHeading(Ped)

				vKEYBOARD.Copy(source,"Cordenadas:",Optimize(Coords["x"])..","..Optimize(Coords["y"])..","..Optimize(Coords["z"])..","..Optimize(Heading))
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tpcds" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Coordenada:")
				if Keyboard then
					local Split = splitString(Keyboard[1],",")
					vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "group" then
			if vRP.HasGroup(Passport, "Admin", 1) then
				local List = {}
				for Index, _ in pairs(GroupsList()) do
					table.insert(List, Index)
				end

				local Keyboard = vKEYBOARD.GiveGroup(source, "Passaporte:", "Hierarquia:", List)
				if Keyboard and Keyboard[1] and Keyboard[2] and Keyboard[3] then
					local Level = Keyboard[2]
					local Permission = Keyboard[3]
					local OtherPassport = Keyboard[1]
					local OtherSource = vRP.Source(Keyboard[1])

					if tonumber(Level) then
						if vRP.GroupType(Permission) then
							if not vRP.GetUserType(OtherPassport, "Work") then
								exports["discord"]:Embed("Admin", "**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level, 0xa3c846)
								TriggerClientEvent("Notify", source, "Sucesso", "Adicionado a permissão <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.", "verde", 5000)
								TriggerClientEvent("Notify", OtherSource, "Sucesso", "Você recebeu a permissão de <b>"..Permission.."</b>.", "verde", 5000)
								vRP.SetPermission(OtherPassport, Permission, Level)
							else
								TriggerClientEvent("Notify", source, "Atenção", "O passaporte já pertence a outro grupo.", "amarelo", 5000)
							end
						else
							exports["discord"]:Embed("Admin", "**Passaporte:** "..Passport.."\n**Comando:** group "..OtherPassport.." "..Permission.." "..Level, 0xa3c846)
							TriggerClientEvent("Notify", source, "Sucesso", "Adicionado a permissão <b>"..Permission.."</b> ao passaporte <b>"..OtherPassport.."</b>.", "verde", 5000)
							TriggerClientEvent("Notify", OtherSource, "Sucesso", "Você recebeu a permissão de <b>"..Permission.."</b>.", "verde", 5000)
							vRP.SetPermission(OtherPassport, Permission, Level)
						end
					else
						TriggerClientEvent("Notify", source, "Aviso", "Campo <b>Hierarquia</b> deve conter apenas números.", "vermelho", 5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "ungroup" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local List = {}
				for Index, _ in pairs(GroupsList()) do
					table.insert(List, Index)
				end

				local Keyboard = vKEYBOARD.RemoveGroup(source,"Passaporte:",List)
				if Keyboard then
					TriggerClientEvent("Notify",source,"Sucesso","Removido <b>"..Keyboard[2].."</b> ao passaporte <b>"..Keyboard[1].."</b>.","verde",5000)
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** ungroup "..Keyboard[1].." "..Keyboard[2],0xa3c846)
					vRP.RemovePermission(Keyboard[1],Keyboard[2])
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "ugroups" then
			if vRP.HasGroup(Passport, "Admin") then
				local Keyboard = vKEYBOARD.Primary(source, "Passaporte:")
				if Keyboard then
					local Result = ""
					local Groups = vRP.Groups()
					local OtherPassport = Keyboard[1]
					for Permission, _ in pairs(Groups) do
						local Data = vRP.DataGroups(Permission)
						if Data[OtherPassport] then
							local Hierarchy = vRP.Hierarchy(Permission)[vRP.GetUserHierarchy(OtherPassport, Permission)]
							Result = Result..Permission.." - "..Hierarchy.."["..Data[OtherPassport].."]\n"
						end
					end

					if Result ~= "" then
						vKEYBOARD.Area(source,Result)
					else
						TriggerClientEvent("Notify", source, "Aviso", "O usuário não possui nenhum grupo.", "vermelho", 5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tptome" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source, "Passaporte:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(source)
						local Coords = GetEntityCoords(Ped)

						vRP.Teleport(ClosestPed, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tpto" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source, "Passaporte:")
				if Keyboard then
					local ClosestPed = vRP.Source(Keyboard[1])
					if ClosestPed then
						local Ped = GetPlayerPed(ClosestPed)
						local Coords = GetEntityCoords(Ped)
						vRP.Teleport(source, Coords["x"], Coords["y"], Coords["z"])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tpway" then
			if vRP.HasGroup(Passport,"Admin",2) then
				vCLIENT.TeleportWay(source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tuning" then
			if vRP.HasGroup(Passport,"Admin") then
				TriggerClientEvent("admin:Tuning", source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "fix" then
			if vRP.HasGroup(Passport,"Admin") then
				local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
				if Vehicle then
					local Players = vRPC.Players(source)
					for _,v in pairs(Players) do
						async(function()
							TriggerClientEvent("target:RollVehicle",v,Network)
							TriggerClientEvent("inventory:RepairAdmin",v,Network,Plate)
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "fuel" then
			if vRP.HasGroup(Passport,"Admin",2) then
				if not vRPC.InsideVehicle(source) then
					local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
					if Vehicle then
						local Keyboard = vKEYBOARD.Primary(source, "Litros:")
						if Keyboard then
							local Networked = NetworkGetEntityFromNetworkId(Network)
							if DoesEntityExist(Networked) then
								Entity(Networked)["state"]:set("Fuel", Keyboard[1], true)
							end

							TriggerClientEvent("Notify",source,"Sucesso","Veículo com <b>"..parseInt(Keyboard[1]).."% de Gasolina</b>.","verde",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"Atenção","Você precisa sair do veículo.","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "nitro" then
			if vRP.HasGroup(Passport,"Admin",2) then
				if vRPC.InsideVehicle(source) then
					local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
					if Vehicle then
						local NitroList = { "Remover" ,"50%", "100%", "Admin" }
						local NitroValue = 0

						local Keyboard = vKEYBOARD.Nitro(source, NitroList)
						if Keyboard then
							if Keyboard[1] == "Remover" then
								NitroValue = 0
							elseif Keyboard[1] == "50%" then
								NitroValue = 1000
							elseif Keyboard[1] == "100%" then
								NitroValue = 2000
							elseif Keyboard[1] == "Admin" then
								NitroValue = 100000
							end

							local Networked = NetworkGetEntityFromNetworkId(Network)
							if DoesEntityExist(Networked) then
								local Nitro = GlobalState["Nitro"]
								Nitro[Plate] = NitroValue
								GlobalState:set("Nitro", Nitro, true)
							end

							TriggerClientEvent("Notify",source,"Sucesso","Nitro atualizado.","verde",5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "lockpick" then
			if vRP.HasGroup(Passport,"Admin",1) then
				local Vehicle, Network, Plate, Model, Class = vRPC.VehicleList(source, 5)
				if Vehicle then
					local Networked = NetworkGetEntityFromNetworkId(Network)
					if DoesEntityExist(Networked) then
						TriggerClientEvent("Notify",source,"Sucesso","Você destrancou o veículo.","verde",5000)

						if not vRP.PassportPlate(Plate) then
							Entity(Networked)["state"]:set("Fuel", 100, true)
							Entity(Networked)["state"]:set("Nitro", 0, true)
							SetVehicleDoorsLocked(Networked, 1)
						else
							SetVehicleDoorsLocked(Networked, 1)
						end

						TriggerEvent("PlateEveryone", Plate)
						TriggerEvent("PlayersPlate", Plate, Passport)

						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** lockpick",0xa3c846)
					end
				else
					TriggerClientEvent("Notify",source,"Atenção","Sem veículos próximos.","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "limparea" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Players = vRPC.Players(source)
				for _,Sources in pairs(Players) do
					async(function()
						vCLIENT.Limparea(Sources,Coords)
					end)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "hash" then
			if vRP.HasGroup(Passport,"Admin") then
				local Vehicle = vRPC.VehicleHash(source)
				if Vehicle then
					vKEYBOARD.Copy(source,"Hash do veículo:",Vehicle)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "setbank" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Quantidade:")
				if Keyboard then
					vRP.GiveBank(Keyboard[1],Keyboard[2])
					TriggerClientEvent("Notify",source,"Sucesso","Envio concluído.","verde",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "rembank" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source, "Passaporte:", "Quantidade:")
				if Keyboard then
					vRP.RemoveBank(Keyboard[1],Keyboard[2])
					TriggerClientEvent("Notify",source,"Sucesso","Remoção concluída.","verde",5000)
					TriggerClientEvent("NotifyItem",source,{ "-", "dollars", Dotted(Keyboard[2]), "Dólares" })
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "players" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("Notify",source,"Sistema","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),"azul",5000)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "playersconnected" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local List = vRP.Players()
				local Players = ""
				for k,v in pairs(List) do
					local IDIdentity = vRP.Identity(k)
					Players = Players ..k..": "..IDIdentity["Name"].." "..IDIdentity["Lastname"].."\n"
				end

				vKEYBOARD.Copy(source,"Players Conectados:",Players)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "announce" then
			if vRP.HasGroup(Passport,"Admin") then
				local Themes = { "amarelo", "announcement", "roxo", "blood", "default", "vermelho", "fome", "hospital", "azul", "mechanic", "money", "phone", "policia", "server", "verde", "sede" }

				local Keyboard = vKEYBOARD.Announce(source,Themes,"Anúncio:","Título:","Segundos:")
				if Keyboard then
					TriggerClientEvent("Notify", -1, Keyboard[3], Keyboard[2], Keyboard[1], Keyboard[4] * 1000)
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** announce "..Keyboard[1].." "..Keyboard[2].." "..Keyboard[3].." "..Keyboard[4] * 1000,0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "chatannounce" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Area(source,"Anúncio:")
				if Keyboard then
					local Messages = Keyboard[1]:gsub("[<>]", "")
					TriggerClientEvent("chat:ClientMessage", -1, "Prefeitura", Messages, "Anúncio")
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** chatannounce "..Messages,0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "setcar" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source, "Passaporte:", "Veículo:")
				if Keyboard and Keyboard[1] and Keyboard[2] and VehicleExist(Keyboard[2]) then
					local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2] })
					if Consult[1] then
						TriggerClientEvent("Notify",source,"Atenção","O veículo <b>"..Keyboard[2].."</b> já está adicionado.","amarelo",5000)
					else
						TriggerClientEvent("Notify",source,"Sucesso","Veículo adicionado com sucesso.","verde",5000)

						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** setcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
						vRP.Query("vehicles/addVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2], Plate = vRP.GeneratePlate(), Weight = VehicleWeight(Keyboard[2]), Work = "false" })
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "remcar" then
			if vRP.HasGroup(Passport,"Admin") then
				local Keyboard = vKEYBOARD.Secondary(source,"Passaporte:","Veículo:")
				if Keyboard then
					TriggerClientEvent("Notify",source,"Sucesso","Veículo removido com sucesso.","verde",5000)

					vRP.Query("vehicles/removeVehicles",{ Passport = Keyboard[1], Vehicle = Keyboard[2] })
					exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** remcar "..Keyboard[1].." "..Keyboard[2],0xa3c846)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "clearprison" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Passaporte:")
				if Keyboard then
					local OtherPlayer = vRP.Source(Keyboard[1])
					if OtherPlayer then
						exports["discord"]:Embed("Admin","**Passaporte:** "..Passport.."\n**Comando:** clearprison "..Keyboard[1],0xa3c846)
						TriggerClientEvent("Notify",source,"Sucesso","Prisão zerada.","verde",5000)
						Player(OtherPlayer)["state"]["Prison"] = false
						vRP.ClearPrison(Keyboard[1])
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "stats" then
			local Service,TotalPolicia = vRP.NumPermission("Policia")
			local Service,TotalMecanico = vRP.NumPermission("Mecanico")
			local Service,TotalParamedico = vRP.NumPermission("Paramedico")
			TriggerClientEvent("Notify",source,ServerName,"Atualmente <b>"..parseInt(GetNumPlayerIndices()).."</b> pessoas conectadas.<br><br>Atualmente <b>"..parseInt(TotalPolicia).." Policiais</b> conectados.<br>Atualmente <b>"..parseInt(TotalMecanico).." Mecânicos</b> conectados.<br>Atualmente <b>"..parseInt(TotalParamedico).." Paramédicos</b> conectados.","azul",10000)
		elseif Mode == "statsPolicia" then
			local Service,TotalPolicia = vRP.NumPermission("Policia")
			TriggerClientEvent("Notify",source,"Polícia","Existem <b>"..parseInt(TotalPolicia).."</b> companheiros com você.","policia",5000)
		elseif Mode == "statsParamedico" then
			local Service,TotalParamedico = vRP.NumPermission("Paramedico")
			TriggerClientEvent("Notify",source,"Paramédico","Existem <b>"..parseInt(TotalParamedico).."</b> companheiros com você.","hospital",5000)
		elseif Mode == "debug" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("admin:ToggleDebug", source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "magneto" then
			if vRP.HasGroup(Passport,"Admin",2) then
				TriggerClientEvent("admin:ToggleMagneto", source)
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "vehiclespeed" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Velocidade:")
				if Keyboard then
					TriggerClientEvent("admin:ChangeVehicleSpeed", source, tonumber(Keyboard[1]))
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "tyreburst" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Número do Pneu:")
				if Keyboard then
					TriggerClientEvent("admin:TyreBurst", source, tonumber(Keyboard[1]))
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		elseif Mode == "createlightning" then
			if vRP.HasGroup(Passport,"Admin",2) then
				local Keyboard = vKEYBOARD.Primary(source,"Número:")
				if Keyboard then
					local UsersList = vRP.Players()
					for k, v in pairs(UsersList) do
						local OtherPassport = parseInt(k)
						local OtherSource = vRP.Source(OtherPassport)
						if OtherSource then
							TriggerClientEvent("admin:LightningThunder", OtherSource, tonumber(Keyboard[1]))
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você não tem permissões para isso.","amarelo",5000)
			end
		end
	end
end)