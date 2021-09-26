--https://github.com/Mokiros/roblox-FE-compatibility
if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,game,owner = owner,game
local RealPlayer = Player
do
	print("FE Compatibility code V2 by Mokiros")
	local RealPlayer = RealPlayer
	script.Parent = RealPlayer.Character

	--Fake event to make stuff like Mouse.KeyDown work
	local Disconnect_Function = function(this)
		this[1].Functions[this[2]] = nil
	end
	local Disconnect_Metatable = {__index={disconnect=Disconnect_Function,Disconnect=Disconnect_Function}}
	local FakeEvent_Metatable = {__index={
		Connect = function(this,f)
			local i = tostring(math.random(0,10000))
			while this.Functions[i] do
				i = tostring(math.random(0,10000))
			end
			this.Functions[i] = f
			return setmetatable({this,i},Disconnect_Metatable)
		end
	}}
	FakeEvent_Metatable.__index.connect = FakeEvent_Metatable.__index.Connect
	local function fakeEvent()
		return setmetatable({Functions={}},FakeEvent_Metatable)
	end

	--Creating fake input objects with fake variables
	local FakeMouse = {Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent(),Button2Up=fakeEvent(),Button2Down=fakeEvent()}
	FakeMouse.keyUp = FakeMouse.KeyUp
	FakeMouse.keyDown = FakeMouse.KeyDown
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	--Merged 2 functions into one by checking amount of arguments
	CAS.UnbindAction = CAS.BindAction

	--This function will trigger the events that have been :Connect()'ed
	local function TriggerEvent(self,ev,...)
		for _,f in pairs(self[ev].Functions) do
			f(...)
		end
	end
	FakeMouse.TriggerEvent = TriggerEvent
	UIS.TriggerEvent = TriggerEvent

	--Client communication
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"
	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=RealPlayer then return end
		FakeMouse.Target = io.Target
		FakeMouse.Hit = io.Hit
		if not io.isMouse then
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return FakeMouse:TriggerEvent(b and "Button1Down" or "Button1Up")
			end
			if io.UserInputType == Enum.UserInputType.MouseButton2 then
				return FakeMouse:TriggerEvent(b and "Button2Down" or "Button2Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			FakeMouse:TriggerEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TriggerEvent(b and "InputBegan" or "InputEnded",io,false)
		end
	end)
	Event.Parent = NLS([==[local Event = script:WaitForChild("UserInput_Event")
	local Mouse = owner:GetMouse()
	local UIS = game:GetService("UserInputService")
	local input = function(io,RobloxHandled)
		if RobloxHandled then return end
		--Since InputObject is a client-side instance, we create and pass table instead
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState,Hit=Mouse.Hit,Target=Mouse.Target})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local h,t
	--Give the server mouse data every second frame, but only if the values changed
	--If player is not moving their mouse, client won't fire events
	local HB = game:GetService("RunService").Heartbeat
	while true do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
		--Wait 2 frames
		for i=1,2 do
			HB:Wait()
		end
	end]==],script)

	----Sandboxed game object that allows the usage of client-side methods and services
	--Real game object
	local RealGame = game

	--Metatable for fake service
	local FakeService_Metatable = {
		__index = function(self,k)
			local s = rawget(self,"_RealService")
			if s then
				return typeof(s[k])=="function"
					and function(_,...)return s[k](s,...)end or s[k]
			end
		end,
		__newindex = function(self,k,v)
			local s = rawget(self,"_RealService")
			if s then s[k]=v end
		end
	}
	local function FakeService(t,RealService)
		t._RealService = typeof(RealService)=="string" and RealGame:GetService(RealService) or RealService
		return setmetatable(t,FakeService_Metatable)
	end

	--Fake game object
	local FakeGame = {
		GetService = function(self,s)
			return rawget(self,s) or RealGame:GetService(s)
		end,
		Players = FakeService({
			LocalPlayer = FakeService({GetMouse=function(self)return FakeMouse end},Player)
		},"Players"),
		UserInputService = FakeService(UIS,"UserInputService"),
		ContextActionService = FakeService(CAS,"ContextActionService"),
		RunService = FakeService({
			_btrs = {},
			RenderStepped = RealGame:GetService("RunService").Heartbeat,
			BindToRenderStep = function(self,name,_,fun)
				self._btrs[name] = self.Heartbeat:Connect(fun)
			end,
			UnbindFromRenderStep = function(self,name)
				self._btrs[name]:Disconnect()
			end,
		},"RunService")
	}
	rawset(FakeGame.Players,"localPlayer",FakeGame.Players.LocalPlayer)
	FakeGame.service = FakeGame.GetService
	FakeService(FakeGame,game)
	--Changing owner to fake player object to support owner:GetMouse()
	game,owner = FakeGame,FakeGame.Players.LocalPlayer
end

local char = owner.Character
local hum = char:FindFirstChildWhichIsA("Humanoid")
local chatDbc = false

if hum.RigType == Enum.HumanoidRigType.R6 then
	print("Script has loaded succesfuly.")
else
	warn("This script doesnt have R15 compatibility, change your body type to R6 and execute script again.")
end

if hum.RigType == Enum.HumanoidRigType.R15 then return end

local bc = char:FindFirstChildWhichIsA("BodyColors")
if bc then
	bc.RightArmColor = BrickColor.new("Cool yellow")
	bc.LeftArmColor = BrickColor.new("Cool yellow")
	bc.RightLegColor = BrickColor.new("Bright blue")
	bc.LeftLegColor = BrickColor.new("Bright blue")
	bc.TorsoColor = BrickColor.new("Dark green")
	bc.HeadColor = BrickColor.new("Cool yellow")
end

for _,i in pairs(char:GetDescendants()) do
	if i:IsA("Accessory") or i:IsA("Shirt") or i:IsA("Pants") then
		i:Destroy()
	elseif i:IsA("Decal") then
		if string.match(string.lower(i.Name), "face") then
			i.Texture = "rbxasset://textures/face.png"
		end
	end
end

--chat

BillboardGui0 = Instance.new("BillboardGui")
Frame1 = Instance.new("Frame")
TextLabel2 = Instance.new("TextLabel")
BillboardGui0.Parent = char.Head
BillboardGui0.LightInfluence = 1
BillboardGui0.Size = UDim2.new(8, 0, 3, 0)
BillboardGui0.Active = true
BillboardGui0.ClipsDescendants = true
BillboardGui0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui0.AlwaysOnTop = true
BillboardGui0.StudsOffset = Vector3.new(0, 3, 0)
Frame1.Parent = BillboardGui0
Frame1.Size = UDim2.new(1, 0, 1, 0)
Frame1.BackgroundColor = BrickColor.new("Institutional white")
Frame1.BackgroundColor3 = Color3.new(1, 1, 1)
Frame1.Style = Enum.FrameStyle.ChatBlue
TextLabel2.Parent = Frame1
TextLabel2.Position = UDim2.new(0, 0, -0.0500000007, 0)
TextLabel2.Size = UDim2.new(1, 0, 1.10000002, 0)
TextLabel2.BackgroundColor = BrickColor.new("Institutional white")
TextLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel2.BackgroundTransparency = 1
TextLabel2.Font = Enum.Font.Cartoon
TextLabel2.FontSize = Enum.FontSize.Size14
TextLabel2.Text = ""
TextLabel2.TextColor = BrickColor.new("Really black")
TextLabel2.TextColor3 = Color3.new(0, 0, 0)
TextLabel2.TextScaled = true
TextLabel2.TextSize = 14
TextLabel2.TextWrap = true
TextLabel2.TextWrapped = true

--hat

Accessory0 = Instance.new("Accessory")
Part1 = Instance.new("Part")
SpecialMesh2 = Instance.new("SpecialMesh")
Vector3Value3 = Instance.new("Vector3Value")
Weld4 = Instance.new("Weld")
Accessory0.Name = "RobloxVisor2017"
Accessory0.Parent = char
Accessory0.AttachmentPoint = CFrame.new(0, 0.0900000036, 0.180000007, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Accessory0.AttachmentPos = Vector3.new(0, 0.090000003576279, 0.18000000715256)
Part1.Name = "Handle"
Part1.Parent = Accessory0
Part1.CFrame = CFrame.new(134.199997, 4.90999889, -103.779724, 1, -7.87137555e-09, -1.12103877e-43, 7.87137555e-09, 1, 4.1444221e-16, -3.26223034e-24, -4.1444221e-16, 1)
Part1.Position = Vector3.new(134.19999694824, 4.9099988937378, -103.77972412109)
Part1.Size = Vector3.new(1, 0.40000000596046, 1)
Part1.Anchored = false
Part1.BottomSurface = Enum.SurfaceType.Smooth
Part1.CanCollide = false
Part1.Massless = true
Part1.Locked = true
Part1.TopSurface = Enum.SurfaceType.Smooth
Part1.FormFactor = Enum.FormFactor.Plate
Part1.formFactor = Enum.FormFactor.Plate
SpecialMesh2.Parent = Part1
SpecialMesh2.MeshId = "http://www.roblox.com/asset/?id=1081088"
SpecialMesh2.Scale = Vector3.new(1.0199999809265, 1.0199999809265, 1.0199999809265)
SpecialMesh2.TextureId = "http://www.roblox.com/asset/?id=581789466"
SpecialMesh2.MeshType = Enum.MeshType.FileMesh
Vector3Value3.Name = "OriginalSize"
Vector3Value3.Parent = Part1
Vector3Value3.Value = Vector3.new(1, 0.40000000596046, 1)
Weld4.Name = "AccessoryWeld"
Weld4.Parent = Part1
Weld4.C0 = CFrame.new(8.65838956e-09, 0.190000057, 0.179727763, 1, 7.87137555e-09, -3.26223034e-24, -7.87137555e-09, 1, -4.1444221e-16, 0, 4.1444221e-16, 1)
Weld4.C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Weld4.Part0 = Part1
Weld4.Part1 = char.Head
	
talk = Instance.new("Sound")
PitchShiftSoundEffect1 = Instance.new("PitchShiftSoundEffect")
talk.Name = "talk"
talk.Parent = char.Head
talk.MaxDistance = 110
talk.Pitch = 2
talk.PlaybackSpeed = 2
talk.RollOffMode = Enum.RollOffMode.Linear
talk.SoundId = "rbxassetid://5417004822"
PitchShiftSoundEffect1.Parent = talk
PitchShiftSoundEffect1.Octave = 2

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if TextLabel2.Text == "" then
			BillboardGui0.Enabled = false
		else
			BillboardGui0.Enabled = true
		end
	end
end))

function chatted(msg)
	if chatDbc == false then
		chatDbc = true
		for i = 1, #msg, 1 do
			talk:Play()
			TextLabel2.Text = string.sub(msg, 1, i)
			task.wait()
		end
		wait(3)
		for i = #msg, 1, -1 do
			TextLabel2.Text = string.sub(msg, 1, i)
			task.wait()
		end
		TextLabel2.Text = ""
		chatDbc = false
	end
end

owner.Chatted:Connect(chatted)
