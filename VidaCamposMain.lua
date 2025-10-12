local p = game.Players.LocalPlayer
local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
local b = Instance.new("TextButton", g)
g.Name = "ILMOD"
b.Size = UDim2.new(0, 200, 0, 40)
b.Position = UDim2.new(0.5, -100, 0.85, 0)
b.Text = "Infinite Life MOD"
b.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
b.TextColor3 = Color3.fromRGB(255, 255, 255)
b.Font = Enum.Font.Fantasy
b.TextSize = 18
b.Active = true
b.Draggable = true
b.MouseButton1Click:Connect(function()
	local c = p.Character or p.CharacterAdded:Wait()
	local h = c:FindFirstChildOfClass("Humanoid")
	if h then
		h.MaxHealth = math.huge
		h.Health = math.huge
		b.Text = "Vida Infinita Ativada"
		b.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		b.TextColor3 = Color3.fromRGB(0, 0, 0)
	end
end)
