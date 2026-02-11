local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YazxExploit - FISCH",
   LoadingTitle = "YazxExploit Loading...",
   LoadingSubtitle = "by Yazx",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- ==========================================
-- TAB STANDAR (Speed, Jump, dll)
-- ==========================================
local StandarTab = Window:CreateTab("Standar", 4483362458)

StandarTab:CreateSlider({
   Name = "Speed (Kecepatan)",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

StandarTab:CreateToggle({
   Name = "Jump Infinity",
   CurrentValue = false,
   Callback = function(Value)
       _G.JumpInf = Value
       game:GetService("UserInputService").JumpRequest:Connect(function()
           if _G.JumpInf then
               game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
           end
       end)
   end,
})

-- ==========================================
-- TAB AUTO (Auto Sell, Quest, Event)
-- ==========================================
local AutoTab = Window:CreateTab("Auto", 4483362458)

AutoTab:CreateToggle({
   Name = "Auto Sell All Fish",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoSell = Value
       while _G.AutoSell do
           task.wait(5)
           game:GetService("ReplicatedStorage").events.sell_all:FireServer()
       end
   end,
})

AutoTab:CreateButton({
    Name = "Auto Quest Rod",
    Callback = function()
        game:GetService("ReplicatedStorage").events.Quest:FireServer("Claim")
    end,
})

-- ==========================================
-- TAB MANCING (Catch, Full Bar, dll)
-- ==========================================
local MancingTab = Window:CreateTab("Mancing", 4483362458)

MancingTab:CreateToggle({
   Name = "Auto Cast (Lempar)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoCast = Value
       while _G.AutoCast do
           task.wait(1)
           local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
           if tool then tool.Click:FireServer() end
       end
   end,
})

MancingTab:CreateButton({
    Name = "Instant Full Bar",
    Callback = function()
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Events") then
            tool.Events.Cast:FireServer(100)
        end
    end,
})

MancingTab:CreateButton({
    Name = "Instant Catch",
    Callback = function()
        game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, true)
    end,
})

-- ==========================================
-- TAB LAINNYA (Shop, Water Walk, Oxygen)
-- ==========================================
local LainTab = Window:CreateTab("Lainnya", 4483362458)

LainTab:CreateToggle({
   Name = "Infinite Oxygen",
   CurrentValue = false,
   Callback = function(Value)
       _G.InfOxygen = Value
       while _G.InfOxygen do
           task.wait(1)
           if game.Players.LocalPlayer.Character:FindFirstChild("Oxygen") then
               game.Players.LocalPlayer.Character.Oxygen.Value = 100
           end
       end
   end,
})

LainTab:CreateToggle({
   Name = "Water Walk",
   CurrentValue = false,
   Callback = function(Value)
       _G.WaterWalk = Value
   end,
})

LainTab:CreateDropdown({
   Name = "Beli Pancingan",
   Options = {"Flimsy Rod", "Carbon Rod", "Lucky Rod", "Magma Rod"},
   CurrentOption = {"Flimsy Rod"},
   Callback = function(Option)
      game:GetService("ReplicatedStorage").events.purchase:FireServer(Option[1], "Rods")
   end,
})

Rayfield:Notify({
   Title = "YazxExploit - FISCH",
   Content = "Script Loaded Successfully!",
   Duration = 5,
})
