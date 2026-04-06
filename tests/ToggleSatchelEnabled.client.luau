--!strict

local Icon = require(script.Parent.Satchel.Packages.topbarplus)
local Satchel = require(script.Parent.Satchel)

local icon = Icon.new()
icon:setLabel("Toggle Satchel")
icon:align("Right")
icon:bindEvent("deselected", function()
	Satchel.setEnabled(not Satchel.getEnabled())
end)
icon:oneClick()
