local p = game.Players.LocalPlayer

local function criarEfeitoVisual()
	local char = p.Character or p.CharacterAdded:Wait()
	local head = char:WaitForChild("Head")

	-- Coroa física visível
	local coroa = Instance.new("Part")
	coroa.Name = "CoroaRei"
	coroa.Size = Vector3.new(2, 1, 2)
	coroa.Anchored = false
	coroa.CanCollide = false
	coroa.Transparency = 0
	coroa.BrickColor = BrickColor.new("Bright yellow")
	coroa.Material = Enum.Material.Neon
	coroa.Shape = Enum.PartType.Ball
	coroa.Parent = char

	local weld = Instance.new("WeldConstraint", coroa)
	weld.Part0 = coroa
	weld.Part1 = head
	coroa.Position = head.Position + Vector3.new(0, 2.5, 0)

	-- Luz dourada visível
	local luz = Instance.new("PointLight", coroa)
	luz.Color = Color3.new(1, 1, 0)
	luz.Range = 10
	luz.Brightness = 5

	-- Aura em volta do corpo
	for _, parte in pairs(char:GetChildren()) do
		if parte:IsA("BasePart") then
			local aura = Instance.new("ParticleEmitter", parte)
			aura.Name = "AuraRei"
			aura.Texture = "rbxassetid://243098098" -- textura de brilho
			aura.Color = ColorSequence.new(Color3.new(1, 1, 0))
			aura.LightEmission = 1
			aura.Size = NumberSequence.new(0.5)
			aura.Rate = 10
			aura.Speed = NumberRange.new(0)
			aura.LockedToPart = true
		end
	end
end

-- Ativa ao entrar no jogo
p.CharacterAdded:Connect(function()
	wait(1)
	criarEfeitoVisual()
end)

-- Ativa se já estiver com personagem carregado
if p.Character then
	criarEfeitoVisual()
end
