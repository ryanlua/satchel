--!strict

local StarterGui = game:GetService("StarterGui")

local Icon = require("./Satchel/Packages/topbarplus")
local Satchel = require("./Satchel")

local icon = Icon.new()
icon:modifyTheme({
	{ "IconLabelContainer", "TargetWidth", 0 }, -- Force minimum width
	{ "IconLabel", "AutoLocalize", false }, -- Don't translate font icon
})
icon:select()
icon:setLabel("two-switches-horizontal")
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
icon:setCaption("Toggle Satchel")
icon.toggled:Connect(function(isSelected, fromSource)
	if fromSource == "User" then
		Satchel.setEnabled(isSelected)
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not isSelected)
	end
end)
