--!strict

local RunService = game:GetService("RunService")

local bindableEvents = script.Parent.Parent.BindableEvents

local function closeInventory()
	assert(RunService:IsClient(), "closeInventory can only be called on the client")

	bindableEvents.InventoryClosed:Fire()
end

return closeInventory
