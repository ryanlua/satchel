--!strict

local React = require("../../react")

local HotbarHint = require("./HotbarHint")

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
