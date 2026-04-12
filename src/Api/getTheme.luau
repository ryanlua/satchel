--!strict

const RunService = game:GetService("RunService")

const currentStyleSheet = script.Parent.Parent.Design.SatchelStyleSheet

const function getTheme(): StyleSheet
	assert(RunService:IsClient(), "getTheme can only be called on the client")

	const currentTheme = currentStyleSheet:FindFirstChildWhichIsA("StyleDerive").StyleSheet
	return currentTheme
end

return getTheme
