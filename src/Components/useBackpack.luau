--!strict

const React = require("../../react")

const bindableEvents = script.Parent.Parent.BindableEvents
const backpackItemAdded = bindableEvents.BackpackItemAdded
const backpackItemRemoved = bindableEvents.BackpackItemRemoved
const backpackItemEquipped = bindableEvents.BackpackItemEquipped
const backpackItemUnequipped = bindableEvents.BackpackItemUnequipped

type SlotItem = { item: BackpackItem, equipped: boolean }

type Actions = {
	onSlotActivated: (item: BackpackItem) -> (),
	move: (item: BackpackItem, targetIndex: number) -> (),
	equipSlot: (index: number) -> (),
	cycleHotbar: (direction: number) -> (),
	unequipAll: () -> (),
	removeFromHotbar: (index: number) -> (),
}

export type BackpackState = Actions & { items: { [number]: SlotItem } }

const function useBackpack(player: Player, hotbarSlotCount: number): BackpackState
	const items, setItems = React.useState({} :: { [number]: SlotItem })
	const actionsRef = React.useRef(nil :: Actions?)

	React.useEffect(function()
		local toolBySlotIndex: { [number]: Tool } = {}
		local slotIndexByTool: { [Tool]: number } = {}
		local equippedStateByTool: { [Tool]: boolean } = {}
		local inventoryConnections: { RBXScriptConnection } = {}
		local character: Model? = nil
		local backpack: Backpack? = nil

		-- Check if tool is equipped.
		local function isEquipped(tool: Tool): boolean
			return character ~= nil and tool.Parent == character
		end

		local function syncItemsToReact()
			local slotItems: { [number]: SlotItem } = {}
			for slotIndex, tool in toolBySlotIndex do
				slotItems[slotIndex] = { item = tool, equipped = isEquipped(tool) }
			end
			setItems(slotItems)
		end

		local function findNextSlotIndex(): number
			for slotIndex = 1, hotbarSlotCount do
				if not toolBySlotIndex[slotIndex] then
					return slotIndex
				end
			end
			local highestSlotIndex = hotbarSlotCount
			for slotIndex in toolBySlotIndex do
				highestSlotIndex = math.max(highestSlotIndex, slotIndex)
			end
			return highestSlotIndex + 1
		end

		local function fireEquippedChangedEvents(tool: Tool)
			local equipped = isEquipped(tool)
			local wasEquipped = equippedStateByTool[tool]
			if wasEquipped == equipped then
				return
			end
			equippedStateByTool[tool] = equipped
			if wasEquipped == nil then
				if equipped then
					backpackItemEquipped:Fire(tool)
				end
			elseif equipped then
				backpackItemEquipped:Fire(tool)
			else
				backpackItemUnequipped:Fire(tool)
			end
		end

		local function trackTool(tool: Tool)
			if slotIndexByTool[tool] then
				fireEquippedChangedEvents(tool)
				return
			end
			local slotIndex = findNextSlotIndex()
			toolBySlotIndex[slotIndex] = tool
			slotIndexByTool[tool] = slotIndex
			backpackItemAdded:Fire(tool)
			fireEquippedChangedEvents(tool)
		end

		local function untrackTool(tool: Tool): boolean
			local slotIndex = slotIndexByTool[tool]
			if not slotIndex then
				return false
			end
			toolBySlotIndex[slotIndex] = nil
			slotIndexByTool[tool] = nil
			equippedStateByTool[tool] = nil
			backpackItemRemoved:Fire(tool)
			return true
		end

		local function onInventoryChildAdded(child: Instance)
			if child:IsA("Tool") then
				trackTool(child)
				syncItemsToReact()
			end
		end

		local function onInventoryChildRemoved(child: Instance)
			if not child:IsA("Tool") then
				return
			end
			local tool = child :: Tool
			local parent = tool.Parent
			if parent == character or parent == backpack then
				return
			end
			if untrackTool(tool) then
				syncItemsToReact()
			end
		end

		local function connectInventoryContainer(container: Instance)
			table.insert(inventoryConnections, container.ChildAdded:Connect(onInventoryChildAdded))
			table.insert(inventoryConnections, container.ChildRemoved:Connect(onInventoryChildRemoved))
			for _, child in container:GetChildren() do
				if child:IsA("Tool") then
					trackTool(child)
				end
			end
		end

		local function disconnectInventory()
			for _, connection in inventoryConnections do
				connection:Disconnect()
			end
			table.clear(inventoryConnections)
			table.clear(toolBySlotIndex)
			table.clear(slotIndexByTool)
			table.clear(equippedStateByTool)
		end

		local function onCharacterAdded(newCharacter: Model)
			disconnectInventory()
			character = newCharacter
			local playerBackpack = player:WaitForChild("Backpack") :: Backpack
			backpack = playerBackpack
			connectInventoryContainer(newCharacter)
			connectInventoryContainer(playerBackpack)
			syncItemsToReact()
		end

		local function getHumanoid(): Humanoid?
			return character and character:FindFirstChildOfClass("Humanoid")
		end

		local function setSlot(slotIndex: number, tool: Tool?)
			toolBySlotIndex[slotIndex] = tool
			if not tool then
				return
			end
			slotIndexByTool[tool] = slotIndex
			-- Tools moved into the inventory must not stay equipped
			local humanoid = getHumanoid()
			if humanoid and slotIndex > hotbarSlotCount and isEquipped(tool) then
				humanoid:UnequipTools()
			end
		end

		local lastEquippedSlotIndex: number? = nil

		local function unequipAll()
			local humanoid = getHumanoid()
			if humanoid then
				humanoid:UnequipTools()
			end
		end

		local function equipTool(tool: Tool)
			local humanoid = getHumanoid()
			if not humanoid then
				return
			elseif isEquipped(tool) then
				unequipAll()
			else
				humanoid:EquipTool(tool)
				local slotIndex = slotIndexByTool[tool]
				if slotIndex and slotIndex <= hotbarSlotCount then
					lastEquippedSlotIndex = slotIndex
				end
			end
		end

		local function nextInventoryIndex(): number
			local highestSlotIndex = hotbarSlotCount
			for slotIndex in toolBySlotIndex do
				highestSlotIndex = math.max(highestSlotIndex, slotIndex)
			end
			for slotIndex = hotbarSlotCount + 1, highestSlotIndex do
				if not toolBySlotIndex[slotIndex] then
					return slotIndex
				end
			end
			return highestSlotIndex + 1
		end

		actionsRef.current = {
			onSlotActivated = function(item: BackpackItem)
				if item:IsA("Tool") then
					equipTool(item)
				end
			end,
			-- Moves the item to targetIndex, swapping with any item already there
			move = function(item: BackpackItem, targetIndex: number)
				local slotIndex = item:IsA("Tool") and slotIndexByTool[item]
				if not slotIndex or slotIndex == targetIndex then
					return
				end
				local otherTool = toolBySlotIndex[targetIndex]
				setSlot(targetIndex, item :: Tool)
				setSlot(slotIndex, otherTool)
				syncItemsToReact()
			end,
			equipSlot = function(index: number)
				local tool = toolBySlotIndex[index]
				if tool then
					equipTool(tool)
				end
			end,
			cycleHotbar = function(direction: number)
				-- Prefer cycling from the currently equipped hotbar tool
				for slotIndex = 1, hotbarSlotCount do
					local tool = toolBySlotIndex[slotIndex]
					if tool and isEquipped(tool) then
						local newSlotIndex = slotIndex + direction
						local hitEdge = false
						if newSlotIndex > hotbarSlotCount then
							newSlotIndex = 1
							hitEdge = true
						elseif newSlotIndex < 1 then
							newSlotIndex = hotbarSlotCount
							hitEdge = true
						end

						local startIndex = newSlotIndex
						while not toolBySlotIndex[newSlotIndex] do
							newSlotIndex += direction
							if newSlotIndex == startIndex then
								return
							elseif newSlotIndex > hotbarSlotCount then
								newSlotIndex = 1
								hitEdge = true
							elseif newSlotIndex < 1 then
								newSlotIndex = hotbarSlotCount
								hitEdge = true
							end
						end

						if hitEdge then
							unequipAll()
						else
							equipTool(toolBySlotIndex[newSlotIndex])
						end
						return
					end
				end

				-- Nothing equipped: re-equip the last hotbar slot, else first tool in direction
				if lastEquippedSlotIndex then
					local lastTool = toolBySlotIndex[lastEquippedSlotIndex]
					if lastTool then
						equipTool(lastTool)
						return
					end
				end

				local startIndex = if direction < 0 then hotbarSlotCount else 1
				local endIndex = if direction < 0 then 1 else hotbarSlotCount
				for slotIndex = startIndex, endIndex, direction do
					local tool = toolBySlotIndex[slotIndex]
					if tool then
						equipTool(tool)
						return
					end
				end
			end,
			unequipAll = unequipAll,
			removeFromHotbar = function(index: number)
				if index < 1 or index > hotbarSlotCount then
					return
				end
				local tool = toolBySlotIndex[index]
				if not tool then
					return
				end
				local targetIndex = nextInventoryIndex()
				setSlot(targetIndex, tool)
				setSlot(index, nil :: Tool?)
				syncItemsToReact()
			end,
		}

		local characterSpawnConnection = player.CharacterAdded:Connect(onCharacterAdded)
		if player.Character then
			onCharacterAdded(player.Character)
		end

		return function()
			characterSpawnConnection:Disconnect()
			disconnectInventory()
			actionsRef.current = nil
		end
	end, { player :: any, hotbarSlotCount :: any })

	-- Stable wrappers so consumers don't re-render when the effect re-runs
	const onSlotActivated = React.useCallback(function(item: BackpackItem)
		if actionsRef.current then
			actionsRef.current.onSlotActivated(item)
		end
	end, {})

	const move = React.useCallback(function(item: BackpackItem, targetIndex: number)
		if actionsRef.current then
			actionsRef.current.move(item, targetIndex)
		end
	end, {})

	const equipSlot = React.useCallback(function(index: number)
		if actionsRef.current then
			actionsRef.current.equipSlot(index)
		end
	end, {})

	const cycleHotbar = React.useCallback(function(direction: number)
		if actionsRef.current then
			actionsRef.current.cycleHotbar(direction)
		end
	end, {})

	const unequipAll = React.useCallback(function()
		if actionsRef.current then
			actionsRef.current.unequipAll()
		end
	end, {})

	const removeFromHotbar = React.useCallback(function(index: number)
		if actionsRef.current then
			actionsRef.current.removeFromHotbar(index)
		end
	end, {})

	return {
		items = items,
		onSlotActivated = onSlotActivated,
		move = move,
		equipSlot = equipSlot,
		cycleHotbar = cycleHotbar,
		unequipAll = unequipAll,
		removeFromHotbar = removeFromHotbar,
	}
end

return useBackpack
