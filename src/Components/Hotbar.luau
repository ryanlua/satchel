local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.HotbarHint)

export type Props = {
	forceHintVisible: boolean?,
}

local function Hotbar(props: Props)
	return React.createElement("Frame", {
		[React.Tag] = "Hotbar",
	}, {
		-- Create default hints for switching between hotbar slots
		SlotLeftHint = React.createElement(HotbarHint, {
			key = Enum.KeyCode.ButtonL1,
			forceVisible = props.forceHintVisible,
			order = -1,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			key = Enum.KeyCode.ButtonR1,
			forceVisible = props.forceHintVisible,
			order = 100,
		}),
	})
end

return Hotbar
