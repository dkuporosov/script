if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(1)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService('Players')
local player = Players.LocalPlayer
local autoKill = false
local killRange = 25
local function getChar() return player.Character end
local function getRoot()
    local c = getChar()
    return c and c:FindFirstChild('HumanoidRootPart')
end
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoKill then
            local root = getRoot()
            if root then
                for i, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA('Model') and obj ~= getChar() then
                        local hum = obj:FindFirstChildOfClass('Humanoid')
                        local oRoot = obj:FindFirstChild('HumanoidRootPart') or obj.PrimaryPart
                        if hum and oRoot and hum.Health > 0 then
                            if (root.Position - oRoot.Position).Magnitude <= killRange then
                                hum.Health = 0
                            end
                        end
                    end
                end
            end
        end
    end
end)
local Window = Rayfield:CreateWindow({
    Name = 'Iron Soul Script',
    LoadingTitle = 'Iron Soul',
    LoadingSubtitle = 'Loading...',
    Theme = 'Default',
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
})
local Main = Window:CreateTab('Main', 'sword')
Main:CreateSlider({
    Name = 'Kill Radius',
    Range = {5, 100},
    Increment = 5,
    CurrentValue = 25,
    Callback = function(val) killRange = val end,
})
Main:CreateToggle({
    Name = 'Auto Kill Mobs',
    CurrentValue = false,
    Callback = function(val)
        autoKill = val
        Rayfield:Notify({ Title = val and 'Auto Kill ON' or 'Auto Kill OFF', Content = 'Radius: ' .. killRange, Duration = 3 })
    end,
})
Main:CreateButton({
    Name = 'Kill All Nearby (once)',
    Callback = function()
        local root = getRoot()
        local count = 0
        if root then
            for i, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA('Model') and obj ~= getChar() then
                    local hum = obj:FindFirstChildOfClass('Humanoid')
                    local oRoot = obj:FindFirstChild('HumanoidRootPart') or obj.PrimaryPart
                    if hum and oRoot and hum.Health > 0 then
                        if (root.Position - oRoot.Position).Magnitude <= killRange then
                            hum.Health = 0
                            count = count + 1
                        end
                    end
                end
            end
        end
        Rayfield:Notify({ Title = 'Done', Content = 'Killed: ' .. count, Duration = 3 })
    end,
})
Main:CreateSlider({
    Name = 'Walk Speed',
    Range = {16, 150},
    Increment = 2,
    CurrentValue = 16,
    Callback = function(val)
        local c = getChar()
        local h = c and c:FindFirstChildOfClass('Humanoid')
        if h then h.WalkSpeed = val end
    end,
})