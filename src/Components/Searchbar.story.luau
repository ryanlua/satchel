--!strict

const React = require("../../react")

const Searchbar = require("./Searchbar")

return {
	summary = "Search for items in the inventory",
	story = function()
		return React.createElement(Searchbar, {
			size = UDim2.fromOffset(190, 30),
		})
	end,
}
