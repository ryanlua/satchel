--!strict

local React = require(script.Parent.Parent.Parent.react)

local App = require(script.Parent.Parent.Components.App)

local controls = {
	hintVisible = true,
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	toolSlot = 1,
	opened = true,
	rows = 4,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hotbar and inventory, including hints for gamepad controls.",
	controls = controls,
	story = function(props: Props)
		local tool = Instance.new("Tool")
		tool.Name = props.controls.toolName
		tool.TextureId = props.controls.toolImage
		tool.ToolTip = props.controls.toolTooltip

		return React.createElement(App, {
			forceGamepadHintVisible = props.controls.hintVisible,
			slots = props.controls.slots,
			items = { [props.controls.toolSlot] = tool },
			opened = props.controls.opened,
			rows = props.controls.rows,
		})
	end,
}
