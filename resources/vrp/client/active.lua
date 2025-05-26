-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active", function(Passport, Name)
	SetDiscordAppId(1375867084805898411)
	SetDiscordRichPresenceAsset("LifeCare")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetSmall("LifeCare")
	SetDiscordRichPresenceAssetText("LifeCare")
	SetDiscordRichPresenceAssetSmallText("LifeCare")
	SetDiscordRichPresenceAction(0, "LifeCare", ServerLink)
end)

