-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Hensa = {}
Tunnel.bindInterface("taskbar",Hensa)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Results = false
local Progress = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAILURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Failure",function(Data,Callback)
	Results = false
	Progress = false
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUCESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Success",function(Data,Callback)
	Results = true
	Progress = false
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIGAME
-----------------------------------------------------------------------------------------------------------------------------------------
function Minigame(Timer)
	if Progress then return end

	Progress = true
	SetNuiFocus(true,false)
	SendNUIMessage({ Action = "Open", Payload = Timer })

	while Progress do
		Wait(0)
	end

	return Results
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Task",function(Amount,Speed)
	local Return = true

	for Number = 1,Amount do
		if not Minigame(Speed) then
			Return = false

			break
		end
	end

	return Return
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function Hensa.Task(Amount,Speed)
	local Return = true

	for Number = 1,Amount do
		if not Minigame(Speed) then
			Return = false

			break
		end
	end

	return Return
end