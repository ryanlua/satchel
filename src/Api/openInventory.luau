--!strict

const RunService = game:GetService("RunService")

const bindableEvents = script.Parent.Parent.BindableEvents

const function openInventory(): ()
	assert(RunService:IsClient(), "openInventory can only be called on the client")

	bindableEvents.InventoryOpened:Fire()
end

return openInventory
