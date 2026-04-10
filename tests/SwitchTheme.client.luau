--!strict

local Icon = require(script.Parent.Satchel.Packages.topbarplus)
local Satchel = require(script.Parent.Satchel)

local icon = Icon.new()
icon:modifyTheme({
	{ "IconLabelContainer", "TargetWidth", 0 }, -- Force minimum width
	{ "IconLabel", "AutoLocalize", false }, -- Don't translate font icon
})
icon:setLabel("two-arrows-left-right")
icon:align("Right")
icon:setTextSize(24)
icon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal,
	"Selected"
)
icon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Regular,
	Enum.FontStyle.Normal,
	"Deselected"
)
icon:autoDeselect(false)
icon:setCaption("Switch Theme")

local defaultTheme: Icon.Icon
local legacyTheme: Icon.Icon

defaultTheme = Icon.new()
defaultTheme:select()
defaultTheme:setLabel("Default")
defaultTheme:bindEvent("selected", function()
	Satchel.setTheme("DefaultTheme")
end)
defaultTheme:bindEvent("deselected", function()
	if not legacyTheme.isSelected then
		defaultTheme:select()
		Satchel.setTheme("DefaultTheme")
	end
end)

legacyTheme = Icon.new()
legacyTheme:setLabel("Legacy")
legacyTheme:bindEvent("selected", function()
	Satchel.setTheme("LegacyTheme")
end)
legacyTheme:bindEvent("deselected", function()
	if not defaultTheme.isSelected then
		defaultTheme:select()
		Satchel.setTheme("DefaultTheme")
	end
end)

icon:setDropdown({ defaultTheme, legacyTheme })

Satchel.themeChanged:Connect(function(theme)
	if theme.Name == "DefaultTheme" then
		defaultTheme:select()
	elseif theme.Name == "LegacyTheme" then
		legacyTheme:select()
	end
end)
