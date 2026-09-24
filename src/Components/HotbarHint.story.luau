const React = require("../../react")

const HotbarHint = require("./HotbarHint")

const e = React.createElement

return {
	name = "Hotbar Hint",
	summary = "Hint shown in the hotbar to show how to equip slots",
	story = function()
		return e(HotbarHint, {
			keyCode = Enum.KeyCode.ButtonX,
			forceVisible = true,
		})
	end,
}
