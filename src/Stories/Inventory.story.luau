--!strict

local React = require(script.Parent.Parent.Parent.react)

local Inventory = require(script.Parent.Parent.Components.Inventory)

return {
	summary = "Toggleable inventory for displaying items not in the hotbar",
	story = function()
		return React.createElement(Inventory, {
			size = UDim2.new(1, 0, 0, 320),
		})
	end,
}
