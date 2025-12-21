--!strict

local Players = game:GetService("Players")

local SlotButton = require(script.Components.SlotButton)

local player = Players.LocalPlayer :: Player
local playerGui = player:FindFirstChild("PlayerGui") :: PlayerGui

local satchelGui = Instance.new("ScreenGui")
satchelGui.Name = "SatchelGui"
satchelGui.ResetOnSpawn = false
satchelGui.Parent = playerGui

local styleLink = Instance.new("StyleLink")
styleLink.StyleSheet = script.StyleSheets.SatchelStyleSheet
styleLink.Parent = satchelGui

local button = SlotButton.new()
button:setText("Hello world!")
button:setHint("9")
button:setParent(satchelGui)

return {}
