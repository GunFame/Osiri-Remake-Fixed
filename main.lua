-- Osiri remake: source-preserving GUI build. Not tested in Roblox.
local originalOK, originalError = xpcall(function()
-- Experimental source repair. Not tested inside Roblox.
--[[
   Script Description
   This is not real osiris.cc this is a remake that uses the same source as them [ ALMOST ]
   I would recommend using this because 60$ for a script thats barley good is insane
   Good features auto resolver that hits shots and resolves good auto prediction and good gunfov
   Some of the features are fake like AirShotSmooth and stickness [ mostly features that isnt being used alot ]
   Some features arent included in osiris so i decided to add some of custom features that would make osiris better
   Its also really buggy so yea enjoy
--]]



-- Under is the instruction from original osiris.cc felt like adding it why not so you know how it works

--[[
    READ THIS BEFORE EXECUTING FOR THE FIRST TIME
    - EVERYTIME THERE IS AN UPDATE YOU WILL LIKELY HAVE TO ADD NEW SETTINGS TO YOUR CONFIG SO MAKE SURE TO CHECK THE DISCORD FOR UPDATES

    • 2 Keybinds must not be the same even if the feature they're associated with is disabled
    • You must not unbind any keybinds even if the feature they're associated with is disabled
    • If you want to visualize what your Regular Silent is doing, set RegularModeVisualizer to true
    • BoxFOV ONLY works with Target Silent **UNLESS** you set RegularModeVisualizer to true and use Regular Silent
    • Triggerbot as of right now ONLY works with Target Silent
--]]

script_key=""; -- you dont need to add anything here

getgenv().Silent = {
    Enabled = true,
    Mode = "FOV", -- "FOV" or "Target"
    ModeType = "Safe", -- Safe, Unlegit
    Mode2 = true,
    HitMode = "ClosestPoint", -- ClosestPoint / ClosestBodypart (ClosestPoint is more legit)
    Prediction = 0.127271,
    AutoPrediction = true, -- If true, prediction will be automatically set based on your ping using PredefinedPredictions
    RegularModeVisualizer = false, -- This will the place where silent aim will hit.

}

getgenv().Camlock = {
    Enabled = true,
    SafetyMeasures = true, -- If true, camlock will not work if you are in thirdperson without shiftlock
    Prediction = 0.13,
    Stickness = 0.135,
	UseTarget = true, -- If true, camlock will be synced with whoever you are targeting and will immediately follow them (recommnded for target silent)
    Parts = {"Head", "UpperTorso", "LowerTorso"},
	Activation = { -- Activation method is convenient if you're using Regular Silent
        Mode = "Keybind", -- Mouse, Keybind 
        Type = "Toggle", -- Hold, Toggle
        Keybind = "X",
        MouseButton = "RightButton" -- You have to right click to use camlock
    },
	FOV = 1000,
	Smoothness = 0.0208165, -- How smooth the camera will move
    AirShot = true,
    AirShotSmooth = 0.02465, 
	ShakeValue = { -- Reference: https://t4.ftcdn.net/jpg/05/12/86/27/360_F_512862789_abYbb2RPLzpN8aAjteTBb4xGnRgqVSyw.jpg
        Enabled = false,
        X = 5, -- How much the camera will shake on the X axis
        Y = 5, -- How much the camera will shake on the Y axis
        Z = 5, -- How much the camera will shake on the Z axis
    },
    EasingStyle = "Exponential",
    --[[
        Linear, Sine, Back, Quad, Quar, Quint, Bounce, Elastic, Exponential, Circular, Cubic ( https://create.roblox.com/docs/reference/engine/enums/EasingStyle )
    ]]--
}

getgenv().SafetyMeasures = { 
	NoFloorShots = true, -- Prevents you from hitting ground shot
	AntiCurve = {
        Enabled = false,
        X = 80, -- If the player position is X pixels away from the X axis, it will not redirect the shots
        Y = 80, -- If the player position is Y pixels away from the Y axis, it will not redirect the shots
        PrintDistance = true -- If true, it will print the distance between the player and the X and Y axis, this is useful for finding the perfect values for X and Y for you
    },
    OverrideYAxis = true -- will override your y axis meaning VERY LEGIT!
}

getgenv().Prediction_Points = { -- Ensures that you ONLY hit realistic prediction points
    Power = 7.75 -- Lowest is 1 (most realistic and harder to hit)
}

getgenv().FovSettings = {
    Visible = false,
	Thickness = 0.2,
	NumSides = 50,
    Radius = 20,
	Filled = true,
    Color = Color3.fromRGB(0, 0, 0),

	BoxFOV = {
        Visible = false,
        Thickness = 2,
        Height = 2,
        Width = 2,
        Color = Color3.fromRGB(255, 0, 0)
    }
}

getgenv().Tracer = { -- basically aimassist fov settings
	Visible = false,
	Thickness = 0.5,
	Color = Color3.fromRGB(0, 0, 0),
}

getgenv().Ranges = {
    LongDistance = 65,
    MediumDistance = 35,
    ShortDistance = 15
}

getgenv().Macro = {
	Enabled = true,
	Mode = "Toggle", -- Hold, Toggle
	Type = "First", --// "First", "Third"
	BypassMacroAbuse = true,
	NoClipMacro = true,
	Delay = 0.01
}

getgenv().Checks = {
    Wall = true,
    Visible = true,
    ForceField = true,
    Team = true,
    Alive = true,
    Friend = false,
    Crew = false
}

getgenv().Guns = { -- too lazy to add this
    FOVS = {
        -- {ShortDistanceFOV, MediumDistanceFOV, LongDistanceFOV}
        Revolver = {4, 3, 2.75},
        DoubleBarrel = {6.25, 5, 4.5},
        Shotgun = {6.5, 6, 5.75},
        TacticalShotgun = {6.5, 6, 5.75},
        SMG = {1, 1, 1},
        Silencer = {1, 1, 1},
        AssaultRifle = {1, 1, 1},
        Others = {1, 1, 1}
    }
}

getgenv().Hitchances = { -- Higher the number, higher the chance of hitting MAX IS 100
    Ground = {
        Revolver = 100,
        DoubleBarrel = 100,
        Shotgun = 100,
        TacticalShotgun = 100,
        SMG = 100,
        Silencer = 100,
        AssaultRifle = 100,
        Others = 100
    },
    Air = {
        Revolver = 100,
        DoubleBarrel = 100,
        Shotgun = 100,
        TacticalShotgun = 100,
        SMG = 100,
        Silencer = 100,
        AssaultRifle = 100,
        Others = 100
    }
}

getgenv().Resolver = {
    Enabled = true, 
    Type = "Osiris", -- Roblox, Osiris ( Automatically will set to "Osiris" when anti aim is detected. )
}

getgenv().Misc = {
    HideVisualsOnStart = true, -- Will hide visuals upon execution [ Doesn't work ]
    Raid_Awareness = true, -- [ Doesn't work ]
	FPSBoost = false, -- [ uwp optimize ]
    RemoveSeats = false,
    AntiFling = false
}

getgenv().Keybinds = {
	NormalSilToggle = "C",
	Anti_Lock = "V",
    Triggerbot = "B",
	Raid_Awareness = "T", -- [ Doesn't work ]
    HideVisuals = "M",
	Macro = "X",
	NoClipMacro = "N",
	OverrideYAxisToggle = "J"
}

getgenv().Anti_Lock = {
	Enabled = false,
	Type = "Sides", -- NormalDS, PredictionDisabler, Sides
	Mode = "Toggle"
}

getgenv().TriggerBot = {
    Enabled = false,
	FOV = {
        Visible = false,
        Thickness = 0.5,
        NumSides = 50,
        Radius = 2.25,
        Filled = false,
        Transparency = 0.2,
        Color = Color3.fromRGB(0, 0, 0)
    },
    Parts = {"Head", "UpperTorso", "LowerTorso"},
    MinDelay = 0.001,
    MaxDelay = 0.001,
    ModeType = "Unlegit",
    BoxSync = true,
    Mode = "Hold"
}

getgenv().MemSpoofer = {
    Enabled = false,
    MinMemory = 940,
    MaxMemory = 942,
    MaxDelay = 1.5,
    MinDelay = 1
}

getgenv().PredefinedPredictions = {  -- THIS WILL ONLY WORK IF YOU HAVE AUTOPREDICTION ON
	Ping30_40 = 0.121,
	Ping40_50 = 0.12354923,
	Ping50_60 = 0.12585,
	Ping60_70 = 0.1321687,
	Ping70_80 = 0.1351382,
	Ping80_90 = 0.1412591,
	Ping90_100 = 0.143902,
	Ping100_110 = 0.14518932,
	Ping110_120 = 0.14981296,
	Ping120_130 = 0.15442,
	Ping130_140 = 0.1579289,
}

getgenv().Chat = {
    Enabled = false,
    Settings = {
        Prediction = "/e pred", -- number example: /e pred 0.125
        AutoPrediction = "/e autopred", -- true or false example: /e autopred true
        Antilock = "/e antilock", -- true or false example: /e antilock true
        AntiLockMode = "/e antilockmode" -- NormalDS or PredictionDisabler example: /e antilockmode NormalDS
    }
}



getgenv().HitParts = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
getgenv().FOV = getgenv().FovSettings
getgenv().FakeSpike = {Enabled=false, RealSpike=false, LagAmmount=0, FakeSpikeAmmount=1}
getgenv().Keybinds.FakeSpike = "P"
getgenv().Keybinds.Panic = "F8"
getgenv().Keybinds.Unload = "F9"
getgenv().SafetyMeasures.PanicBindEnabled = false
getgenv().SafetyMeasures.UnloadBindEnabled = false
getgenv().FovSettings.Type = "Static"
getgenv().FovSettings.DynamicRadius = 20
getgenv().FovSettings.Deadzone = {Radius=0, Visible=false, Filled=false}
getgenv().UniversalSettings = {FFAMode=false, CursorOffset={Enabled=false, X=0, Y=0}}
getgenv().HitChance = {AutoReload=false}
getgenv().Camlock.Deadzone = false
getgenv().Camlock.ClosestToCursorHitpart = false
getgenv().SafetyMeasures.KickOnStaffJoin = false
getgenv().Silent.HitChance = 100


repeat task.wait() until game:IsLoaded() and (game:GetService('Players').LocalPlayer.Character or game:GetService('Players').LocalPlayer.CharacterAdded:Wait())
--
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...)
		return (...)
	end;
	LPH_NO_VIRTUALIZE = function(...)
		return (...)
	end;
end;
-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Stats = game:GetService("Stats")
-- // Variables
local Network = settings():GetService("NetworkSettings")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local Ping = Stats.PerformanceStats.Ping
local CurrentCamera = Workspace.CurrentCamera;
-- // Optimization Variables
local MRandom = math.random
local Floor = math.floor
local Round = math.round
local Clamp = math.clamp
local Acos = math.acos
local Huge = math.huge
local Sqrt = math.sqrt
local Ceil = math.ceil
local Cos = math.cos
local Abs = math.abs
local Sin = math.sin
local Pi = math.pi
local Remove = table.remove
local Find = table.find
local Lower = string.lower
local Split = string.split
local Create = coroutine.create
local Resume = coroutine.resume
local Delay = task.delay
local Spawn = task.spawn
local Wait = task.wait
local Drawingnew = Drawing.new
local Vector2new = Vector2.new
local Vector3new = Vector3.new





local CurrentGame, RemoteEvent, SupportedGames, WebSocket;
--
local SupportedGames = {
	[1008451066] = {
		Name = "Da Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				if (Player) and Player.Character:FindFirstChild("BodyEffects") then
					return Player.Character.BodyEffects["K.O"].Value
				end
                --
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[1958807588] = {
		Name = "Hood Modded",
		MouseArguments = "MousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").Bullets
			end
		},
	},
	[3895585994] = {
		Name = "Hood Trainer",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainRemote
			end
		},
	},
	[3634139746] = {
		Name = "Hood Customs",
		MouseArguments = "GetMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[4313782906] = {
		Name = "Dah Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):WaitForChild("Handle")
			end
		},
	},
	[3445639790] = {
		Name = "Untitled-Hood",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):FindFirstChild(".gg/untitledhood")
			end
		},
	},
	[3633740623] = {
		Name = "Da Hood Aim Trainer",
		MouseArguments = "UpdateMousePos",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage").MainEvent
			end
		},
	},
	[4204799886] = {
		Name = "Five Duels",
		MouseArguments = "shoot",
		HoodGame = true,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MouseUpdater")
			end
		},
	},
	["Universal"] = {
		Name = "Universal",
		MouseArguments = "None",
		HoodGame = false,
		Functions = {
			CheckKnocked = function(Player)
				return false
			end,
			GetRemote = function()
				return;
			end
		},
	}
}
--
if SupportedGames[game.GameId] then
	CurrentGame = SupportedGames[game.GameId];
else
	CurrentGame = SupportedGames["Universal"];
end;
-- // Preload tables
local Visuals = {}
local Utility = {}
local State = {
	Utils = {},
	Connections = {},
	Objects = {},
	Velocities = {},
	Tracked = {},
	Connect = {},
	Previous = {}
}
local Osiris = {
	Locals = {
		LastStutter = tick(),
		SelectedTargetSilent = nil,
		SelectedTargetAssist = nil,
		Macro = false,
		NoClipMacro = false,
		CurrentRange = 1,
		AntiGroundValue = 0.165,
	},
	Safe = true
}
--
do -- // Renders
	SilentAimCircle = Drawingnew("Circle")
	SilentAimOutline = Drawingnew("Circle")
    --
	AimAssistCircle = Drawingnew("Circle")
    --
	DeadzoneCircle = Drawingnew("Circle")
	DeadzoneOutline = Drawingnew("Circle")
    --
	TargetDot = Drawingnew("Circle")
    --
	SilentAimCircle.Filled = getgenv().FOV.Filled
	SilentAimCircle.ZIndex = 59
    --
	SilentAimOutline.Thickness = 1.5
	SilentAimOutline.Filled = false
	SilentAimOutline.ZIndex = 60
    --
	AimAssistCircle.Filled = false
	AimAssistCircle.ZIndex = 59
    --
	DeadzoneCircle.Filled = getgenv().FovSettings.Deadzone.Filled
	DeadzoneOutline.Filled = false
	DeadzoneCircle.ZIndex = 58
	DeadzoneOutline.ZIndex = 58
    --
	TargetDot.Transparency = 1
	TargetDot.Thickness = 1
	TargetDot.NumSides = 100
	TargetDot.Radius = 10
	TargetDot.Color = Color3.fromRGB(255, 20, 147)
	TargetDot.Filled = true
end
--// Functions
do -- // Utility
	function Utility:Connection(connectionType, connectionCallback)
		local connection = connectionType:Connect(connectionCallback)
		State.Connections[# State.Connections + 1] = connection
        --
		return connection
	end
    --
	function Utility:ThreadFunction(Func, Name, ...)
		local Func = Name and function()
			local Passed, Statement = pcall(Func)
            --
			if not Passed and not Osiris.Safe then
				warn("Osiris:\n", "              " .. Name .. ":", Statement)
			end
		end or Func
		local Thread = Create(Func)
        --
		Resume(Thread, ...)
		return Thread
	end
    --
	function Utility:MousePosition(Offset)
		if Offset then
			return UserInputService:GetMouseLocation() + Osiris:CursorOffset()
		else
			return UserInputService:GetMouseLocation()
		end
	end
    --
	function Utility:Console(Action, ...)
		if not Osiris.Safe then
			Action(...)
		end
	end
    --
	function Utility:ClampString(String, Length, Font)
		local Font = (Font or 2)
		local Split = String:split("\n")
        --
		local Clamped = ""
        --
		for Index, Value2 in pairs(Split) do
			if (Index * 13) <= Length then
				Clamped = Clamped .. Value2 .. (Index == # Split and "" or "\n")
			end
		end
        --
		return (Clamped ~= String and (Clamped == "" and "" or Clamped:sub(0, # Clamped - 1) .. " ...") or Clamped)
	end
end
--

if getgenv().Misc.RemoveSeats then
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Seat") then
            v:Destroy()
        end
    end
end

do -- // Osiris
	LPH_JIT_MAX(function()
		function Osiris:UnloadCheat()
			do -- Unload Connections
				for Index, Value in pairs(State.Connections) do
					Value:Disconnect()
				end
			end
            --
			Visuals:Unload()
			Osiris.Locals.Macro = false
			Osiris.Locals.NoClipMacro = false
			getgenv().MemSpoofer.Enabled = false
			getgenv().UniversalSettings = nil
			getgenv().Silent = nil
			getgenv().Camlock = nil
			getgenv().TriggerBot = nil
			getgenv().SafetyMeasures = nil
			getgenv().Checks = nil
			getgenv().FovSettings = nil
			getgenv().HitChance = nil
			getgenv().Macro = nil
			getgenv().FakeSpike = nil
			getgenv().Keybinds = nil
			getgenv().PredefinedPredictions = nil
			getgenv().ChatCommands = nil
		end
        --
		function Osiris:PlayerValid(Player, Function)
			if Player:IsA("Player") then
				if Function then
					return Function(Player)
				else
					return true
				end
			else
				return false
			end
		end
        --
		function Osiris:CheckTeam(Player1, Player2)
			if getgenv().UniversalSettings.FFAMode then return true end
            return Player1.Team ~= Player2.Team
		end
        --
		function Osiris:CheckFriend(Player)
			if Player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
				return false;
			else
				return true;
			end
		end
        --
		function Osiris:CheckCrew(Player)
		    local a = Client:WaitForChild("DataFolder"):FindFirstChild("Crew", true)
		    local b = Player:WaitForChild("DataFolder"):FindFirstChild("Crew", true)
			if a and b then
				if (a.Value ~= "" and b.Value ~= "") and (a.Value == b.Value) then
					return false;
				end
			else
				return true
			end
		end
        --
		function Osiris:GetIgnore(Unpacked)
			return
		end
        --
		function Osiris:GetOrigin(Origin)
			if Origin == "Head" then
				local Object, Humanoid, RootPart = Osiris:ValidateClient(Client)
				local Head = Object:FindFirstChild("Head")
                --
				if Head and Head:IsA("BasePart") then
					return Head.CFrame.Position
				end
			elseif Origin == "Torso" then
				local Object, Humanoid, RootPart = Osiris:ValidateClient(Client)
                --
				if RootPart then
					return RootPart.CFrame.Position
				end
			end
            --
			return Workspace.CurrentCamera.CFrame.Position
		end
        --
		function Osiris:CursorOffset()
			if getgenv().UniversalSettings.CursorOffset.Enabled then
				local CursorOffsetX = tonumber(getgenv().UniversalSettings.CursorOffset.X)
				local CursorOffsetY = tonumber(getgenv().UniversalSettings.CursorOffset.Y)
                --
				return Vector2.new(CursorOffsetX, CursorOffsetY)
			else
				return Vector2.new(0, 0)
			end
		end
        --
		function Osiris:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
			local Parts = {}
			local Hitboxes = Hitboxes or {
				"Head",
				"Torso",
				"Arms",
				"Legs"
			}
            --
			for Index, Part in pairs(Character:GetChildren()) do
				if Part:IsA("BasePart") and Part ~= RootPart then
					if Find(Hitboxes, "Head") and Part.Name:lower():find("head") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif (Find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif (Find(Hitboxes, "Legs") and Part.Name:lower():find("foot")) then
						Parts[Indexes and Part.Name or # Parts + 1] = Part
					elseif Find(Hitboxes, Part.Name) then
						Parts[Indexes and Part.Name or #Parts + 1] = Part
					end
				end
			end
            --
			return Parts
		end
        --
		function Osiris:ClientAlive(Humanoid)
			local Health = Humanoid.Health
            --
			return (Health > 0)
		end
		--
		function Osiris:GetCharacter(Player)
			return Player.Character
		end
        --
		function Osiris:ValidateClient(Player)
			local Object = Osiris:GetCharacter(Player)
			local Humanoid = (Object and Object:FindFirstChildWhichIsA("Humanoid"))
			local RootPart = (Humanoid and Humanoid.RootPart)
            --
			return Object, Humanoid, RootPart
		end
        --
		function Osiris:RayCast(Part, Origin, Ignore, Distance)
			local Ignore = Ignore or {}
			local Distance = Distance or 2000
            --
			local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
			local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, Ignore)
			if Hit and Hit:IsDescendantOf(Part.Parent) then
				return true, Hit
			else
				return false, Hit
			end
			return false, nil
		end
        --
		function Osiris:GetEquippedWeaponName(Player)
			local ch = Player.Character
			local tool = ch and ch:FindFirstChildWhichIsA("Tool") or false
			if tool then
				if string.find(tool.Name, "%[") and string.find(tool.Name, "%]") and not string.find(tool.name, "Wallet") and not string.find(tool.Name, "Phone") then
					local tname = string.split(string.split(tool.Name, "[")[2], "]")[1]
					return tname
				end
			else
				return nil
			end
		end
        --
		function Osiris:CalculateHitChance(Percent)
			Percent = math.floor(Percent)
			local Chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
			return Chance <= Percent / 100
		end
        --
		function Osiris:IsUsingAntiAim(Player)
			if getgenv().Resolver.Enabled and getgenv().Resolver.Type == "Osiris" then
				return true
			else
				if (Player) and (Player.Character) then
					local part = Player.Character:FindFirstChild("HumanoidRootPart") or Player.Character:FindFirstChild("Torso")
					if part and State.Velocities[Player.Name] then
						local Difference = (- State.Velocities[Player.Name] - part.Velocity).Magnitude
						if Difference > 50 or Difference < - 50 then
							return true
						else
							return false
						end
                        --
					end
				end
			end
		end
        --
		function Osiris:CharacterEvent(Character)
			task.wait()
			if (Character) and Character:FindFirstChild("HumanoidRootPart") then
				local deltaTimeElapsed, deltaTime, previousTick, addingDeltaTime = 0, 0, 0, 0
				if State.Connect[Character.Name] ~= nil then
					State.Previous[Character.Name] = nil
					State.Velocities[Character.Name] = Vector3.new(0, 0, 0)
					State.Connect[Character.Name]:Disconnect()
					State.Connect[Character.Name] = nil
				end
				State.Connect[Character.Name] = Utility:Connection(game:GetService("RunService").RenderStepped, function()
					addingDeltaTime = game:GetService("RunService").Heartbeat:Wait()
					deltaTimeElapsed = deltaTimeElapsed + addingDeltaTime
					if deltaTimeElapsed >= 0.03 then
						deltaTimeElapsed = 0
						deltaTime = tick() - previousTick
						previousTick = tick()
						if Character:FindFirstChild("HumanoidRootPart") then
							local arguments = {
								Character.HumanoidRootPart.Position,
								Character.HumanoidRootPart.Position,
								deltaTime
							}
							if State.Previous[Character.Name] ~= nil then
								arguments[2] = State.Previous[Character.Name]
							end
							State.Velocities[Character.Name] = (arguments[1] - arguments[2]) / arguments[3]
							State.Previous[Character.Name] = Character.HumanoidRootPart.Position
						end
					end
				end)
			end
		end
        --
		function Osiris:GetVelocity(Player)
			if Player and Player.Character and Osiris:IsUsingAntiAim(Player) then
				if State.Velocities[Player.Name] then
					return State.Velocities[Player.Name]
				end
			elseif (Player.Character) and not Osiris:IsUsingAntiAim(Player) then
				local part = Player.Character.HumanoidRootPart or Player.Character:FindFirstChildWhichIsA("BasePart")
				return part.Velocity
			end
            --
			return Vector3.new(0, 0, 0)
		end
        --
		function Osiris:GetHitPosition(Mode)
			local Target = nil;
			local Hit = nil;
			local Hitpart = nil;
            --
			if Mode == "Redirect" then
				local Object, Humanoid, RootPart = Osiris:ValidateClient(PriorityRelationSilent)
				if (Object and Humanoid and RootPart) then
					Target = PriorityRelationSilent
                    --
					if getgenv().Silent.HitMode == "ClosestPoint" then
						local Point = Osiris:GetNearestPointOnCharacter(Object, "Redirect")
						Hit = Point
					elseif getgenv().Silent.HitMode == "ClosestBodypart" then
						local Part = Osiris:GetClosestPartOnCharacter(Object, "Redirect")
						Hit = Part.Position
					else
						Hit = Object["Head"].Position
					end
                    --
					if not getgenv().Silent.Enabled then
						return Hit, Target
					else
						local Velocity = Osiris:GetVelocity(Target)
                        --
						if Velocity and Hit then
							return Hit and Vector3.new(Hit.X + (Velocity.X * getgenv().Silent.Prediction), getgenv().SafetyMeasures.NoFloorShots and Hit.Y or Hit.Y + (Velocity.Y * getgenv().Silent.Prediction), Hit.Z + (Velocity.Z * getgenv().Silent.Prediction)), Target
						end
					end
				end
			elseif Mode == "AssistCamera" then
				local Object, Humanoid, RootPart = Osiris:ValidateClient(PriorityRelationAssist)
				if (Object and Humanoid and RootPart) then
					Target = PriorityRelationAssist
                    --
					local Part = Osiris:GetClosestPartOnCharacter(Object, "Assist")
					Hit = Part.Position
					HitPart2 = Part
				end
                --
				if not getgenv().Camlock.Enabled then
					return Hit, Target
				else
					local Velocity = Osiris:GetVelocity(Target)
                    --
					return Hit and Vector3.new(Hit.X + (Velocity.X * getgenv().Camlock.Prediction), true and Hit.Y or Hit.Y + (Velocity.Y * getgenv().Camlock.Prediction), Hit.Z + (Velocity.Z * getgenv().Camlock.Prediction)), Target, HitPart2
				end
			elseif Mode == "AssistMouse" then
			end
            --
			return;
		end
		--
		function Osiris:LagServer(Increase)
			local Main, Spammed = {}, {}
			local function getmax(value)
				local eachTable = 499999
				if type(value) ~= "number" then
					return nil
				else
					local increasedValue = (eachTable / (value + 2))
					return increasedValue
				end
				return nil
			end
			table.insert(Spammed, {})
			other_table = Spammed[1]
			local maxValue, Limit = getmax(Increase), nil
			for i = 1, Increase do
				local empty = {}
				table.insert(other_table, empty)
				other_table = empty
			end
			if maxValue ~= nil then
				Limit = maxValue
			else
				Limit = 999999
			end
			for i = 1, Limit do
				table.insert(Main, Spammed)
			end
			game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(Main)
		end
        --
		function Osiris:IsInRange(range, model)
			local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
			local Distance, Part = math.huge, nil
			range = range * 10
			local Range = range / ((model.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) * 0.8
			local Position, Visible = game.Workspace.CurrentCamera:WorldToScreenPoint(model.HumanoidRootPart.Position)
			if Visible then
				local CurrentDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
				if CurrentDistance < Distance and CurrentDistance <= Range then
					Distance = CurrentDistance
					Osiris.Locals.CurrentRange = Range
					return true
				end
			end
			return false
		end
	end)()
    --
	LPH_NO_VIRTUALIZE(function()
		function Osiris:GetPlayers()
			return Players:GetPlayers()
		end
        --
		function Osiris:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, Target, PossibleTarget)
			local WallCheck = getgenv().Checks.Wall
			local VisibleCheck = getgenv().Checks.Visible
			local ForceFieldCheck = getgenv().Checks.ForceField
			local TeamCheck = getgenv().Checks.Team
			local AliveCheck = getgenv().Checks.Alive
			local CrewCheck = getgenv().Checks.Crew
            --
			if (TeamCheck and Osiris:CheckTeam(Client, Player)) then
				return
			end
            --
			if (CrewCheck and Osiris:CheckCrew(Client, Player)) then
				return
			end
			--
			local Object, Humanoid, RootPart = Osiris:ValidateClient(Player)
            --
			if (Object and Humanoid and RootPart) then
				if (ForceFieldCheck and Object:FindFirstChildOfClass("ForceField")) or (AliveCheck and not Osiris:ClientAlive(Humanoid)) then
					return
				end
                --
				local RootPosition = (RootPart.CFrame.Position)
				local Position, Visible = Workspace.CurrentCamera:WorldToScreenPoint(RootPosition)
				local Position2 = Vector2.new(Position.X, Position.Y)
				local Magnitude = (MouseLocation - Position2).Magnitude
				local Distance = (Workspace.CurrentCamera.CFrame.Position - RootPosition).Magnitude
				local FOV = FieldOfView
				local DeadzoneFOV = Deadzone

				if (WallCheck and not (Osiris:RayCast(RootPart, Osiris:GetOrigin(Origin), {Osiris:GetCharacter(Client)}))) then return end
				--
				if (VisibleCheck and (Object.Head.Transparency == 1)) then return end
                --
				if Visible and Magnitude <= PossibleTarget.Magnitude then
					PossibleTarget = {
						Player = Player,
						Object = Object,
						Distance = Distance,
						Magnitude = Magnitude
					}
				end
                --
				if Visible then
					if ((not FOVCheckDisabled) and not (Magnitude <= FOV)) or not (Magnitude <= Target.Magnitude) then
						return
					end
					return {
						Player = Player,
						Object = Object,
						Distance = Distance,
						Magnitude = Magnitude
						}
				end
			end
		end
        --
		function Osiris:CheckFOV(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes)
			local Object, Humanoid, RootPart = Osiris:ValidateClient(Player)
            --
			if (Object and Humanoid and RootPart) then
				local RootPosition = (RootPart.CFrame.Position)
				local Position, Visible = Workspace.CurrentCamera:WorldToScreenPoint(RootPosition)
				local Position2 = Vector2.new(Position.X, Position.Y)
				local Magnitude = (MouseLocation - Position2).Magnitude
				local Distance = (Workspace.CurrentCamera.CFrame.Position - RootPosition).Magnitude
				local SelfAimAssistFOV = FieldOfView
				local SelfDeadzoneFOV = Deadzone
				local SelfMultiplier = 1
                --
				SelfAimAssistFOV = (SelfAimAssistFOV * SelfMultiplier)
				SelfDeadzoneFOV = (SelfDeadzoneFOV * SelfMultiplier)
                --
				if Visible then
					for Index2, Part in pairs(Osiris:GetBodyParts(Object, RootPart, false, Hitboxes)) do
						local HitboxPosition = Part.CFrame.p
                        --
						local Position3, Visible2 = Workspace.CurrentCamera:WorldToScreenPoint(HitboxPosition)
						local Position4 = Vector2.new(Position3.X, Position3.Y)
						local Magnitude2 = (MouseLocation - Position4).Magnitude
                        --
						if Position4 and Visible2 then
							if ((not FOVCheckDisabled) and (Magnitude2 <= SelfAimAssistFOV)) then
								return true
							end
						end
					end
				else
					return false
				end
			end
		end
        --
		function Osiris:UpdateFieldOfView()
			local ScreenSize = Workspace.CurrentCamera.ViewportSize
            --
			local FieldOfViewSilent = getgenv().FOV.Radius
			local FieldOfViewAssist = getgenv().Camlock.FOV
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
            --
			Osiris.Locals.SilentAimFOV = ((FieldOfViewSilent / 100) * ScreenSize.Y)
			Osiris.Locals.AimAssistFOV = ((FieldOfViewAssist / 100) * ScreenSize.Y)
			Osiris.Locals.DeadzoneFOV = (Osiris.Locals.AimAssistFOV * 0.9) * (Deadzone / 100)
            --
			Osiris.Locals.VisualSilentAimFOV = (Osiris.Locals.SilentAimFOV)
			Osiris.Locals.VisualAimAssistFOV = (Osiris.Locals.AimAssistFOV)
			Osiris.Locals.VisualDeadzoneFOV = (Osiris.Locals.DeadzoneFOV)
		end
        --
		function Osiris:GetClosestPartOnCharacter(character, mode)
			local distance, part = 9e99, nil
			local parts;
			if mode == "Redirect" then
				parts = Osiris:GetBodyParts(character, character.Humanoid.RootPart, false, getgenv().HitParts)
			elseif mode == "Assist" then
				parts = Osiris:GetBodyParts(character, character.Humanoid.RootPart, false, getgenv().Camlock.Parts)
			end
			if mode == "Redirect" then
				if getgenv().Silent.HitMode == "ClosestPoint" then
					for i, v in pairs(character:GetChildren()) do
						if v:IsA("BasePart") then
							local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
							if onscreen then
								local pos = Vector2.new(_.X, _.Y)
								local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
								if mag < distance then
									part = v
									distance = mag
								end
							end
						end
					end
				else
					for i, v in pairs(parts) do
						local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
						if onscreen then
							local pos = Vector2.new(_.X, _.Y)
							local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
							if mag < distance then
								part = v
								distance = mag
							end
						end
					end
				end
			elseif mode == "Assist" then
				if getgenv().Camlock.ClosestToCursorHitpart then
					for i, v in pairs(character:GetChildren()) do
						if v:IsA("BasePart") then
							local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
							if onscreen then
								local pos = Vector2.new(_.X, _.Y)
								local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
								if mag < distance then
									part = v
									distance = mag
								end
							end
						end
					end
				else
					for i, v in pairs(parts) do
						local _, onscreen = CurrentCamera:WorldToScreenPoint(v.Position)
						if onscreen then
							local pos = Vector2.new(_.X, _.Y)
							local mag = (pos - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
							if mag < distance then
								part = v
								distance = mag
							end
						end
					end
				end
			end
			return part
		end
        --
		function Osiris:GetNearestPointOnCharacter(Character, Mode)
			local NearestPart = Osiris:GetClosestPartOnCharacter(Character, Mode)
            --
			if NearestPart ~= nil then
                --
				local Hit, Half = Mouse.Hit.p, NearestPart.Size * 0.5
                --
				local Transform = NearestPart.CFrame:PointToObjectSpace(Hit)
                --
				local NearestPosition = NearestPart.CFrame * Vector3.new(math.clamp(Transform.X, - Half.X, Half.X), math.clamp(Transform.Y, - Half.Y, Half.Y), math.clamp(Transform.Z, - Half.Z, Half.Z))
                --
				return NearestPosition
			end
		end
        --
		function Osiris:GetSilentAimTarget()
			local TargetSilent = {
				Player = nil,
				Object = nil,
				Part = nil,
				Vector = nil,
				Magnitude = 9e99
			}
            --
			local MouseLocation = Utility:MousePosition(true)
            --
			local UsePredicton = getgenv().Silent.Enabled
			local PredictionAmmoumt = getgenv().Silent.Prediction
			local FieldOfView = getgenv().FOV.Radius
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
			local FOVType = getgenv().FovSettings.Type
			local Dynamic = getgenv().FovSettings.DynamicRadius
			local Origin = "Camera"
            --
			local FOVCheckDisabled = getgenv().FOV.Radius == 0
			local DeadzoneCheckDisabled = getgenv().FovSettings.Deadzone.Radius == 0
			local FieldOfView = (Osiris.Locals.SilentAimFOV / 2)
			local Deadzone = (Osiris.Locals.DeadzoneFOV / 2)
			local Hitboxes = getgenv().HitParts
            --
			local PossibleTargetSilent = {
				Player = nil,
				Object = nil,
				Magnitude = 9e99
			}
            --
			local Objects = Osiris:GetPlayers()
            --
			for Index, Player in pairs(Objects) do
				if Player ~= Client then
					local Validated = Osiris:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, TargetSilent, PossibleTargetSilent)
                    --
					if Validated then
						TargetSilent = Validated
					end
				end
			end
            --
			if TargetSilent.Player and TargetSilent.Object then
				PossibleTargetSilent = {
					Player = TargetSilent.Player,
					Object = TargetSilent.Object,
					Distance = TargetSilent.Distance
				}
                --
				Osiris.Locals.TargetSilent = TargetSilent
			else
				Osiris.Locals.TargetSilent = nil
			end
            --
			if PossibleTargetSilent and PossibleTargetSilent.Distance then
				Osiris.Locals.PossibleTargetSilent = PossibleTargetSilent
			else
				Osiris.Locals.PossibleTargetSilent = nil
			end
		end
        --
		function Osiris:GetAimAssistTarget(Priority)
			local TargetAssist = {
				Player = nil,
				Object = nil,
				Part = nil,
				Vector = nil,
				Magnitude = 9e99
			}
            --
			local MouseLocation = Utility:MousePosition(true)
            --
			local UsePredicton = getgenv().Camlock.Enabled
			local PredictionAmmoumt = getgenv().Camlock.Prediction
			local FieldOfView = getgenv().Camlock.FOV
			local Deadzone = getgenv().FovSettings.Deadzone.Radius
			local FOVType = getgenv().FovSettings.Type
			local Dynamic = getgenv().FovSettings.DynamicRadius
			local Origin = "Camera"
            --
			local FOVCheckDisabled = getgenv().Camlock.FOV == 0
			local DeadzoneCheckDisabled = getgenv().FovSettings.Deadzone.Radius == 0
			local FieldOfView = (Osiris.Locals.AimAssistFOV / 2)
			local Deadzone = (Osiris.Locals.DeadzoneFOV / 2)
			local Hitboxes = getgenv().Camlock.Parts
            --
			local PossibleTargetAssist = {
				Player = nil,
				Object = nil,
				Magnitude = 9e99
			}
            --
			local Objects = Priority and {
				Priority
			} or Osiris:GetPlayers()
            --
			for Index, Player in pairs(Objects) do
				if Player ~= Client then
					local Validated = Osiris:ValidatePlayer(Player, MouseLocation, FieldOfView, Deadzone, FOVCheckDisabled, Hitboxes, Origin, TargetAssist, PossibleTargetAssist)
                    --
					if Validated then
						TargetAssist = Validated
					end
				end
			end
            --
			if TargetAssist.Player and TargetAssist.Object then
				PossibleTargetAssist = {
					Player = TargetAssist.Player,
					Object = TargetAssist.Object,
					Distance = TargetAssist.Distance
				}
                --
				Osiris.Locals.TargetAssist = TargetAssist
			else
				Osiris.Locals.TargetAssist = nil
			end
            --
			if PossibleTargetAssist and PossibleTargetAssist.Distance then
				Osiris.Locals.PossibleTargetAssist = PossibleTargetAssist
			else
				Osiris.Locals.PossibleTargetAssist = nil
			end
		end
        --
		function Osiris:ActivateAimAssist()
			if getgenv().Silent.Enabled and getgenv().Camlock.Enabled then
				if PriorityRelationAssist and PriorityRelationAssist.Character then
					local Object, Humanoid, RootPart = Osiris:ValidateClient(PriorityRelationAssist)
                    --
					if (Object and Humanoid and RootPart) then
						if not CurrentGame.Functions.CheckKnocked(PriorityRelationAssist) then
							local Stutter = 0
							local Deadzone = getgenv().FovSettings.Deadzone.Radius
							if not ((not Stutter == 0) and not ((tick() - Osiris.Locals.LastStutter) >= (Stutter / 1000))) then
								Osiris.Locals.LastStutter = tick()
                                --
								if getgenv().Camlock.SafetyMeasures and UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then return end
								--
								local MouseLocation = Utility:MousePosition(true)
								local HitPosition, CurrentTarget, HitPart;
								HitPosition, CurrentTarget, HitPart = Osiris:GetHitPosition("AssistCamera")
                                --
								if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then
									return
								end
								if (getgenv().Checks.Alive and not Osiris:ClientAlive(Humanoid)) then
									return
								end
								if (getgenv().Checks.Friend and not Osiris:CheckFriend(PriorityRelationAssist)) then
									return
								end
								if (getgenv().Checks.Crew and not Osiris:CheckCrew(PriorityRelationAssist)) then
									return
								end
                                --
								local ClosestPartToCharThing = Osiris:GetClosestPartOnCharacter(CurrentTarget.Character, "Assist")
                                --
								if (getgenv().Checks.Wall and not Osiris:RayCast(ClosestPartToCharThing, Osiris:GetOrigin("Camera"), {
									Osiris:GetCharacter(Client),
									Osiris:GetIgnore(true)
								})) then
									return
								end
                                --
								if getgenv().Camlock.ShakeValue.Enabled then
									local MainJitter = CFrame.new(CurrentCamera.CFrame.p, HitPosition + Vector3.new(
										math.random(-getgenv().Camlock.ShakeValue.X, getgenv().Camlock.ShakeValue.X), math.random(- getgenv().Camlock.ShakeValue.Y, getgenv().Camlock.ShakeValue.Y), math.random(- getgenv().Camlock.ShakeValue.Z, getgenv().Camlock.ShakeValue.Z)) * 0.1)
									CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(MainJitter, getgenv().Camlock.Smoothness, Enum.EasingStyle[getgenv().Camlock.EasingStyle], Enum.EasingDirection.InOut, Enum.EasingStyle[getgenv().Camlock.EasingStyle], Enum.EasingDirection.Out)
								else
									local Main = CFrame.new(CurrentCamera.CFrame.p, HitPosition)
									CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(Main, getgenv().Camlock.Smoothness, Enum.EasingStyle[getgenv().Camlock.EasingStyle], Enum.EasingDirection.InOut, Enum.EasingStyle[getgenv().Camlock.EasingStyle], Enum.EasingDirection.Out)
								end
							end
						end
					end
				end
			end
		end
	end)()
    --
	do -- // Game LUAs
		local HoodGames = {
			"Da Hood",
			"Hood Customs",
			"Hood Trainer",
			"Dah Hood",
			"Untitled-Hood",
			"Da Hood Aim Trainer"
		}
		local HoodGamesEditedSys = {
			"Hood Modded"
		}
		local Games = {
			[{2788229376, 7213786345, 9825515356, 9824221333, 10773759206, 9183932460, 10355218822, 5602055394, 12243533824}] = {Name = "HoodGames", Func = function()
				RemoteEvent = CurrentGame.Functions.GetRemote();
                --
				function Osiris:DisconnectPreviousToolConnections()
					if State.Connections["Tool"] then
						State.Connections["Tool"]:Disconnect()
					end
					State.Connections["Tool"] = nil
				end
                --
				function Osiris:CreateConnectionTool(Tool)
					wait(0.1)
					Osiris:DisconnectPreviousToolConnections()
					State.Connections["Tool"] = Utility:Connection(Tool.Activated, function()
						if getgenv().Silent.Enabled and getgenv().Silent.Enabled and getgenv().Silent.ModeType == "Safe" then
							if PriorityRelationSilent and PriorityRelationSilent.Character then
								local Object, Humanoid, RootPart = Osiris:ValidateClient(PriorityRelationSilent)
								--
								if (Object and Humanoid and RootPart) then
									if not CurrentGame.Functions.CheckKnocked(PriorityRelationSilent) then
										local HitPosition, CurrentTarget = Osiris:GetHitPosition("Redirect")
										--
										if (not Osiris:CalculateHitChance(100)) then
											return
										end
										--
										local RemoteArgs = {}
										if (table.find(HoodGames, CurrentGame.Name)) then
											RemoteArgs = {
												CurrentGame.MouseArguments,
												HitPosition
											}
										elseif (table.find(HoodGamesEditedSys, CurrentGame.Name)) then
											RemoteArgs = {
												CurrentGame.MouseArguments,
												HitPosition,
												"P"
											}
										end
										--
										if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then
											return
										end
										if (getgenv().Checks.Alive and not Osiris:ClientAlive(Humanoid)) then
											return
										end
										if (getgenv().Checks.Friend and not Osiris:CheckFriend(PriorityRelationSilent)) then
											return
										end
										if (getgenv().Checks.Crew and not Osiris:CheckCrew(PriorityRelationSilent)) then
											return
										end
										--
										local ClosestPartToCharThing = Osiris:GetClosestPartOnCharacter(CurrentTarget.Character, "Redirect")
										--
										if (getgenv().Checks.Wall and not Osiris:RayCast(ClosestPartToCharThing, Osiris:GetOrigin("Camera"), {
											Osiris:GetCharacter(Client),
											Osiris:GetIgnore(true)
										})) then
											return
										end
										--
										if PriorityRelationSilent and PriorityRelationSilent.Character then
											if getgenv().FOV.Radius and Osiris:CheckFOV(PriorityRelationSilent, Utility:MousePosition(true), (Osiris.Locals.SilentAimFOV), (Osiris.Locals.DeadzoneFOV / 2), getgenv().FOV.Radius == 0, getgenv().HitParts) then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											elseif getgenv().FovSettings.Type == "Dynamic" and Osiris:IsInRange(getgenv().FovSettings.DynamicRadius, CurrentTarget.Character) and HitPosition ~= nil then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											end
										end
									end
								end
							end
						end
					end)
				end
                --
				function Osiris:CharacterAddedEvent(Character)
					Utility:Connection(Character.DescendantAdded, function(Descendant)
						if Descendant:IsA("Tool") and Descendant:FindFirstChildWhichIsA("Script") then
							if CurrentGame.HoodGame and Osiris:GetEquippedWeaponName(Client) ~= nil and getgenv().Hitchances then
								if CurrentGame.Name == "Da Hood" or CurrentGame.Name == "Hood Customs" or CurrentGame.Name == "Untitled-Hood" or CurrentGame.Name == "Hood Trainer" then
									local EquippedWeapon = Osiris:GetEquippedWeaponName(Client)
									if EquippedWeapon == "Double-Barrel SG" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.DoubleBarrel
									elseif EquippedWeapon == "Revolver" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.Revolver
									elseif EquippedWeapon == "SMG" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.SMG
									elseif EquippedWeapon == "Shotgun" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.Shotgun
									elseif EquippedWeapon == "TacticalShotgun" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.TacticalShotgun
									end
								end
							end
							Osiris:CreateConnectionTool(Descendant)
						end
					end)
				end
                --
				Utility:Connection(Client.CharacterAdded, function(Character)
					Osiris:CharacterAddedEvent(Character)
				end)
                --
				if Client.Character then
					Osiris:CharacterAddedEvent(Client.Character)
				end
                --
				if getgenv().SafetyMeasures.KickOnStaffJoin then
					local ModPowers = { a = 'Hearing', b = 'HeroArc', c = 'ReverseFlashOutfit', d = 'Dash Punch', e = 'Speed Force', f = 'Claws', g = 'WolverineOutfit', h = 'FirePower', i = 'Super Punch', j = 'Timeskip', k = 'InvisibleHit', l = 'SpiritOrb', m = 'Fly', n = 'AdminBan', o = 'Glide', p = 'InvisibleHit', q = 'SpiritOrb', r = 'SuperPunch' }
                    --
					for i, v in pairs(game.Players:GetChildren()) do
						for i, p in pairs(v.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if p.Name == d then
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end
                    --
					Utility:Connection(Players.PlayerAdded, function(Player)
						repeat wait() until Player.Character
                        --
						for i, v in pairs(Player.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if v.Name == d then
								-- Client:Kick(Player.Name.. 'is a mod')
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end)
				end
			end},
			[{11228173542, 10876054559, 4790960806, 5296589146, 5973754207, 6580968658, 5961745093, 9582807828, 9483937523, 9682207432, 11401909704}] = {Name = "Prime", Func = function()
			end},
			[{292439477}] = {Name = "Phantom Forces", Func = function()
			end},
			[{11127650206}] = {Name = "Vanity", Func = function()
				local Characters = Workspace:FindFirstChild("Players")
				--
				function Osiris:GetCharacter(Player)
					return Characters:FindFirstChild(Player.Name)
				end
			end},
			[{11883610532, 12128125888, 12543953865}] = {Name = "Five Duels", Func = function()
				RemoteEvent = CurrentGame.Functions.GetRemote();
                --
				function Osiris:DisconnectPreviousToolConnections()
					if State.Connections["Tool"] then
						State.Connections["Tool"]:Disconnect()
					end
					State.Connections["Tool"] = nil
				end
                --
				function Osiris:CreateConnectionTool(Tool)
					wait(0.1)
					Osiris:DisconnectPreviousToolConnections()
					State.Connections["Tool"] = Utility:Connection(Tool.Activated, function()
						if getgenv().Silent.Enabled and getgenv().Silent.Enabled and getgenv().Silent.ModeType == "Safe" then
							if PriorityRelationSilent and PriorityRelationSilent.Character then
								local Object, Humanoid, RootPart = Osiris:ValidateClient(PriorityRelationSilent)
								--
								if (Object and Humanoid and RootPart) then
									if not CurrentGame.Functions.CheckKnocked(PriorityRelationSilent) then
										local HitPosition, CurrentTarget = Osiris:GetHitPosition("Redirect")
										--
										if (not Osiris:CalculateHitChance(100)) then return end
										--
										local RemoteArgs = {HitPosition}
										local RemoteArgs2 = {
											[1] = "shoot",
											[2] = {
												[1] = HitPosition
											}
										}
										--
										if (getgenv().Checks.ForceField and Object:FindFirstChildOfClass("ForceField")) then return end
										if (getgenv().Checks.Alive and not Osiris:ClientAlive(Humanoid)) then return end
										if (getgenv().Checks.Friend and not Osiris:CheckFriend(PriorityRelationSilent)) then return end
										--
										local ClosestPartToCharThing = Osiris:GetClosestPartOnCharacter(CurrentTarget.Character, "Redirect")
										--
										if (getgenv().Checks.Wall and not Osiris:RayCast(ClosestPartToCharThing, Osiris:GetOrigin("Camera"), {
											Osiris:GetCharacter(Client),
											Osiris:GetIgnore(true)
										})) then return end
										--
										if PriorityRelationSilent and PriorityRelationSilent.Character then
											if getgenv().FOV.Radius and Osiris:CheckFOV(PriorityRelationSilent, Utility:MousePosition(true), (Osiris.Locals.SilentAimFOV), (Osiris.Locals.DeadzoneFOV / 2), getgenv().FOV.Radius == 0, getgenv().HitParts) then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
												game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteEvent"):FireServer(table.unpack(RemoteArgs2))
											elseif getgenv().FovSettings.Type == "Dynamic" and Osiris:IsInRange(getgenv().FovSettings.DynamicRadius, CurrentTarget.Character) and HitPosition ~= nil then
												RemoteEvent:FireServer(table.unpack(RemoteArgs))
											end
										end
									end
								end
							end
						end
					end)
				end
                --
				function Osiris:CharacterAddedEvent(Character)
					Utility:Connection(Character.DescendantAdded, function(Descendant)
						if Descendant:IsA("Tool") and Descendant:FindFirstChildWhichIsA("Script") then
							if CurrentGame.HoodGame and Osiris:GetEquippedWeaponName(Client) ~= nil and getgenv().HitChance then
								if CurrentGame.Name == "Da Hood" or CurrentGame.Name == "Hood Customs" or CurrentGame.Name == "Untitled-Hood" or CurrentGame.Name == "Hood Trainer" then
									local EquippedWeapon = Osiris:GetEquippedWeaponName(Client)
									if EquippedWeapon == "Double-Barrel SG" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.DoubleBarrel
									elseif EquippedWeapon == "Revolver" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.Revolver
									elseif EquippedWeapon == "SMG" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.SMG
									elseif EquippedWeapon == "Shotgun" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.Shotgun
									elseif EquippedWeapon == "TacticalShotgun" then
										getgenv().Silent.HitChance = getgenv().Hitchances.Ground.TacticalShotgun
									end
								end
							end
							Osiris:CreateConnectionTool(Descendant)
						end
					end)
				end
                --
				Utility:Connection(Client.CharacterAdded, function(Character)
					Osiris:CharacterAddedEvent(Character)
				end)
                --
				if Client.Character then
					Osiris:CharacterAddedEvent(Client.Character)
				end
                --
				if getgenv().SafetyMeasures.KickOnStaffJoin then
					local ModPowers = { a = 'Hearing', b = 'HeroArc', c = 'ReverseFlashOutfit', d = 'Dash Punch', e = 'Speed Force', f = 'Claws', g = 'WolverineOutfit', h = 'FirePower', i = 'Super Punch', j = 'Timeskip', k = 'InvisibleHit', l = 'SpiritOrb', m = 'Fly', n = 'AdminBan', o = 'Glide', p = 'InvisibleHit', q = 'SpiritOrb', r = 'SuperPunch' }
                    --
					for i, v in pairs(game.Players:GetChildren()) do
						for i, p in pairs(v.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if p.Name == d then
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end
                    --
					Utility:Connection(Players.PlayerAdded, function(Player)
						repeat wait() until Player.Character
                        --
						for i, v in pairs(Player.Backpack:GetChildren()) do
							for i, d in pairs(ModPowers) do
								if v.Name == d then
								-- Client:Kick(Player.Name.. 'is a mod')
									Client:Kick('Failed to connect to the Game. (ID = 17: Connection attempt failed.)')
								end
							end
						end
					end)
				end
			end},
		}
        --
		local PlaceId = game.PlaceId
        --
		function Osiris:LoadLuas()
			for Index, Value in pairs(Games) do
				if Find(Index, PlaceId) then
					Utility:ThreadFunction(Value.Func, "Lx01")
				end
			end
		end
	end
end
--
do -- // Visuals
	function Visuals:Update()
		local MouseLocation = Utility:MousePosition(true)
        --
		if getgenv().FOV.Visible and getgenv().Silent.Enabled and getgenv().Silent.Enabled then
			local SilentAimColor1, SilentAimTransparency1 = Color3.fromRGB(93, 62, 152), 0.6
			local SilentAimColor2, SilentAimTransparency2 = Color3.fromRGB(93, 62, 152), 0.6
			local SilentAimSides = 50
			local FieldOfViewSilent = Osiris.Locals.VisualSilentAimFOV / 2
            --
			if not PriorityRelationSilent then
				SilentAimCircle.Position = MouseLocation
			end
			SilentAimCircle.Color = SilentAimColor1
			SilentAimCircle.Transparency = 1 - SilentAimTransparency1
			SilentAimCircle.Radius = FieldOfViewSilent
			SilentAimCircle.NumSides = SilentAimSides
			SilentAimCircle.Filled = getgenv().FOV.Filled
			SilentAimCircle.Visible = true
            --
			if not PriorityRelationSilent then
				SilentAimOutline.Position = MouseLocation
			end
			SilentAimOutline.Color = SilentAimColor2
			SilentAimOutline.Transparency = 1 - SilentAimTransparency2
			SilentAimOutline.Radius = FieldOfViewSilent
			SilentAimOutline.NumSides = SilentAimSides
			SilentAimOutline.Visible = true
			if getgenv().FOV.Filled then
				SilentAimCircle.Thickness = 0.9
				SilentAimOutline.Thickness = 0.9
			else
				SilentAimCircle.Thickness = 1
				SilentAimOutline.Thickness = 1.5
			end
		else
			SilentAimCircle.Visible = false
			SilentAimOutline.Visible = false
		end
        --
		if getgenv().Tracer.Visible and getgenv().Camlock.Enabled and getgenv().Silent.Enabled then
			local AimAssistColor1, AimAssistTransparency1 = Color3.fromRGB(0, 191, 255), 0.6
			local AimAssistColor2, AimAssistTransparency2 = Color3.fromRGB(0, 191, 255), 0.6
			local AimAssistSides = 50
			local FieldOfViewAssist = Osiris.Locals.VisualAimAssistFOV / 2
            --
			if not PriorityRelationAssist then
				AimAssistCircle.Position = MouseLocation
			end
			AimAssistCircle.Color = AimAssistColor1
			AimAssistCircle.Transparency = 1 - AimAssistTransparency1
			AimAssistCircle.Radius = FieldOfViewAssist
			AimAssistCircle.NumSides = AimAssistSides
			AimAssistCircle.Filled = false
			AimAssistCircle.Visible = true
		else
			AimAssistCircle.Visible = false
		end
        --
		if getgenv().Camlock.Deadzone and getgenv().FovSettings.Deadzone.Visible and getgenv().Silent.Enabled then
			local DeadzoneColor1, DeadzoneTransparency1 = Color3.fromRGB(25, 25, 25), 0.6
			local DeadzoneColor2, DeadzoneTransparency2 = Color3.fromRGB(25, 25, 25), 0.6
			local AimAssistSides = 50
			local FieldOfView = Osiris.Locals.VisualDeadzoneFOV / 2
            --
			DeadzoneCircle.Position = MouseLocation
			DeadzoneCircle.Color = DeadzoneColor1
			DeadzoneCircle.Transparency = 1 - DeadzoneTransparency1
			DeadzoneCircle.Radius = FieldOfView
			DeadzoneCircle.NumSides = AimAssistSides
			DeadzoneCircle.Visible = true
            --
			DeadzoneOutline.Position = MouseLocation
			DeadzoneOutline.Color = DeadzoneColor2
			DeadzoneOutline.Transparency = 1 - DeadzoneTransparency2
			DeadzoneOutline.Radius = FieldOfView
			DeadzoneOutline.NumSides = AimAssistSides
			DeadzoneOutline.Visible = getgenv().FovSettings.Deadzone.Visible
		else
			DeadzoneCircle.Visible = false
			DeadzoneOutline.Visible = false
		end
        --
		if getgenv().Silent.Enabled and getgenv().Silent.RegularModeVisualizer and getgenv().Silent.Enabled then
			if PriorityRelationSilent and PriorityRelationSilent.Character then
				local HitPosition, CurrentTarget = Osiris:GetHitPosition("Redirect")
				local Velocity = Osiris:GetVelocity(CurrentTarget)
				local Vector;
                --
				if getgenv().Silent.Enabled then
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition) + (Velocity * getgenv().Silent.Prediction)
				else
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition)
				end
                --
				TargetDot.Visible = true
				TargetDot.Position = Vector2.new(Vector.X, Vector.Y)
			else
				TargetDot.Visible = false
			end
		else
			TargetDot.Visible = false
		end
        --
		if getgenv().Silent.Enabled and getgenv().Silent.Mode2 and getgenv().Silent.Enabled then
			local MouseLocation = Utility:MousePosition(true)
			if PriorityRelationSilent and PriorityRelationSilent.Character then
				local HitPosition, CurrentTarget = Osiris:GetHitPosition("Redirect")
				local Velocity = Osiris:GetVelocity(CurrentTarget)
				local Vector;
                --
				if getgenv().Silent.Enabled then
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition) + (Velocity * getgenv().Silent.Prediction)
				else
					Vector = CurrentCamera:WorldToViewportPoint(HitPosition)
				end
                --
				SilentAimCircle.Position = Vector2.new(Vector.X, Vector.Y)
				SilentAimOutline.Position = Vector2.new(Vector.X, Vector.Y)
				AimAssistCircle.Position = Vector2.new(Vector.X, Vector.Y)
			else
				SilentAimCircle.Position = MouseLocation
				SilentAimOutline.Position = MouseLocation
				AimAssistCircle.Position = MouseLocation
			end
		else
			SilentAimCircle.Position = MouseLocation
			SilentAimOutline.Position = MouseLocation
			AimAssistCircle.Position = MouseLocation
		end
	end
    --
	function Visuals:Unload()
		SilentAimCircle:Remove()
		SilentAimOutline:Remove()
        --
		AimAssistCircle:Remove()
        --
		DeadzoneCircle:Remove()
		DeadzoneOutline:Remove()
        --
		TargetDot:Remove()
	end
end
--
do -- // Main
	Osiris:LoadLuas()
    --
	do -- Connections
		Utility:Connection(UserInputService.InputBegan, function(Input, Processed)
			if not Processed then
				if getgenv().SafetyMeasures.PanicBindEnabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Panic:upper()] then
					Osiris.Locals.PanicMode = not Osiris.Locals.PanicMode
					getgenv().Silent.Enabled = not getgenv().Silent.Enabled
				elseif getgenv().SafetyMeasures.UnloadBindEnabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Unload:upper()] then
					Osiris:UnloadCheat()
				elseif getgenv().Silent.Enabled and getgenv().FakeSpike.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.FakeSpike:upper()] then
					if getgenv().FakeSpike.RealSpike then
						Osiris:LagServer(getgenv().FakeSpike.FakeSpikeAmmount)
					else
						Network.IncomingReplicationLag = getgenv().FakeSpike.LagAmmount
						task.wait(1.5)
						Network.IncomingReplicationLag = 0
					end
				elseif getgenv().Silent.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.NormalSilToggle:upper()] then
					if getgenv().Silent.Enabled and getgenv().Silent.Mode ~= "FOV" then
						if PriorityRelationSilent then
							PriorityRelationSilent = nil
							Osiris.Locals.TargetSilent = nil
						else
							Osiris:GetSilentAimTarget()
                            --
							if Osiris.Locals.TargetSilent then
								PriorityRelationSilent = Osiris.Locals.TargetSilent.Player
							else
								PriorityRelationSilent = nil
							end
						end
					end
                    --
					if getgenv().Camlock.Enabled and getgenv().Silent.Mode ~= "FOV" then
						if PriorityRelationAssist then
							PriorityRelationAssist = nil
							Osiris.Locals.TargetAssist = nil
						else
							Osiris:GetAimAssistTarget()
                            --
							if Osiris.Locals.TargetAssist then
								PriorityRelationAssist = Osiris.Locals.TargetAssist.Player
							else
								PriorityRelationAssist = nil
							end
						end
					end
				end
			end
		end)
        --
		if CurrentGame.HoodGame then
			local cameraOK, Cameras = pcall(function() return require(game.Players.LocalPlayer.PlayerScripts.PlayerModule):GetCameras() end)
            if not cameraOK then Cameras = nil end
			local Controller = Cameras and Cameras.activeCameraController
            --
			Utility:Connection(UserInputService.InputBegan, function(Input, Processed)
				if not Processed and Controller then
					if getgenv().Silent.Enabled and getgenv().Macro.Enabled and getgenv().Macro.BypassMacroAbuse and getgenv().Macro.Type ~= "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["I"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance - 5);
					elseif getgenv().Silent.Enabled and getgenv().Macro.Enabled and getgenv().Macro.BypassMacroAbuse and getgenv().Macro.Type ~= "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["O"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance + 5);
					elseif getgenv().Silent.Enabled and getgenv().Macro.Enabled and getgenv().Macro.Type == "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["I"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance - 0.6);
					elseif getgenv().Silent.Enabled and getgenv().Macro.Enabled and getgenv().Macro.Type == "First" and getrenv()._G.HoldGunBool and Input.KeyCode == Enum.KeyCode["O"] then
						Controller:SetCameraToSubjectDistance(Controller.currentSubjectDistance + 0.6);
					elseif getgenv().Silent.Enabled and getgenv().Macro.Enabled and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.Macro:upper()] then
						Osiris.Locals.Macro = not Osiris.Locals.Macro
                        --
						repeat
							game:GetService("RunService").Heartbeat:wait()
							keypress(73)
							game:GetService("RunService").Heartbeat:wait()
							keypress(79)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(73)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(79)
							game:GetService("RunService").Heartbeat:wait()
						until not Osiris.Locals.Macro
					elseif getgenv().Silent.Enabled and getgenv().Macro.Enabled and getgenv().Macro.NoClipMacro and Input.KeyCode == Enum.KeyCode[getgenv().Keybinds.NoClipMacro:upper()] then
						Osiris.Locals.NoClipMacro = not Osiris.Locals.NoClipMacro
						--
						repeat
							game:GetService("RunService").Heartbeat:wait()
							keypress(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keypress(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(0x33)
							game:GetService("RunService").Heartbeat:wait()
							keyrelease(0x33)
							game:GetService("RunService").Heartbeat:wait()
						until not Osiris.Locals.NoClipMacro
					end
				end
			end)
		end
        --
		Utility:Connection(Client.Chatted, function(Chat)
			local ChatSent = Split(Lower(Chat), " ")
			if getgenv().Chat.Enabled and ChatSent[1] == getgenv().Chat.Settings.Prediction and tonumber(ChatSent[2]) ~= nil then
				getgenv().Silent.Prediction = tonumber(ChatSent[2])
			elseif getgenv().Chat.Enabled and ChatSent[1] == getgenv().Chat.Settings.AutoPrediction then
				getgenv().Silent.AutoPrediction = not getgenv().Silent.AutoPrediction
			end
		end)
        --
		task.spawn(function()
			LPH_JIT_MAX(function()
				local Memory = {
					Current = tonumber(math.random(700, 900) .. "." .. tostring(math.random(10, 99))),
					Base = math.random(700, 900),
					History = {},
					Display = tonumber(math.random(700, 900) .. "." .. tostring(math.random(10, 99)))
				}
				local function decimalRandom(minimum, maximum)
					return math.random() * (maximum - minimum) + minimum
				end
                --
				local getAverageMemory = function()
					local Average = 0
					for i, v in pairs(Memory.History) do
						Average += v
					end
					return Average / # Memory.History
				end
                --
				local getNewMemory = function()
					local random, random_chance = math.random(1, 3), math.random(1, 3)
					if random == 1 or random == 2 then
						if random_chance == 3 and tonumber(Memory.Current) ~= nil then
							Memory.Current = tostring(math.floor(tonumber(Memory.Current)) .. "." .. math.random(10, 99))
						else
							Memory.Current = tostring(math.random(Memory.Base - 4, Memory.Base + 3)) .. "." .. tostring(math.random(10, 99))
						end
						if # Memory.History == 10 then
							table.remove(Memory.History, 10)
						end
						table.insert(Memory.History, tonumber(Memory.Current))
					end
					return Memory.Current
				end
                --
				local MemoryViewer = nil
                --
				repeat
					wait()
				until game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("PerformanceStats")
                --
				for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats:GetChildren()) do
					if v.Name == "PS_Button" then
						if v.StatsMiniTextPanelClass.TitleLabel.Text == "Mem" then
							Utility:Connection(RunService.RenderStepped, function()
								LPH_JIT_MAX(function()
									if getgenv().MemSpoofer.Enabled then
										v.StatsMiniTextPanelClass.ValueLabel.Text = Memory.Display .. " MB"
									end
								end)()
							end)
							MemoryViewer = v.StatsMiniTextPanelClass.ValueLabel
						end
                        --
						if v.StatsMiniTextPanelClass.TitleLabel.Text == "Ping" then
							Utility:Connection(v.StatsMiniTextPanelClass.ValueLabel:GetPropertyChangedSignal("Text"), function()
								if getgenv().MemSpoofer.Enabled then
									if MemoryViewer ~= nil then
										local New = getNewMemory()
										Memory.Display = tostring(New)
										MemoryViewer.Text = New .. " MB"
									end
								end
							end)
						end
					end
				end
                --
				Utility:Connection(RunService.RenderStepped, function()
					LPH_JIT_MAX(function()
						if getgenv().MemSpoofer.Enabled then
							local s, e = pcall(function()
								if game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame.TextLabel.Text == "Memory" then
									for i, v in pairs(game:GetService("CoreGui").RobloxGui.PerformanceStats["PS_Viewer"].Frame:GetChildren()) do
										if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Current') then
											v.Label.Text = "Current: " .. Memory.Current .. " MB"
										end
										if v.Name == "PS_DecoratedValueLabel" and string.find(v.Label.Text, 'Average') then
											v.Label.Text = "Average: " .. string.sub(getAverageMemory(), 1, 6) .. " MB"
										end
									end
								end
							end)
							pcall(function()
								game:GetService("CoreGui").DevConsoleMaster.DevConsoleWindow.DevConsoleUI.TopBar.LiveStatsModule["MemoryUsage_MB"].Text = math.round(tonumber(Memory.Current)) .. " MB"
							end)
						end
					end)()
				end)
			end)()
		end)
        --
		Utility:Connection(RunService.RenderStepped, function()
			LPH_JIT_MAX(function()
				if getgenv().Silent.Enabled then
					if getgenv().Silent.Enabled or getgenv().Camlock.Enabled then
						Utility:ThreadFunction(Osiris.UpdateFieldOfView, "2x01")
					end --// Update FOV
                    --
					if getgenv().Silent.Enabled and getgenv().Silent.Mode == "FOV" then
						Osiris:GetSilentAimTarget()
                        --
						if Osiris.Locals.TargetSilent then
							PriorityRelationSilent = Osiris.Locals.TargetSilent.Player
						else
							PriorityRelationSilent = nil
						end
					end --// Update TARGET FOV MODE ( SILENT )
                    --
					if getgenv().Camlock.Enabled and getgenv().Silent.Mode == "FOV" then
						Osiris:GetAimAssistTarget()
                        --
						if Osiris.Locals.TargetAssist then
							PriorityRelationAssist = Osiris.Locals.TargetAssist.Player
						else
							PriorityRelationAssist = nil
						end
					end --// Update TARGET FOV MODE ( ASSIST )
                    --
					if getgenv().Camlock.Enabled and PriorityRelationAssist and Osiris.Locals.TargetAssist then
						Osiris:ActivateAimAssist()
					end
                    --
					if getgenv().Silent.AutoPrediction then
						local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
						local ping = tonumber(string.match(pingvalue, "[%d%.]+")) or 60
						if ping >= 130 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping130_140
                        elseif ping >= 120 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping120_130
                        elseif ping >= 110 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping110_120
                        elseif ping >= 100 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping100_110
                        elseif ping >= 90 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping90_100
                        elseif ping >= 80 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping80_90
                        elseif ping >= 70 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping70_80
                        elseif ping >= 60 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping60_70
                        elseif ping >= 50 then
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping50_60
                        else
                            getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping30_40
                        end
					end
                    --
					if CurrentGame.HoodGame then
						if getgenv().HitChance then
							if getgenv().Silent.Enabled and PriorityRelationSilent and PriorityRelationSilent.Character then
								if PriorityRelationSilent.Character.Humanoid.Health < 1 then
									PriorityRelationSilent = nil
									Osiris.Locals.TargetSilent = nil
								end
							end
                            --
							if getgenv().Camlock.Enabled and PriorityRelationAssist and PriorityRelationAssist.Character then
								if PriorityRelationAssist.Character.Humanoid.Health < 1 then
									PriorityRelationAssist = nil
									Osiris.Locals.TargetAssist = nil
								end
							end
						end
                        --
						if getgenv().HitChance and getgenv().HitChance.AutoReload then
							if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") and game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
								game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"))
							end
						end
					end
				end
				Visuals:Update()
			end)()
		end)
        --
		for index, player in pairs(Osiris:GetPlayers()) do
			if (player.Character) then
				Osiris:CharacterEvent(player.Character)
			end
			Utility:Connection(player.CharacterAdded, function()
				task.wait()
				Osiris:CharacterEvent(player.Character)
			end)
		end
        --
		Utility:Connection(Players.PlayerAdded, function(Player)
			if (Player.Character) then
				Osiris:CharacterEvent(Player.Character)
			end
            --
			Utility:Connection(Player.CharacterAdded, function(Character)
				task.wait()
				Osiris:CharacterEvent(Character)
			end)
            --
		end)
	end
    --
	do -- Hooks
	end
    --
	do -- Websockets
	end
end

local OsirisMisc = {
    Misc            = {}
}


if (getgenv().Misc.AntiFling) then 
    if (Players.LocalPlayer ~= nil and Players.LocalPlayer.Character ~= nil and Players.LocalPlayer.Character.PrimaryPart ~= nil) then
        table.insert(OsirisMisc.Misc, RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function() 
            pcall(LPH_NO_VIRTUALIZE(function() 
                local OldVelocity = Players.LocalPlayer.Character.PrimaryPart.Velocity
                Players.LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                RunService.RenderStepped:Wait()
                Players.LocalPlayer.Character.PrimaryPart.Velocity = OldVelocity
            end))
        end)))
        
    end
end

repeat task.wait() until game:IsLoaded();



end, function(err) warn("[Osiri original runtime] "..tostring(err)); return err end)
if not originalOK then warn("[Osiri] Original mechanics encountered an error; configuration menu will still open.") end

-- UI is separate from the original logic so it still opens if a game-specific handler errors.
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local uiRoot = Players.LocalPlayer:WaitForChild("PlayerGui")
local previous = uiRoot:FindFirstChild("OsiriRemakeMenu")
if previous then previous:Destroy() end
local ui = Instance.new("ScreenGui")
ui.Name = "OsiriRemakeMenu"
ui.ResetOnSpawn = false
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.Parent = uiRoot
local function new(kind, props, parent)
    local obj = Instance.new(kind)
    for k,v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end
local bg = new("Frame", {Size=UDim2.fromOffset(520,385), Position=UDim2.new(0.5,-260,0.5,-192),BackgroundColor3=Color3.fromRGB(18,20,32),BorderSizePixel=0}, ui)
new("UICorner",{CornerRadius=UDim.new(0,12)},bg)
local title = new("TextLabel",{Text="OSIRI REMAKE   |   ORIGINAL CONFIG",TextColor3=Color3.fromRGB(230,229,255),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=16,TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromOffset(18,8),Size=UDim2.fromOffset(420,36)},bg)
new("TextLabel",{Text="RightShift = open / close",TextColor3=Color3.fromRGB(145,148,179),BackgroundTransparency=1,Font=Enum.Font.Gotham,TextSize=11,TextXAlignment=Enum.TextXAlignment.Right,Position=UDim2.fromOffset(324,354),Size=UDim2.fromOffset(180,20)},bg)
local sidebar = new("Frame",{Position=UDim2.fromOffset(12,48),Size=UDim2.fromOffset(130,294),BackgroundTransparency=1},bg)
new("UIListLayout",{Padding=UDim.new(0,6)},sidebar)
local pane = new("ScrollingFrame",{Position=UDim2.fromOffset(150,48),Size=UDim2.fromOffset(358,295),BackgroundColor3=Color3.fromRGB(25,28,43),BorderSizePixel=0,ScrollBarThickness=4,CanvasSize=UDim2.fromOffset(0,0)},bg)
new("UICorner",{CornerRadius=UDim.new(0,8)},pane)
local layout=new("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder},pane)
new("UIPadding",{PaddingTop=UDim.new(0,9),PaddingBottom=UDim.new(0,9),PaddingLeft=UDim.new(0,9),PaddingRight=UDim.new(0,9)},pane)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() pane.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y+22) end)
local pages = {}
local current
local function refresh()
    for k,arr in pairs(pages) do
        for _,w in ipairs(arr) do w.Visible=(k==current) end
    end
end
local function add(kind, title, getter, setter, opts)
    local row=new("Frame",{Size=UDim2.new(1,-7,0,39),BackgroundColor3=Color3.fromRGB(36,39,59),BorderSizePixel=0},pane)
    new("UICorner",{CornerRadius=UDim.new(0,7)},row)
    new("TextLabel",{Size=UDim2.new(0.53,0,1,0),Position=UDim2.fromOffset(10,0),Text=title,TextColor3=Color3.fromRGB(225,225,240),Font=Enum.Font.Gotham,TextSize=12,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left},row)
    if kind=="toggle" then
        local b=new("TextButton",{Position=UDim2.new(1,-91,0,6),Size=UDim2.fromOffset(82,27),Font=Enum.Font.GothamBold,TextSize=12,BorderSizePixel=0},row)
        new("UICorner",{CornerRadius=UDim.new(0,6)},b)
        local function paint() local v=getter(); b.Text=v and "ON" or "OFF"; b.BackgroundColor3=v and Color3.fromRGB(85,91,184) or Color3.fromRGB(65,67,83);b.TextColor3=Color3.new(1,1,1) end
        b.MouseButton1Click:Connect(function() setter(not getter()); paint() end)
        paint()
    elseif kind=="value" then
        local entry=new("TextBox",{Position=UDim2.new(1,-118,0,6),Size=UDim2.fromOffset(108,27),Text=tostring(getter()),Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(250,250,255),BackgroundColor3=Color3.fromRGB(54,57,82),ClearTextOnFocus=false,BorderSizePixel=0},row)
        new("UICorner",{CornerRadius=UDim.new(0,6)},entry)
        entry.FocusLost:Connect(function() local n=tonumber(entry.Text); if n then setter(math.clamp(n,opts[1],opts[2])) end;entry.Text=tostring(getter()) end)
    elseif kind=="cycle" then
        local b=new("TextButton",{Position=UDim2.new(1,-118,0,6),Size=UDim2.fromOffset(108,27),Text=tostring(getter()),Font=Enum.Font.Gotham,TextSize=11,TextColor3=Color3.new(1,1,1),BackgroundColor3=Color3.fromRGB(85,91,184),BorderSizePixel=0},row)
        new("UICorner",{CornerRadius=UDim.new(0,6)},b)
        b.MouseButton1Click:Connect(function() local currentIndex=table.find(opts,getter()) or 0;setter(opts[currentIndex % #opts+1]);b.Text=tostring(getter()) end)
    end
    table.insert(pages[current],row)
end
local function tab(name)
    pages[name]={}
    local b=new("TextButton",{Size=UDim2.new(1,0,0,34),Text=name,TextColor3=Color3.fromRGB(238,236,255),BackgroundColor3=Color3.fromRGB(43,46,70),Font=Enum.Font.GothamSemibold,TextSize=12,BorderSizePixel=0},sidebar)
    new("UICorner",{CornerRadius=UDim.new(0,7)},b)
    b.MouseButton1Click:Connect(function() current=name;refresh() end)
    current=name
end
local g=getgenv()
local function toggle(label,obj,key) add("toggle",label,function()return obj[key] end,function(v)obj[key]=v end) end
local function val(label,obj,key,low,high) add("value",label,function()return obj[key] end,function(v)obj[key]=v end,{low,high}) end
local function cycle(label,obj,key,choices) add("cycle",label,function()return obj[key] end,function(v)obj[key]=v end,choices) end
tab("Silent Aim")
toggle("Enabled",g.Silent,"Enabled")
cycle("Mode",g.Silent,"Mode",{"FOV","Target"})
cycle("Mode Type",g.Silent,"ModeType",{"Safe","Unlegit"})
cycle("Hit Mode",g.Silent,"HitMode",{"ClosestPoint","ClosestBodypart"})
toggle("Auto Prediction",g.Silent,"AutoPrediction")
val("Prediction",g.Silent,"Prediction",0,0.5)
toggle("Hit Visualizer",g.Silent,"RegularModeVisualizer")
toggle("FOV Circle",g.FOV,"Visible")
val("FOV Radius",g.FOV,"Radius",0,1000)
tab("Camlock")
toggle("Enabled",g.Camlock,"Enabled")
toggle("Use Target",g.Camlock,"UseTarget")
toggle("Safety Measures",g.Camlock,"SafetyMeasures")
val("FOV",g.Camlock,"FOV",0,1000)
val("Prediction",g.Camlock,"Prediction",0,0.5)
val("Smoothness",g.Camlock,"Smoothness",0,1)
toggle("Airshot",g.Camlock,"AirShot")
tab("Combat")
toggle("Triggerbot",g.TriggerBot,"Enabled")
val("Trigger FOV",g.TriggerBot.FOV,"Radius",0,100)
toggle("Resolver",g.Resolver,"Enabled")
cycle("Resolver Type",g.Resolver,"Type",{"Osiris","Roblox"})
toggle("No Floor Shots",g.SafetyMeasures,"NoFloorShots")
toggle("Wall Check",g.Checks,"Wall")
toggle("Visible Check",g.Checks,"Visible")
toggle("Team Check",g.Checks,"Team")
toggle("Alive Check",g.Checks,"Alive")
tab("Movement")
toggle("Macro",g.Macro,"Enabled")
cycle("Macro Type",g.Macro,"Type",{"First","Third"})
toggle("NoClip Macro",g.Macro,"NoClipMacro")
val("Macro Delay",g.Macro,"Delay",0.001,1)
toggle("Anti-Lock",g.Anti_Lock,"Enabled")
cycle("Anti-Lock Type",g.Anti_Lock,"Type",{"Sides","NormalDS","PredictionDisabler"})
tab("Misc")
toggle("FPS Boost",g.Misc,"FPSBoost")
toggle("Anti Fling",g.Misc,"AntiFling")
toggle("Remove Seats",g.Misc,"RemoveSeats")
toggle("FOV Box",g.FovSettings.BoxFOV,"Visible")
toggle("Tracer",g.Tracer,"Visible")
toggle("Chat Commands",g.Chat,"Enabled")
current="Silent Aim"
refresh()
UIS.InputBegan:Connect(function(input,processed)
    if not processed and input.KeyCode==Enum.KeyCode.RightShift then bg.Visible=not bg.Visible end
end)
local dragging,dragStart,startPos
title.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=input.Position;startPos=bg.Position end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
        local d=input.Position-dragStart
        bg.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
