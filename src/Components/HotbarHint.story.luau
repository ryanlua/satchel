--!strict

const React = require("../../react")

const HotbarHint = require("./HotbarHint")

return {
	name = "Hotbar Hint",
	summary = "Hint shown in the hotbar to show how to equip slots",
	story = function()
		return React.createElement(HotbarHint, {
			keyCode = Enum.KeyCode.ButtonX,
			forceVisible = true,
		})
	end,
}
