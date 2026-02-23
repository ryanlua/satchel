--!strict

local Players = game:GetService("Players")

local React = require(script.Parent.react)
local ReactRoblox = require(script.Parent["react-roblox"])

local Backpack = require(script.Components.Backpack)

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
	Backpack = React.createElement(Backpack, {
		opened = true,
	}),
}))

return {}
