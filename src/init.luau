--!strict

const api = script.Api
const bindableEvents = script.BindableEvents

return {
	-- Functions
	getEnabled = require(api.getEnabled),
	setEnabled = require(api.setEnabled),
	getTheme = require(api.getTheme),
	setTheme = require(api.setTheme),
	getTopbarIcon = require(api.getTopbarIcon),
	openInventory = require(api.openInventory),
	closeInventory = require(api.closeInventory),
	isInventoryOpen = require(api.isInventoryOpen),

	-- Events
	backpackItemAdded = bindableEvents.BackpackItemAdded.Event,
	backpackItemRemoved = bindableEvents.BackpackItemRemoved.Event,
	backpackItemEquipped = bindableEvents.BackpackItemEquipped.Event,
	backpackItemUnequipped = bindableEvents.BackpackItemUnequipped.Event,
	inventoryOpened = bindableEvents.InventoryOpened.Event,
	inventoryClosed = bindableEvents.InventoryClosed.Event,
	themeChanged = bindableEvents.ThemeChanged.Event,
}
