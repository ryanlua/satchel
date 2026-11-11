# Satchel Roblox Backpack AGENTS.md

## Code Style

- Format/style code using [StyLua](https://github.com/JohnnyMorganz/StyLua) and lint using [selene](https://github.com/Kampfkarren/selene)
- Simplify `UDim2.new` to `UDim2.fromScale` or `UDim2.fromOffset`
- Use the [`const`](https://create.roblox.com/docs/luau/variables#const-variables) keyword instead of `local` for immutable bindings
- Use [require-by-string](https://create.roblox.com/docs/en-us/reference/engine/globals/LuaGlobals#require) when using `require()`
- Avoid deprecated API such as `GuiObject.Draggable`, `:connect()` instead of `:Connect()`, `wait()`/`delay()` instead of `task.wait()`/`task.delay()` and `tick()`

## Editing Styles in `src/Design.rbxmx`

The stylesheet is a serialized [`StyleSheet`](https://create.roblox.com/docs/reference/engine/classes/StyleSheet) of nested [`StyleRule`](https://create.roblox.com/docs/reference/engine/classes/StyleRule) items (see [UI styling](https://create.roblox.com/docs/ui/styling)). Rules can be edited by hand:

- Each `StyleRule` has a [`Selector`](https://create.roblox.com/docs/reference/engine/classes/StyleRule#Selector) and `Name` (keep them the same), a [`Priority`](https://create.roblox.com/docs/reference/engine/classes/StyleRule#Priority) (higher wins over conflicting rules), and a unique `referent` (any unused `RBX` + 32 hex characters)
- Nested `StyleRule` items merge their selectors with their parent rule ([nesting and merging](https://create.roblox.com/docs/ui/styling/css-comparisons#nesting-and-merging)), e.g. `.Equipped` under `TextButton.Slot`, then `::UIStroke` under `.Equipped`. Escape `>` as `&gt;`
- `PropertiesSerialize` is the serialized form of the rule's properties and uses the same binary encoding as `AttributesSerialize`. This is not documented by Roblox; rbx-dom treats it as the `Attributes` type ([rbx-dom patching docs](https://dom.rojo.space/patching-database.html), [rbx-dom#597](https://github.com/rojo-rbx/rbx-dom/issues/597)), and the layout is specified by the [rbx-dom attribute binary format](https://github.com/rojo-rbx/rbx-dom/blob/master/docs/attributes.md): base64 of little-endian binary with a `u32` property count, then per property a `u32`-length-prefixed name, a 1-byte type ID and the value. Common type IDs:
  - `0x02` string: `u32` length + bytes. Strings starting with `$` such as `$SlotPressStrokeColor` are [token references](https://create.roblox.com/docs/ui/styling/css-comparisons#variables) to attributes on the stylesheet (prefer tokens over literal values)
  - `0x03` bool: 1 byte
  - `0x06` number: 8-byte double
  - `0x0A` UDim2: two `f32` scale + `i32` offset pairs
  - `0x0F` Color3: three `f32`s
  - `0x15` enum: `u32`-length-prefixed enum name (e.g. `ApplyStrokeMode`) + `u32` value
- An empty rule is `AAAAAA==`. Leave `PropertyTransitionsSerialize` as `AgAAAAAA` (copied from existing rules without transitions; its format is undocumented)
- Prefer reusing an existing rule's blob when the properties match. Otherwise encode new blobs with a script and check the encoder by re-encoding an existing blob byte for byte
- Verify with `rojo build` after editing

## Resources

- [Flipbook](https://github.com/flipbook-labs/flipbook) is used to storybook the [React Luau](https://github.com/Roblox/react-luau) UI. Ensure compatibility with Flipbook
- Use the [Roblox Creator Documentation](https://github.com/Roblox/creator-docs) to understand the Roblox API and best practices
- Behaviors should be as close as possible to the CoreGui backpack unless specified. Priority should be as listed below, top to bottom:
  - Our own fork (subproject of Satchel) of the Roblox CoreGui backpack with changes made run without Roblox script security. The repo often has better practices because it is newer
    - https://github.com/ryanlua/purse/blob/main/src/init.luau
  - Latest version of the Roblox CoreGui backpack
    - https://github.com/MaximumADHD/Roblox-Client-Tracker/blob/roblox/scripts/CoreScripts/Modules/BackpackScript.lua
  - Legacy Roblox CoreGui backpack
    - https://github.com/Roblox/Core-Scripts/blob/master/CoreScriptsRoot/Modules/BackpackScript.lua
