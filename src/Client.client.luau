--!strict

const GuiService = game:GetService("GuiService")
const Players = game:GetService("Players")
const RunService = game:GetService("RunService")
const StarterGui = game:GetService("StarterGui")
const UserInputService = game:GetService("UserInputService")

-- Enable Dev Mode and React DevTools in Studio
if RunService:IsStudio() then
	const ReactGlobals = require("../react-globals")
	ReactGlobals.__DEV__ = true
	ReactGlobals.__PROFILE__ = true
	require("../react-devtools")
end

const React = require("../react")
const ReactRoblox = require("../react-roblox")
const closeInventory = require("./Api/closeInventory")

const App = require("./Components/App")

const DESIGN_SHEET = script.Parent.Design.SatchelStyleSheet

const player = Players.LocalPlayer
const playerGui = player:WaitForChild("PlayerGui")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

const handle = Instance.new("ScreenGui")
handle.Name = "SatchelGui"
handle.ResetOnSpawn = false
handle.Parent = playerGui

const root = ReactRoblox.createRoot(handle)

const function Satchel()
	-- Open and close backpack based on bindable events
	const opened, setOpened = React.useState(false)

	React.useEffect(function()
		const bindableEvents = script.Parent.BindableEvents

		const inventoryOpenedSignal = bindableEvents.InventoryOpened.Event:Connect(function()
			setOpened(true)
		end)
		const inventoryClosedSignal = bindableEvents.InventoryClosed.Event:Connect(function()
			setOpened(false)
		end)
		const menuOpenedSignal = GuiService.MenuOpened:Connect(function()
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
		const inputSignal = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			const inputType = input.UserInputType
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
	const slots, setSlots = React.useState(10)
	const rows, setRows = React.useState(4)

	React.useEffect(function()
		const function updateBackpackSize()
			const screenOrientation = playerGui.CurrentScreenOrientation
			const viewportSize = GuiService.ViewportDisplaySize

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
		const viewportSignal = GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(updateBackpackSize)
		const orientationSignal =
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
