local p = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "BotaoCuraToggle"

local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 250, 0, 40)
botao.Position = UDim2.new(0.5, -125, 0.85, 0)
botao.Text = "Ativar Cura Contínua"
botao.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Font = Enum.Font.Fantasy
botao.TextSize = 18
botao.Active = true
botao.Draggable = true

local curando = false

botao.MouseButton1Click:Connect(function()
	curando = not curando

	if curando then
		botao.Text = "Cura Ativa"
		botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

		-- Loop de cura contínua
		task.spawn(function()
			while curando do
				local c = p.Character or p.CharacterAdded:Wait()
				local h = c:FindFirstChildOfClass("Humanoid")
				if h and h.Health < h.MaxHealth then
					h.Health = math.min(h.Health + 5, h.MaxHealth)
				end
				wait(1.5) -- tempo entre cada regeneração
			end
		end)
	else
		botao.Text = "Ativar Cura Contínua"
		botao.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	end
end)
