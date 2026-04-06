--!strict

local Icon = require(script.Parent.Satchel.Packages.topbarplus)
local Satchel = require(script.Parent.Satchel)

local icon = Icon.new()
icon:setLabel("Toggle Inventory")
icon:align("Right")
icon:bindEvent("deselected", function()
	if Satchel.isInventoryOpen() then
		Satchel.closeInventory()
	else
		Satchel.openInventory()
	end
end)
icon:oneClick()
