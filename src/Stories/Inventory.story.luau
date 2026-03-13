--!strict

local React = require(script.Parent.Parent.Parent.react)

local Inventory = require(script.Parent.Parent.Components.Inventory)

return {
	summary = "Toggleable inventory for displaying items not in the hotbar",
	story = function()
		return React.createElement(Inventory, {
			size = UDim2.fromOffset(655, 320),
		})
	end,
}
