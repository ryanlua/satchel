--!strict

local React = require(script.Parent.Parent.Parent.react)

local Backpack = require(script.Parent.Parent.Components.Backpack)

local controls = {
	hintVisible = true,
	slots = 10,
	toolName = "Sword",
	toolImage = "rbxasset://Textures/Sword128.png",
	toolTooltip = "A classic sword",
	toolSlot = 1,
	opened = false,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Backpack that holds the hotbar and inventory",
	controls = controls,
	story = function(props: Props)
		local Tool = Instance.new("Tool")
		Tool.Name = props.controls.toolName
		Tool.TextureId = props.controls.toolImage
		Tool.ToolTip = props.controls.toolTooltip

		return React.createElement(Backpack, {
			forceGamepadHintVisible = props.controls.hintVisible,
			slots = props.controls.slots,
			tools = { [props.controls.toolSlot] = Tool },
			opened = props.controls.opened,
		})
	end,
}
