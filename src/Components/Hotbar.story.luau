local React = require(script.Parent.Parent.Parent.react)

local Hotbar = require(script.Parent.Hotbar)

local controls = {
	forceHintVisible = true,
	slots = 10,
	unlocked = false,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "Hotbar component that holds hotbar slots and hints",
	controls = controls,
	story = function(props: Props)
		return React.createElement(Hotbar, {
			forceHintVisible = props.controls.forceHintVisible,
			slots = props.controls.slots,
			unlocked = props.controls.unlocked,
		})
	end,
}
