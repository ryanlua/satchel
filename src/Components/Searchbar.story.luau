--!strict

local React = require(script.Parent.Parent.Parent.react)

local Searchbar = require(script.Parent.Searchbar)

return {
	summary = "Search for items in the inventory",
	story = function()
		return React.createElement(Searchbar, {
			size = UDim2.fromOffset(190, 30),
		})
	end,
}
