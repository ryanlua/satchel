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
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.toolName
		Tool.TextureId = props.controls.toolImage
		Tool.ToolTip = props.controls.toolTooltip

		return React.createElement(App, {
			forceGamepadHintVisible = props.controls.hintVisible,
			slots = props.controls.slots,
			tools = { [props.controls.toolSlot] = Tool },
			opened = props.controls.opened,
			rows = props.controls.rows,
		})
	end,
}
