local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera

-- Interface personalizada
local ScreenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
ScreenGui.Name = "VoidReaperAimUI"
ScreenGui.ResetOnSpawn = false

local button = Instance.new("TextButton", ScreenGui)
button.Size = UDim2.new(0, 180, 0, 50)
button.Position = UDim2.new(0.5, -90, 0.9, -25)
button.BackgroundTransparency = 1
button.Text = "AIM NOOB [OFF]"
button.TextColor3 = Color3.fromRGB(255, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(255, 0, 0)

-- Efeito RGB pulsante
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.01) % 1
    local rgb = Color3.fromHSV(hue, 1, 1)
    button.BorderColor3 = rgb
    button.TextColor3 = rgb
end)

-- Aim inteligente
local aimEnabled = false
local lockedTarget = nil

local function getTargetInSight()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < 100 then -- FOV de 100 pixels
                    return player.Character.HumanoidRootPart
                end
            end
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    if aimEnabled then
        if not lockedTarget then
            lockedTarget = getTargetInSight()
        end
        if lockedTarget then
            camera.CFrame = CFrame.new(camera.CFrame.Position, lockedTarget.Position)
        end
    else
        lockedTarget = nil
    end
end)

-- Toggle do botão
button.MouseButton1Click:Connect(function()
    aimEnabled = not aimEnabled
    button.Text = "AIM NOOB [" .. (aimEnabled and "ON" or "OFF") .. "]"
end)
