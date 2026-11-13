const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

const Backpack = require("./Backpack")
const HotbarHint = require("./HotbarHint")
const InventoryHint = require("./InventoryHint")
const Slot = require("./Slot")

const DOUBLE_CLICK_TIME = 0.5
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
	items: { [number]: { item: BackpackItem, equipped: boolean } }?,
	opened: boolean?,
	onSlotActivated: ((item: BackpackItem) -> ())?,
	onMove: ((item: BackpackItem, targetIndex: number) -> ())?,
}

type Items = { [number]: { item: BackpackItem, equipped: boolean } }
type DragState = { item: BackpackItem, slotPosition: Vector2, start: Vector2, input: Vector2, moved: boolean }

const function isGamepadPreferred(): boolean
	return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
end

const function isInBounds(guiObject: GuiObject?, point: Vector2): boolean
	if not guiObject or not guiObject.Visible then
		return false
	end
	const offset = point - guiObject.AbsolutePosition
	return offset.X > 0
		and offset.Y > 0
		and offset.X <= guiObject.AbsoluteSize.X
		and offset.Y <= guiObject.AbsoluteSize.Y
end

const function findItemIndex(items: Items, item: BackpackItem): number?
	for index, slot in items do
		if slot.item == item then
			return index
		end
	end
	return nil
end

const function App(props: Props)
	const slotCount = props.slots or 10
	const width = slotCount * 65 + 5
	const items: Items = props.items or {}

	const drag, setDrag = React.useState(nil :: DragState?)
	const dragRef = React.useRef(nil :: DragState?)
	const lastClickTimes = React.useRef({} :: { [BackpackItem]: number })
	const hintsRef = React.useRef(nil :: Frame?)
	const dragLayerRef = React.useRef(nil :: Frame?)

	-- Gamepad uses select/swap instead of dragging, like the CoreGui backpack
	const gamepadPreferred, setGamepadPreferred = React.useState(isGamepadPreferred)

	React.useEffect(function()
		const preferredInputSignal = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
			setGamepadPreferred(isGamepadPreferred())
		end)

		return function()
			preferredInputSignal:Disconnect()
		end
	end, {})

	const function setDragState(state: DragState?)
		dragRef.current = state
		setDrag(state)
	end

	-- Cancel the drag if the dragged item leaves the backpack
	React.useEffect(function()
		if dragRef.current and not findItemIndex(items, dragRef.current.item) then
			setDragState(nil)
		end
	end, { props.items })

	const function nextInventoryIndex(): number
		local highestIndex = slotCount
		for index in items do
			highestIndex = math.max(highestIndex, index)
		end
		return highestIndex + 1
	end

	const function firstEmptyHotbarIndex(): number?
		for index = 1, slotCount do
			if not items[index] then
				return index
			end
		end
		return nil
	end

	const function findDropTarget(index: number, point: Vector2): number?
		const backpack = hintsRef.current and hintsRef.current:FindFirstChild("Backpack", true)
		const hotbar = backpack and backpack:FindFirstChild("Hotbar") :: GuiObject?
		const inventory = backpack and backpack:FindFirstChild("Inventory") :: GuiObject?

		-- Hotbar tools dropped on the inventory or outside the backpack move to the inventory
		if isInBounds(inventory, point) or not isInBounds(hotbar, point) then
			return if index <= slotCount then nextInventoryIndex() else nil
		end

		local closestIndex, closestDistance = nil, math.huge
		for _, hotbarSlot in (hotbar :: GuiObject):GetChildren() do
			if hotbarSlot:IsA("GuiButton") then
				const distance = (hotbarSlot.AbsolutePosition + hotbarSlot.AbsoluteSize / 2 - point).Magnitude
				if distance < closestDistance then
					closestIndex, closestDistance = hotbarSlot.LayoutOrder, distance
				end
			end
		end
		return closestIndex
	end

	const function onSlotDrag(phase: string, item: BackpackItem, slot: GuiObject, inputPosition: Vector2)
		const current = dragRef.current
		if phase == "Start" then
			setDragState({
				item = item,
				slotPosition = slot.AbsolutePosition,
				start = inputPosition,
				input = inputPosition,
				moved = false,
			})
			return
		elseif not current or current.item ~= item then
			return
		elseif phase == "Continue" then
			const moved = current.moved or (inputPosition - current.start).Magnitude >= DRAG_THRESHOLD
			setDragState({
				item = item,
				slotPosition = current.slotPosition,
				start = current.start,
				input = inputPosition,
				moved = moved,
			})
			return
		end

		setDragState(nil)
		const index = findItemIndex(items, item)
		if not index then
			return
		end

		local targetIndex = nil
		if current.moved then
			targetIndex = findDropTarget(index, inputPosition)
		else
			-- UIDragDetector swallows Activated, so a press released in place is a click
			if props.onSlotActivated then
				props.onSlotActivated(item)
			end
			const now = os.clock()
			if index > slotCount and now - (lastClickTimes.current[item] or 0) < DOUBLE_CLICK_TIME then
				targetIndex = firstEmptyHotbarIndex()
			end
			lastClickTimes.current[item] = now
		end

		if targetIndex and targetIndex ~= index and props.onMove then
			props.onMove(item, targetIndex)
		end
	end

	-- Keep the inventory open until the dragged slot is dropped, like the CoreGui backpack
	const opened = props.opened or drag ~= nil

	local draggedSlot = nil
	const dragLayer = dragLayerRef.current
	if drag and drag.moved and dragLayer then
		const position = drag.slotPosition + drag.input - drag.start - dragLayer.AbsolutePosition
		const index = findItemIndex(items, drag.item) or 0
		const isHotbarSlot = index <= slotCount
		draggedSlot = e(Slot, {
			item = drag.item,
			unlocked = true,
			dragging = true,
			equipped = items[index] and items[index].equipped,
			order = if isHotbarSlot then index else index - slotCount,
			hint = isHotbarSlot,
			forceHintVisible = props.forceKeyboardHintVisible,
			position = UDim2.fromOffset(position.X, position.Y),
		})
	end

	local visibleHotbarSlots = 0
	for order = 1, slotCount do
		if items[order] then
			visibleHotbarSlots += 1
		end
	end

	const backpackWidth = if opened then width else visibleHotbarSlots * 65 + 5

	-- Don't show hotbar hints if hotbar has no slots
	const hotbarVisible = opened or visibleHotbarSlots > 0

	return e(React.Fragment, nil, {
		HotbarHints = e("Frame", {
			ref = hintsRef,
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
					draggingItem = if drag and drag.moved then drag.item else nil,
					onSlotActivated = props.onSlotActivated,
					onSlotDrag = if gamepadPreferred then nil else onSlotDrag,
				}),
			}),
		}),
		DragLayer = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Interactable = false,
			ZIndex = 10,
			ref = dragLayerRef,
		}, {
			DraggedSlot = draggedSlot,
		}),
	})
end

return App
