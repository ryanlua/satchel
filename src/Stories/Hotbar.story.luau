--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Hotbar = require("../Components/Hotbar")
local Slot = require("../Components/Slot")

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		local component = React.createElement(Hotbar, {}, {
			Tool = React.createElement(Slot, {
				toolName = "Classic Sword",
				tooltipText = "A classic sword",
				slotNumber = 1,
				toolImage = "rbxasset://Textures/Sword128.png",
				order = 1,
			}),
			StyleLink = React.createElement("StyleLink", {
				StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
			}),
		})

		return component
	end,
}
