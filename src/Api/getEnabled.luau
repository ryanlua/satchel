--!strict

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = playerGui:WaitForChild("SatchelGui")

local function getEnabled(): boolean
	assert(RunService:IsClient(), "getEnabled can only be called on the client")

	return screenGui.Enabled
end

return getEnabled
