--!strict

const Players = game:GetService("Players")
const RunService = game:GetService("RunService")

const player = Players.LocalPlayer
const playerGui = player:WaitForChild("PlayerGui")
const screenGui = playerGui:WaitForChild("SatchelGui")

const function getEnabled(): boolean
	assert(RunService:IsClient(), "getEnabled can only be called on the client")

	return screenGui.Enabled
end

return getEnabled
