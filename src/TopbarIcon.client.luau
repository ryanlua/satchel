--!strict

local Satchel = require(script.Parent)
local Icon = require(script.Parent.Parent.topbarplus)

local icon = Icon.new()
icon:modifyTheme({ "IconLabelContainer", "TargetWidth", 0 }) -- Force minimum width
icon:setLabel("backpack")
icon:setOrder(-1)
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
icon:bindToggleKey(Enum.KeyCode.Backquote)
icon:autoDeselect(false)
icon:setCaption("Inventory")

icon.toggled:Connect(function(isSelected, fromSource)
	if fromSource == "User" then
		Satchel.setEnabled(isSelected)
	end
end)
