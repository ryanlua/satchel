local React = require(script.Parent.Parent.Parent.react)
local ReactRoblox = require(script.Parent.Parent.Parent["react-roblox"])

return {
	story = function()
		return React.createElement("TextButton", {
			Text = "Click Me",
			TextSize = 16,
			Font = Enum.Font.BuilderSansExtraBold,
			TextColor3 = Color3.fromRGB(50, 50, 50),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(200, 40),
			[React.Event.Activated] = function()
				print("clicked")
			end,
		})
	end,
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}