--!strict

local StarterGui = game:GetService("StarterGui")

local Icon = require(script.Parent.Satchel.Packages.topbarplus)

local icon = Icon.new()
icon:setLabel("Toggle CoreGui Backpack")
icon:align("Right")
icon:bindEvent("deselected", function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack))
end)
icon:oneClick()
