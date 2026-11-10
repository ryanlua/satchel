# Satchel Roblox Backpack AGENTS.md

## Code Style

- Format/style code using [StyLua](https://github.com/JohnnyMorganz/StyLua) and lint using [selene](https://github.com/Kampfkarren/selene)
- Simplify `UDim2.new` to `UDim2.fromScale` or `UDim2.fromOffset`
- Use the [`const`](https://create.roblox.com/docs/luau/variables#const-variables) keyword instead of `local` for immutable bindings
- Use [require-by-string](https://create.roblox.com/docs/en-us/reference/engine/globals/LuaGlobals#require) when using `require()`
- Avoid deprecated API such as `GuiObject.Draggable`, `:connect()` instead of `:Connect()`, `wait()`/`delay()` instead of `task.wait()`/`task.delay()` and `tick()`

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
