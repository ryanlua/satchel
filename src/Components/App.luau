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
	tools: { Tool? }?,
	opened: boolean?,
}

local function App(props: Props)
	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
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
			[React.Tag] = "InventoryHints",

		}, {
			Hints = React.createElement("Frame", {
				[React.Tag] = "Hints",
                LayoutOrder = -1,
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
				tools = props.tools,
				opened = props.opened,
			}),
		}),
	})
end

return App
