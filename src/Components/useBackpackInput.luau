--!strict

const GuiService = game:GetService("GuiService")
const UserInputService = game:GetService("UserInputService")

const React = require("../../react")

const closeInventory = require("../Api/closeInventory")
const openInventory = require("../Api/openInventory")

const HotbarBindings = script.Parent.Parent.Bindings.HotbarContext
const InventoryBindings = script.Parent.Parent.Bindings.InventoryContext

const SELECTION_PARENT_NAME = "SatchelSelection"
const DUAL_BUMPER_WINDOW = 0.06

type SlotItem = { item: BackpackItem, equipped: boolean }

export type Props = {
	opened: boolean,
	hotbarSlotCount: number,
	items: { [number]: SlotItem },
	selectionRoot: GuiObject?,
	equipSlot: (index: number) -> (),
	cycleHotbar: (direction: number) -> (),
	unequipAll: () -> (),
	removeFromHotbar: (index: number) -> (),
	move: (item: BackpackItem, targetIndex: number) -> (),
}

export type Result = {
	swapSourceIndex: number?,
	onGamepadSlotActivated: (slotIndex: number) -> (),
	clearSwapSource: () -> (),
}

const function isTyping(): boolean
	return UserInputService:GetFocusedTextBox() ~= nil
end

const function getSelectedSlotIndex(hotbarSlotCount: number): number?
	const selected = GuiService.SelectedObject
	if not selected or not selected:IsA("GuiObject") or not selected:HasTag("Slot") then
		return nil
	end
	const parent = selected.Parent
	if not parent then
		return nil
	elseif parent.Name == "Hotbar" then
		return selected.LayoutOrder
	elseif parent:IsA("ScrollingFrame") then
		return selected.LayoutOrder + hotbarSlotCount
	end
	return nil
end

const function useBackpackInput(props: Props): Result
	const swapSourceIndex, setSwapSourceIndex = React.useState(nil :: number?)
	const swapSourceRef = React.useRef(nil :: number?)
	const itemsRef = React.useRef(props.items)
	const openedRef = React.useRef(props.opened)
	const hotbarSlotCountRef = React.useRef(props.hotbarSlotCount)
	const actionsRef = React.useRef({
		equipSlot = props.equipSlot,
		cycleHotbar = props.cycleHotbar,
		unequipAll = props.unequipAll,
		removeFromHotbar = props.removeFromHotbar,
		move = props.move,
	})

	itemsRef.current = props.items
	openedRef.current = props.opened
	hotbarSlotCountRef.current = props.hotbarSlotCount
	actionsRef.current = {
		equipSlot = props.equipSlot,
		cycleHotbar = props.cycleHotbar,
		unequipAll = props.unequipAll,
		removeFromHotbar = props.removeFromHotbar,
		move = props.move,
	}

	const function setSwapSource(index: number?)
		swapSourceRef.current = index
		setSwapSourceIndex(index)
	end

	const function clearSwapSource()
		setSwapSource(nil)
	end

	const lastSelectSwapRef = React.useRef(nil :: { index: number, time: number }?)

	const function selectSwap(slotIndex: number)
		-- ButtonA may fire both InputAction.Pressed and GuiButton.Activated
		const now = os.clock()
		const lastSelect = lastSelectSwapRef.current
		if lastSelect and lastSelect.index == slotIndex and now - lastSelect.time < 0.05 then
			return
		end
		lastSelectSwapRef.current = { index = slotIndex, time = now }

		const currentSource = swapSourceRef.current
		if currentSource == nil then
			setSwapSource(slotIndex)
			return
		elseif currentSource == slotIndex then
			clearSwapSource()
			return
		end

		const items = itemsRef.current
		const sourceSlot = items[currentSource]
		const targetSlot = items[slotIndex]
		if sourceSlot then
			actionsRef.current.move(sourceSlot.item, slotIndex)
		elseif targetSlot then
			actionsRef.current.move(targetSlot.item, currentSource)
		end
		clearSwapSource()
	end

	const selectSwapRef = React.useRef(selectSwap)
	selectSwapRef.current = selectSwap

	const onGamepadSlotActivated = React.useCallback(function(slotIndex: number)
		selectSwapRef.current(slotIndex)
	end, {})

	-- Enable / disable input contexts
	React.useEffect(function()
		HotbarBindings.Enabled = true
		return function()
			HotbarBindings.Enabled = false
			InventoryBindings.Enabled = false
		end
	end, {})

	React.useEffect(function()
		InventoryBindings.Enabled = props.opened
		if not props.opened then
			clearSwapSource()
		end
	end, { props.opened })

	-- GuiService selection while the inventory is open on gamepad
	React.useEffect(function()
		const root = props.selectionRoot
		const opened = props.opened

		const function clearSelection()
			GuiService:RemoveSelectionGroup(SELECTION_PARENT_NAME)
			const selected = GuiService.SelectedObject
			if selected and root and selected:IsDescendantOf(root) then
				GuiService.SelectedObject = nil
			end
		end

		const function updateSelection()
			if not root or not opened or UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad then
				clearSelection()
				return
			end

			GuiService:AddSelectionParent(SELECTION_PARENT_NAME, root)

			const backpack = root:FindFirstChild("Backpack", true)
			const hotbar = backpack and backpack:FindFirstChild("Hotbar")
			const firstSlot = hotbar and hotbar:FindFirstChild("1")
			if firstSlot and firstSlot:IsA("GuiObject") then
				GuiService.SelectedObject = firstSlot
			end
		end

		updateSelection()
		const preferredInputSignal = UserInputService:GetPropertyChangedSignal("PreferredInput")
			:Connect(updateSelection)

		return function()
			preferredInputSignal:Disconnect()
			clearSelection()
		end
	end, { props.opened :: any, props.selectionRoot :: any })

	-- Hotbar context actions
	React.useEffect(function()
		local lastBumperAction: InputAction? = nil
		local lastBumperTime = 0

		const connections = {
			HotbarBindings.ToggleInventoryAction.Pressed:Connect(function()
				if isTyping() then
					return
				elseif openedRef.current then
					closeInventory()
				else
					openInventory()
				end
			end),
			HotbarBindings.SlotLeftAction.Pressed:Connect(function()
				const now = os.clock()
				if
					lastBumperAction == HotbarBindings.SlotRightAction
					and now - lastBumperTime <= DUAL_BUMPER_WINDOW
				then
					actionsRef.current.unequipAll()
					lastBumperAction = HotbarBindings.SlotLeftAction
					lastBumperTime = now
					return
				end
				lastBumperAction = HotbarBindings.SlotLeftAction
				lastBumperTime = now
				task.delay(DUAL_BUMPER_WINDOW, function()
					if lastBumperAction ~= HotbarBindings.SlotLeftAction then
						return
					end
					actionsRef.current.cycleHotbar(-1)
				end)
			end),
			HotbarBindings.SlotRightAction.Pressed:Connect(function()
				const now = os.clock()
				if lastBumperAction == HotbarBindings.SlotLeftAction and now - lastBumperTime <= DUAL_BUMPER_WINDOW then
					actionsRef.current.unequipAll()
					lastBumperAction = HotbarBindings.SlotRightAction
					lastBumperTime = now
					return
				end
				lastBumperAction = HotbarBindings.SlotRightAction
				lastBumperTime = now
				task.delay(DUAL_BUMPER_WINDOW, function()
					if lastBumperAction ~= HotbarBindings.SlotRightAction then
						return
					end
					actionsRef.current.cycleHotbar(1)
				end)
			end),
		}

		for slotNumber = 0, 9 do
			const actionName = "EquipSlot" .. tostring(slotNumber)
			const action = HotbarBindings:FindFirstChild(actionName) :: InputAction
			const slotIndex = if slotNumber == 0 then 10 else slotNumber
			table.insert(
				connections,
				action.Pressed:Connect(function()
					if isTyping() then
						return
					elseif slotIndex > hotbarSlotCountRef.current then
						return
					end
					actionsRef.current.equipSlot(slotIndex)
				end)
			)
		end

		return function()
			for _, connection in connections do
				connection:Disconnect()
			end
		end
	end, {})

	-- Inventory context actions
	React.useEffect(function()
		const connections = {
			InventoryBindings.CloseInventoryAction.Pressed:Connect(function()
				const focused = UserInputService:GetFocusedTextBox()
				if focused then
					focused.Text = ""
					focused:ReleaseFocus()
					return
				elseif swapSourceRef.current ~= nil then
					clearSwapSource()
					return
				end
				closeInventory()
			end),
			InventoryBindings.RemoveFromHotbarAction.Pressed:Connect(function()
				const slotIndex = getSelectedSlotIndex(hotbarSlotCountRef.current)
				if slotIndex and slotIndex <= hotbarSlotCountRef.current then
					actionsRef.current.removeFromHotbar(slotIndex)
					clearSwapSource()
				end
			end),
			InventoryBindings.SelectSwapAction.Pressed:Connect(function()
				const slotIndex = getSelectedSlotIndex(hotbarSlotCountRef.current)
				if slotIndex then
					selectSwapRef.current(slotIndex)
				end
			end),
		}

		return function()
			for _, connection in connections do
				connection:Disconnect()
			end
		end
	end, {})

	return {
		swapSourceIndex = swapSourceIndex,
		onGamepadSlotActivated = onGamepadSlotActivated,
		clearSwapSource = clearSwapSource,
	}
end

return useBackpackInput
