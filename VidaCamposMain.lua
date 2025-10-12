local p = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "PainelKillsFake"

-- Contador de kills
local contador = Instance.new("TextLabel", gui)
contador.Size = UDim2.new(0, 200, 0, 40)
contador.Position = UDim2.new(0.5, -100, 0.1, 0)
contador.Text = "Kills: 0"
contador.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
contador.TextColor3 = Color3.fromRGB(255, 215, 0)
contador.Font = Enum.Font.Fantasy
contador.TextSize = 22

local kills = 0
local coroa = nil

-- Função para criar coroa flutuante
local function criarCoroa()
	if coroa then return end
	coroa = Instance.new("BillboardGui", p.Character.Head)
	coroa.Size = UDim2.new(0, 100, 0, 100)
	coroa.StudsOffset = Vector3.new(0, 2.5, 0)
	coroa.AlwaysOnTop = true

	local img = Instance.new("ImageLabel", coroa)
	img.Size = UDim2.new(1, 0, 1, 0)
	img.BackgroundTransparency = 1
	img.Image = "rbxassetid://7483871524" -- Ícone de coroa dourada
end

-- Simulador de kills multiplicadas
game:GetService("RunService").Heartbeat:Connect(function()
	for _, jogador in pairs(game.Players:GetPlayers()) do
		if jogador ~= p then
			local char = jogador.Character
			if char then
				local h = char:FindFirstChildOfClass("Humanoid")
				if h and h.Health < h.MaxHealth and h.Health > 0 then
					kills += 10 -- Cada hit conta como 10 kills
					contador.Text = "Kills: " .. kills
					wait(0.2)

					if kills >= 10 and not coroa then
						criarCoroa()
					end
				end
			end
		end
	end
end)
