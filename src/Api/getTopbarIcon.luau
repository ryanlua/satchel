--!strict

local RunService = game:GetService("RunService")

local TopbarPlus = require(script.Parent.Parent.Parent.topbarplus)

local function getTopbarIcon(): TopbarPlus.Icon?
	assert(RunService:IsClient(), "getTopbarIcon can only be called on the client")

	for _, icon in TopbarPlus.getIcons() do
		if icon.captionText == "Inventory" then
			return icon
		end
	end

	return nil
end

return getTopbarIcon
