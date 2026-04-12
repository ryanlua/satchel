--!strict

const Players = game:GetService("Players")
const RunService = game:GetService("RunService")

const getTopbarIcon = require("./getTopbarIcon")

const player = Players.LocalPlayer
const playerGui = player:WaitForChild("PlayerGui")
const screenGui = playerGui:WaitForChild("SatchelGui")

const function setEnabled(enabled: boolean): ()
	assert(RunService:IsClient(), "setEnabled can only be called on the client")

	screenGui.Enabled = enabled

	const icon = getTopbarIcon()
	if icon then
		icon:setEnabled(enabled)
	end
end

return setEnabled
