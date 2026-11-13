# Satchel Roblox Backpack AGENTS.md

## Code Style

- Format/style code using [StyLua](https://github.com/JohnnyMorganz/StyLua) and lint using [selene](https://github.com/Kampfkarren/selene)
- Simplify `UDim2.new` to `UDim2.fromScale` or `UDim2.fromOffset`
- Use the [`const`](https://create.roblox.com/docs/luau/variables#const-variables) keyword instead of `local` for immutable bindings
- Use [require-by-string](https://create.roblox.com/docs/en-us/reference/engine/globals/LuaGlobals#require) when using `require()`
- Avoid deprecated API such as `GuiObject.Draggable`, `:connect()` instead of `:Connect()`, `wait()`/`delay()` instead of `task.wait()`/`task.delay()` and `tick()`

## Editing Styles in `src/Design`

Styles are written in [RSML](https://github.com/rbx-rsml) (see the [RSML docs](https://github.com/rbx-rsml/rsml-docs/tree/main/src/docs)). Each `.rsml` file in `src/Design` is one [`StyleSheet`](https://create.roblox.com/docs/reference/engine/classes/StyleSheet) of nested [`StyleRule`](https://create.roblox.com/docs/reference/engine/classes/StyleRule) items (see [UI styling](https://create.roblox.com/docs/ui/styling)):

- Edit the `.rsml` files, then run `rsml build src` (or `rsml watch src` alongside `rojo serve`) and commit the regenerated `.model.json` files. Never edit the `.model.json` files by hand. They are committed so Wally consumers and `rojo serve` work without RSML, and CI fails if they are out of date
- `ThemeTokens` and `BaseTokens` define tokens as `$Name = value;`. Tokens referencing other tokens (`$HintTextColor = $TextColor;`) stay as runtime [token references](https://create.roblox.com/docs/ui/styling/css-comparisons#variables) (prefer tokens over literal values)
- Themes link to other sheets with `@derive "./BaseTokens";` at the top of the file
- Nested rules merge their selectors with their parent rule ([nesting and merging](https://create.roblox.com/docs/ui/styling/css-comparisons#nesting-and-merging)), e.g. `.Equipped` inside `TextButton.Slot`, then `::UIStroke` inside `.Equipped`. Add rules where they belong in the tree
- Rules default to priority 0; use `@priority 5;` inside a rule to override. Priority only competes between sibling rules, so to resolve a conflict between nested rules set it on their top-most differing ancestors
- Never rely on source order: rules with equal priority that set the same property resolve unpredictably at runtime. Give every overriding rule (states like `:Hover`/`:Press`, tags like `.Equipped`, style queries like `@PreferredInputGamepad`) a higher priority than the rule it overrides
- Values: `:Fit` for enums whose type matches the property name (otherwise `Enum.AutomaticSize.Y`), `#191B1D` colours, `8px`/`50%` for UDims, `udim2 (60px, 60px)`, `vec2 (0, 0.5)`, `font ("BuilderSans", :Medium)`
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
