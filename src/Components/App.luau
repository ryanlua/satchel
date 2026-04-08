--!strict

local React = require(script.Parent.Parent.Parent.react)

local Backpack = require(script.Parent.Backpack)
local HotbarHint = require(script.Parent.HotbarHint)
local InventoryHint = require(script.Parent.InventoryHint)

local InventoryBindings = script.Parent.Parent.Bindings.InventoryContext
local RemoveFromHotbarGamepadKeyCode = InventoryBindings.RemoveFromHotbarAction.GamepadBinding.KeyCode
local SelectSwapGamepadKeyCode = InventoryBindings.SelectSwapAction.GamepadBinding.KeyCode
local CloseInventoryGamepadKeyCode = InventoryBindings.CloseInventoryAction.GamepadBinding.KeyCode

local HotbarBindings = script.Parent.Parent.Bindings.HotbarContext
local SlotLeftGamepadKeyCode = HotbarBindings.SlotLeftAction.GamepadBinding.KeyCode
local SlotRightGamepadKeyCode = HotbarBindings.SlotRightAction.GamepadBinding.KeyCode

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?, -- TODO: Add rows for inventory height
	items: { Tool | HopperBin }?,
	opened: boolean?,
}

local function App(props: Props)
	local backpackSize, setBackpackSize = React.useState(Vector2.zero)

	return React.createElement("Frame", {
		[React.Tag] = "HotbarHints",
	}, {
		SlotLeftHint = React.createElement(HotbarHint, {
			keyCode = SlotLeftGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = -1,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			keyCode = SlotRightGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = 1,
		}),
		InventoryHints = React.createElement("Frame", {
			Size = UDim2.fromOffset(backpackSize.X, 0),
			[React.Tag] = "InventoryHints",
		}, {
			Hints = React.createElement("Frame", {
				Visible = props.opened,
				LayoutOrder = -1,
				[React.Tag] = "Hints",
			}, {
				RemoveFromHotbarHint = React.createElement(InventoryHint, {
					keyCode = RemoveFromHotbarGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Remove from hotbar",
				}),
				SelectSwapHint = React.createElement(InventoryHint, {
					keyCode = SelectSwapGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Select/Swap",
				}),
				CloseInventoryHint = React.createElement(InventoryHint, {
					keyCode = CloseInventoryGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Close inventory",
				}),
			}),
			Backpack = React.createElement(Backpack, {
				forceKeyboardHintVisible = props.forceKeyboardHintVisible,
				slots = props.slots,
				rows = props.rows,
				items = props.items,
				opened = props.opened,
				onAbsoluteSizeChanged = setBackpackSize,
			}),
		}),
	})
end

return App
