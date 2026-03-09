--!strict

local RunService = game:GetService("RunService")

local TopbarPlus = require("../../topbarplus")

local function getTopbarIcon(): TopbarPlus.Icon
	assert(RunService:IsClient(), "getTopbarIcon can only be called on the client")
	print("Not implemented")
	return nil
end

return getTopbarIcon
