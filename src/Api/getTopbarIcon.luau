--!strict

local RunService = game:GetService("RunService")

local TopbarPlus = require(script.Parent.Parent.Parent.topbarplus)

local function getTopbarIcon(): TopbarPlus.Icon?
	assert(RunService:IsClient(), "getTopbarIcon can only be called on the client")

	return TopbarPlus.getIcon("SatchelInventory")
end

return getTopbarIcon
