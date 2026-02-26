-- LOAD UI
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Yazx Hub 🔥",
   LoadingTitle = "Wait....",
   LoadingSubtitle = "YazxExploit",
   ConfigurationSaving = {Enabled = false}
})

local Main = Window:CreateTab("Main", 4483362458)
local ESP = Window:CreateTab("ESP", 4483362458)
local Misc = Window:CreateTab("Misc", 4483362458)

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- FUNCTIONS
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    return getChar():WaitForChild("HumanoidRootPart")
end

local function getHumanoid()
    return getChar():WaitForChild("Humanoid")
end

-- ================= FLOAT =================
local floatParts = {}
local floating = false
local partCount = 1
local maxHeight = 10
local startY = 0

local function createParts()
    for _,p in pairs(floatParts) do if p then p:Destroy() end end
    floatParts = {}

    for i = 1, partCount do
        local part = Instance.new("Part")
        part.Size = Vector3.new(5,1,5)
        part.Anchored = true
        part.CanCollide = true
        part.Transparency = 0.3
        part.Color = Color3.fromRGB(0,170,255)
        part.Parent = workspace
        table.insert(floatParts, part)
    end
end

-- ================= SPEED =================
local speedEnabled = false
local speedValue = 16

-- ================= RGB =================
local rgb = false
RunService.RenderStepped:Connect(function()
    if rgb then
        for _,v in pairs(getChar():GetDescendants()) do
            if v:IsA("BasePart") then
                v.Color = Color3.fromHSV(tick()%5/5,1,1)
            end
        end
    end
end)

-- ================= ESP PLAYER =================
local espEnabled = false
local espObjects = {}

local function createESP(p)
    if p == player then return end

    local function apply(char)
        if not espEnabled then return end

        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(255,0,0)
        highlight.FillTransparency = 0.5
        highlight.Parent = char

        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0,100,0,40)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0,3,0)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Parent = billboard

        billboard.Parent = char:WaitForChild("Head")

        RunService.RenderStepped:Connect(function()
            if char and char:FindFirstChild("HumanoidRootPart") then
                local dist = (getHRP().Position - char.HumanoidRootPart.Position).Magnitude
                label.Text = p.Name.." ["..math.floor(dist).."]"
            end
        end)

        espObjects[p] = {highlight, billboard}
    end

    if p.Character then apply(p.Character) end
    p.CharacterAdded:Connect(apply)
end

local function clearESP()
    for _,v in pairs(espObjects) do
        for _,o in pairs(v) do
            if o then o:Destroy() end
        end
    end
    espObjects = {}
end

for _,p in pairs(game.Players:GetPlayers()) do createESP(p) end
game.Players.PlayerAdded:Connect(createESP)

-- ================= NOCLIP =================
local noclip = false
RunService.Stepped:Connect(function()
    if noclip then
        for _,v in pairs(getChar():GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- ================= ZIGZAG =================
local zigzag = false
local zigWidth = 10
local t = 0

RunService.RenderStepped:Connect(function(dt)
    if zigzag then
        t += dt * 5
        local hrp = getHRP()
        hrp.CFrame = hrp.CFrame + hrp.CFrame.RightVector * math.sin(t) * zigWidth * dt
    end
end)

-- ================= AUTO AMBIL =================
local autoInteract = false
local interactDistance = 20
local lastFire = 0

RunService.RenderStepped:Connect(function()
    if not autoInteract then return end
    if tick() - lastFire < 0.1 then return end

    local hrp = getHRP()
    local closestPrompt = nil
    local closestDist = interactDistance

    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then

            local part = prompt.Parent:IsA("BasePart") and prompt.Parent 
                or prompt.Parent:FindFirstChildWhichIsA("BasePart")

            if part then
                local dist = (hrp.Position - part.Position).Magnitude

                if dist < closestDist then
                    closestDist = dist
                    closestPrompt = prompt
                end
            end
        end
    end

    if closestPrompt then
        closestPrompt.HoldDuration = 0
        closestPrompt.RequiresLineOfSight = false
        closestPrompt.MaxActivationDistance = 25

        for i = 1,3 do
            fireproximityprompt(closestPrompt)
        end

        lastFire = tick()
    end
end)

-- ================= MAIN LOOP =================
RunService.RenderStepped:Connect(function()
    if floating and #floatParts > 0 then
        local hrp = getHRP()
        local pos = hrp.Position
        local limitedY = math.clamp(pos.Y, startY, startY + maxHeight)

        for i, part in pairs(floatParts) do
            part.Position = Vector3.new(pos.X, (limitedY - 3) - ((i-1)*1.2), pos.Z)
        end
    end

    if speedEnabled then
        getHumanoid().WalkSpeed = speedValue
    end
end)

-- ================= UI =================

Main:CreateToggle({Name="Float",Callback=function(v)
    floating=v
    if v then
        startY = getHRP().Position.Y
        createParts()
    else
        for _,p in pairs(floatParts) do if p then p:Destroy() end end
        floatParts = {}
    end
end})

Main:CreateSlider({Name="Jumlah Part",Range={1,30},Increment=1,CurrentValue=1,Callback=function(v)
    partCount=v
    if floating then createParts() end
end})

Main:CreateToggle({Name="Speed",Callback=function(v) speedEnabled=v end})
Main:CreateSlider({Name="Speed Value",Range={1,500},Increment=1,CurrentValue=16,Callback=function(v) speedValue=v end})

Main:CreateToggle({Name="Auto Ambil",Callback=function(v) autoInteract=v end})

ESP:CreateToggle({Name="ESP Player",Callback=function(v)
    espEnabled=v
    if not v then clearESP() else for _,p in pairs(game.Players:GetPlayers()) do createESP(p) end end
end})

Misc:CreateToggle({Name="Noclip",Callback=function(v) noclip=v end})
Misc:CreateToggle({Name="ZigZag",Callback=function(v) zigzag=v end})
Misc:CreateSlider({Name="ZigZag Width",Range={1,100},Increment=1,CurrentValue=10,Callback=function(v) zigWidth=v end})
Misc:CreateToggle({Name="RGB Character",Callback=function(v) rgb=v end})
