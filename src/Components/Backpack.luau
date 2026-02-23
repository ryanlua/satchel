--!strict

local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	tools: { Tool? }?,
	opened: boolean?,
}

local function Backpack(props: Props)
	return React.createElement("Frame", { [React.Tag] = "Backpack" }, {
		Hotbar = React.createElement(Hotbar, {
			forceGamepadHintVisible = props.forceGamepadHintVisible,
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = props.slots,
			tools = props.tools,
			opened = props.opened,
		}),
	})
end

return Backpack
