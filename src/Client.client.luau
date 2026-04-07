--!strict

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local React = require(script.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent["react-roblox"])

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

		return function()
			inventoryOpenedSignal:Disconnect()
			inventoryClosedSignal:Disconnect()
		end
	end, {})

	-- Change slots based on viewport display size
	local slots, setSlots = React.useState(10)
	local rows, setRows = React.useState(4)

	React.useEffect(function()
		local function viewportDisplaySizeChanged()
			local viewportSize = GuiService.ViewportDisplaySize
			if viewportSize == Enum.DisplaySize.Small then
				setSlots(5)
				setRows(3)
			else
				setSlots(10)
				setRows(4)
			end
		end

		viewportDisplaySizeChanged()
		local signal = GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(viewportDisplaySizeChanged)

		return function()
			signal:Disconnect()
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
