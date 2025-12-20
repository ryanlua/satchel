local React = require("../../react")

local Hotbar = require("./Hotbar")

export type Props = {
	children: any?,
}

local function Backpack(props: Props)
	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
	}, {
		Hotbar = React.createElement(Hotbar, props.children),
		StyleLink = React.createElement("StyleLink", {
			StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
		}),
	})
end

return Backpack
