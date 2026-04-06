--!strict

local RunService = game:GetService("RunService")

local bindableEvents = script.Parent.Parent.BindableEvents

local inventoryOpen = false

bindableEvents.InventoryOpened.Event:Connect(function()
	inventoryOpen = true
end)

bindableEvents.InventoryClosed.Event:Connect(function()
	inventoryOpen = false
end)

local function isInventoryOpen(): boolean
	assert(RunService:IsClient(), "isInventoryOpen can only be called on the client")

	return inventoryOpen
end

return isInventoryOpen
