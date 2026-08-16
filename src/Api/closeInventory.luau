--!strict

const RunService = game:GetService("RunService")

const bindableEvents = script.Parent.Parent.BindableEvents

const function closeInventory(): ()
	assert(RunService:IsClient(), "closeInventory can only be called on the client")

	bindableEvents.InventoryClosed:Fire()
end

return closeInventory
