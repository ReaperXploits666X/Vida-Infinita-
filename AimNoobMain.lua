local button = script.Parent
local player = game.Players.LocalPlayer
local dragging = false
local offset = Vector2.new()

-- Estilo do botão
button.Text = "Regenerar Vida"
button.Size = UDim2.new(0, 160, 0, 40)
button.Position = UDim2.new(0, 100, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.Active = true
button.Draggable = false -- vamos usar nosso próprio sistema de arrastar

-- Função para regenerar vida
button.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Health = humanoid.MaxHealth
	end
end)

-- Sistema de arrastar o botão
button.MouseButton1Down:Connect(function(x, y)
	dragging = true
	offset = Vector2.new(x, y) - button.AbsolutePosition
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local newPos = input.Position - offset
		button.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
