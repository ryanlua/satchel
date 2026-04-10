--!strict

local React = require("../../react")

local InventoryHint = require("./InventoryHint")

local controls = {
	text = "Remove from Hotbar",
}

type Props = {
	controls: typeof(controls),
}

return {
	name = "Inventory Hint",
	summary = "Hint shown in the inventory",
	controls = controls,
	story = function(props: Props)
		return React.createElement(InventoryHint, {
			keyCode = Enum.KeyCode.ButtonX,
			forceVisible = true,
			text = props.controls.text,
		})
	end,
}
