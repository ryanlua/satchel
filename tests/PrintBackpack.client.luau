--!strict

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local character = player.Character or player.CharacterAdded:Wait()

-- Check if instance is an item
local function isItem(instance: Tool | HopperBin): boolean
	return instance:IsA("Tool") or instance:IsA("HopperBin")
end

-- Connect to item events
local function onItem(item: Tool | HopperBin)
	if not isItem(item) then
		return
	end

	print("[Added]", item.Name)

	item.AncestryChanged:Connect(function(_, newParent)
		if newParent == character then
			print("[Equipped]", item.Name)
		elseif newParent == backpack then
			print("[Unequipped]", item.Name)
		elseif newParent == nil then
			print("[Removed]", item.Name)
		end
	end)
end

local function onChildAdded(child)
	if isItem(child) then
		onItem(child)
	end
end

local function onChildRemoved(child)
	if isItem(child) and child.Parent ~= character and child.Parent ~= backpack then
		print("[Removed]", child.Name)
	end
end

backpack.ChildAdded:Connect(onChildAdded)
backpack.ChildRemoved:Connect(onChildRemoved)
character.ChildAdded:Connect(onChildAdded)
character.ChildRemoved:Connect(onChildRemoved)

-- Handle character respawn
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	character.ChildAdded:Connect(onChildAdded)
	character.ChildRemoved:Connect(onChildRemoved)

	for _, child in character:GetChildren() do
		onChildAdded(child)
	end
end)

-- Add existing items in backpack and character
for _, child in backpack:GetChildren() do
	onChildAdded(child)
end
for _, child in character:GetChildren() do
	onChildAdded(child)
end
