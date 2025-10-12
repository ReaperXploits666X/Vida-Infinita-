local p = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
gui.Name = "PainelKillsVisual"

-- Contador visual flutuante
local billboard = Instance.new("BillboardGui")
billboard.Name = "CoroaKills"
billboard.Size = UDim2.new(0, 100, 0, 50)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true

local crownIcon = Instance.new("ImageLabel", billboard)
crownIcon.Size = UDim2.new(0, 40, 0, 40)
crownIcon.Position = UDim2.new(0, 0, 0, 0)
crownIcon.BackgroundTransparency = 1
crownIcon.Image = "rbxassetid://7483871524" -- Ícone de coroa dourada

local killLabel = Instance.new("TextLabel", billboard)
killLabel.Size = UDim2.new(0, 60, 0, 40)
killLabel.Position = UDim2.new(0, 40, 0, 0)
killLabel.BackgroundTransparency = 1
killLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
killLabel.Font = Enum.Font.Fantasy
killLabel.TextSize = 22
killLabel.Text = "0"

billboard.Parent = p.Character:WaitForChild("Head")

-- Contador de kills
local kills = 0
local mortos = {}

-- Detecta mortes reais e simula 10 kills por cada
game:GetService("RunService").Heartbeat:Connect(function()
	for _, jogador in pairs(game.Players:GetPlayers()) do
		if jogador ~= p and not mortos[jogador] then
			local char = jogador.Character
			if char then
				local h = char:FindFirstChildOfClass("Humanoid")
				if h and h.Health <= 0 then
					mortos[jogador] = true
					kills += 10
					killLabel.Text = tostring(kills)
				end
			end
		end
	end
end)
