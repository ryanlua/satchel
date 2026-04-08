--!strict

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local getTopbarIcon = require(script.Parent.getTopbarIcon)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = playerGui:WaitForChild("SatchelGui")

local function setEnabled(enabled: boolean): ()
	assert(RunService:IsClient(), "setEnabled can only be called on the client")

	screenGui.Enabled = enabled

	local icon = getTopbarIcon()
	if icon then
		icon:setEnabled(enabled)
	end
end

return setEnabled
