-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Disconnect"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Services"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Salary"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Admin"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Garages"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Paramedic"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Payments"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Airport"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Deaths"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Gemstone"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Rename"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Roles"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Skins"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Marketplace"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Pause"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Boxes"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b",
	["Hackers"] = "https://discord.com/api/webhooks/1376029232890646560/FdadbAfJWiEUonNtluka16jbagOHGkVlxuW2tK3ScHvvzuL95JfhEPVh_2RCoe_rLH8b"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,Color,source)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		embeds = {
			{ color = (Color or 0xa3c846), description = Message }
		}
	}),{ ["Content-Type"] = "application/json" })

	if source then
		TriggerClientEvent("megazord:Screenshot",source,Discord[Hook])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Content",function(Hook,Message)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Webhook",function(Hook)
	return Discord[Hook] or ""
end)