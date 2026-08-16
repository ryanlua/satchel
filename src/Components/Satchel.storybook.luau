const React = require("../../react")
const ReactRoblox = require("../../react-roblox")

const DESIGN_SHEET = script.Parent.Parent.Design.SatchelStyleSheet

const e = React.createElement

return {
	name = "Satchel",
	mapStory = function(Story)
		return function(storyProps)
			return e(React.Fragment, nil, {
				UIListLayout = e("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
				StyleLink = e("StyleLink", {
					StyleSheet = DESIGN_SHEET,
				}),
				Story = e(Story, storyProps),
			})
		end
	end,
	storyRoots = {
		script.Parent,
	},
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}
