--!strict

const StarterGui = game:GetService("StarterGui")

const Icon = require("./Satchel/Packages/topbarplus")
const Satchel = require("./Satchel")

const icon = Icon.new()
icon:modifyTheme({ "IconLabel", "AutoLocalize", false }) -- Don't translate font icon
const iconLabelContainer = icon:getInstance("IconLabelContainer") :: Instance
iconLabelContainer:SetAttribute("TargetWidth", 0) -- Force minimum width
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
icon:select()
