--!strict

local React = require(script.Parent.Parent.Parent.react)

local HotbarHint = require(script.Parent.Parent.Components.HotbarHint)

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
