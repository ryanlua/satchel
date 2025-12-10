--!strict

local React = require("../../react")

local HotbarHint = require("./HotbarHint")

export type Props = {
	children: any?,
}

local function Hotbar(props: Props)
	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, {
		SlotLeftHint = React.createElement(HotbarHint, {
			hintImage = "rbxasset://textures/ui/Controls/DesignSystem/ButtonL1.png",
			order = -1,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			hintImage = "rbxasset://textures/ui/Controls/DesignSystem/ButtonR1.png",
			order = 100,
		}),
	}, props.children)
end

return Hotbar
