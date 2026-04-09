--!strict

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local React = require(script.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent["react-roblox"])
local closeInventory = require(script.Parent.Api.closeInventory)

local App = require(script.Parent.Components.App)

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
		local menuOpenedSignal = GuiService.MenuOpened:Connect(function()
			closeInventory()
		end)

		return function()
			inventoryOpenedSignal:Disconnect()
			inventoryClosedSignal:Disconnect()
			menuOpenedSignal:Disconnect()
		end
	end, {})

	-- Close backpack when clicking outside of it
	React.useEffect(function()
		local inputSignal = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			local inputType = input.UserInputType
			if not gameProcessedEvent then
				if inputType == Enum.UserInputType.MouseButton1 or inputType == Enum.UserInputType.Touch then
					closeInventory()
				end
			end
		end)

		return function()
			inputSignal:Disconnect()
		end
	end, {})

	-- Change slots based on viewport display size
	local slots, setSlots = React.useState(10)
	local rows, setRows = React.useState(4)

	React.useEffect(function()
		local function updateBackpackSize()
			local screenOrientation = playerGui.CurrentScreenOrientation
			local viewportSize = GuiService.ViewportDisplaySize

			if screenOrientation == Enum.ScreenOrientation.Portrait then
				setSlots(3)
				setRows(3)
			elseif viewportSize == Enum.DisplaySize.Small then
				setSlots(5)
				setRows(2)
			else
				setSlots(10)
				setRows(4)
			end
		end

		updateBackpackSize()
		local viewportSignal = GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(updateBackpackSize)
		local orientationSignal =
			playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(updateBackpackSize)

		return function()
			viewportSignal:Disconnect()
			orientationSignal:Disconnect()
		end
	end, {})

	return React.createElement(App, {
		slots = slots,
		rows = rows,
		opened = opened,
	})
end

root:render(React.createElement(React.Fragment, nil, {
	StyleLink = React.createElement("StyleLink", {
		StyleSheet = DESIGN_SHEET,
	}),
	App = React.createElement(Satchel),
}))
