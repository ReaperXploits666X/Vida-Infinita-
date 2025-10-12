local player = game.Players.LocalPlayer

-- Criar GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "InfiniteLifeMOD_GUI"
gui.ResetOnSpawn = false

-- Criar botão
local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 220, 0, 50)
botao.Position = UDim2.new(0.5, -110, 0.85, 0)
botao.Text = "Infinite Life MOD"
botao.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Font = Enum.Font.Fantasy
botao.TextSize = 20
botao.Active = true
botao.Draggable = true -- permite mover o botão

-- Função ao clicar
botao.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = math.huge
		hum.Health = math.huge
		botao.Text = "Vida Infinita Ativada"
		botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		botao.TextColor3 = Color3.fromRGB(0, 0, 0)
	end
end)
