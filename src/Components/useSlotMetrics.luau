const React = require("../../react")

const getSlotMetrics = require("../Design/getSlotMetrics")

const ThemeChanged = script.Parent.Parent.BindableEvents.ThemeChanged

const function useSlotMetrics(tenFootInterface: boolean?): getSlotMetrics.SlotMetrics
	-- Bumps after setTheme so this hook re-reads layout tokens.
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

	return getSlotMetrics(tenFootInterface == true)
end

return useSlotMetrics
