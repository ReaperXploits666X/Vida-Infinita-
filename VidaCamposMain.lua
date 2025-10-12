local p = game.Players.LocalPlayer

local function ativarVisualRei()
	local char = p.Character or p.CharacterAdded:Wait()
	local head = char:WaitForChild("Head")

	-- 👑 COROA 3D FÍSICA
	local coroa = Instance.new("Part")
	coroa.Name = "CoroaRei"
	coroa.Size = Vector3.new(1.5, 1, 1.5)
	coroa.Anchored = false
	coroa.CanCollide = false
	coroa.Shape = Enum.PartType.Ball
	coroa.Material = Enum.Material.Neon
	coroa.BrickColor = BrickColor.new("Bright yellow")
	coroa.Position = head.Position + Vector3.new(0, 2.5, 0)
	coroa.Parent = char

	local weld = Instance.new("WeldConstraint", coroa)
	weld.Part0 = coroa
	weld.Part1 = head

	-- 💬 CONTADOR DE KILLS VISUAL
	local gui = Instance.new("BillboardGui", head)
	gui.Name = "ContadorKills"
	gui.Size = UDim2.new(0, 120, 0, 50)
	gui.StudsOffset = Vector3.new(0, 4, 0)
	gui.AlwaysOnTop = true

	local coroaIcone = Instance.new("ImageLabel", gui)
	coroaIcone.Size = UDim2.new(0, 40, 1, 0)
	coroaIcone.Position = UDim2.new(0, 0, 0, 0)
	coroaIcone.BackgroundTransparency = 1
	coroaIcone.Image = "rbxassetid://7483871524"

	local contador = Instance.new("TextLabel", gui)
	contador.Size = UDim2.new(0, 80, 1, 0)
	contador.Position = UDim2.new(0, 40, 0, 0)
	contador.BackgroundTransparency = 1
	contador.TextColor3 = Color3.fromRGB(255, 215, 0)
	contador.Font = Enum.Font.Fantasy
	contador.TextSize = 24
	contador.Text = "0"

	local kills = 0
	local mortos = {}

	-- ⚡ CONTORNO AMARELO COM RAIO E BRILHO
	for _, parte in pairs(char:GetChildren()) do
		if parte:IsA("BasePart") then
			local aura = Instance.new("ParticleEmitter", parte)
			aura.Texture = "rbxassetid://243098098"
			aura.Color = ColorSequence.new(Color3.new(1, 1, 0))
			aura.LightEmission = 1
			aura.Size = NumberSequence.new(0.6)
			aura.Rate = 20
			aura.Speed = NumberRange.new(0)
			aura.LockedToPart = true

			local raio = Instance.new("ParticleEmitter", parte)
			raio.Texture = "rbxassetid://5695074144"
			raio.Color = ColorSequence.new(Color3.new(1, 1, 0))
			raio.LightEmission = 1
			raio.Size = NumberSequence.new(0.4)
			raio.Rate = 5
			raio.Speed = NumberRange.new(1)
			raio.Lifetime = NumberRange.new(0.3)
			raio.LockedToPart = true
		end
	end

	-- 💀 DETECTA MORTES E ATUALIZA CONTADOR
	game:GetService("RunService").Heartbeat:Connect(function()
		for _, jogador in pairs(game.Players:GetPlayers()) do
			if jogador ~= p and not mortos[jogador] then
				local char = jogador.Character
				if char then
					local h = char:FindFirstChildOfClass("Humanoid")
					if h and h.Health <= 0 then
						mortos[jogador] = true
						kills += 1
						contador.Text = tostring(kills)
					end
				end
			end
		end
	end)
end

-- Ativa ao entrar no jogo
p.CharacterAdded:Connect(function()
	wait(1)
	ativarVisualRei()
end)

-- Ativa se já estiver com personagem carregado
if p.Character then
	ativarVisualRei()
end
