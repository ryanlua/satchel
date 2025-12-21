local SlotButton = require(script.Components.SlotButton)

local button = SlotButton.new()
button:setText("Hello world!")
button:setHint("9")
button:setParent(game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui"))

return {}
