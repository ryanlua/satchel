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
icon:setCaption("Switch Theme")
icon:setDropdown({
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
