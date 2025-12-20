local React = require("../../react")

local HotbarHint = require("./HotbarHint")

export type Props = {
	forceHintVisible: boolean?,
	children: any?,
}

local function Hotbar(props: Props)
	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, {
		SlotLeftHint = React.createElement(HotbarHint, {
			hintKey = Enum.KeyCode.ButtonL1,
			forceVisible = props.forceHintVisible,
			order = -1,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			hintKey = Enum.KeyCode.ButtonR1,
			forceVisible = props.forceHintVisible,
			order = 100,
		}),
	}, props.children)
end

return Hotbar
