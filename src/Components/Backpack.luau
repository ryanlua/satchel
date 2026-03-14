--!strict

local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)
local Inventory = require(script.Parent.Inventory)

export type Props = {
	size: UDim2?,
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	tools: { Tool? }?,
	opened: boolean?,
}

local function Backpack(props: Props)
	return React.createElement("Frame", {
		Size = props.size,
		[React.Tag] = "Backpack",
	}, {
		Hotbar = React.createElement(Hotbar, {
			forceGamepadHintVisible = props.forceGamepadHintVisible,
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = props.slots,
			tools = props.tools,
			opened = props.opened,
		}),
		Inventory = React.createElement(Inventory, {
			forceGamepadHintVisible = props.forceGamepadHintVisible,
			forceKeyboardHintVisible = props.forceKeyboardHintVisible,
			slots = props.slots,
			tools = props.tools,
			visible = props.opened,
		}),
	})
end

return Backpack
