local React = require(script.Parent.Parent.Parent.react)

local function ReactButton(props: {
	text: string,
	onActivated: () -> (),
})
	return React.createElement("TextButton", {
		Text = props.text,
		TextSize = 16,
		Font = Enum.Font.BuilderSansExtraBold,
		TextColor3 = Color3.fromRGB(50, 50, 50),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(200, 40),
		[React.Event.Activated] = props.onActivated,
	})
end

return ReactButton