--!strict

const Players = game:GetService("Players")
const RunService = game:GetService("RunService")

const player = Players.LocalPlayer :: Player
const playerGui = player:WaitForChild("PlayerGui")
const screenGui = playerGui:WaitForChild("SatchelGui") :: ScreenGui

const DEFAULT_HOTBAR_SLOT_COUNT = 10

const function getHotbarSlotCount(): number
	assert(RunService:IsClient(), "getHotbarSlotCount can only be called on the client")

	const count = screenGui:GetAttribute("HotbarSlotCount")
	if typeof(count) == "number" then
		return count
	end
	return DEFAULT_HOTBAR_SLOT_COUNT
end

return getHotbarSlotCount
