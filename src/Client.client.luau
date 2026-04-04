--!strict

local Players = game:GetService("Players")

local React = require(script.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent["react-roblox"])

local Backpack = require(script.Parent.Components.Backpack)

local DESIGN_SHEET = script.Parent.Design.SatchelStyleSheet

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local handle = Instance.new("ScreenGui")
handle.Name = "SatchelGui"
handle.ResetOnSpawn = false
handle.Parent = playerGui

local root = ReactRoblox.createRoot(handle)

local function Satchel()
	return React.createElement(Backpack, {
		size = UDim2.fromOffset(655, 0),
		slots = 10,
	})
end

root:render(React.createElement(React.Fragment, nil, {
	StyleLink = React.createElement("StyleLink", {
		StyleSheet = DESIGN_SHEET,
	}),
	App = React.createElement(Satchel),
}))
