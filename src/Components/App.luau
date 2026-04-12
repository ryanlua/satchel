--!strict

const React = require("../../react")

const Backpack = require("./Backpack")
const HotbarHint = require("./HotbarHint")
const InventoryHint = require("./InventoryHint")

const InventoryBindings = script.Parent.Parent.Bindings.InventoryContext
const RemoveFromHotbarGamepadKeyCode = InventoryBindings.RemoveFromHotbarAction.GamepadBinding.KeyCode
const SelectSwapGamepadKeyCode = InventoryBindings.SelectSwapAction.GamepadBinding.KeyCode
const CloseInventoryGamepadKeyCode = InventoryBindings.CloseInventoryAction.GamepadBinding.KeyCode

const HotbarBindings = script.Parent.Parent.Bindings.HotbarContext
const SlotLeftGamepadKeyCode = HotbarBindings.SlotLeftAction.GamepadBinding.KeyCode
const SlotRightGamepadKeyCode = HotbarBindings.SlotRightAction.GamepadBinding.KeyCode

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?,
	items: { Tool | HopperBin }?,
	opened: boolean?,
}

const function App(props: Props)
	const backpackSize, setBackpackSize = React.useState(Vector2.zero)
	const slotCount = props.slots or 10

	local hotbarVisible = props.opened or false

	-- Don't show hotbar hints if hotbar has no slots
	if not hotbarVisible and props.items then
		for order = 1, slotCount do
			if props.items[order] ~= nil then
				hotbarVisible = true
				break
			end
		end
	end

	return React.createElement("Frame", {
		[React.Tag] = "HotbarHints",
	}, {
		SlotLeftHint = React.createElement(HotbarHint, {
			keyCode = SlotLeftGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = -1,
			visible = hotbarVisible,
		}),
		SlotRightHint = React.createElement(HotbarHint, {
			keyCode = SlotRightGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = 1,
			visible = hotbarVisible,
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
