--!strict

const RunService = game:GetService("RunService")

const bindableEvents = script.Parent.Parent.BindableEvents
const styleSheets = script.Parent.Parent.Design
const currentTheme = styleSheets.SatchelStyleSheet:FindFirstChildOfClass("StyleDerive") :: StyleDerive

type DefaultThemes = "DefaultTheme" | "LegacyTheme"

const function setTheme(theme: DefaultThemes | StyleSheet): ()
	assert(RunService:IsClient(), "setTheme can only be called on the client")

	const newTheme: StyleSheet = if typeof(theme) == "string" then styleSheets:WaitForChild(theme) :: StyleSheet else theme
	currentTheme.StyleSheet = newTheme

	bindableEvents.ThemeChanged:Fire(newTheme)
end

return setTheme
