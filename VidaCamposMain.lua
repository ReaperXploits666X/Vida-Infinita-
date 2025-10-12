local p = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "BotaoDanoBuff"

local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 250, 0, 40)
botao.Position = UDim2.new(0.5, -125, 0.85, 0)
botao.Text = "Dano x20"
botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Font = Enum.Font.Fantasy
botao.TextSize = 18
botao.Active = true
botao.Draggable = true

local ativo = false

botao.MouseButton1Click:Connect(function()
	ativo = not ativo
	if ativo then
		botao.Text = "Dano x20 ATIVADO"
		botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

		-- Intercepta RemoteEvent de dano
		for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
			if obj:IsA("RemoteEvent") and obj.Name:lower():find("dano") then
				local original = obj.FireServer
				obj.FireServer = function(self, alvo, dano)
					print("Dano interceptado: multiplicando por 20")
					return original(self, alvo, dano * 20)
				end
			end
		end

	else
		botao.Text = "Dano x20"
		botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
