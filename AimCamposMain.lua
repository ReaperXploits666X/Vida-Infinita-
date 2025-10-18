local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ConnoisseurCreations/KavoUI/main/source.lua"))()
local Window = Library.CreateLib("VoidReaper Hub V1.0 Beta", "DarkTheme")
local AimTab = Window:NewTab("Campos de Batalha")
local AimSection = AimTab:NewSection("AIM NOOB")

local aimEnabled = false
local aimButton

local function getClosestTarget()
    local closest, distance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
            if dist < distance then
                closest = player.Character.HumanoidRootPart
                distance = dist
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if aimEnabled then
        local target = getClosestTarget()
        if target then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
        end
    end
end)

aimButton = AimSection:NewButton("AIM NOOB [OFF]", "Ativa/desativa mira colada", function()
    aimEnabled = not aimEnabled
    aimButton:UpdateButton("AIM NOOB [" .. (aimEnabled and "ON" or "OFF") .. "]")
end)
