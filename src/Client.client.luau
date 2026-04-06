--!strict

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local React = require(script.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent["react-roblox"])

local Backpack = require(script.Parent.Components.Backpack)

local DESIGN_SHEET = script.Parent.Design.SatchelStyleSheet

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

local handle = Instance.new("ScreenGui")
handle.Name = "SatchelGui"
handle.ResetOnSpawn = false
handle.Parent = playerGui

local root = ReactRoblox.createRoot(handle)

local function Satchel()
	-- Open and close backpack based on bindable events
	local opened, setOpened = React.useState(false)

	React.useEffect(function()
		local bindableEvents = script.Parent.BindableEvents

		local inventoryOpenedSignal = bindableEvents.InventoryOpened.Event:Connect(function()
			setOpened(true)
		end)
		local inventoryClosedSignal = bindableEvents.InventoryClosed.Event:Connect(function()
			setOpened(false)
		end)

		return function()
			inventoryOpenedSignal:Disconnect()
			inventoryClosedSignal:Disconnect()
		end
	end, {})

	return React.createElement(Backpack, {
		size = UDim2.fromOffset(655, 0),
		slots = 10,
		opened = opened,
	})
end

root:render(React.createElement(React.Fragment, nil, {
	StyleLink = React.createElement("StyleLink", {
		StyleSheet = DESIGN_SHEET,
	}),
	Satchel = React.createElement(Satchel),
}))
