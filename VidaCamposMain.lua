local p = game.Players.LocalPlayer
local g = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
g.Name = "ModoImortal"

local b = Instance.new("TextButton", g)
b.Size = UDim2.new(0, 250, 0, 40)
b.Position = UDim2.new(0.5, -125, 0.85, 0)
b.Text = "Ativar Modo Imortal"
b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
b.TextColor3 = Color3.fromRGB(255, 255, 255)
b.Font = Enum.Font.Fantasy
b.TextSize = 18
b.Active = true
b.Draggable = true

local ativo = false
local connections = {}

b.MouseButton1Click:Connect(function()
	ativo = not ativo
	if ativo then
		b.Text = "Desativar Modo Imortal"
		b.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		b.TextColor3 = Color3.fromRGB(0, 0, 0)

		-- Regeneração contínua
		table.insert(connections, game:GetService("RunService").RenderStepped:Connect(function()
			local c = p.Character or p.CharacterAdded:Wait()
			for _, obj in pairs(c:GetDescendants()) do
				if obj:IsA("NumberValue") or obj:IsA("IntValue") or obj:IsA("FloatValue") then
					if obj.Value < 100000 then
						obj.Value = 100000
					end
				end
			end
		end))

		-- Bloqueio de RemoteEvents de dano
		for _, v in pairs(game:GetDescendants()) do
			if v:IsA("RemoteEvent") and string.find(v.Name:lower(), "damage") then
				v:Destroy()
			elseif v:IsA("RemoteFunction") and string.find(v.Name:lower(), "damage") then
				v:Destroy()
			end
		end

	else
		b.Text = "Ativar Modo Imortal"
		b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		b.TextColor3 = Color3.fromRGB(255, 255, 255)

		-- Desconectar tudo
		for _, conn in pairs(connections) do
			if conn then conn:Disconnect() end
		end
		connections = {}
	end
end)
