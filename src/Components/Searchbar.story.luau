const React = require("../../react")

const Searchbar = require("./Searchbar")

const e = React.createElement

return {
	summary = "Search for items in the inventory",
	story = function()
		return e(Searchbar, {
			size = UDim2.fromOffset(190, 30),
		})
	end,
}
