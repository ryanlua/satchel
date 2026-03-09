local RunService = game:GetService("RunService")

local function isInventoryOpen(): boolean
	assert(RunService:IsClient(), "isInventoryOpen can only be called on the client")
	return nil -- Not implemented
end

return isInventoryOpen
