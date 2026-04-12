--!strict

const RunService = game:GetService("RunService")

const TopbarPlus = require("../../topbarplus")

const function getTopbarIcon(): TopbarPlus.Icon?
	assert(RunService:IsClient(), "getTopbarIcon can only be called on the client")

	return TopbarPlus.getIcon("SatchelInventory")
end

return getTopbarIcon
