--!strict

local bindableEvents = script.BindableEvents

return {
	-- Functions
	setEnabled = require(script.Api.setEnabled),
	getTopbarIcon = require(script.Api.getTopbarIcon),
	openInventory = require(script.Api.openInventory),
	closeInventory = require(script.Api.closeInventory),
	setInventoryVisible = require(script.Api.setInventoryVisible),

	-- Events
	backpackItemAdded = bindableEvents.BackpackItemAdded.Event,
	backpackItemRemoved = bindableEvents.BackpackItemRemoved.Event,
	backpackItemEquipped = bindableEvents.BackpackItemEquipped.Event,
	backpackItemUnequipped = bindableEvents.BackpackItemUnequipped.Event,
	inventoryOpened = bindableEvents.InventoryOpened.Event,
	inventoryClosed = bindableEvents.InventoryClosed.Event,
	inventoryToggled = bindableEvents.InventoryToggled.Event,
}
