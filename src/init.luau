--!strict

const bindableEvents = script.BindableEvents

return {
	-- Functions
	getEnabled = require(script.Api.getEnabled),
	setEnabled = require(script.Api.setEnabled),
	getTheme = require(script.Api.getTheme),
	setTheme = require(script.Api.setTheme),
	getTopbarIcon = require(script.Api.getTopbarIcon),
	openInventory = require(script.Api.openInventory),
	closeInventory = require(script.Api.closeInventory),
	isInventoryOpen = require(script.Api.isInventoryOpen),

	-- Events
	backpackItemAdded = bindableEvents.BackpackItemAdded.Event,
	backpackItemRemoved = bindableEvents.BackpackItemRemoved.Event,
	backpackItemEquipped = bindableEvents.BackpackItemEquipped.Event,
	backpackItemUnequipped = bindableEvents.BackpackItemUnequipped.Event,
	inventoryOpened = bindableEvents.InventoryOpened.Event,
	inventoryClosed = bindableEvents.InventoryClosed.Event,
	themeChanged = bindableEvents.ThemeChanged.Event,
}
