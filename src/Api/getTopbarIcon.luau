local TopbarPlus = require(script.Parent.Parent.Parent.topbarplus)

local RunService = game:GetService("RunService")

local function getTopbarIcon(): TopbarPlus.Icon
	assert(RunService:IsClient(), "getTopbarIcon can only be called on the client")
	print("Not implemented")
	return nil
end

return getTopbarIcon
