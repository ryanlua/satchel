## Methods

### getEnabled

```
getEnabled(): boolean
```

Gets if the backpack is enabled.

### setEnabled

```
setEnabled(enabled: boolean): ()
```

Sets whether the backpack is enabled or not.

### getTheme

```
getTheme(): StyleSheet
```

Gets the active StyleSheet for the backpack theme.

### setTheme

```
setTheme(theme: "DefaultTheme" | "LegacyTheme" | StyleSheet): ()
```

Configures the backpack theme with a StyleSheet.

### getTopbarIcon

```
getTopbarIcon(): TopbarPlus.Icon
```

Gets the [TopbarPlus icon] used to toggle the backpack.

  [TopbarPlus icon]: https://1foreverhd.github.io/TopbarPlus/api/

### openInventory

```
openInventory(): ()
```

Opens the inventory.

### closeInventory

```
closeInventory(): ()
```

Closes the inventory.

### isInventoryOpen

```
isInventoryOpen(): boolean
```

Returns `true` if the inventory is open.

### getHotbarSlotCount

```
getHotbarSlotCount(): number
```

Returns the number of hotbar slots. This can change with viewport size and screen orientation (typically 3, 5, or 10). Slot indices from `1` through this value are on the hotbar; higher indices are inventory overflow.

## Events

### backpackItemAdded

```
backpackItemAdded(item: BackpackItem, slotIndex: number): BindableEvent
```

Fires when an item is added to the backpack. `slotIndex` is the slot the item was placed in. Compare with [getHotbarSlotCount](#gethotbarslotcount) to tell hotbar from inventory.

### backpackItemRemoved

```
backpackItemRemoved(item: BackpackItem, slotIndex: number): BindableEvent
```

Fires when an item is removed from the backpack. `slotIndex` is the slot the item occupied at removal time.

### backpackItemEquipped

```
backpackItemEquipped(item: BackpackItem): BindableEvent
```

Fires when an item is equipped.

### backpackItemUnequipped

```
backpackItemUnequipped(item: BackpackItem): BindableEvent
```

Fires when an item is unequipped.

### inventoryOpened

```
inventoryOpened(): BindableEvent
```

Fires when the player opens the inventory or when [openInventory](#openinventory) is called.

### inventoryClosed

```
inventoryClosed(): BindableEvent
```

Fires when the player closes the inventory or when [closeInventory](#closeinventory) is called.

### themeChanged

```
themeChanged(newTheme: StyleSheet, oldTheme: StyleSheet): BindableEvent
```

Fires when the backpack theme is changed.
