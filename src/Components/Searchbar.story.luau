--!strict

local React = require("../../react")

local Searchbar = require("./Searchbar")

return {
	summary = "Search for items in the inventory",
	story = function()
		return React.createElement(Searchbar, {
			size = UDim2.fromOffset(190, 30),
		})
	end,
}
