const React = require("../../react")

const InventoryHint = require("./InventoryHint")

const e = React.createElement

const controls = {
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
		return e(InventoryHint, {
			keyCode = Enum.KeyCode.ButtonX,
			forceVisible = true,
			text = props.controls.text,
		})
	end,
}
