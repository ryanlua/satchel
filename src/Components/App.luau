const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

const Backpack = require("./Backpack")
const HotbarHint = require("./HotbarHint")
const InventoryHint = require("./InventoryHint")
const Slot = require("./Slot")
const useSlotMetrics = require("./useSlotMetrics")

const DRAG_THRESHOLD = 4

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
	tenFootInterface: boolean?,
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	swapSourceIndex: number?,
	onSelectionRootChanged: ((root: GuiObject?) -> ())?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onSelectSwap: ((slotIndex: number) -> ())?,
	-- A nil targetIndex moves the item to the inventory
	onMove: ((item: BackpackItem, targetIndex: number?) -> ())?,
}

type Items = { [number]: { item: BackpackItem, equipped: boolean } }

const function isGamepadPreferred(): boolean
	return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
end

const function findItemIndex(items: Items, item: BackpackItem): number?
	for index, slot in items do
		if slot.item == item then
			return index
		end
	end
	return nil
end

-- Closest hotbar slot to a point over the hotbar, like the CoreGui backpack
const function hotbarIndexAt(slot: GuiObject, point: Vector2): number?
	const backpack = slot:FindFirstAncestor("Backpack")
	const hotbar = backpack and backpack:FindFirstChild("Hotbar") :: GuiObject?
	if not hotbar then
		return nil
	end
	const offset = point - hotbar.AbsolutePosition
	if offset.X < 0 or offset.Y < 0 or offset.X > hotbar.AbsoluteSize.X or offset.Y > hotbar.AbsoluteSize.Y then
		return nil
	end

	local closestIndex, closestDistance = nil, math.huge
	for _, hotbarSlot in hotbar:GetChildren() do
		if hotbarSlot:IsA("GuiButton") then
			const distance = (hotbarSlot.AbsolutePosition + hotbarSlot.AbsoluteSize / 2 - point).Magnitude
			if distance < closestDistance then
				closestIndex, closestDistance = hotbarSlot.LayoutOrder, distance
			end
		end
	end
	return closestIndex
end

const function App(props: Props)
	const slotCount = props.slots or 10
	const metrics = useSlotMetrics(props.tenFootInterface)
	const width = metrics.rowWidth(slotCount)
	const tenFootInterfaceTag = if props.tenFootInterface then " TenFootInterface" else ""
	const items: Items = props.items or {}

	const hintsRef = React.useRef(nil :: Frame?)
	const dragItem, setDragItem = React.useState(nil :: BackpackItem?)
	const dragPosition, setDragPosition = React.useBinding(UDim2.new())
	const dragStart = React.useRef(Vector2.zero)
	-- Dragged slot position relative to the App parent, minus the drag start point
	const dragOffset = React.useRef(Vector2.zero)

	-- Gamepad uses select/swap instead of dragging, like the CoreGui backpack
	const gamepadPreferred, setGamepadPreferred = React.useState(isGamepadPreferred)
	const selectSwap = if gamepadPreferred and (props.opened or false) then props.onSelectSwap else nil

	React.useEffect(function()
		const preferredInputSignal = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
			setGamepadPreferred(isGamepadPreferred())
		end)

		return function()
			preferredInputSignal:Disconnect()
		end
	end, {})

	-- Expose the hints root for GuiService gamepad selection parenting
	React.useEffect(function()
		if props.onSelectionRootChanged then
			props.onSelectionRootChanged(hintsRef.current)
		end
		return function()
			if props.onSelectionRootChanged then
				props.onSelectionRootChanged(nil)
			end
		end
	end, { props.onSelectionRootChanged :: any })

	const onSlotDrag: Slot.OnDrag = function(phase, item, detector, point)
		const slot = detector.Parent :: GuiObject
		if phase == "Start" then
			const root = (hintsRef.current :: Frame).Parent :: GuiBase2d
			dragStart.current = point
			dragOffset.current = slot.AbsolutePosition - root.AbsolutePosition - point
			setDragItem(item)
		end

		const position = dragOffset.current + point
		setDragPosition(UDim2.fromOffset(position.X, position.Y))

		if phase == "End" then
			setDragItem(nil)
			-- UIDragDetector swallows Activated, so a press released in place is a click
			if (point - dragStart.current).Magnitude < DRAG_THRESHOLD then
				if props.onSlotActivated then
					props.onSlotActivated(item)
				end
			elseif props.onMove then
				props.onMove(item, hotbarIndexAt(slot, point))
			end
		end
	end

	-- Hidden if the dragged item leaves the backpack mid-drag
	const dragIndex = if dragItem then findItemIndex(items, dragItem) else nil

	-- Keep the inventory open until the dragged slot is dropped, like the CoreGui backpack
	const opened = props.opened or dragIndex ~= nil

	local visibleHotbarSlots = 0
	for order = 1, slotCount do
		if items[order] then
			visibleHotbarSlots += 1
		end
	end

	const backpackWidth = if opened then width else metrics.rowWidth(visibleHotbarSlots)

	-- Don't show hotbar hints if hotbar has no slots
	const hotbarVisible = opened or visibleHotbarSlots > 0

	return e(React.Fragment, nil, {
		HotbarHints = e("Frame", {
			ref = hintsRef,
			[React.Tag] = "HotbarHints" .. tenFootInterfaceTag,
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
					Visible = opened,
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
					opened = opened,
					width = width,
					height = metrics.rowsHeight(props.rows or 4),
					scrollbarGutter = metrics.scrollbarGutter,
					swapSourceIndex = props.swapSourceIndex,
					onSlotActivated = props.onSlotActivated,
					onSelectSwap = selectSwap,
					onSlotDrag = if gamepadPreferred then nil else onSlotDrag,
				}),
			}),
		}),
		DragLayer = if dragIndex
			then e("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Interactable = false,
				ZIndex = 10,
				[React.Tag] = if props.tenFootInterface then "TenFootInterface" else nil,
			}, {
				DraggedSlot = e(Slot, {
					item = dragItem,
					unlocked = true,
					dragging = true,
					equipped = items[dragIndex].equipped,
					order = if dragIndex <= slotCount then dragIndex else dragIndex - slotCount,
					hint = dragIndex <= slotCount,
					forceHintVisible = props.forceKeyboardHintVisible,
					position = dragPosition,
				}),
			})
			else nil,
	})
end

return App
