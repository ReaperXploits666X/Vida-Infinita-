local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera

-- GUI personalizada
local ScreenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
ScreenGui.Name = "VoidReaperAimUI"
ScreenGui.ResetOnSpawn = false

local buttonFrame = Instance.new("Frame", ScreenGui)
buttonFrame.Size = UDim2.new(0, 180, 0, 50)
buttonFrame.Position = UDim2.new(0.5, -90, 0.9, -25)
buttonFrame.BackgroundTransparency = 0.5
buttonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
buttonFrame.BorderSizePixel = 2
buttonFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
buttonFrame.Active = true
buttonFrame.Draggable = true

local button = Instance.new("TextButton", buttonFrame)
button.Size = UDim2.new(1, 0, 1, 0)
button.BackgroundTransparency = 1
button.Text = "AIM NOOB [OFF]"
button.TextColor3 = Color3.fromRGB(255, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.AutoButtonColor = false

-- Efeito RGB pulsante
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.01) % 1
    local rgb = Color3.fromHSV(hue, 1, 1)
    buttonFrame.BorderColor3 = rgb
    button.TextColor3 = rgb
end)

-- Aim inteligente com grude total
local aimEnabled = false
local lockedTarget = nil

local function getTargetInSight()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < 100 then
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
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, lockedTarget.Position)
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
