--!strict

const RunService = game:GetService("RunService")

const bindableEvents = script.Parent.Parent.BindableEvents
const styleSheets = script.Parent.Parent.Design
const currentTheme = styleSheets.SatchelStyleSheet:FindFirstChildWhichIsA("StyleDerive")

-- TODO: Add autocomplete for default themes
const function setTheme(theme: string | StyleSheet)
	assert(RunService:IsClient(), "setTheme can only be called on the client")

	const newTheme = if typeof(theme) == "string" then styleSheets:WaitForChild(theme) else theme
	currentTheme.StyleSheet = newTheme

	bindableEvents.ThemeChanged:Fire(newTheme)
end

return setTheme
