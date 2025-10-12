local p = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "BotaoInverterRegeneracao"

local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 250, 0, 40)
botao.Position = UDim2.new(0.5, -125, 0.75, 0)
botao.Text = "Inverter Regeneração"
botao.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Font = Enum.Font.Fantasy
botao.TextSize = 18
botao.Active = true
botao.Draggable = true

local ativo = false
local conexao = nil

botao.MouseButton1Click:Connect(function()
	ativo = not ativo
	if ativo then
		botao.Text = "Regeneração Invertida ON"
		botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

		local lastHealth = nil
		conexao = game:GetService("RunService").Heartbeat:Connect(function()
			local c = p.Character
			if c then
				local h = c:FindFirstChildOfClass("Humanoid")
				if h then
					if lastHealth and h.Health < lastHealth then
						h.Health = h.MaxHealth -- Cura total ao detectar dano
						print("Dano revertido: regeneração ativada")
					end
					lastHealth = h.Health
				end
			end
		end)

	else
		botao.Text = "Inverter Regeneração"
		botao.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
		if conexao then conexao:Disconnect() end
	end
end)
