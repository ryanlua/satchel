--!strict

const React = require("../../react")

const DESIGN_SHEET = script.Parent.Parent.Design.SatchelStyleSheet
const ThemeChanged = script.Parent.Parent.BindableEvents.ThemeChanged

export type SlotMetrics = {
	gap: number,
	scrollbarGutter: number,
	rowWidth: (count: number) -> number,
	rowsHeight: (rowCount: number) -> number,
}

-- Used when a theme does not define the layout tokens. Matches BaseTokens.
const DEFAULT_SLOT_WIDTH = 60
const DEFAULT_SLOT_HEIGHT = 60
const DEFAULT_TEN_FOOT_SLOT_WIDTH = 100
const DEFAULT_TEN_FOOT_SLOT_HEIGHT = 100
const DEFAULT_GAP = 5
const DEFAULT_SCROLLBAR_GUTTER = 13

const function findAttribute(sheet: StyleSheet, name: string, visited: { [StyleSheet]: boolean }): any
	if visited[sheet] then
		return nil
	end
	visited[sheet] = true

	local value = sheet:GetAttribute(name)
	if value ~= nil then
		return value
	end

	const derives: { StyleDerive } = {}
	for _, child in sheet:GetChildren() do
		if child:IsA("StyleDerive") and child.StyleSheet ~= nil then
			table.insert(derives, child)
		end
	end
	table.sort(derives, function(a: StyleDerive, b: StyleDerive)
		return a.Priority > b.Priority
	end)

	for _, derive in derives do
		value = findAttribute(derive.StyleSheet :: StyleSheet, name, visited)
		if value ~= nil then
			return value
		end
	end

	return nil
end

const function resolveToken(root: StyleSheet, name: string): any
	const seen: { [string]: boolean } = {}

	const function resolve(tokenName: string): any
		if seen[tokenName] then
			return nil
		end
		seen[tokenName] = true

		local value = findAttribute(root, tokenName, {})
		if typeof(value) == "string" then
			local referent = string.match(value, "^%$(%w+)$")
			if referent then
				return resolve(referent)
			end
		end
		return value
	end

	return resolve(name)
end

const function offsetOnAxis(value: any, axis: "X" | "Y"): number?
	if typeof(value) == "number" then
		return value
	elseif typeof(value) == "UDim" then
		return value.Offset
	elseif typeof(value) == "UDim2" then
		return if axis == "X" then value.X.Offset else value.Y.Offset
	end
	return nil
end

const function activeTheme(): StyleSheet
	const derive = DESIGN_SHEET:FindFirstChildOfClass("StyleDerive") :: StyleDerive
	const theme = derive.StyleSheet
	assert(theme, "SatchelStyleSheet is missing a theme")
	return theme
end

const function getSlotMetrics(tenFootInterface: boolean?): SlotMetrics
	const tenFoot = tenFootInterface == true
	const theme = activeTheme()
	const slotToken = if tenFoot then "TenFootSlotSize" else "SlotSize"
	const slot = resolveToken(theme, slotToken)
	const slotWidth = offsetOnAxis(slot, "X") or if tenFoot then DEFAULT_TEN_FOOT_SLOT_WIDTH else DEFAULT_SLOT_WIDTH
	const slotHeight = offsetOnAxis(slot, "Y") or if tenFoot then DEFAULT_TEN_FOOT_SLOT_HEIGHT else DEFAULT_SLOT_HEIGHT
	const gap = offsetOnAxis(resolveToken(theme, "SlotGap"), "X") or DEFAULT_GAP
	const scrollbarGutter = offsetOnAxis(resolveToken(theme, "InventoryScrollbarGutter"), "X") or DEFAULT_SCROLLBAR_GUTTER

	-- Hotbar uses $SlotGap between slots and as its left and right padding.
	const pitchX = slotWidth + gap
	const pitchY = slotHeight + gap

	return {
		gap = gap,
		scrollbarGutter = scrollbarGutter,
		rowWidth = function(count: number): number
			return count * pitchX + gap
		end,
		rowsHeight = function(rowCount: number): number
			return rowCount * pitchY - gap
		end,
	}
end

-- Re-reads layout tokens after setTheme.
const function useSlotMetrics(tenFootInterface: boolean?): SlotMetrics
	const _revision, setRevision = React.useState(0)

	React.useEffect(function()
		const connection = ThemeChanged.Event:Connect(function()
			setRevision(function(current: number)
				return current + 1
			end)
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return getSlotMetrics(tenFootInterface)
end

return useSlotMetrics
