--!strict

local Icon = require(script.Parent.Satchel.Packages.topbarplus)
local Satchel = require(script.Parent.Satchel)

local switchThemeIcon = Icon.new()
switchThemeIcon:modifyTheme({ "IconLabelContainer", "TargetWidth", 0 }) -- Force minimum width
switchThemeIcon:setLabel("two-arrows-left-right")
switchThemeIcon:setTextSize(24)
switchThemeIcon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Bold,
	Enum.FontStyle.Normal,
	"Selected"
)
switchThemeIcon:setTextFont(
	"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json",
	Enum.FontWeight.Regular,
	Enum.FontStyle.Normal,
	"Deselected"
)
switchThemeIcon:setCaption("Switch Theme")
switchThemeIcon:align("Right")
switchThemeIcon:setDropdown({
	Icon.new()
		:setLabel("Default")
		:bindEvent("deselected", function()
			Satchel.setTheme("DefaultTheme")
		end)
		:oneClick(),
	Icon.new()
		:setLabel("Legacy")
		:bindEvent("deselected", function()
			Satchel.setTheme("LegacyTheme")
		end)
		:oneClick(),
})
