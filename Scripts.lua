https://raw.githubusercontent.com/ShaanDaBest/AeroHub/refs/heads/main/Hub'

local Window = OrionLib:MakeWindow({Name = "AeroHub", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local playerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = MovementTab:AddSection({
	Name = "Movement"
})
