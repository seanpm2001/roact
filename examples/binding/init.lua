return function()
	local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui

	local Roact = require(game.ReplicatedStorage.Roact)

	--[[
		A search bar with an icon and a text box
		When the icon is clicked, the TextBox captures focus
	]]
	local BindingTest = Roact.Component:extend("BindingTest")

	function BindingTest:init()
		self.binding = Roact.createBinding(0)
	end

	function BindingTest:render()
		return Roact.createElement("Frame", {
			Size = UDim2.new(0, 200, 0, 200),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BorderSizePixel = self.binding,
		})
	end

	function BindingTest:didMount()
		spawn(function()
			while true do
				wait(1)

				print("Update binding!")
				self.binding:update(self.binding:getValue() + 1)
			end
		end)
	end

	local app = Roact.createElement("ScreenGui", nil, {
		BindingTest = Roact.createElement(BindingTest),
	})

	local handle = Roact.mount(app, PlayerGui)

	local function stop()
		Roact.unmount(handle)
	end

	return stop
end