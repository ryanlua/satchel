--!strict

local Players = game:GetService("Players")

local React = require("./react")
local ReactRoblox = require("./react-roblox")

local Hotbar = require("@self/Components/Hotbar")

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
