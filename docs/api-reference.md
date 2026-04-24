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

Gets the TopbarPlus icon used to toggle the backpack.

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
