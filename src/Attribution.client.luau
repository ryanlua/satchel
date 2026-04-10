--!strict

--[[
	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at http://mozilla.org/MPL/2.0/.
]]

--[[
	By using Satchel, you agree to provide attribution in one of the following ways:
		1. Keep the Attribution script unmodified and enabled
		2. Provide credit in your experience description by name (Satchel) and creator (@WinnersTakesAll)
		3. Have a DevForum topic linked in your experience description, crediting with the above

	For questions or exceptions to the attribution terms, reach out through the social links:
		https://create.roblox.com/store/asset/13947506401

	Thank you for supporting Satchel.
]]

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local VERSION = "2.0.0"

-- Print attribution. Do not modify without reading above
if not RunService:IsStudio() and RunService:IsClient() then
	print(`💼 Running Satchel v{VERSION} by @WinnersTakesAll`)
end

-- Check for updates. You may modify the below
local latestVersion: string?

local success, result = pcall(function()
	return MarketplaceService:GetProductInfoAsync(13947506401)
end)

if success then
	latestVersion = string.match(result.Name, "v(%d+%.%d+%.%d+)")
end

if latestVersion and latestVersion ~= VERSION then
	warn(
		`A new version of Satchel (v{VERSION} -> v{latestVersion}) is available: https://create.roblox.com/store/asset/13947506401`
	)
end
