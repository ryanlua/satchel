--!strict

local React = require(script.Parent.Parent.Parent.react)

local InventoryHint = require(script.Parent.InventoryHint)
local Searchbar = require(script.Parent.Searchbar)
local Slot = require(script.Parent.Slot)

local InventoryBindings = script.Parent.Parent.Bindings.InventoryContext
local RemoveFromHotbarGamepadKeyCode = InventoryBindings.RemoveFromHotbarAction.GamepadBinding.KeyCode
local SelectSwapGamepadKeyCode = InventoryBindings.SelectSwapAction.GamepadBinding.KeyCode
local CloseInventoryGamepadKeyCode = InventoryBindings.CloseInventoryAction.GamepadBinding.KeyCode

export type Props = {
	forceHintVisible: boolean?,
	size: UDim2?, -- TODO: change size to use slots amount
	tools: { Tool? }?,
	visible: boolean?,
}

local function Inventory(props: Props)
	local slotChildren = {}

	if props.tools then
		for order, tool in props.tools do
			if tool then
				slotChildren[order] = React.createElement(Slot, {
					unlocked = true,
					order = order,
					tool = tool,
				})
			end
		end
	end

	return React.createElement("Frame", {
		Size = props.size,
		Visible = props.visible,
		[React.Tag] = "Inventory",
	}, {
		Hints = React.createElement("Frame", {
			[React.Tag] = "Hints",
		}, {
			RemoveFromHotbarHint = React.createElement(InventoryHint, {
				keyCode = RemoveFromHotbarGamepadKeyCode,
				forceVisible = props.forceHintVisible,
				text = "Remove from hotbar",
			}),
			SelectSwapHint = React.createElement(InventoryHint, {
				keyCode = SelectSwapGamepadKeyCode,
				forceVisible = props.forceHintVisible,
				text = "Select/Swap",
			}),
			CloseInventoryHint = React.createElement(InventoryHint, {
				keyCode = CloseInventoryGamepadKeyCode,
				forceVisible = props.forceHintVisible,
				text = "Close inventory",
			}),
		}),
		Slots = React.createElement("Frame", {
			[React.Tag] = "Slots",
		}, {
			SearchBox = React.createElement(Searchbar),
			SlotFrame = React.createElement("ScrollingFrame", nil, slotChildren),
		}),
	})
end

return Inventory
