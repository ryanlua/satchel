--!strict

local Players = game:GetService("Players")

local React = require(script.Parent.react)
local ReactRoblox = require(script.Parent["react-roblox"])

local Hotbar = require(script.Components.Hotbar)

local player = Players.LocalPlayer :: Player
local playerGui = player.PlayerGui

local handle = Instance.new("ScreenGui")
handle.Name = "SatchelGui"
handle.Parent = playerGui

local root = ReactRoblox.createRoot(handle)
root:render(React.createElement(React.Fragment, nil, {
	StyleLink = React.createElement("StyleLink", {
		StyleSheet = script.Design.SatchelStyleSheet,
	}),
	Hotbar = React.createElement(Hotbar, {
		opened = true,
	}),
}))

return {}
