--!strict

local RunService = game:GetService("RunService")

local styleSheets = script.Parent.Parent.Design
local currentTheme = styleSheets.SatchelStyleSheet:FindFirstChildWhichIsA("StyleDerive")

-- TODO: Add autocomplete for default themes
local function setTheme(theme: string | StyleSheet)
	assert(RunService:IsClient(), "setTheme can only be called on the client")

	local newTheme = if typeof(theme) == "string" then styleSheets:WaitForChild(theme) else theme
	currentTheme.StyleSheet = newTheme
end

return setTheme
