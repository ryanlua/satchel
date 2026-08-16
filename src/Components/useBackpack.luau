--!strict

const React = require("../../react")

const bindableEvents = script.Parent.Parent.BindableEvents
const backpackItemAdded = bindableEvents.BackpackItemAdded
const backpackItemRemoved = bindableEvents.BackpackItemRemoved
const backpackItemEquipped = bindableEvents.BackpackItemEquipped
const backpackItemUnequipped = bindableEvents.BackpackItemUnequipped

type SlotItem = { item: BackpackItem, equipped: boolean }

export type BackpackState = {
	items: { [number]: SlotItem },
	onSlotActivated: (item: BackpackItem) -> (),
}

const function useBackpack(player: Player, hotbarSlotCount: number): BackpackState
	const items, setItems = React.useState({} :: { [number]: SlotItem })
	const activateItemRef = React.useRef(nil :: ((item: BackpackItem) -> ())?)

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
			local isEquipped = isEquipped(tool)
			local wasEquipped = equippedStateByTool[tool]
			if wasEquipped == isEquipped then
				return
			end
			equippedStateByTool[tool] = isEquipped
			if wasEquipped == nil then
				if isEquipped then
					backpackItemEquipped:Fire(tool)
				end
			elseif isEquipped then
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

		activateItemRef.current = function(item: BackpackItem)
			if not item:IsA("Tool") then
				return
			end
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				return
			end
			if isEquipped(item) then
				humanoid:UnequipTools()
			else
				humanoid:EquipTool(item)
			end
		end

		local characterSpawnConnection = player.CharacterAdded:Connect(onCharacterAdded)
		if player.Character then
			onCharacterAdded(player.Character)
		end

		return function()
			characterSpawnConnection:Disconnect()
			disconnectInventory()
			activateItemRef.current = nil
		end
	end, { player :: any, hotbarSlotCount :: any })

	const onSlotActivated = React.useCallback(function(item: BackpackItem)
		local activateItem = activateItemRef.current
		if activateItem then
			activateItem(item)
		end
	end, {})

	return { items = items, onSlotActivated = onSlotActivated }
end

return useBackpack
