--!strict

local RunService = game:GetService("RunService")

local bindableEvents = script.Parent.Parent.BindableEvents

local function openInventory()
	assert(RunService:IsClient(), "openInventory can only be called on the client")

	bindableEvents.InventoryOpened:Fire()
end

return openInventory
