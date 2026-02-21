local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)

local controls = {
	forceGamepadHintVisible = true,
	forceKeyboardHintVisible = true,
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	toolSlot = 1,
	unlocked = false,
	opened = true,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hotbar component that holds hotbar slots and hints",
	controls = controls,
	story = function(props: Props)
		local tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.tooltipText

		local tools = {}
		tools[props.controls.toolSlot] = tool

		return React.createElement(Hotbar, {
			forceGamepadHintVisible = props.controls.forceGamepadHintVisible,
			forceKeyboardHintVisible = props.controls.forceKeyboardHintVisible,
			slots = props.controls.slots,
			tools = tools,
			unlocked = props.controls.unlocked,
			opened = props.controls.opened,
		})
	end,
}
