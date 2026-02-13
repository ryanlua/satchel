local React = require(script.Parent.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent.Parent["react-roblox"])

return {
	name = "Satchel",
	storyRoots = {
		script.Parent,
	},
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}