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

const e = React.createElement

export type Props = {
	forceGamepadHintVisible: boolean?,
	forceKeyboardHintVisible: boolean?,
	slots: number?,
	rows: number?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
}

const function App(props: Props)
	const slotCount = props.slots or 10
	const width = slotCount * 65 + 5

	local visibleHotbarSlots = 0
	if props.items then
		for order = 1, slotCount do
			if props.items[order] then
				visibleHotbarSlots += 1
			end
		end
	end

	const backpackWidth = if props.opened then width else visibleHotbarSlots * 65 + 5

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

	return e("Frame", {
		[React.Tag] = "HotbarHints",
	}, {
		SlotLeftHint = e(HotbarHint, {
			keyCode = SlotLeftGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = -1,
			visible = hotbarVisible,
		}),
		SlotRightHint = e(HotbarHint, {
			keyCode = SlotRightGamepadKeyCode,
			forceVisible = props.forceGamepadHintVisible,
			order = 1,
			visible = hotbarVisible,
		}),
		InventoryHints = e("Frame", {
			Size = UDim2.fromOffset(backpackWidth, 0),
			[React.Tag] = "InventoryHints",
		}, {
			Hints = e("Frame", {
				Size = UDim2.fromOffset(backpackWidth, 0),
				Visible = props.opened,
				LayoutOrder = -1,
				[React.Tag] = "Hints",
			}, {
				RemoveFromHotbarHint = e(InventoryHint, {
					keyCode = RemoveFromHotbarGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Remove from hotbar",
				}),
				SelectSwapHint = e(InventoryHint, {
					keyCode = SelectSwapGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Select/Swap",
				}),
				CloseInventoryHint = e(InventoryHint, {
					keyCode = CloseInventoryGamepadKeyCode,
					forceVisible = props.forceGamepadHintVisible,
					text = "Close inventory",
				}),
			}),
			Backpack = e(Backpack, {
				forceKeyboardHintVisible = props.forceKeyboardHintVisible,
				slots = props.slots,
				rows = props.rows,
				items = props.items,
				opened = props.opened,
				width = width,
				onSlotActivated = props.onSlotActivated,
			}),
		}),
	})
end

return App
