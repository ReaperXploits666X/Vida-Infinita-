local p = game.Players.LocalPlayer

local function ativarCoroaEmojiContador()
	local char = p.Character or p.CharacterAdded:Wait()
	local head = char:WaitForChild("Head")

	-- 👑 Billboard GUI com emoji e contador
	local gui = Instance.new("BillboardGui", head)
	gui.Name = "CoroaEmojiContador"
	gui.Size = UDim2.new(0, 120, 0, 50)
	gui.StudsOffset = Vector3.new(0, 3.5, 0)
	gui.AlwaysOnTop = true

	local texto = Instance.new("TextLabel", gui)
	texto.Size = UDim2.new(1, 0, 1, 0)
	texto.BackgroundTransparency = 1
	texto.TextColor3 = Color3.fromRGB(255, 215, 0)
	texto.Font = Enum.Font.Fantasy
	texto.TextSize = 28
	texto.Text = "👑 0"

	local kills = 0
	local mortos = {}

	-- 💀 Detecta mortes e atualiza contador
	game:GetService("RunService").Heartbeat:Connect(function()
		for _, jogador in pairs(game.Players:GetPlayers()) do
			if jogador ~= p and not mortos[jogador] then
				local char = jogador.Character
				if char then
					local h = char:FindFirstChildOfClass("Humanoid")
					if h and h.Health <= 0 then
						mortos[jogador] = true
						kills += 1
						texto.Text = "👑 " .. tostring(kills)
					end
				end
			end
		end
	end)
end

-- Ativa ao entrar no jogo
p.CharacterAdded:Connect(function()
	wait(1)
	ativarCoroaEmojiContador()
end)

-- Ativa se já estiver com personagem carregado
if p.Character then
	ativarCoroaEmojiContador()
end
