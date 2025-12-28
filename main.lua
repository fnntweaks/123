-- Game ID Check
if game.PlaceId ~= 104581705420265 then
    warn("⚠️ Wrong game!")
    return
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PSXEScript"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "PSXE Script"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Minimize & Close Buttons
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.TextSize = 24
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Confirmation Dialog
local confirmDialog = Instance.new("Frame")
confirmDialog.Size = UDim2.new(0, 300, 0, 150)
confirmDialog.Position = UDim2.new(0.5, -150, 0.5, -75)
confirmDialog.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
confirmDialog.BorderSizePixel = 0
confirmDialog.Visible = false
confirmDialog.ZIndex = 10
confirmDialog.Parent = mainFrame

local confirmCorner = Instance.new("UICorner")
confirmCorner.CornerRadius = UDim.new(0, 10)
confirmCorner.Parent = confirmDialog

local confirmStroke = Instance.new("UIStroke")
confirmStroke.Color = Color3.fromRGB(170, 0, 0)
confirmStroke.Thickness = 2
confirmStroke.Parent = confirmDialog

local confirmTitle = Instance.new("TextLabel")
confirmTitle.Size = UDim2.new(1, -20, 0, 40)
confirmTitle.Position = UDim2.new(0, 10, 0, 10)
confirmTitle.BackgroundTransparency = 1
confirmTitle.Text = "Are you sure?"
confirmTitle.TextColor3 = Color3.new(1, 1, 1)
confirmTitle.TextSize = 18
confirmTitle.Font = Enum.Font.GothamBold
confirmTitle.ZIndex = 11
confirmTitle.Parent = confirmDialog

local confirmText = Instance.new("TextLabel")
confirmText.Size = UDim2.new(1, -20, 0, 30)
confirmText.Position = UDim2.new(0, 10, 0, 50)
confirmText.BackgroundTransparency = 1
confirmText.Text = "Unload PSXE Script?"
confirmText.TextColor3 = Color3.fromRGB(200, 200, 200)
confirmText.TextSize = 14
confirmText.Font = Enum.Font.Gotham
confirmText.ZIndex = 11
confirmText.Parent = confirmDialog

local yesBtn = Instance.new("TextButton")
yesBtn.Size = UDim2.new(0, 120, 0, 40)
yesBtn.Position = UDim2.new(0, 15, 1, -50)
yesBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
yesBtn.Text = "Yes, Unload"
yesBtn.TextColor3 = Color3.new(1, 1, 1)
yesBtn.TextSize = 16
yesBtn.Font = Enum.Font.GothamBold
yesBtn.ZIndex = 11
yesBtn.Parent = confirmDialog
Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 8)

local noBtn = Instance.new("TextButton")
noBtn.Size = UDim2.new(0, 120, 0, 40)
noBtn.Position = UDim2.new(1, -135, 1, -50)
noBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
noBtn.Text = "No, Go Back"
noBtn.TextColor3 = Color3.new(1, 1, 1)
noBtn.TextSize = 16
noBtn.Font = Enum.Font.GothamBold
noBtn.ZIndex = 11
noBtn.Parent = confirmDialog
Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 8)

-- Tab Container
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 40)
tabContainer.Position = UDim2.new(0, 10, 0, 50)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabContainer

-- Create Tabs
local tabs = {}
local tabButtons = {}
local tabNames = {"Main", "Spawn", "Christmas"}

for i, tabName in ipairs(tabNames) do
    -- Tab Button
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(0.32, 0, 1, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    tabBtn.Text = tabName
    tabBtn.TextColor3 = Color3.new(1, 1, 1)
    tabBtn.TextSize = 16
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.Parent = tabContainer
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)
    
    tabButtons[tabName] = tabBtn
    
    -- Tab Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -110)
    contentFrame.Position = UDim2.new(0, 10, 0, 100)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = (i == 1) -- Show Main tab by default
    contentFrame.Parent = mainFrame
    
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.ScrollBarThickness = 6
    scrollingFrame.Parent = contentFrame
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 12)
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = scrollingFrame
    
    uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 20)
    end)
    
    tabs[tabName] = scrollingFrame
end

-- Function to switch tabs
local function switchTab(tabName)
    for name, frame in pairs(tabs) do
        frame.Parent.Visible = (name == tabName)
    end
    
    for name, btn in pairs(tabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
    end
end

-- Connect tab buttons
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
end

-- Set initial tab
switchTab("Main")

-- === MAIN TAB CONTENT ===
local mainTab = tabs["Main"]

-- TELEPORT TO CHRISTMAS WORLD BUTTON
local toChristmasButton = Instance.new("TextButton")
toChristmasButton.Size = UDim2.new(1, -20, 0, 50)
toChristmasButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toChristmasButton.Text = "TELEPORT TO SPAWN WORLD"
toChristmasButton.TextColor3 = Color3.new(1, 1, 1)
toChristmasButton.TextSize = 18
toChristmasButton.Font = Enum.Font.GothamBold
toChristmasButton.Parent = mainTab

local toChristmasCorner = Instance.new("UICorner")
toChristmasCorner.CornerRadius = UDim.new(0, 10)
toChristmasCorner.Parent = toChristmasButton

-- TELEPORT TO SPAWN WORLD BUTTON
local toSpawnButton = Instance.new("TextButton")
toSpawnButton.Size = UDim2.new(1, -20, 0, 50)
toSpawnButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toSpawnButton.Text = "TELEPORT TO CHRISTMAS WORLD"
toSpawnButton.TextColor3 = Color3.new(1, 1, 1)
toSpawnButton.TextSize = 18
toSpawnButton.Font = Enum.Font.GothamBold
toSpawnButton.Parent = mainTab

local toSpawnCorner = Instance.new("UICorner")
toSpawnCorner.CornerRadius = UDim.new(0, 10)
toSpawnCorner.Parent = toSpawnButton

-- ANTI AFK BUTTON
local antiAfkButton = Instance.new("TextButton")
antiAfkButton.Size = UDim2.new(1, -20, 0, 50)
antiAfkButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
antiAfkButton.Text = "ANTI AFK"
antiAfkButton.TextColor3 = Color3.new(1, 1, 1)
antiAfkButton.TextSize = 18
antiAfkButton.Font = Enum.Font.GothamBold
antiAfkButton.Parent = mainTab

local antiAfkCorner = Instance.new("UICorner")
antiAfkCorner.CornerRadius = UDim.new(0, 10)
antiAfkCorner.Parent = antiAfkButton

local antiAfkStatus = Instance.new("TextLabel")
antiAfkStatus.Size = UDim2.new(1, -20, 0, 30)
antiAfkStatus.BackgroundTransparency = 1
antiAfkStatus.Text = "Anti AFK: Stopped"
antiAfkStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
antiAfkStatus.TextSize = 16
antiAfkStatus.Font = Enum.Font.Gotham
antiAfkStatus.Parent = mainTab

-- AUTO COIN FARM BUTTON
local coinFarmButton = Instance.new("TextButton")
coinFarmButton.Size = UDim2.new(1, -20, 0, 50)
coinFarmButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
coinFarmButton.Text = "AUTO COIN FARM"
coinFarmButton.TextColor3 = Color3.new(1, 1, 1)
coinFarmButton.TextSize = 18
coinFarmButton.Font = Enum.Font.GothamBold
coinFarmButton.Parent = mainTab

local coinFarmCorner = Instance.new("UICorner")
coinFarmCorner.CornerRadius = UDim.new(0, 10)
coinFarmCorner.Parent = coinFarmButton

local coinFarmStatus = Instance.new("TextLabel")
coinFarmStatus.Size = UDim2.new(1, -20, 0, 30)
coinFarmStatus.BackgroundTransparency = 1
coinFarmStatus.Text = "Auto Coin Farm: Stopped"
coinFarmStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
coinFarmStatus.TextSize = 16
coinFarmStatus.Font = Enum.Font.Gotham
coinFarmStatus.Parent = mainTab

-- DROPDOWN FRAME
local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(1, -20, 0, 0)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.ClipsDescendants = true
dropdownFrame.Visible = false
dropdownFrame.Parent = mainTab

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 10)
dropdownCorner.Parent = dropdownFrame

-- Dropdown options
local breakableTypes = {
    {name = "Small", id = "rbxassetid://7041621431", enabled = true},
    {name = "Large", id = "rbxassetid://7041620873", enabled = true},
    {name = "Crate", id = "rbxassetid://13087701699", enabled = true},
    {name = "Present", id = "rbxassetid://13087826929", enabled = true}
}

local dropdownButtons = {}
local dropdownExpanded = false

-- Create dropdown buttons
for i, breakable in ipairs(breakableTypes) do
    local optionButton = Instance.new("TextButton")
    optionButton.Size = UDim2.new(1, -10, 0, 40)
    optionButton.Position = UDim2.new(0, 5, 0, (i - 1) * 45 + 5)
    optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    optionButton.Text = "✓ " .. breakable.name
    optionButton.TextColor3 = Color3.fromRGB(0, 255, 0)
    optionButton.TextSize = 16
    optionButton.Font = Enum.Font.GothamBold
    optionButton.Parent = dropdownFrame
    
    local optionCorner = Instance.new("UICorner")
    optionCorner.CornerRadius = UDim.new(0, 8)
    optionCorner.Parent = optionButton
    
    dropdownButtons[i] = optionButton
    
    optionButton.MouseButton1Click:Connect(function()
        breakable.enabled = not breakable.enabled
        if breakable.enabled then
            optionButton.Text = "✓ " .. breakable.name
            optionButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            optionButton.Text = "✗ " .. breakable.name
            optionButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Dropdown toggle button
local dropdownToggle = Instance.new("TextButton")
dropdownToggle.Size = UDim2.new(1, -20, 0, 40)
dropdownToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
dropdownToggle.Text = "SELECT BREAKABLES ▼"
dropdownToggle.TextColor3 = Color3.new(1, 1, 1)
dropdownToggle.TextSize = 16
dropdownToggle.Font = Enum.Font.GothamBold
dropdownToggle.Parent = mainTab

local dropdownToggleCorner = Instance.new("UICorner")
dropdownToggleCorner.CornerRadius = UDim.new(0, 10)
dropdownToggleCorner.Parent = dropdownToggle

dropdownToggle.MouseButton1Click:Connect(function()
    dropdownExpanded = not dropdownExpanded
    if dropdownExpanded then
        dropdownFrame.Visible = true
        dropdownToggle.Text = "SELECT BREAKABLES ▲"
        TweenService:Create(dropdownFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, #breakableTypes * 45 + 10)}):Play()
    else
        dropdownToggle.Text = "SELECT BREAKABLES ▼"
        local tween = TweenService:Create(dropdownFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function()
            if not dropdownExpanded then
                dropdownFrame.Visible = false
            end
        end)
    end
end)

-- === SPAWN TAB CONTENT ===
local spawnTab = tabs["Spawn"]

-- AUTO REWARDS BUTTON
local rewardsButton = Instance.new("TextButton")
rewardsButton.Size = UDim2.new(1, -20, 0, 50)
rewardsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
rewardsButton.Text = "AUTO REWARDS FARM"
rewardsButton.TextColor3 = Color3.new(1, 1, 1)
rewardsButton.TextSize = 18
rewardsButton.Font = Enum.Font.GothamBold
rewardsButton.Parent = spawnTab

local rewardsCorner = Instance.new("UICorner")
rewardsCorner.CornerRadius = UDim.new(0, 10)
rewardsCorner.Parent = rewardsButton

local rewardsStatus = Instance.new("TextLabel")
rewardsStatus.Size = UDim2.new(1, -20, 0, 30)
rewardsStatus.BackgroundTransparency = 1
rewardsStatus.Text = "Auto Rewards: Stopped"
rewardsStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
rewardsStatus.TextSize = 16
rewardsStatus.Font = Enum.Font.Gotham
rewardsStatus.Parent = spawnTab

-- === CHRISTMAS TAB CONTENT ===
local christmasTab = tabs["Christmas"]

-- AUTO LOOTBAG BUTTON
local lootbagButton = Instance.new("TextButton")
lootbagButton.Size = UDim2.new(1, -20, 0, 50)
lootbagButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
lootbagButton.Text = "AUTO LOOTBAG FARM"
lootbagButton.TextColor3 = Color3.new(1, 1, 1)
lootbagButton.TextSize = 18
lootbagButton.Font = Enum.Font.GothamBold
lootbagButton.Parent = christmasTab

local lootbagCorner = Instance.new("UICorner")
lootbagCorner.CornerRadius = UDim.new(0, 10)
lootbagCorner.Parent = lootbagButton

local lootbagStatus = Instance.new("TextLabel")
lootbagStatus.Size = UDim2.new(1, -20, 0, 30)
lootbagStatus.BackgroundTransparency = 1
lootbagStatus.Text = "Auto Lootbag: Stopped"
lootbagStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
lootbagStatus.TextSize = 16
lootbagStatus.Font = Enum.Font.Gotham
lootbagStatus.Parent = christmasTab

-- === SHARED TELEPORT FUNCTION ===
local function teleportToPart(part)
    if not part or not part:IsA("BasePart") then return end
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
end

-- === AUTO COIN FARM LOGIC (IMPROVED - SCANS EVERY 1 SECOND) ===
local coinFarmRunning = false
local camera = workspace.CurrentCamera
local currentTargetCoin = nil
local coinFarmConnection

-- Function to get enabled mesh IDs from dropdown
local function getEnabledMeshIds()
    local enabledIds = {}
    for _, breakable in ipairs(breakableTypes) do
        if breakable.enabled then
            table.insert(enabledIds, breakable.id)
        end
    end
    return enabledIds
end

-- Function to check if a mesh ID is in the enabled list
local function isTargetMesh(meshId)
    local enabledIds = getEnabledMeshIds()
    for _, targetId in ipairs(enabledIds) do
        if meshId == targetId then
            return true
        end
    end
    return false
end

-- Function to check if a coin has a target mesh
local function hasTargetMesh(coin)
    if coin:IsA("MeshPart") and coin.MeshId then
        if isTargetMesh(coin.MeshId) then
            return true
        end
    end
    
    local mesh = coin:FindFirstChildOfClass("SpecialMesh")
    if mesh and mesh.MeshId then
        if isTargetMesh(mesh.MeshId) then
            return true
        end
    end
    
    for _, descendant in ipairs(coin:GetDescendants()) do
        if descendant:IsA("SpecialMesh") and descendant.MeshId then
            if isTargetMesh(descendant.MeshId) then
                return true
            end
        elseif descendant:IsA("MeshPart") and descendant.MeshId then
            if isTargetMesh(descendant.MeshId) then
                return true
            end
        end
    end
    
    return false
end

-- Function to click center screen
local function clickCenterScreen()
    local screenSize = camera.ViewportSize
    local centerX = screenSize.X / 2
    local centerY = screenSize.Y / 2
    
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
    wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
end

-- Get the coins folder
local coinsFolder = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Coins")

-- Function to check if a coin has diamond particles (priority)
local function hasDiamondParticles(coin)
    return coin:FindFirstChild("SpecialBonusParticleDiamonds") ~= nil
end

-- Function to get closest available coin
local function getClosestCoin()
    if not coinsFolder then
        coinsFolder = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Coins")
        if not coinsFolder then return nil end
    end
    
    local character = player.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local closestCoin = nil
    local closestDistance = math.huge
    local diamondCoin = nil
    local diamondDistance = math.huge
    
    for _, coinFolder in pairs(coinsFolder:GetChildren()) do
        local coin = coinFolder:FindFirstChild("Coin")
        if coin and hasTargetMesh(coin) then
            local coinPos = coin:IsA("BasePart") and coin.Position or (coin.PrimaryPart and coin.PrimaryPart.Position)
            if coinPos then
                local distance = (hrp.Position - coinPos).Magnitude
                
                -- Prioritize diamond coins
                if hasDiamondParticles(coin) then
                    if distance < diamondDistance then
                        diamondCoin = coin
                        diamondDistance = distance
                    end
                else
                    if distance < closestDistance then
                        closestCoin = coin
                        closestDistance = distance
                    end
                end
            end
        end
    end
    
    -- Return diamond coin if found, otherwise return closest normal coin
    return diamondCoin or closestCoin
end

-- Function to get total coin count
local function getTotalCoinCount()
    if not coinsFolder then
        coinsFolder = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Coins")
        if not coinsFolder then return 0, 0 end
    end
    
    local diamondCount = 0
    local normalCount = 0
    
    for _, coinFolder in pairs(coinsFolder:GetChildren()) do
        local coin = coinFolder:FindFirstChild("Coin")
        if coin and hasTargetMesh(coin) then
            if hasDiamondParticles(coin) then
                diamondCount = diamondCount + 1
            else
                normalCount = normalCount + 1
            end
        end
    end
    
    return diamondCount, normalCount
end

local function startCoinFarm()
    if coinFarmRunning then return end
    
    -- Check if at least one breakable is selected
    local enabledIds = getEnabledMeshIds()
    if #enabledIds == 0 then
        coinFarmStatus.Text = "Auto Coin Farm: No breakables selected!"
        return
    end
    
    coinFarmRunning = true
    coinFarmButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    coinFarmStatus.Text = "Auto Coin Farm: Running"
    currentTargetCoin = nil
    
    -- Continuous clicking loop (every 0.5 seconds)
    task.spawn(function()
        while coinFarmRunning do
            clickCenterScreen()
            wait(0.5)
        end
    end)
    
    -- Main loop that constantly scans for coins
    coinFarmConnection = task.spawn(function()
        while coinFarmRunning do
            -- Update coin count for display
            local diamondCount, normalCount = getTotalCoinCount()
            
            -- Show which types are being farmed
            local enabledNames = {}
            for _, breakable in ipairs(breakableTypes) do
                if breakable.enabled then
                    table.insert(enabledNames, breakable.name)
                end
            end
            local typesList = table.concat(enabledNames, ", ")
            
            if diamondCount + normalCount == 0 then
                coinFarmStatus.Text = "Auto Coin Farm: No coins (" .. typesList .. ")"
            else
                coinFarmStatus.Text = "💎 " .. diamondCount .. " diamonds | " .. normalCount .. " normal"
            end
            
            -- Check if current target is still valid
            if currentTargetCoin and (not currentTargetCoin.Parent or not hasTargetMesh(currentTargetCoin)) then
                currentTargetCoin = nil
                print("✅ Coin collected! Scanning for next...")
            end
            
            -- If no current target, find a new one
            if not currentTargetCoin then
                currentTargetCoin = getClosestCoin()
                
                if currentTargetCoin then
                    local character = player.Character
                    if character then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            print("🎯 New target found! Teleporting...")
                            
                            -- Teleport to coin
                            if currentTargetCoin:IsA("BasePart") then
                                humanoidRootPart.CFrame = currentTargetCoin.CFrame
                            elseif currentTargetCoin:IsA("Model") and currentTargetCoin.PrimaryPart then
                                humanoidRootPart.CFrame = currentTargetCoin.PrimaryPart.CFrame
                            elseif currentTargetCoin:FindFirstChildWhichIsA("BasePart") then
                                local part = currentTargetCoin:FindFirstChildWhichIsA("BasePart")
                                humanoidRootPart.CFrame = part.CFrame
                            end
                        end
                    end
                end
            end
            
            -- Scan every 1 second
            wait(1)
        end
    end)
end

local function stopCoinFarm()
    coinFarmRunning = false
    coinFarmButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    coinFarmStatus.Text = "Auto Coin Farm: Stopped"
    currentTargetCoin = nil
    
    if coinFarmConnection then
        task.cancel(coinFarmConnection)
        coinFarmConnection = nil
    end
end

coinFarmButton.MouseButton1Click:Connect(function()
    if coinFarmRunning then
        stopCoinFarm()
    else
        startCoinFarm()
    end
end)

-- === LOOTBAG FARM LOGIC ===
local lootbagFolder = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Lootbags")
local lootbagRunning = false
local lootbagConnection

local function startLootbagFarm()
    if lootbagRunning then return end
    lootbagRunning = true
    lootbagButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    lootbagStatus.Text = "Auto Lootbag: Running"

    lootbagConnection = RunService.Heartbeat:Connect(function()
        if not lootbagRunning then return end
        
        if not lootbagFolder or not lootbagFolder.Parent then
            lootbagFolder = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Lootbags")
        end
        
        if lootbagFolder then
            local lootbags = lootbagFolder:GetChildren()
            if #lootbags > 0 then
                for _, bag in ipairs(lootbags) do
                    if not lootbagRunning then break end
                    if bag and bag:IsA("BasePart") then
                        teleportToPart(bag)
                        task.wait(2)
                    end
                end
            end
        end
    end)
end

local function stopLootbagFarm()
    lootbagRunning = false
    lootbagButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    if lootbagConnection then
        lootbagConnection:Disconnect()
    end
    lootbagStatus.Text = "Auto Lootbag: Stopped"
end

lootbagButton.MouseButton1Click:Connect(function()
    if lootbagRunning then
        stopLootbagFarm()
    else
        startLootbagFarm()
    end
end)

-- === AUTO REWARDS FARM LOGIC ===
local rewardsRunning = false
local rewardsConnection
local freePad1, freePad2, vipPad, rankPad

local function findRewardPads()
    local interactiveFolder = Workspace:FindFirstChild("__MAP") and Workspace.__MAP:FindFirstChild("Interactive")
    if not interactiveFolder then 
        warn("Interactive folder not found!")
        return false
    end
    
    local children = interactiveFolder:GetChildren()
    if children[22] then
        freePad1 = children[22]:FindFirstChild("Pad")
    end
    
    local freeRewards = interactiveFolder:FindFirstChild("Free Rewards")
    if freeRewards then
        freePad2 = freeRewards:FindFirstChild("Pad")
    end
    
    local vipRewards = interactiveFolder:FindFirstChild("VIP Rewards")
    if vipRewards then
        vipPad = vipRewards:FindFirstChild("Pad")
    end
    
    local rankRewards = interactiveFolder:FindFirstChild("Rank Rewards")
    if rankRewards then
        rankPad = rankRewards:FindFirstChild("Pad")
    end
    
    return true
end

local FREE_PAD_INTERVAL = 602
local VIP_PAD_INTERVAL = 14400
local RANK_PAD_INTERVAL = 28800

local lastFreePadTime = 0
local lastVipPadTime = 0
local lastRankPadTime = 0

local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if hours > 0 then
        return string.format("%dh %dm %ds", hours, mins, secs)
    elseif mins > 0 then
        return string.format("%dm %ds", mins, secs)
    else
        return string.format("%ds", secs)
    end
end

local function updateRewardsStatus()
    if not rewardsRunning then return end
    
    local currentTime = tick()
    local nextFree = FREE_PAD_INTERVAL - (currentTime - lastFreePadTime)
    local nextVip = VIP_PAD_INTERVAL - (currentTime - lastVipPadTime)
    local nextRank = RANK_PAD_INTERVAL - (currentTime - lastRankPadTime)
    
    if nextFree < 0 then nextFree = 0 end
    if nextVip < 0 then nextVip = 0 end
    if nextRank < 0 then nextRank = 0 end
    
    rewardsStatus.Text = string.format("Free: %s | VIP: %s | Rank: %s", formatTime(nextFree), formatTime(nextVip), formatTime(nextRank))
end

local function teleportToSpawn()
    local playerSpawns = Workspace:FindFirstChild("__MAP") and Workspace.__MAP:FindFirstChild("PlayerSpawns")
    if playerSpawns then
        local spawns = playerSpawns:GetChildren()
        if spawns[6] then
            teleportToPart(spawns[6])
        end
    end
end

local function startRewardsFarm()
    if rewardsRunning then return end
    
    if not findRewardPads() then
        warn("Failed to find reward pads!")
        return
    end
    
    rewardsRunning = true
    rewardsButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    rewardsStatus.Text = "Auto Rewards: Initializing..."
    
    task.spawn(function()
        if freePad1 then
            teleportToPart(freePad1)
            task.wait(2)
        end
        if freePad2 then
            teleportToPart(freePad2)
            task.wait(2)
        end
        if vipPad then
            teleportToPart(vipPad)
            task.wait(2)
        end
        if rankPad then
            teleportToPart(rankPad)
            task.wait(2)
        end
        teleportToSpawn()
        
        rewardsStatus.Text = "Auto Rewards: Running"
    end)
    
    lastFreePadTime = tick()
    lastVipPadTime = tick()
    lastRankPadTime = tick()
    
    rewardsConnection = RunService.Heartbeat:Connect(function()
        if not rewardsRunning then return end
        
        local currentTime = tick()
        
        if currentTime - lastFreePadTime >= FREE_PAD_INTERVAL then
            if freePad1 then
                teleportToPart(freePad1)
                task.wait(3)
            end
            if freePad2 then
                teleportToPart(freePad2)
                task.wait(2)
            end
            teleportToSpawn()
            lastFreePadTime = currentTime
        end
        
        if currentTime - lastVipPadTime >= VIP_PAD_INTERVAL then
            if vipPad then
                teleportToPart(vipPad)
                task.wait(2)
            end
            teleportToSpawn()
            lastVipPadTime = currentTime
        end
        
        if currentTime - lastRankPadTime >= RANK_PAD_INTERVAL then
            if rankPad then
                teleportToPart(rankPad)
                task.wait(2)
            end
            teleportToSpawn()
            lastRankPadTime = currentTime
        end
        
        updateRewardsStatus()
    end)
end

local function stopRewardsFarm()
    rewardsRunning = false
    rewardsButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    if rewardsConnection then
        rewardsConnection:Disconnect()
    end
    rewardsStatus.Text = "Auto Rewards: Stopped"
end

rewardsButton.MouseButton1Click:Connect(function()
    if rewardsRunning then
        stopRewardsFarm()
    else
        startRewardsFarm()
    end
end)

-- === WORLD TELEPORT FUNCTIONS ===
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function findCannonByName(name)
    local cannonsFolder = Workspace:FindFirstChild("__MAP") and Workspace.__MAP:FindFirstChild("Cannons")
    if not cannonsFolder then return nil end
    
    for _, cannon in ipairs(cannonsFolder:GetChildren()) do
        if cannon.Name == name then
            return cannon
        end
    end
    return nil
end

toChristmasButton.MouseButton1Click:Connect(function()
    local spawnCannon = findCannonByName("Spawn")
    if spawnCannon then
        teleportToPart(spawnCannon)
        task.wait(0.5)
        pressKey(Enum.KeyCode.E)
    else
        warn("Spawn cannon not found!")
    end
end)

toSpawnButton.MouseButton1Click:Connect(function()
    local christmasCannon = findCannonByName("Christmas")
    if christmasCannon then
        teleportToPart(christmasCannon)
        task.wait(1.5)
        pressKey(Enum.KeyCode.E)
    else
        warn("Christmas cannon not found!")
    end
end)

-- === ANTI AFK LOGIC ===
local antiAfkRunning = false
local antiAfkConnection

local function startAntiAfk()
    if antiAfkRunning then return end
    antiAfkRunning = true
    antiAfkButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    antiAfkStatus.Text = "Anti AFK: Jumping"
    
    antiAfkConnection = task.spawn(function()
        while antiAfkRunning do
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    if humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and 
                       humanoid:GetState() ~= Enum.HumanoidStateType.Flying then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
    
    print("🔄 Anti-AFK: Constant jumping enabled")
end

local function stopAntiAfk()
    antiAfkRunning = false
    antiAfkButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    antiAfkStatus.Text = "Anti AFK: Stopped"
    
    if antiAfkConnection then
        task.cancel(antiAfkConnection)
        antiAfkConnection = nil
    end
end

antiAfkButton.MouseButton1Click:Connect(function()
    if antiAfkRunning then
        stopAntiAfk()
    else
        startAntiAfk()
    end
end)

-- === DRAGGABLE FRAME ===
local dragging = false
local mousePos, framePos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

-- === MENU TOGGLE ===
local menuOpen = false
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        menuOpen = not menuOpen
        mainFrame.Visible = menuOpen
    end
end)

-- === MINIMIZE & CLOSE ===
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    minimizeBtn.Text = minimized and "+" or "–"
    TweenService:Create(mainFrame, TweenInfo.new(0.4), {Size = minimized and UDim2.new(0, 400, 0, 40) or UDim2.new(0, 400, 0, 500)}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    confirmDialog.Visible = true
end)

yesBtn.MouseButton1Click:Connect(function()
    if lootbagRunning then
        stopLootbagFarm()
    end
    if rewardsRunning then
        stopRewardsFarm()
    end
    if antiAfkRunning then
        stopAntiAfk()
    end
    if coinFarmRunning then
        stopCoinFarm()
    end
    
    screenGui:Destroy()
    print("PSXE Script unloaded successfully!")
end)

noBtn.MouseButton1Click:Connect(function()
    confirmDialog.Visible = false
end)
