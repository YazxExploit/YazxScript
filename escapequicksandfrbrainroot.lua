-- [[ ANTI-KICK BYPASS ]]
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if tostring(method) == "Kick" or tostring(method) == "kick" then return nil end
    return old(self, ...)
end)
setreadonly(mt, true)

-- [[ LOAD UI RAYFIELD ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "YazxExploit - Escape Quicksand for Brainroot 🌊",
   LoadingTitle = "Follow my discord - https://discord.gg/TqmcDwAZV8",
   LoadingSubtitle = "By YazxExploit",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
})

-- Variabel Global
_G.WalkSpeed = 16
_G.AutoUpgrade = false

-- [[ TAB UTAMA: AUTO UPGRADE ]]
local MainTab = Window:CreateTab("Auto Upgrade", 4483362458)
MainTab:CreateSection("Super Fast Upgrade Mode")

MainTab:CreateToggle({
   Name = "Enable Instant Upgrade (Floor 1-3)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoUpgrade = Value
      task.spawn(function()
         local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Bases"):WaitForChild("UpgradeEntity")
         while _G.AutoUpgrade do
            -- Tanpa Delay di dalam loop (Persis teks aslimu agar sangat cepat)
            pcall(function()
               -- Floor 1 (1-10)
               for i = 1, 10 do 
                  if i ~= 8 then Remote:FireServer("Floor1", i) end 
               end
               -- Floor 2 (11-20)
               for i = 11, 20 do 
                  if i ~= 18 then Remote:FireServer("Floor2", i) end 
               end
               -- Floor 3 (21-30)
               for i = 21, 30 do 
                  if i ~= 28 then Remote:FireServer("Floor3", i) end 
               end
            end)
            task.wait() -- Minimal wait agar game tidak hang/crash total
         end
      end)
   end,
})

-- [[ TAB PLAYER: MOVEMENT ]]
local PlayerTab = Window:CreateTab("Movement", 4483362458)

PlayerTab:CreateSlider({
   Name = "WalkSpeed Custom",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      _G.WalkSpeed = Value
      if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- [[ TAB MISC: PROTECTION ]]
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
   Name = "Enable Anti-AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         task.wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({Title = "Anti-AFK", Content = "Aktif!", Duration = 3})
   end,
})

-- LOGIC: MENJAGA SPEED
task.spawn(function()
   while true do
      task.wait(0.5)
      pcall(function()
         local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
         if hum and hum.WalkSpeed ~= _G.WalkSpeed then
            hum.WalkSpeed = _G.WalkSpeed
         end
      end)
   end
end)

Rayfield:Notify({
   Title = "YazxExploit Ready!",
   Content = "Instant Upgrade Mode Activated.",
   Duration = 5,
})
