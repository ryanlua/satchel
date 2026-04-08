--!strict

local RunService = game:GetService("RunService")

local currentStyleSheet = script.Parent.Parent.Design.SatchelStyleSheet

local function getTheme(): StyleSheet
	assert(RunService:IsClient(), "getTheme can only be called on the client")

	local currentTheme = currentStyleSheet:FindFirstChildWhichIsA("StyleDerive").StyleSheet
	return currentTheme
end

return getTheme
