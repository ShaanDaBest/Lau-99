local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Aero",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Aero Interface",
   LoadingSubtitle = "by Shaan",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "q", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "AeroKey",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "AeroKeySystem", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, 
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"AeoTester","AeroDev","AeroOwner"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local PlayerTab = Window:CreateTab("Player", 4483362458) -- Title, Image

local Section = PlayerTab:CreateSection("Movement")

local PlayerSlider = Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 100},
    Increment = 1,
    Suffix = "WS",
    CurrentValue = 16,
    Flag = "WSslider",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChild("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end,
})

local BringTab = Window:CreateTab("Bring", 4483362458) -- Title, Image

local Section = BringTab:CreateSection("To campfire")

local selected = {}

BringTab:CreateDropdown({
	Name = "Select fuel",
	Options = {"Logs", "Coal"},
	CurrentOption = {"--"},
	MultipleOptions = true,
	Flag = "BringFuel",
	Callback = function(options)
		selected = options
		print("Saved selection:", table.concat(options, ", "))
	end,
})

-- Function that brings a fuel type to the campfire
local function bringFuel(fuelName)
	local fire = workspace.map.campground:FindFirstChild("MainFire")
	local folder = workspace.Items:FindFirstChild(fuelName:lower())
	if not (fire and folder) then
		warn("Couldn't find campfire or folder for: " .. fuelName)
		return
	end

	local firePos = fire.PrimaryPart and fire.PrimaryPart.Position or fire.Position
	for _, item in ipairs(folder:GetChildren()) do
		local pos = firePos + Vector3.new(math.random(-2,2), 5, math.random(-2,2))
		if item:IsA("Model") and item.PrimaryPart then
			item:SetPrimaryPartCFrame(CFrame.new(pos))
		elseif item:IsA("BasePart") then
			item.CFrame = CFrame.new(pos)
		end
	end
	print(fuelName .. " brought to campfire!")
end

-- Input box where the player types a fuel name
BringTab:CreateInput({
	Name = "Enter fuel name to bring",
	PlaceholderText = "e.g. Logs or Coal",
	RemoveTextAfterFocusLost = false,
	Callback = function(ToFire)
		bringFuel(ToFire)
	end,
})


