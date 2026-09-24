--!strict

const Players = game:GetService("Players")
const RunService = game:GetService("RunService")

const player = Players.LocalPlayer :: Player
const playerGui = player:WaitForChild("PlayerGui")
const screenGui = playerGui:WaitForChild("SatchelGui") :: ScreenGui

const function getEnabled(): boolean
	assert(RunService:IsClient(), "getEnabled can only be called on the client")

	return screenGui.Enabled
end

return getEnabled
