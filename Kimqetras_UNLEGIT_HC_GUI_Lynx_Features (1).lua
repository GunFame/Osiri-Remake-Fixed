warn("Kimqetras UNLEGIT HC source rebuild")
-- Kimqetras UNLEGIT • startup repair 2
-- This small launcher reports compile/runtime errors before the larger body runs.
local Players=game:GetService('Players')
local player=Players.LocalPlayer
if not player then Players:GetPropertyChangedSignal('LocalPlayer'):Wait();player=Players.LocalPlayer end
local playerGui=player:WaitForChild('PlayerGui',15)
assert(playerGui,'Kimqetras UNLEGIT: PlayerGui did not become available.')
local parent=playerGui
local boot=Instance.new('ScreenGui');boot.Name='KimqetrasUNLEGIT_Startup';boot.ResetOnSpawn=false;boot.IgnoreGuiInset=true;boot.DisplayOrder=100001
local ok=pcall(function()boot.Parent=parent end);if not ok or not boot.Parent then parent=playerGui;boot.Parent=parent end
for _,child in ipairs(parent:GetChildren())do if child~=boot and child.Name=='KimqetrasUNLEGIT_Startup'then child:Destroy()end end
local frame=Instance.new('Frame');frame.Size=UDim2.new(0,410,0,230);frame.AnchorPoint=Vector2.new(.5,.5);frame.Position=UDim2.fromScale(.5,.5);frame.BackgroundColor3=Color3.fromRGB(22,22,28);frame.BorderSizePixel=0;frame.Parent=boot
local corner=Instance.new('UICorner');corner.CornerRadius=UDim.new(0,10);corner.Parent=frame
local title=Instance.new('TextLabel');title.Size=UDim2.new(1,-24,0,38);title.Position=UDim2.fromOffset(12,6);title.BackgroundTransparency=1;title.Font=Enum.Font.GothamBold;title.TextSize=17;title.TextColor3=Color3.new(1,1,1);title.Text='Kimqetras UNLEGIT';title.Parent=frame
local message=Instance.new('TextLabel');message.Size=UDim2.new(1,-24,1,-100);message.Position=UDim2.fromOffset(12,44);message.BackgroundTransparency=1;message.TextColor3=Color3.fromRGB(210,210,220);message.TextSize=14;message.Font=Enum.Font.Code;message.TextWrapped=true;message.TextYAlignment=Enum.TextYAlignment.Top;message.Text='Starting…';message.Parent=frame
local details=''
local function button(name,x,fn)
 local b=Instance.new('TextButton');b.Size=UDim2.new(.5,-18,0,30);b.Position=UDim2.new(x,12,1,-42);b.BackgroundColor3=Color3.fromRGB(40,40,48);b.TextColor3=Color3.new(1,1,1);b.Font=Enum.Font.Gotham;b.TextSize=13;b.Text=name;b.Parent=frame;b.Activated:Connect(fn);return b
end
local copy=button('Copy error',0,function()if type(setclipboard)=='function'then setclipboard(details);message.Text='Error copied. Paste it in the chat.'else message.Text=details:sub(1,950)end end);copy.Visible=false
local close=button('Close',.5,function()boot:Destroy()end)
local function fail(stage,err)
 details='Kimqetras UNLEGIT / '..stage..'\n'..tostring(err)
 warn(details)
 if boot.Parent then title.Text='UNLEGIT • '..stage;message.Text=details:sub(1,950);copy.Visible=true end
end
if type(loadstring)~='function'then fail('Load error','This runtime does not provide loadstring.');return end

local source=[========[
-- Kimqetras UNLEGIT: independent HC interface, local Lynx-source features.
local Players=game:GetService('Players')
local RunService=game:GetService('RunService')
local UIS=game:GetService('UserInputService')
local Http=game:GetService('HttpService')
local Lighting=game:GetService('Lighting')
local TweenService=game:GetService('TweenService')
local Debris=game:GetService('Debris')
local lp=Players.LocalPlayer
local pg=assert(lp:WaitForChild('PlayerGui',15),'PlayerGui unavailable')
local mouse=lp:GetMouse()
local previous=_G.KimqetrasUNLEGIT
if previous and previous.Destroy then pcall(function()previous:Destroy()end)end
local U={alive=true,connections={},objects={},state='Ready',errors={},properties={},groups={},bindings={}}
_G.KimqetrasUNLEGIT=U
function U.error(context,err)
 U.state=context..': '..tostring(err)
 if U.errors[context]~=tostring(err)then U.errors[context]=tostring(err);warn('[UNLEGIT] '..U.state)end
end
function U.connect(signal,fn)
 local c=signal:Connect(function(...)if not U.alive then return end;local ok,err=pcall(fn,...);if not ok then U.error('Controller',err)end end)
 table.insert(U.connections,c);return c
end
function U.own(o)table.insert(U.objects,o);return o end
function U.property(group,o,key,value)
 local records=U.groups[group];if not records then records={};U.groups[group]=records end
 local record=records[o];if not record then record={};records[o]=record end
 if not record[key]then record[key]={before=o[key]}end
 if o[key]~=value then o[key]=value end
 record[key].last=value
end
function U.release(group)
 local records=U.groups[group];if not records then return end
 for o,keys in pairs(records)do for key,v in pairs(keys)do pcall(function()if o[key]==v.last then o[key]=v.before end end)end end
 U.groups[group]=nil
end
function U:Destroy()
 if not self.alive then return end;self.alive=false
 if self.stopRuntime then pcall(self.stopRuntime)end
 for name in pairs(self.groups)do self.release(name)end
 for _,c in ipairs(self.connections)do pcall(function()c:Disconnect()end)end
 for _,o in ipairs(self.objects)do pcall(function()o:Destroy()end)end
 if self.gui then pcall(function()self.gui:Destroy()end)end
 if _G.KimqetrasUNLEGIT==self then _G.KimqetrasUNLEGIT=nil end
end

local defaults={Aim=false,Sticky=true,AimPart="Head",Prediction=0,Smoothness=15,AimRange=7500,FOV=180,Deadzone=0,WallCheck=true,ForcefieldCheck=true,KnockedCheck=true,Shake=false,ShakeX=0.01,ShakeY=0.01,ShakeZ=0.01,ShowFOV=false,FilledFOV=false,FOVOpacity=0.2,ShowDeadzone=false,FOVColor="#C82828",PredictionMarker=false,TargetHighlight=false,TargetTracer=false,TargetDot=false,TracerThickness=1,TargetColor="#FF4080",HitObserve=false,HitMarker=false,MarkerType="2D",HitHighlight=false,HitNotify=false,HitDuration=1,HitColor="#FF4080",HitSound=false,HitSoundName="Skeet",HitVolume=1,HitPitch=1,HitParticles=false,ParticleType="Bubble",ESP=false,ESPNames=true,ESPBoxes=true,ESPCorners=false,ESPFill=false,ESPFillOpacity=0.15,ESPWeapon=false,ESPDistance=false,ESPMoney=false,ESPKnocked=false,ESPHealth=true,ESPHealthNumber=false,ESPGradient=true,ESPArrows=false,ESPArrowRadius=180,ESPRange=7500,ESPHighlights=false,ESPColor="#FFFFFF",Speed=false,Walkspeed=16,Bhop=false,JumpPower=50,Fly=false,FlySpeed=40,CharMaterial=false,CharMat="ForceField",CharColor="#C82828",RainbowBody=false,Morph=false,MorphName="AmongUs",GunMaterial=false,GunMat="ForceField",GunColor="#C82828",RainbowGun=false,SineGun=false,Grip=false,GripX=0,GripY=0,GripZ=0,Crosshair=false,CrosshairDot=true,DynamicGap=false,CrosshairSpin=false,CrosshairSpinSpeed=90,CrosshairLength=8,CrosshairGap=6,CrosshairThickness=2,CrosshairColor="#FFFFFF",GunSounds=false,GunSoundName="Skeet",GunVolume=1,GunPitch=1,StompObserve=false,StompEffect="Heart",Ambient=false,AmbientColor="#808080",ColorShift=false,ShiftColor="#FFFFFF",Fog=false,FogColor="#C0C0C0",FogStart=0,FogEnd=7500,Time=false,Hour=12,Sky=false,SkyName="Normal",Correction=false,TintColor="#FFFFFF",Brightness=0,Contrast=0,Saturation=0,Watermark=true,KeybindDisplay=false,MenuScale=1,RainbowSpeed=1}
local numericBounds={Prediction={0,0.5},Smoothness={1,100},AimRange={10,7500},FOV={10,500},Deadzone={0,150},ShakeX={0,5},ShakeY={0,5},ShakeZ={0,5},FOVOpacity={0,1},TracerThickness={1,5},HitDuration={0.1,5},HitVolume={0,10},HitPitch={0.1,3},ESPFillOpacity={0,1},ESPArrowRadius={50,500},ESPRange={50,10000},Walkspeed={0,150},JumpPower={10,150},FlySpeed={1,200},GripX={-10,10},GripY={-10,10},GripZ={-10,10},CrosshairSpinSpeed={0,360},CrosshairLength={1,50},CrosshairGap={0,50},CrosshairThickness={1,5},GunVolume={0,10},GunPitch={0.1,3},FogStart={0,10000},FogEnd={0,10000},Hour={0,24},Brightness={-1,1},Contrast={-1,1},Saturation={-1,1},MenuScale={0.6,1.4},RainbowSpeed={0.1,5}}
local choices={AimPart={"Head","HumanoidRootPart","UpperTorso","Torso"},MarkerType={"2D","3D"},HitSoundName={"Bameware","Skeet","Bonk","Lazer Beam","Windows XP Error","TF2 Hitsound","TF2 Critical","TF2 Bat","Bow Hit","Bow","OSU","Minecraft Hit","Steve","1nn","Rust","TF2 Pan","Neverlose","Mario"},ParticleType={"Bubble","Confetti"},CharMat={"ForceField","Neon","Plastic"},MorphName={"AmongUs","SpongeBob","Patrick","Maxell","Brian","CapyBara","Chicken","Sonic"},GunMat={"ForceField","Neon","Plastic"},GunSoundName={"Bameware","Skeet","Bonk","Lazer Beam","Windows XP Error","TF2 Hitsound","TF2 Critical","TF2 Bat","Bow Hit","Bow","OSU","Minecraft Hit","Steve","1nn","Rust","TF2 Pan","Neverlose","Mario"},StompEffect={"Glitch","Explosion","Airstrike","Heart","UFO"},SkyName={"Normal","DoomSpire","CatGirl","Vibe","Blue Aurora","Purple Clouds","Purple Nebula","Purple and Blue","Vivid Skies","Twighlight"}}
local decimals={Prediction=3,Smoothness=0,AimRange=0,FOV=0,Deadzone=0,ShakeX=2,ShakeY=2,ShakeZ=2,FOVOpacity=2,TracerThickness=0,HitDuration=1,HitVolume=1,HitPitch=1,ESPFillOpacity=2,ESPArrowRadius=0,ESPRange=0,Walkspeed=0,JumpPower=0,FlySpeed=0,GripX=2,GripY=2,GripZ=2,CrosshairSpinSpeed=0,CrosshairLength=0,CrosshairGap=0,CrosshairThickness=0,GunVolume=1,GunPitch=1,FogStart=0,FogEnd=0,Hour=1,Brightness=2,Contrast=2,Saturation=2,MenuScale=2,RainbowSpeed=1}
local colorKeys={FOVColor=true,TargetColor=true,HitColor=true,ESPColor=true,CharColor=true,GunColor=true,CrosshairColor=true,AmbientColor=true,ShiftColor=true,FogColor=true,TintColor=true}

local S={};for k,v in pairs(defaults)do S[k]=v end
U.settings=S
function U.set(k,v)
 if defaults[k]==nil or type(v)~=type(defaults[k])then return false end
 if type(v)=='number'then
  if v~=v or math.abs(v)==math.huge then return false end
  if numericBounds[k]then v=math.clamp(v,numericBounds[k][1],numericBounds[k][2])end
 end
 if choices[k]and not table.find(choices[k],v)then return false end
 if colorKeys[k]then if not v:match('^#%x%x%x%x%x%x$')then return false end;v=v:upper()end
 S[k]=v
 if U.changed then U.changed(k)end
 if U.refresh then U.refresh()end
 return true
end
function U.color(key)return Color3.fromHex(S[key]or '#FFFFFF')end
function U.character(p)
 local c=p and p.Character;return c,c and c:FindFirstChildOfClass('Humanoid'),c and c:FindFirstChild('HumanoidRootPart')
end
function U.knocked(c)
 local b=c and c:FindFirstChild('BodyEffects');local k=b and(b:FindFirstChild('K.O')or b:FindFirstChild('KO'));return k and(k.Value==true or k.Value==1)or false
end

local ASSETS={}
ASSETS.sfx={
        ["Bameware"] = "3124331820",
        ["Skeet"] = "4753603610",
        ["Bonk"] = "3765689841",
        ["Lazer Beam"] = "130791043",
        ["Windows XP Error"] = "160715357",
        ["TF2 Hitsound"] = "3455144981",
        ["TF2 Critical"] = "296102734",
        ["TF2 Bat"] = "3333907347",
        ['Bow Hit'] = "1053296915",
        ['Bow'] = "3442683707",
        ['OSU'] = "7147454322",
        ['Minecraft Hit'] = "4018616850",
        ['Steve'] = "5869422451",
        ['1nn'] = "7349055654",
        ['Rust'] = "3744371091",
        ["TF2 Pan"] = "3431749479",
        ["Neverlose"] = "8679627751",
        ["Mario"] = "5709456554",
    }
ASSETS.SkyBoxes={
        ["Normal"] = {600886090,600830446,600831635,600832720,600833862,600835177},
        ["DoomSpire"] = {6050649245,6050664592,6050648475,6050644331,6050649718,6050650083},
        ["CatGirl"] = {444167615,444167615,444167615,444167615,444167615,444167615},
        ["Vibe"] = {1417494402,1417494030,1417494146,1417494253,1417494499,1417494643},
        ["Blue Aurora"] = {12063984,12064107,12064152,12064121,12064115,12064131},
        ["Purple Clouds"] = {151165191,151165214,151165197,151165224,151165206,151165227},
        ["Purple Nebula"] = {159454286,159454299,159454296,159454293,159454300,159454288},
        ["Twighlight"] = {264909758,264908339,264907909,264909420,264908886,264907379},
        ["Vivid Skies"] = {271042310,271042516,271077243,271042556,271042467,271077958},
        ["Purple and Blue"] = {149397684,149397692,149397686,149397697,149397688,149397702},
    }
ASSETS.Characters={
		AmongUs = {Vector3.new(0.15,0.15,0.15), "6686375937", "6686375902"}, 
		SpongeBob = {Vector3.new(5,5,5), "5408463358", "5408463211"},
		Patrick = {Vector3.new(0.4,0.4,0.4), "5730253510", "5730253467"}, 
		Maxell = {Vector3.new(0.2,0.2,0.2), "12303996609", "12303996327"},
		Brian = {Vector3.new(1.7,1.7,1.7), "512454212", "512454192"},
		CapyBara = {Vector3.new(2,2,2), "11255227067", "11255226712"},
		Chicken = {Vector3.new(3, 3, 3), "2114220248", "2114220154"},
		Sonic = {Vector3.new(0.15,0.15,0.15), "6901422268", "6901422170"},
	}

    local COL={
        main=Color3.fromRGB(22,22,28),
        main2=Color3.fromRGB(28,28,35),
        main3=Color3.fromRGB(20,20,26),
        section=Color3.fromRGB(30,30,38),
        field=Color3.fromRGB(28,28,36),
        field2=Color3.fromRGB(24,24,30),
        track=Color3.fromRGB(38,38,48),
        stroke=Color3.fromRGB(55,55,68),
        accent=Color3.fromRGB(200,40,40),
        accentFill=Color3.fromRGB(210,45,45),
        accentStroke=Color3.fromRGB(230,70,70),
        accentDark=Color3.fromRGB(80,10,15),
        text=Color3.fromRGB(255,255,255),
        sub=Color3.fromRGB(160,160,175),
        dim=Color3.fromRGB(150,150,150),
        tab=Color3.fromRGB(195,195,195),
        title=Color3.fromRGB(168,168,168),
        subtitle=Color3.fromRGB(100,100,115),
        value=Color3.fromRGB(220,220,220),
    }

    local function safeFont(family,weight,fallback)
        local ok,result=pcall(function()return Font.new(family,weight,Enum.FontStyle.Normal)end)
        if ok then return result end
        return Font.fromEnum(fallback)
    end
    local Gotham=safeFont("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Regular,Enum.Font.Gotham)
    local GothamBold=safeFont("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Bold,Enum.Font.GothamBold)
    local Source=safeFont("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Regular,Enum.Font.SourceSans)

    local function corner(o,r)
        local c=Instance.new("UICorner")
        c.CornerRadius=UDim.new(0,r)
        c.Parent=o
        return c
    end
    local function stroke(o,color,trans,thickness)
        local s=Instance.new("UIStroke")
        s.Color=color or COL.stroke
        s.Transparency=trans or 0
        s.Thickness=thickness or 1
        s.LineJoinMode=Enum.LineJoinMode.Round
        s.Parent=o
        return s
    end
    local function pad(o,l,r,t,b)
        local p=Instance.new("UIPadding")
        p.PaddingLeft=UDim.new(0,l or 0)
        p.PaddingRight=UDim.new(0,r or 0)
        p.PaddingTop=UDim.new(0,t or 0)
        p.PaddingBottom=UDim.new(0,b or 0)
        p.Parent=o
        return p
    end
    local function text(parent,txt,size,pos,textSize,color,font,xalign)
        local l=Instance.new("TextLabel")
        l.BackgroundTransparency=1
        l.BorderSizePixel=0
        l.Text=tostring(txt or "")
        l.Size=size
        l.Position=pos or UDim2.new()
        l.TextSize=textSize or 12
        l.TextColor3=color or COL.text
        l.TextTransparency=0
        l.TextXAlignment=xalign or Enum.TextXAlignment.Left
        l.TextYAlignment=Enum.TextYAlignment.Center
        l.FontFace=font or Gotham
        l.Parent=parent
        return l
    end

    ----------------------------------------------------------------------
    -- ROOT + MAIN WINDOW: recovered Lasion geometry
    ----------------------------------------------------------------------
    local gui=Instance.new("ScreenGui")
    gui.Name="KimqetrasUNLEGIT"
    gui.ResetOnSpawn=false
    gui.IgnoreGuiInset=false
    gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder=10000
    local parent=pg
    local parentOK=pcall(function()gui.Parent=parent end)
    if not parentOK or not gui.Parent then gui.Parent=pg end
    gui.Enabled=true
    U.gui=gui

    local main=Instance.new("Frame")
    main.Name="Frame"
    main.AnchorPoint=Vector2.new(.5,.5)
    main.Position=UDim2.fromScale(.5,.5)
    main.Size=UDim2.fromOffset(550,600)
    main.BackgroundColor3=COL.main
    main.BackgroundTransparency=.2
    main.BorderSizePixel=0
    main.Active=true
    main.Visible=true
    main.Parent=gui
    corner(main,12)
    stroke(main,COL.accent,.4,1.5)

    local mg=Instance.new("UIGradient")
    mg.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(28,28,35)),
        ColorSequenceKeypoint.new(.5,Color3.fromRGB(24,24,30)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(20,20,26))
    })
    mg.Rotation=45
    mg.Parent=main

    -- Lasion uses a second full-size translucent glass layer over the main frame.
    local glass=Instance.new("Frame")
    glass.Name="Frame"
    glass.Position=UDim2.new(0,0,0,0)
    glass.Size=UDim2.new(1,0,1,0)
    glass.BackgroundColor3=Color3.fromRGB(22,22,28)
    glass.BackgroundTransparency=.25
    glass.BorderSizePixel=0
    glass.Parent=main
    corner(glass,12)
    local glassGradient=Instance.new("UIGradient")
    glassGradient.Color=ColorSequence.new(Color3.new(1,1,1),Color3.new(1,1,1))
    glassGradient.Transparency=NumberSequence.new({
        NumberSequenceKeypoint.new(0,.15),
        NumberSequenceKeypoint.new(.5,.25),
        NumberSequenceKeypoint.new(1,.35)
    })
    glassGradient.Rotation=135
    glassGradient.Parent=glass

    local header=Instance.new("Frame")
    header.Name="Header"
    header.Size=UDim2.new(1,0,0,48)
    header.BackgroundTransparency=1
    header.Active=true
    header.ZIndex=2
    header.Parent=main

    text(header,"Kimqetras UNLEGIT",UDim2.new(1,-30,1,0),UDim2.fromOffset(15,0),20,COL.title,Gotham,Enum.TextXAlignment.Center)

    -- Dragging.
    do
        local drag=false
        local startMouse,startPos
        header.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then
                drag=true; startMouse=i.Position; startPos=main.Position
            end
        end)
        U.connect(UIS.InputChanged,function(i)
            if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
                local d=i.Position-startMouse
                main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            end
        end)
        U.connect(UIS.InputEnded,function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
        end)
    end

    ----------------------------------------------------------------------
    -- EXACT LASION TOP TAB BAR
    ----------------------------------------------------------------------
    local tabBar=Instance.new("ScrollingFrame")
    tabBar.AutomaticCanvasSize=Enum.AutomaticSize.X;tabBar.CanvasSize=UDim2.new();tabBar.ScrollingDirection=Enum.ScrollingDirection.X;tabBar.ScrollBarThickness=3;tabBar.ClipsDescendants=true
    tabBar.Name="Tabs"
    tabBar.Position=UDim2.fromOffset(15,58)
    tabBar.Size=UDim2.new(1,-30,0,35)
    tabBar.BackgroundColor3=COL.main
    tabBar.BackgroundTransparency=.5
    tabBar.BorderSizePixel=0
    tabBar.ZIndex=2
    tabBar.Parent=main
    corner(tabBar,6)
    stroke(tabBar,COL.stroke,.6,1)
    local tgrad=Instance.new("UIGradient")
    tgrad.Transparency=NumberSequence.new({
        NumberSequenceKeypoint.new(0,.4),
        NumberSequenceKeypoint.new(.5,.5),
        NumberSequenceKeypoint.new(1,.6)
    })
    tgrad.Rotation=90
    tgrad.Parent=tabBar
    pad(tabBar,7,7,4,0)

    local tl=Instance.new("UIListLayout")
    tl.FillDirection=Enum.FillDirection.Horizontal
    tl.Padding=UDim.new(0,8)
    tl.VerticalAlignment=Enum.VerticalAlignment.Top
    tl.SortOrder=Enum.SortOrder.LayoutOrder
    tl.Parent=tabBar

    local host=Instance.new("Frame")
    host.Position=UDim2.fromOffset(15,103)
    host.Size=UDim2.new(1,-30,1,-108)
    host.BackgroundTransparency=1
    host.ZIndex=2
    host.Parent=main


local TAB_NAMES={'Aim Assist','Target Visuals','Hit Effects','ESP','Movement','Character','Visuals','World','Settings'}
local pages,tabButtons={},{}
    local function page(name)
        local root=Instance.new("Frame")
        root.Name=name.."Page"
        root.Size=UDim2.fromScale(1,1)
        root.BackgroundColor3=COL.main
        root.BackgroundTransparency=.5
        root.BorderSizePixel=0
        root.Visible=false
        root.Parent=host
        corner(root,8)
        stroke(root,COL.stroke,.6,1)
        local g=Instance.new("UIGradient")
        g.Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0,.45),
            NumberSequenceKeypoint.new(.5,.5),
            NumberSequenceKeypoint.new(1,.55)
        })
        g.Rotation=135
        g.Parent=root

        local columns=Instance.new("Frame")
        columns.Size=UDim2.fromScale(1,1)
        columns.BackgroundTransparency=1
        columns.Parent=root

        local function col(side)
            local c=Instance.new("ScrollingFrame")
            c.Name=side
            if side=="left" then
                c.Position=UDim2.new(0,0,0,0)
                c.Size=UDim2.new(.5,-5,1,0)
            else
                c.Position=UDim2.new(.5,5,0,0)
                c.Size=UDim2.new(.5,-5,1,0)
            end
            c.BackgroundTransparency=1
            c.BorderSizePixel=0
            c.ClipsDescendants=true
            c.AutomaticCanvasSize=Enum.AutomaticSize.Y
            c.CanvasSize=UDim2.new()
            c.ScrollBarThickness=3
            c.ScrollBarImageColor3=Color3.new(1,1,1)
            c.ScrollBarImageTransparency=0
            c.ScrollingDirection=Enum.ScrollingDirection.Y
            c.Parent=columns

            local l=Instance.new("UIListLayout")
            l.Padding=UDim.new(0,8)
            l.SortOrder=Enum.SortOrder.LayoutOrder
            l.Parent=c
            if side=="left" then pad(c,10,5,10,10) else pad(c,5,10,10,10) end
            return c
        end

        pages[name]={root=root,left=col("left"),right=col("right"),sections={}}
    end

for _,n in ipairs(TAB_NAMES)do page(n)end
    local function showPage(name)
        for _,n in ipairs(TAB_NAMES) do
            pages[n].root.Visible=(n==name)
            local b=tabButtons[n]
            if b then b.TextTransparency=(n==name) and 0 or .5 end
        end
    end

    for i,n in ipairs(TAB_NAMES) do
        local b=Instance.new("TextButton")
        b.Name=n
        b.AutomaticSize=Enum.AutomaticSize.X
        b.Size=UDim2.fromOffset(10,24)
        b.BackgroundTransparency=1
        b.BorderSizePixel=0
        b.Text=n
        b.TextColor3=COL.tab
        b.TextTransparency=(i==1) and 0 or .5
        b.TextSize=13
        b.FontFace=Gotham
        b.AutoButtonColor=true
        b.LayoutOrder=i
        b.Parent=tabBar
        b.MouseButton1Click:Connect(function()
            showPage(n)
        end)
        tabButtons[n]=b
    end

    ----------------------------------------------------------------------
local scale=Instance.new('UIScale');scale.Parent=main
local function fit()local c=workspace.CurrentCamera;if c then scale.Scale=math.min(1,(c.ViewportSize.X-24)/550,(c.ViewportSize.Y-32)/600)end end
fit()
U.connect(UIS.InputBegan,function(i,g)if not g and not UIS:GetFocusedTextBox()and i.KeyCode==Enum.KeyCode.RightShift then gui.Enabled=not gui.Enabled end end)
U.gui=gui
U.connect(gui.Destroying,function()if U.alive and U.Destroy then U:Destroy()end end)
    local function section(tab,title,side)
        local pgx=pages[tab]
        if pgx.sections[title] then return pgx.sections[title] end
        local parent=(side=="right") and pgx.right or pgx.left

        local s=Instance.new("Frame")
        s.Name=title.."Section"
        s.Size=UDim2.new(1,0,0,40)
        s.BackgroundColor3=COL.section
        s.BackgroundTransparency=.4
        s.BorderSizePixel=0
        s.Parent=parent
        corner(s,8)
        stroke(s,COL.stroke,.6,1)
        local sg=Instance.new("UIGradient")
        sg.Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0,.3),
            NumberSequenceKeypoint.new(.5,.4),
            NumberSequenceKeypoint.new(1,.5)
        })
        sg.Rotation=45
        sg.Parent=s

        text(s,title,UDim2.new(1,-16,0,20),UDim2.fromOffset(8,6),12,COL.text,Gotham,Enum.TextXAlignment.Left)

        local body=Instance.new("Frame")
        body.Name="Body"
        body.Position=UDim2.fromOffset(0,28)
        body.Size=UDim2.new(1,0,0,0)
        body.BackgroundTransparency=1
        body.Parent=s
        pad(body,8,0,4,8)

        local layout=Instance.new("UIListLayout")
        layout.Padding=UDim.new(0,4)
        layout.SortOrder=Enum.SortOrder.LayoutOrder
        layout.Parent=body

        local order=0
        local function resize()
            local h=layout.AbsoluteContentSize.Y+12
            body.Size=UDim2.new(1,0,0,h)
            s.Size=UDim2.new(1,0,0,28+h)
        end
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)
        task.defer(resize)

        local api={frame=s,body=body}
        function api:add(obj)
            order+=1
            obj.LayoutOrder=order
            obj.Parent=body
            return obj
        end
        pgx.sections[title]=api
        return api
    end

local refreshers={}
local keybindListening=nil
local toggleKeyActions={}
local bindingRecords={}
U.bindings=bindingRecords
local META={}
local function reportControlIssue(name,err)
 U.state=tostring(name)..': '..tostring(err);warn('[Kimqetras UNLEGIT] '..U.state)
end
function U.refresh()for _,fn in ipairs(refreshers)do fn()end end
U.connect(UIS.InputBegan,function(input,gpe)
 if gpe or UIS:GetFocusedTextBox()then return end
 if keybindListening and input.UserInputType==Enum.UserInputType.Keyboard then
  local rec=keybindListening;keybindListening=nil
  if rec.old then toggleKeyActions[rec.old]=nil end
  if input.KeyCode==Enum.KeyCode.Escape or input.KeyCode==Enum.KeyCode.Backspace then rec.old=nil;rec.label.Text='None';return end
  if input.KeyCode==Enum.KeyCode.RightShift then rec.label.Text=rec.old and rec.old.Name or 'None';if rec.old then toggleKeyActions[rec.old]=rec.action end;return end
  for _,other in pairs(bindingRecords)do if other~=rec and other.old==input.KeyCode then other.old=nil;other.label.Text='None' end end
  rec.old=input.KeyCode;rec.label.Text=input.KeyCode.Name;toggleKeyActions[input.KeyCode]=rec.action;return
 end
 local action=toggleKeyActions[input.KeyCode];if action then pcall(action)end
end)
    local function safeGet(e,default)
        if type(e)=="table" and type(e.get)=="function" then
            local ok,v=pcall(e.get)
            if ok and v~=nil then return v end
            if not ok then reportControlIssue("Reading a setting",v) end
        end
        return default
    end
    local function safeSet(e,v,name)
        if type(e)~="table" or type(e.set)~="function" then
            reportControlIssue(name,"feature backend is unavailable")
            return false
        end
        local ok,result=pcall(e.set,v)
        if not ok or result==false then
            reportControlIssue(name,ok and "setting was rejected" or result)
            return false
        end
        return true
    end

    local function hcToggle(sec,name,entry)
        local row=Instance.new("TextButton")
        row.Name=name.."Toggle"
        row.Size=UDim2.new(1,-10,0,16)
        row.BackgroundTransparency=1
        row.BorderSizePixel=0
        row.Text=""
        row.AutoButtonColor=false
        sec:add(row)

        local leaf=text(row,"🍁",UDim2.fromOffset(14,14),UDim2.new(0,0,.5,-7),13,Color3.fromRGB(38,38,46),GothamBold,Enum.TextXAlignment.Center)
        local lg=Instance.new("UIGradient")
        lg.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,COL.accentDark),
            ColorSequenceKeypoint.new(.35,COL.accentDark),
            ColorSequenceKeypoint.new(.5,Color3.fromRGB(255,40,60)),
            ColorSequenceKeypoint.new(.65,COL.accentDark),
            ColorSequenceKeypoint.new(1,COL.accentDark)
        })
        lg.Offset=Vector2.new(-1,0)
        lg.Rotation=15
        lg.Enabled=false
        lg.Parent=leaf

        text(row,name,UDim2.new(1,-60,1,0),UDim2.fromOffset(18,-1),13,COL.text,Source,Enum.TextXAlignment.Left)

        local key=Instance.new("TextButton")
        key.Position=UDim2.new(1,-36,0,0)
        key.Size=UDim2.fromOffset(36,16)
        key.BackgroundTransparency=1
        key.BorderSizePixel=0
        key.Text=""
        key.AutoButtonColor=false
        key.Parent=row
        local keyText=text(key,"None",UDim2.fromScale(1,1),UDim2.new(),11,COL.text,Source,Enum.TextXAlignment.Center)

        local function refresh()
            local on=not not safeGet(entry,false)
            leaf.TextColor3=on and Color3.fromRGB(255,40,60) or Color3.fromRGB(38,38,46)
            leaf.TextTransparency=on and 0 or .4
            lg.Enabled=on
        end
        local function flip()
            safeSet(entry,not safeGet(entry,false),name)
            refresh()
        end
        row.MouseButton1Click:Connect(flip)
        local binding={label=keyText,action=flip,old=nil}
        bindingRecords[name]=binding
        key.MouseButton1Click:Connect(function()
            keyText.Text="..."
            keybindListening=binding
        end)
        table.insert(refreshers,refresh)
        refresh()
    end

    local function hcSlider(sec,name,entry,override)
        local meta=override or entry.meta or META[name] or {}
        local min=tonumber(meta.min) or 0
        local max=tonumber(meta.max) or 100
        if max<=min then max=min+1 end
        local dec=tonumber(meta.decimals)
        if dec==nil then dec=(entry.kind=="decimal") and 2 or 0 end

        local row=Instance.new("Frame")
        row.Name=name.."Slider"
        row.Size=UDim2.new(1,-10,0,30)
        row.BackgroundColor3=Color3.fromRGB(163,162,165)
        row.BackgroundTransparency=1
        row.BorderSizePixel=0
        sec:add(row)

        local list=Instance.new("UIListLayout")
        list.Padding=UDim.new(0,0)
        list.FillDirection=Enum.FillDirection.Vertical
        list.HorizontalAlignment=Enum.HorizontalAlignment.Left
        list.VerticalAlignment=Enum.VerticalAlignment.Top
        list.SortOrder=Enum.SortOrder.LayoutOrder
        list.Parent=row

        local title=text(
            row,name,
            UDim2.new(1,0,0,12),
            UDim2.new(),
            11,
            Color3.fromRGB(160,160,175),
            Gotham,
            Enum.TextXAlignment.Left
        )
        title.LayoutOrder=0

        local valueHolder=Instance.new("Frame")
        valueHolder.Size=UDim2.new(1,0,0,10)
        valueHolder.BackgroundTransparency=1
        valueHolder.LayoutOrder=1
        valueHolder.Parent=row

        local value=text(
            valueHolder,"",
            UDim2.fromScale(1,1),
            UDim2.new(),
            10,
            Color3.fromRGB(220,220,220),
            Gotham,
            Enum.TextXAlignment.Right
        )

        local track=Instance.new("Frame")
        track.Size=UDim2.new(1,0,0,8)
        track.BackgroundColor3=Color3.fromRGB(38,38,48)
        track.BackgroundTransparency=.3
        track.BorderSizePixel=0
        track.Active=true
        track.LayoutOrder=2
        track.Parent=row
        corner(track,4)
        stroke(track,Color3.fromRGB(55,55,68),.5,1)

        local fill=Instance.new("TextButton")
        fill.Position=UDim2.fromOffset(1,1)
        fill.Size=UDim2.new(0,-2,1,-2)
        fill.BackgroundColor3=Color3.fromRGB(210,45,45)
        fill.BackgroundTransparency=.35
        fill.BorderSizePixel=0
        fill.Text=""
        fill.TextSize=8
        fill.FontFace=Font.new("rbxasset://fonts/families/LegacyArial.json",Enum.FontWeight.Regular,Enum.FontStyle.Normal)
        fill.AutoButtonColor=true
        fill.Parent=track
        corner(fill,3)
        stroke(fill,Color3.fromRGB(230,70,70),.3,1)

        local dragging=false
        local function fmt(v)
            if dec<=0 then return tostring(math.floor(v+.5)) end
            return string.format("%."..dec.."f",v)
        end
        local function refresh()
            local v=math.clamp(tonumber(safeGet(entry,min)) or min,min,max)
            value.Text=fmt(v)
            fill.Size=UDim2.new((v-min)/(max-min),-2,1,-2)
        end
        local function setX(x)
            local a=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
            local v=min+(max-min)*a
            if dec<=0 then v=math.floor(v+.5) end
            safeSet(entry,v,name)
            refresh()
        end

        fill.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then
                dragging=true
                setX(i.Position.X)
            end
        end)
        track.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then
                dragging=true
                setX(i.Position.X)
            end
        end)
        U.connect(UIS.InputChanged,function(i)
            if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
                setX(i.Position.X)
            end
        end)
        U.connect(UIS.InputEnded,function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
        end)

        table.insert(refreshers,refresh)
        refresh()
    end

    local openedDropdown=nil
    local function closeDropdown()
        if openedDropdown and openedDropdown.Parent then
            openedDropdown.Visible=false
            local row=openedDropdown.Parent
            if row then row.Size=UDim2.new(1,-10,0,36) end
        end
        openedDropdown=nil
    end

    local function hcDropdown(sec,name,entry,optionsOverride)
        local row=Instance.new("Frame")
        row.Name=name.."DropdownRow"
        row.Size=UDim2.new(1,-10,0,36)
        row.BackgroundColor3=Color3.fromRGB(163,162,165)
        row.BackgroundTransparency=1
        row.BorderSizePixel=0
        sec:add(row)

        local rowList=Instance.new("UIListLayout")
        rowList.Padding=UDim.new(0,0)
        rowList.FillDirection=Enum.FillDirection.Vertical
        rowList.HorizontalAlignment=Enum.HorizontalAlignment.Left
        rowList.VerticalAlignment=Enum.VerticalAlignment.Top
        rowList.SortOrder=Enum.SortOrder.LayoutOrder
        rowList.Parent=row

        local title=text(
            row,name,
            UDim2.new(1,0,0,12),
            UDim2.new(),
            11,
            Color3.fromRGB(160,160,175),
            Gotham,
            Enum.TextXAlignment.Left
        )
        title.LayoutOrder=0

        local mainButton=Instance.new("TextButton")
        mainButton.Name=name.."Dropdown"
        mainButton.Size=UDim2.new(1,0,0,24)
        mainButton.BackgroundColor3=Color3.fromRGB(28,28,36)
        mainButton.BackgroundTransparency=.2
        mainButton.BorderSizePixel=0
        mainButton.TextColor3=Color3.new(1,1,1)
        mainButton.TextSize=11
        mainButton.TextXAlignment=Enum.TextXAlignment.Left
        mainButton.TextYAlignment=Enum.TextYAlignment.Center
        mainButton.FontFace=Gotham
        mainButton.AutoButtonColor=false
        mainButton.LayoutOrder=1
        mainButton.Parent=row
        pad(mainButton,8,8,0,0)
        corner(mainButton,4)
        stroke(mainButton,Color3.fromRGB(55,55,68),.5,1)

        local panel=Instance.new("Frame")
        panel.Size=UDim2.new(1,0,0,0)
        panel.BackgroundTransparency=1
        panel.Visible=false
        panel.LayoutOrder=2
        panel.Parent=row

        local inner=Instance.new("Frame")
        inner.Size=UDim2.new(1,0,0,0)
        inner.BackgroundColor3=Color3.fromRGB(28,28,36)
        inner.BackgroundTransparency=.15
        inner.BorderSizePixel=0
        inner.Parent=panel
        corner(inner,0)
        stroke(inner,Color3.fromRGB(55,55,68),.5,1)

        -- Keep search fixed while a long set of skins/configs scrolls below it.
        local optionScroll=Instance.new("ScrollingFrame")
        optionScroll.Name="Options"
        optionScroll.Position=UDim2.fromOffset(0,26)
        optionScroll.Size=UDim2.new(1,-2,0,0)
        optionScroll.BackgroundTransparency=1
        optionScroll.BorderSizePixel=0
        optionScroll.ScrollingDirection=Enum.ScrollingDirection.Y
        optionScroll.ScrollBarThickness=4
        optionScroll.ScrollBarImageColor3=COL.accentFill
        optionScroll.ClipsDescendants=true
        optionScroll.Parent=inner

        local il=Instance.new("UIListLayout")
        il.Padding=UDim.new(0,1)
        il.FillDirection=Enum.FillDirection.Vertical
        il.HorizontalAlignment=Enum.HorizontalAlignment.Left
        il.VerticalAlignment=Enum.VerticalAlignment.Top
        il.SortOrder=Enum.SortOrder.LayoutOrder
        il.Parent=optionScroll
        pad(inner,1,1,1,1)
        pad(optionScroll,1,6,1,1)

        local search=Instance.new("TextBox")
        search.Size=UDim2.new(1,0,0,24)
        search.BackgroundColor3=Color3.fromRGB(24,24,30)
        search.BackgroundTransparency=.1
        search.BorderSizePixel=0
        search.PlaceholderText="Search..."
        search.PlaceholderColor3=Color3.fromRGB(150,150,150)
        search.Text=""
        search.TextColor3=Color3.new(1,1,1)
        search.TextSize=11
        search.TextXAlignment=Enum.TextXAlignment.Left
        search.TextYAlignment=Enum.TextYAlignment.Center
        search.FontFace=Gotham
        search.ClearTextOnFocus=false
        search.LayoutOrder=0
        search.Parent=inner
        pad(search,8,8,0,0)

        local optionObjects={}

        local function options()
            if type(optionsOverride)=="function" then
                local ok,v=pcall(optionsOverride)
                if ok and type(v)=="table" then return v end
            elseif type(optionsOverride)=="table" then
                return optionsOverride
            end

            local fm=META[name]
            if entry.meta and type(entry.meta.options)=="table" then return entry.meta.options end
            if fm and type(fm.options)=="table" then return fm.options end
            return {}
        end

        local function refresh()
            mainButton.Text=tostring(safeGet(entry,"None"))
        end

        local function rebuild()
            for _,o in ipairs(optionObjects) do
                pcall(function() o:Destroy() end)
            end
            table.clear(optionObjects)

            local filter=search.Text:lower()
            local shown=0

            for _,v in ipairs(options()) do
                local optionName=tostring(v)
                if filter=="" or optionName:lower():find(filter,1,true) then
                    shown+=1
                    local b=Instance.new("TextButton")
                    b.Size=UDim2.new(1,0,0,24)
                    b.BackgroundColor3=Color3.fromRGB(24,24,30)
                    b.BackgroundTransparency=.2
                    b.BorderSizePixel=0
                    b.Text=optionName
                    b.TextColor3=Color3.new(1,1,1)
                    b.TextSize=11
                    b.TextXAlignment=Enum.TextXAlignment.Left
                    b.TextYAlignment=Enum.TextYAlignment.Center
                    b.FontFace=Gotham
                    b.AutoButtonColor=false
                    b.LayoutOrder=shown
                    b.Parent=optionScroll
                    pad(b,8,8,0,0)
                    corner(b,0)
                    table.insert(optionObjects,b)

                    b.MouseButton1Click:Connect(function()
                        if safeSet(entry,v,name) then
                            refresh()
                            closeDropdown()
                        end
                    end)
                end
            end

            local h=math.min(194,28+math.max(shown,1)*25)
            inner.Size=UDim2.new(1,0,0,h)
            optionScroll.Size=UDim2.new(1,-2,0,h-27)
            optionScroll.CanvasSize=UDim2.new(0,0,0,shown*25+3)
            optionScroll.CanvasPosition=Vector2.zero
            panel.Size=UDim2.new(1,0,0,h)
            row.Size=UDim2.new(1,-10,0,36+h)
        end

        search:GetPropertyChangedSignal("Text"):Connect(function()
            if panel.Visible then rebuild() end
        end)

        mainButton.MouseButton1Click:Connect(function()
            if openedDropdown==panel then
                closeDropdown()
            else
                closeDropdown()
                panel.Visible=true
                openedDropdown=panel
                rebuild()
            end
        end)

        table.insert(refreshers,refresh)
        refresh()
    end

    local function hcButton(sec,name,fn)
        local b=Instance.new("TextButton")
        b.Name=name.."Button"
        b.Size=UDim2.new(1,-10,0,24)
        b.BackgroundColor3=COL.track
        b.BackgroundTransparency=0
        b.BorderSizePixel=0
        b.Text=name
        b.TextColor3=COL.text
        b.TextSize=12
        b.FontFace=Gotham
        b.AutoButtonColor=false
        sec:add(b)
        corner(b,4)
        stroke(b,COL.stroke,.3,1)
        b.MouseButton1Click:Connect(function()
            local ok,err=pcall(fn)
            if not ok then reportControlIssue(name,err) end
        end)
        return b
    end

    local function hcTextbox(sec,name,entry,placeholder)
        local box=Instance.new("TextBox")
        box.Name=name.."TextBox"
        box.Size=UDim2.new(1,-10,0,22)
        box.BackgroundColor3=Color3.fromRGB(28,28,36)
        box.BackgroundTransparency=.2
        box.BorderSizePixel=0
        box.Text=tostring(safeGet(entry,""))
        box.PlaceholderText=placeholder or name
        box.PlaceholderColor3=Color3.fromRGB(150,150,150)
        box.TextColor3=Color3.new(1,1,1)
        box.TextSize=11
        box.TextXAlignment=Enum.TextXAlignment.Left
        box.TextYAlignment=Enum.TextYAlignment.Center
        box.FontFace=Gotham
        box.ClearTextOnFocus=false
        box.MultiLine=false
        box.TextEditable=true
        sec:add(box)
        pad(box,6,0,0,0)
        corner(box,4)
        stroke(box,Color3.fromRGB(55,55,68),.5,1)

        box.FocusLost:Connect(function()
            safeSet(entry,box.Text,name)
        end)

        local function refresh()
            local v=tostring(safeGet(entry,box.Text))
            if not box:IsFocused() then box.Text=v end
        end
        table.insert(refreshers,refresh)
        return box
    end

local function setting(key)
 return {get=function()return S[key]end,set=function(v)return U.set(key,v)end}
end
local function toggle(sec,name,key)return hcToggle(sec,name,setting(key))end
local function number(sec,name,key)
 local range=numericBounds[key]or {0,100}
 local fractional=decimals
 return hcSlider(sec,name,setting(key),{min=range[1],max=range[2],decimals=fractional[key]or 0})
end
local function cycle(sec,name,key)return hcDropdown(sec,name,setting(key),choices[key])end
local function button(sec,name,fn)return hcButton(sec,name,fn)end
local function field(sec,name,initial,fn)
 local box
 box=hcTextbox(sec,name,{get=function()return box and box.Text or initial end,set=function(v)fn(v);return true end},name)
 return box
end
local function note(sec,value,height)local t=text(nil,value,UDim2.new(1,-4,0,height or 38),nil,12,COL.sub,Source);t.TextWrapped=true;sec:add(t);return t end

do local sec=section("Aim Assist","Camera aim","left")
toggle(sec,"Enable Aim Assist","Aim")
toggle(sec,"Sticky Aim","Sticky")
cycle(sec,"Hit Part","AimPart")
number(sec,"Prediction (seconds)","Prediction")
number(sec,"Smoothness","Smoothness")
number(sec,"Target Range","AimRange")
number(sec,"FOV Radius","FOV")
number(sec,"Deadzone Radius","Deadzone")
end
do local sec=section("Aim Assist","Checks & camera shake","right")
toggle(sec,"Wall Check","WallCheck")
toggle(sec,"Forcefield Check","ForcefieldCheck")
toggle(sec,"Knocked Check","KnockedCheck")
toggle(sec,"Camera Shake","Shake")
number(sec,"Shake X","ShakeX")
number(sec,"Shake Y","ShakeY")
number(sec,"Shake Z","ShakeZ")
end
do local sec=section("Target Visuals","Circles","left")
toggle(sec,"Show FOV","ShowFOV")
toggle(sec,"Filled FOV","FilledFOV")
number(sec,"FOV Opacity","FOVOpacity")
toggle(sec,"Show Deadzone","ShowDeadzone")
hcTextbox(sec,"FOV Color (#RRGGBB)",setting("FOVColor"))
end
do local sec=section("Target Visuals","Selected target","right")
toggle(sec,"Prediction Marker","PredictionMarker")
toggle(sec,"Target Highlight","TargetHighlight")
toggle(sec,"Target Tracer","TargetTracer")
toggle(sec,"Target Dot","TargetDot")
number(sec,"Tracer Thickness","TracerThickness")
hcTextbox(sec,"Target Color (#RRGGBB)",setting("TargetColor"))
end
do local sec=section("Hit Effects","Feedback","left")
toggle(sec,"Observe Local Shots","HitObserve")
toggle(sec,"Hitmarker","HitMarker")
cycle(sec,"Marker Type","MarkerType")
toggle(sec,"Hit Highlight","HitHighlight")
toggle(sec,"Hit Notifications","HitNotify")
number(sec,"Effect Duration","HitDuration")
hcTextbox(sec,"Hit Color (#RRGGBB)",setting("HitColor"))
end
do local sec=section("Hit Effects","Sound & particles","right")
toggle(sec,"Hit Sound","HitSound")
cycle(sec,"Sound","HitSoundName")
number(sec,"Volume","HitVolume")
number(sec,"Pitch","HitPitch")
toggle(sec,"Hit Particles","HitParticles")
cycle(sec,"Particle Effect","ParticleType")
end
do local sec=section("ESP","Player information","left")
toggle(sec,"Enable ESP","ESP")
toggle(sec,"Names","ESPNames")
toggle(sec,"Boxes","ESPBoxes")
toggle(sec,"Corner Boxes","ESPCorners")
toggle(sec,"Box Fill","ESPFill")
number(sec,"Fill Opacity","ESPFillOpacity")
toggle(sec,"Equipped Weapon","ESPWeapon")
toggle(sec,"Distance","ESPDistance")
toggle(sec,"Money","ESPMoney")
toggle(sec,"Knocked Status","ESPKnocked")
end
do local sec=section("ESP","Health & appearance","right")
toggle(sec,"Health Bar","ESPHealth")
toggle(sec,"Health Numbers","ESPHealthNumber")
toggle(sec,"Health Gradient","ESPGradient")
toggle(sec,"Offscreen Arrows","ESPArrows")
number(sec,"Arrow Radius","ESPArrowRadius")
number(sec,"Render Range","ESPRange")
toggle(sec,"Player Highlights","ESPHighlights")
hcTextbox(sec,"ESP Color (#RRGGBB)",setting("ESPColor"))
end
do local sec=section("Movement","Ground","left")
toggle(sec,"Speed","Speed")
number(sec,"Walkspeed","Walkspeed")
toggle(sec,"Bunny Hop","Bhop")
number(sec,"Jump Power","JumpPower")
end
do local sec=section("Movement","Air","right")
toggle(sec,"Fly","Fly")
number(sec,"Fly Speed","FlySpeed")
end
do local sec=section("Character","Character appearance","left")
toggle(sec,"Character Material","CharMaterial")
cycle(sec,"Body Material","CharMat")
hcTextbox(sec,"Body Color (#RRGGBB)",setting("CharColor"))
toggle(sec,"Rainbow Body","RainbowBody")
toggle(sec,"Custom Character","Morph")
cycle(sec,"Character Model","MorphName")
end
do local sec=section("Character","Weapon appearance","right")
toggle(sec,"Gun Material","GunMaterial")
cycle(sec,"Weapon Material","GunMat")
hcTextbox(sec,"Weapon Color (#RRGGBB)",setting("GunColor"))
toggle(sec,"Rainbow Gun","RainbowGun")
toggle(sec,"Sine Gun Color","SineGun")
toggle(sec,"Custom Grip","Grip")
number(sec,"Grip X","GripX")
number(sec,"Grip Y","GripY")
number(sec,"Grip Z","GripZ")
end
do local sec=section("Visuals","Crosshair","left")
toggle(sec,"Custom Crosshair","Crosshair")
toggle(sec,"Center Dot","CrosshairDot")
toggle(sec,"Dynamic Gap","DynamicGap")
toggle(sec,"Spin Crosshair","CrosshairSpin")
number(sec,"Spin Speed","CrosshairSpinSpeed")
number(sec,"Line Length","CrosshairLength")
number(sec,"Gap","CrosshairGap")
number(sec,"Thickness","CrosshairThickness")
hcTextbox(sec,"Crosshair Color (#RRGGBB)",setting("CrosshairColor"))
end
do local sec=section("Visuals","Gun sounds & stomp visuals","right")
toggle(sec,"Custom Gun Sounds","GunSounds")
cycle(sec,"Firing Sound","GunSoundName")
number(sec,"Firing Volume","GunVolume")
number(sec,"Firing Pitch","GunPitch")
toggle(sec,"Observe Stomps","StompObserve")
cycle(sec,"Stomp Effect","StompEffect")
end
do local sec=section("World","Lighting & fog","left")
toggle(sec,"Ambient Lighting","Ambient")
hcTextbox(sec,"Ambient Color (#RRGGBB)",setting("AmbientColor"))
toggle(sec,"Color Shift","ColorShift")
hcTextbox(sec,"Shift Color (#RRGGBB)",setting("ShiftColor"))
toggle(sec,"Fog","Fog")
hcTextbox(sec,"Fog Color (#RRGGBB)",setting("FogColor"))
number(sec,"Fog Start","FogStart")
number(sec,"Fog End","FogEnd")
toggle(sec,"Custom Time","Time")
number(sec,"Hour","Hour")
end
do local sec=section("World","Sky & color correction","right")
toggle(sec,"Custom Skybox","Sky")
cycle(sec,"Skybox","SkyName")
toggle(sec,"Color Correction","Correction")
hcTextbox(sec,"Tint (#RRGGBB)",setting("TintColor"))
number(sec,"Brightness","Brightness")
number(sec,"Contrast","Contrast")
number(sec,"Saturation","Saturation")
end
do local sec=section("Settings","Menu & overlay","right")
toggle(sec,"Watermark","Watermark")
toggle(sec,"Keybind Display","KeybindDisplay")
number(sec,"Menu Scale","MenuScale")
number(sec,"Rainbow Speed","RainbowSpeed")
end

-- All backend dependencies are local services. Optional visual assets load on demand.
local overlay=U.own(Instance.new('ScreenGui'));overlay.Name='KimqetrasUNLEGIT_Overlay';overlay.IgnoreGuiInset=true;overlay.ResetOnSpawn=false;overlay.DisplayOrder=9999;overlay.Parent=pg
local fx=U.own(Instance.new('Folder'));fx.Name='KimqetrasUNLEGIT_Effects';fx.Parent=workspace
local function make(class,parent,props)
 local o=Instance.new(class);for k,v in pairs(props or {})do o[k]=v end;o.Parent=parent;return o
end
local function label(parent,size)
 return make('TextLabel',parent,{BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),Font=Enum.Font.Gotham,TextSize=size or 12,TextStrokeTransparency=.4,BorderSizePixel=0})
end
local function line(parent)
 return make('Frame',parent,{BorderSizePixel=0,AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=Color3.new(1,1,1),Visible=false})
end
local function drawLine(o,a,b,color,width)
 local d=b-a;o.Position=UDim2.fromOffset((a.X+b.X)/2,(a.Y+b.Y)/2);o.Size=UDim2.fromOffset(d.Magnitude,width or 1);o.Rotation=math.deg(math.atan2(d.Y,d.X));o.BackgroundColor3=color;o.Visible=true
end
local function circle()
 local f=make('Frame',overlay,{AnchorPoint=Vector2.new(.5,.5),BackgroundTransparency=1,BorderSizePixel=0,Visible=false})
 make('UICorner',f,{CornerRadius=UDim.new(1,0)});local s=make('UIStroke',f,{Thickness=1});return f,s
end
local fov,fovStroke=circle();local dead,deadStroke=circle()
local tracer=line(overlay);local dot=label(overlay,20);dot.Text='•';dot.Size=UDim2.fromOffset(12,12);dot.AnchorPoint=Vector2.new(.5,.5)
local prediction=make('Part',fx,{Name='PredictionMarker',Shape=Enum.PartType.Ball,Size=Vector3.new(.35,.35,.35),Anchored=true,CanCollide=false,CanTouch=false,CanQuery=false,Material=Enum.Material.Neon,Transparency=1})
local targetHighlight=make('Highlight',fx,{Enabled=false,FillTransparency=.75})
local watermark=label(overlay,12);watermark.Position=UDim2.fromOffset(12,12);watermark.Size=UDim2.fromOffset(320,22);watermark.TextXAlignment=Enum.TextXAlignment.Left
local keysLabel=label(overlay,12);keysLabel.Position=UDim2.fromOffset(12,42);keysLabel.Size=UDim2.fromOffset(260,230);keysLabel.TextXAlignment=Enum.TextXAlignment.Left;keysLabel.TextYAlignment=Enum.TextYAlignment.Top
local toast=label(overlay,14);toast.Position=UDim2.new(.5,-240,.85,0);toast.Size=UDim2.fromOffset(480,44);toast.TextWrapped=true;toast.Visible=false
local toastUntil=0
function U.notify(message)toast.Text=message;toastUntil=os.clock()+3 end
local cross={};for i=1,4 do cross[i]=line(overlay)end
local crossDot=make('Frame',overlay,{Size=UDim2.fromOffset(3,3),AnchorPoint=Vector2.new(.5,.5),BorderSizePixel=0,Visible=false})
local target,now,espClock,cosmeticClock=nil,0,0,0
local morph,morphName,morphChar
local flyAttachment,flyVelocity
local skyCreated
local cc=U.own(Instance.new('ColorCorrectionEffect'));cc.Name='KimqetrasUNLEGIT_Color';cc.Enabled=false;cc.Parent=Lighting
local esp={}
local function destroyESP(p)
 local row=esp[p];if row then row.gui:Destroy();row.highlight:Destroy();esp[p]=nil end
end
local function newESP(p)
 local root=make('Frame',overlay,{BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Visible=false})
 local box=make('Frame',root,{BackgroundTransparency=1,BorderSizePixel=0});local outline=make('UIStroke',box,{Thickness=1})
 local text=label(root,12);text.TextWrapped=false
 local lower=label(root,11)
 local barBG=make('Frame',root,{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0})
 local bar=make('Frame',barBG,{BorderSizePixel=0,AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1)})
 local health=label(root,11);local arrow=label(root,24);arrow.Text='▲';arrow.Size=UDim2.fromOffset(24,24);arrow.AnchorPoint=Vector2.new(.5,.5)
 local edges={};for i=1,8 do edges[i]=line(root)end
 local h=make('Highlight',fx,{Enabled=false,FillTransparency=.8})
 local row={gui=root,box=box,stroke=outline,name=text,lower=lower,bg=barBG,bar=bar,health=health,arrow=arrow,edges=edges,highlight=h};esp[p]=row;return row
end
local function projectBox(cam,root)
 -- Use character root dimensions, avoiding accessory-induced oversized boxes.
 local points={};for _,x in ipairs({-2,2})do for _,y in ipairs({-3,3})do for _,z in ipairs({-1,1})do
  local v=cam:WorldToViewportPoint(root.CFrame:PointToWorldSpace(Vector3.new(x,y,z)));if v.Z<=0 then return end;table.insert(points,v)
 end end end
 local l,t,r,b=math.huge,math.huge,-math.huge,-math.huge
 for _,v in ipairs(points)do l=math.min(l,v.X);t=math.min(t,v.Y);r=math.max(r,v.X);b=math.max(b,v.Y)end
 return l,t,r-l,b-t
end
local function updateESP(cam,myRoot)
 if not S.ESP then for _,row in pairs(esp)do row.gui.Visible=false;row.highlight.Enabled=false end;return end
 for _,p in ipairs(Players:GetPlayers())do if p~=lp then
  local row=esp[p]or newESP(p);local c,h,r=U.character(p)
  local enabled=S.ESP and h and h.Health>0 and r and myRoot and (r.Position-myRoot.Position).Magnitude<=S.ESPRange
  row.gui.Visible=enabled==true;row.highlight.Enabled=enabled==true and S.ESPHighlights;row.highlight.Adornee=c;row.highlight.FillColor=U.color('ESPColor');row.highlight.OutlineColor=U.color('ESPColor')
  if enabled then
   local v,on=cam:WorldToViewportPoint(r.Position);local l,t,w,ht=projectBox(cam,r)
   local showing=on and l~=nil;local color=U.color('ESPColor')
   row.box.Visible=showing and(S.ESPBoxes or S.ESPFill);row.stroke.Enabled=S.ESPBoxes and not S.ESPCorners
   row.name.Visible=showing and S.ESPNames;row.lower.Visible=showing;row.bg.Visible=showing and S.ESPHealth;row.health.Visible=showing and S.ESPHealthNumber
   row.arrow.Visible=not showing and S.ESPArrows
   for _,e in ipairs(row.edges)do e.Visible=false end
   if showing then
    row.box.Position=UDim2.fromOffset(l,t);row.box.Size=UDim2.fromOffset(w,ht);row.box.BackgroundColor3=color;row.box.BackgroundTransparency=S.ESPFill and 1-S.ESPFillOpacity or 1;row.stroke.Color=color
    row.name.Text=p.DisplayName..' (@'..p.Name..')';row.name.TextColor3=color;row.name.Position=UDim2.fromOffset(l-50,t-20);row.name.Size=UDim2.fromOffset(w+100,18)
    local parts={};local tool=c:FindFirstChildOfClass('Tool')
    if S.ESPWeapon and tool then table.insert(parts,tool.Name)end
    if S.ESPDistance then table.insert(parts,math.floor((r.Position-myRoot.Position).Magnitude)..' studs')end
    if S.ESPMoney then local d=p:FindFirstChild('DataFolder');local money=d and d:FindFirstChild('Currency');table.insert(parts,money and '$'..tostring(money.Value)or '$ unavailable')end
    if S.ESPKnocked and U.knocked(c)then table.insert(parts,'KNOCKED')end
    row.lower.Text=table.concat(parts,' • ');row.lower.TextColor3=color;row.lower.Position=UDim2.fromOffset(l-70,t+ht+2);row.lower.Size=UDim2.fromOffset(w+140,18)
    local ratio=math.clamp(h.Health/math.max(1,h.MaxHealth),0,1);row.bg.Position=UDim2.fromOffset(l-6,t);row.bg.Size=UDim2.fromOffset(3,ht);row.bar.Size=UDim2.fromScale(1,ratio);row.bar.BackgroundColor3=S.ESPGradient and Color3.fromHSV(ratio/3,1,1)or color
    row.health.Text=tostring(math.ceil(h.Health));row.health.Position=UDim2.fromOffset(l-42,t+ht*(1-ratio)-8);row.health.Size=UDim2.fromOffset(32,16)
    if S.ESPBoxes and S.ESPCorners then local len=math.min(w,ht)/4;local coords={{l,t,1,1},{l+w,t,-1,1},{l,t+ht,1,-1},{l+w,t+ht,-1,-1}}
     for i,a in ipairs(coords)do drawLine(row.edges[i*2-1],Vector2.new(a[1],a[2]),Vector2.new(a[1]+len*a[3],a[2]),color);drawLine(row.edges[i*2],Vector2.new(a[1],a[2]),Vector2.new(a[1],a[2]+len*a[4]),color)end
    end
   elseif S.ESPArrows then
    local localPos=cam.CFrame:PointToObjectSpace(r.Position);local dir=Vector2.new(localPos.X,-localPos.Y);if dir.Magnitude<.01 then dir=Vector2.new(0,1)end;if localPos.Z>0 then dir=-dir end;dir=dir.Unit
    local radius=math.min(S.ESPArrowRadius,math.min(cam.ViewportSize.X,cam.ViewportSize.Y)*.42);local pos=cam.ViewportSize/2+dir*radius
    row.arrow.Position=UDim2.fromOffset(pos.X,pos.Y);row.arrow.Rotation=math.deg(math.atan2(dir.Y,dir.X))+90;row.arrow.TextColor3=color
   end
  end
 end end
end
U.connect(Players.PlayerRemoving,destroyESP)
local function validTarget(p,cam,cursor,myRoot)
 if p==lp then return end
 local c,h,r=U.character(p);if not r or not h or h.Health<=0 or not myRoot then return end
 if S.KnockedCheck and U.knocked(c)then return end
 if S.ForcefieldCheck and c:FindFirstChildOfClass('ForceField')then return end
 local part=c:FindFirstChild(S.AimPart)or c:FindFirstChild('Torso')or r
 local v,on=cam:WorldToViewportPoint(part.Position);if not on then return end
 local dist=(Vector2.new(v.X,v.Y)-cursor).Magnitude
 if dist>S.FOV or(part.Position-myRoot.Position).Magnitude>S.AimRange then return end
 if S.WallCheck then
  local params=RaycastParams.new();params.FilterType=Enum.RaycastFilterType.Exclude;params.FilterDescendantsInstances={lp.Character,fx};params.IgnoreWater=true
  local hit=workspace:Raycast(cam.CFrame.Position,part.Position-cam.CFrame.Position,params)
  if hit and not hit.Instance:IsDescendantOf(c)then return end
 end
 return {player=p,char=c,hum=h,root=r,part=part,pixels=dist}
end
local keys={}
U.connect(UIS.InputBegan,function(i,g)if not g and not UIS:GetFocusedTextBox()then keys[i.KeyCode]=true;if i.KeyCode==Enum.KeyCode.E then U.lastStompInput=os.clock()end end end)
U.connect(UIS.InputEnded,function(i)keys[i.KeyCode]=nil end)
U.connect(UIS.WindowFocusReleased,function()keys={}end)
local function stopFly()
 if flyVelocity then flyVelocity:Destroy();flyVelocity=nil end
 if flyAttachment then flyAttachment:Destroy();flyAttachment=nil end
 U.release('fly')
end
local function dropMorph()
 if morph then morph:Destroy();morph=nil end;morphName=nil;morphChar=nil;U.release('morph')
end
local function updateCosmetics(c,r)
 if not c or not r then U.release('body');U.release('gun');U.release('grip');dropMorph();return end
 local rainbow=Color3.fromHSV((now*S.RainbowSpeed*.1)%1,1,1)
 if S.CharMaterial then
  for _,o in ipairs(c:GetDescendants())do if o:IsA('BasePart')and not o:FindFirstAncestorOfClass('Tool')and o~=r and o~=morph then U.property('body',o,'Material',Enum.Material[S.CharMat]);U.property('body',o,'Color',S.RainbowBody and rainbow or U.color('CharColor'))end end
 else U.release('body')end
 local tool=c:FindFirstChildOfClass('Tool')
 if U.previousTool~=tool then U.release('gun');U.release('grip');U.release('sound');U.previousTool=tool end
 if S.GunMaterial and tool then
  local col=S.RainbowGun and rainbow or U.color('GunColor');if S.SineGun then col=col:Lerp(Color3.new(0,0,0),(math.sin(now*3)+1)*.35)end
  for _,o in ipairs(tool:GetDescendants())do if o:IsA('BasePart')then U.property('gun',o,'Color',col);U.property('gun',o,'Material',Enum.Material[S.GunMat])end end
 else U.release('gun')end
 if S.Grip and tool then
  local record=U.groups.grip and U.groups.grip[tool];local original=record and record.Grip and record.Grip.before or tool.Grip
  U.property('grip',tool,'Grip',original*CFrame.new(S.GripX,S.GripY,S.GripZ))
 else U.release('grip')end
 if S.GunSounds and tool then
  local found=false
  for _,o in ipairs(tool:GetDescendants())do local name=o.Name:lower();if o:IsA('Sound')and(name=='shootsound'or name=='shoot'or name=='firesound'or name=='fire')then
   found=true;U.property('sound',o,'SoundId','rbxassetid://'..ASSETS.sfx[S.GunSoundName]);U.property('sound',o,'Volume',S.GunVolume);U.property('sound',o,'PlaybackSpeed',S.GunPitch)
  end end
  U.soundStatus=found and 'Firing sound found' or 'Equipped tool has no recognized firing sound'
 else U.release('sound');U.soundStatus='Equip a compatible gun to change its sound'end
 if S.Morph then
  if not morph or morphName~=S.MorphName or morphChar~=c then
   dropMorph();local data=ASSETS.Characters[S.MorphName]
   morph=make('Part',fx,{Name='LocalCharacterVisual',Size=Vector3.new(1,1,1),CanCollide=false,CanTouch=false,CanQuery=false,Massless=true,CFrame=r.CFrame})
   make('SpecialMesh',morph,{MeshType=Enum.MeshType.FileMesh,MeshId='rbxassetid://'..data[3],TextureId='rbxassetid://'..data[2],Scale=data[1]})
   make('WeldConstraint',morph,{Part0=r,Part1=morph});morphName=S.MorphName;morphChar=c
  end
  for _,o in ipairs(c:GetDescendants())do if o:IsA('BasePart')and not o:FindFirstAncestorOfClass('Tool')then U.property('morph',o,'LocalTransparencyModifier',1)end end
 else dropMorph()end
end
local skyProps={'SkyboxLf','SkyboxBk','SkyboxDn','SkyboxFt','SkyboxRt','SkyboxUp'}
local function updateWorld()
 if S.Ambient then U.property('ambient',Lighting,'Ambient',U.color('AmbientColor'));U.property('ambient',Lighting,'OutdoorAmbient',U.color('AmbientColor'))else U.release('ambient')end
 if S.ColorShift then U.property('shift',Lighting,'ColorShift_Top',U.color('ShiftColor'))else U.release('shift')end
 if S.Fog then U.property('fog',Lighting,'FogColor',U.color('FogColor'));U.property('fog',Lighting,'FogStart',math.min(S.FogStart,S.FogEnd));U.property('fog',Lighting,'FogEnd',math.max(S.FogStart,S.FogEnd))else U.release('fog')end
 if S.Time then U.property('time',Lighting,'ClockTime',S.Hour)else U.release('time')end
 cc.Enabled=S.Correction;cc.TintColor=U.color('TintColor');cc.Brightness=S.Brightness;cc.Contrast=S.Contrast;cc.Saturation=S.Saturation
 if S.Sky then
  local sky=Lighting:FindFirstChildOfClass('Sky');if not sky then sky=U.own(Instance.new('Sky'));sky.Parent=Lighting;skyCreated=sky end
  for i,key in ipairs(skyProps)do U.property('sky',sky,key,'rbxassetid://'..ASSETS.SkyBoxes[S.SkyName][i])end
 else U.release('sky');if skyCreated then skyCreated:Destroy();skyCreated=nil end end
end
U.stopRuntime=function()
 stopFly();dropMorph();for p in pairs(esp)do destroyESP(p)end
end
U.changed=function(key)
 if key=='Fly'and not S.Fly then stopFly()end
 if key=='Speed'and not S.Speed then U.release('speed')end
 if key=='Bhop'and not S.Bhop then U.release('jump')end
 if key=='Morph'or key=='MorphName'then dropMorph()end
 updateWorld()
end
U.connect(lp.CharacterAdded,function()stopFly();dropMorph();for _,group in ipairs({'speed','jump','body','gun','grip','sound'})do U.release(group)end;target=nil end)
U.connect(RunService.Heartbeat,function(dt)
 now=os.clock();local c,h,r=U.character(lp)
 if h and r and h.Health>0 then
  if S.Speed then U.property('speed',h,'WalkSpeed',S.Walkspeed)else U.release('speed')end
  if S.Bhop then
   U.property('jump',h,'UseJumpPower',true);U.property('jump',h,'JumpPower',S.JumpPower)
   if not h.Sit and h.MoveDirection.Magnitude>0 and h.FloorMaterial~=Enum.Material.Air and not UIS:GetFocusedTextBox()then h:ChangeState(Enum.HumanoidStateType.Jumping)end
  else U.release('jump')end
  if S.Fly and not h.Sit then
   if not flyVelocity or flyVelocity.Parent~=r then stopFly();flyAttachment=make('Attachment',r);flyVelocity=make('LinearVelocity',r,{Attachment0=flyAttachment,RelativeTo=Enum.ActuatorRelativeTo.World,MaxForce=math.huge,ForceLimitsEnabled=false})end
   U.property('fly',h,'AutoRotate',false)
   local input=Vector3.zero
   if not UIS:GetFocusedTextBox()then input=Vector3.new((keys[Enum.KeyCode.D]and 1 or 0)-(keys[Enum.KeyCode.A]and 1 or 0),(keys[Enum.KeyCode.Space]and 1 or 0)-(keys[Enum.KeyCode.LeftControl]and 1 or 0),(keys[Enum.KeyCode.S]and 1 or 0)-(keys[Enum.KeyCode.W]and 1 or 0))end
   local cam=workspace.CurrentCamera;if cam then local direction=cam.CFrame:VectorToWorldSpace(input);flyVelocity.VectorVelocity=direction.Magnitude>0 and direction.Unit*S.FlySpeed or Vector3.zero end
  else stopFly()end
 else stopFly();U.release('speed');U.release('jump')end
 cosmeticClock=cosmeticClock+dt
 if cosmeticClock>=.1 then cosmeticClock=0;updateCosmetics(c,r);updateWorld()end
end)
U.connect(RunService.RenderStepped,function(dt)
 local cam=workspace.CurrentCamera;if not cam then return end
 local cursor=UIS:GetMouseLocation();local _,_,myRoot=U.character(lp)
 local wantsTarget=S.Aim or S.PredictionMarker or S.TargetHighlight or S.TargetTracer or S.TargetDot
 local candidate=wantsTarget and S.Sticky and target and validTarget(target.player,cam,cursor,myRoot)or nil
 if wantsTarget and not candidate then local best=math.huge;for _,p in ipairs(Players:GetPlayers())do local t=validTarget(p,cam,cursor,myRoot);if t and t.pixels<best then best=t.pixels;candidate=t end end end
 target=candidate;U.target=target
 local point=target and(target.part.Position+target.root.AssemblyLinearVelocity*S.Prediction)
 if S.Aim and target and target.pixels>S.Deadzone and not gui.Enabled and not UIS:GetFocusedTextBox()then
  local desired=CFrame.lookAt(cam.CFrame.Position,point);local alpha=1-math.exp(-dt*(101-S.Smoothness)*.8)
  cam.CFrame=cam.CFrame:Lerp(desired,alpha)
  if S.Shake then cam.CFrame=cam.CFrame*CFrame.Angles(math.rad(math.sin(now*19)*S.ShakeX),math.rad(math.sin(now*23)*S.ShakeY),math.rad(math.sin(now*17)*S.ShakeZ))end
 end
 fov.Visible=S.ShowFOV;fov.Position=UDim2.fromOffset(cursor.X,cursor.Y);fov.Size=UDim2.fromOffset(S.FOV*2,S.FOV*2);fovStroke.Color=U.color('FOVColor');fov.BackgroundColor3=U.color('FOVColor');fov.BackgroundTransparency=S.FilledFOV and 1-S.FOVOpacity or 1
 dead.Visible=S.ShowDeadzone and S.Deadzone>0;dead.Position=fov.Position;dead.Size=UDim2.fromOffset(S.Deadzone*2,S.Deadzone*2);deadStroke.Color=U.color('FOVColor')
 targetHighlight.Enabled=S.TargetHighlight and target~=nil;targetHighlight.Adornee=target and target.char;targetHighlight.FillColor=U.color('TargetColor');targetHighlight.OutlineColor=U.color('TargetColor')
 prediction.Transparency=S.PredictionMarker and point and .2 or 1;if point then prediction.Position=point;prediction.Color=U.color('TargetColor')end
 tracer.Visible=false;dot.Visible=false
 if point then local v,on=cam:WorldToViewportPoint(point);if on then local p=Vector2.new(v.X,v.Y);if S.TargetTracer then drawLine(tracer,cursor,p,U.color('TargetColor'),S.TracerThickness)end;dot.Visible=S.TargetDot;dot.Position=UDim2.fromOffset(v.X,v.Y);dot.TextColor3=U.color('TargetColor')end end
 for i,o in ipairs(cross)do o.Visible=S.Crosshair;if S.Crosshair then
  local angle=(i-1)*math.pi/2+(S.CrosshairSpin and math.rad(now*S.CrosshairSpinSpeed)or 0);local dir=Vector2.new(math.cos(angle),math.sin(angle));local gap=S.CrosshairGap+(S.DynamicGap and(math.sin(now*3)+1)*3 or 0)
  drawLine(o,cursor+dir*gap,cursor+dir*(gap+S.CrosshairLength),U.color('CrosshairColor'),S.CrosshairThickness)
 end end
 crossDot.Visible=S.Crosshair and S.CrosshairDot;crossDot.Position=UDim2.fromOffset(cursor.X,cursor.Y);crossDot.BackgroundColor3=U.color('CrosshairColor')
 watermark.Visible=S.Watermark;watermark.Text='Kimqetras UNLEGIT | '..lp.Name
 keysLabel.Visible=S.KeybindDisplay;local names={};for name,b in pairs(bindingRecords)do if b.old then table.insert(names,'['..b.old.Name..'] '..name)end end;table.sort(names);keysLabel.Text=table.concat(names,'\n')
 toast.Visible=os.clock()<toastUntil
 scale.Scale=math.max(.25,math.min(S.MenuScale,(cam.ViewportSize.X-24)/550,(cam.ViewportSize.Y-32)/600))
 espClock=espClock+dt;if espClock>=.05 then espClock=0;updateESP(cam,myRoot)end
end)

local cachedAssets={};local cacheFolder=U.own(Instance.new('Folder'));cacheFolder.Name='UNLEGITVisualCache' -- deliberately unparented
local function asset(id)
 if not cachedAssets[id]then
  local objects=game:GetObjects('rbxassetid://'..id);local object=objects and objects[1];assert(object,'Visual asset unavailable: '..id)
  for _,o in ipairs(object:GetDescendants())do
   if o:IsA('LuaSourceContainer')then o:Destroy()
   elseif o:IsA('BasePart')then o.Anchored=true;o.CanCollide=false;o.CanTouch=false;o.CanQuery=false
   elseif o:IsA('Sound')then o.PlayOnRemove=false;o:Stop()end
  end
  if object:IsA('LuaSourceContainer')then object:Destroy();error('Expected a visual asset')end
  if object:IsA('BasePart')then object.Anchored=true;object.CanCollide=false;object.CanTouch=false;object.CanQuery=false end
  object.Parent=cacheFolder;cachedAssets[id]=object
 end
 return cachedAssets[id]:Clone()
end
local function positionEffect(object,cf)
 if object:IsA('Model')then object:PivotTo(cf)
 elseif object:IsA('BasePart')then object.CFrame=cf
 else
  local pivot=object:FindFirstChildWhichIsA('BasePart',true)
  if pivot then local delta=cf*pivot.CFrame:Inverse();for _,o in ipairs(object:GetDescendants())do if o:IsA('BasePart')then o.CFrame=delta*o.CFrame end end end
 end
end
local function emit(object)
 local list=object:GetDescendants();table.insert(list,object)
 for _,o in ipairs(list)do
  if o:IsA('ParticleEmitter')then local count=tonumber(o:GetAttribute('EmitCount'))or 20;local delay=tonumber(o:GetAttribute('EmitDelay'))or 0;o.Enabled=false
   task.delay(delay,function()if U.alive and o.Parent then o:Emit(math.clamp(count,1,300))end end)
  elseif o:IsA('Sound')then o:Play()end
 end
end
local function sound(id,volume,pitch,parent)
 local s=make('Sound',parent or fx,{SoundId='rbxassetid://'..id,Volume=volume,PlaybackSpeed=pitch});s:Play();Debris:AddItem(s,10)
end
local function playParticles(position)
 task.spawn(function()
  local ok,err=pcall(function()
   local id=S.ParticleType=='Confetti'and '7255773215'or '14745759584'
   local object=asset(id);if not U.alive then object:Destroy();return end
   positionEffect(object,CFrame.new(position));object.Parent=fx
   for _,o in ipairs(object:GetDescendants())do if o:IsA('ParticleEmitter')then
    if S.ParticleType=='Bubble'then o.Color=ColorSequence.new(U.color('HitColor'))end
   end end
   emit(object);Debris:AddItem(object,5)
  end)
  if not ok then U.error('Hit particle asset',err)end
 end)
end
local function hitFeedback(character,position,preview)
 if not U.alive then return end
 if S.HitSound then sound(ASSETS.sfx[S.HitSoundName],S.HitVolume,S.HitPitch)end
 if S.HitHighlight and character then local h=make('Highlight',fx,{Adornee=character,FillColor=U.color('HitColor'),OutlineColor=U.color('HitColor'),FillTransparency=.4});Debris:AddItem(h,S.HitDuration)end
 if S.HitMarker then
  if S.MarkerType=='3D'then
   local p=make('Part',fx,{Size=Vector3.new(.1,.1,.1),Position=position,Anchored=true,CanCollide=false,CanQuery=false,CanTouch=false,Transparency=1})
   local billboard=make('BillboardGui',p,{Size=UDim2.fromOffset(32,32),AlwaysOnTop=true,Adornee=p});local mark=label(billboard,26);mark.Text='×';mark.Size=UDim2.fromScale(1,1);mark.TextColor3=U.color('HitColor');Debris:AddItem(p,S.HitDuration)
  else
   local mark=label(overlay,26);mark.Text='×';mark.Size=UDim2.fromOffset(32,32);mark.AnchorPoint=Vector2.new(.5,.5);local p=UIS:GetMouseLocation();mark.Position=UDim2.fromOffset(p.X,p.Y);mark.TextColor3=U.color('HitColor');Debris:AddItem(mark,S.HitDuration)
  end
 end
 if S.HitParticles then playParticles(position)end
 if S.HitNotify then U.notify(preview and 'Hit feedback preview' or 'Observed shot near '..(character and character.Name or 'target'))end
end
U.previewHit=function()
 local c,_,r=U.character(lp);assert(r,'Character not ready');hitFeedback(c,r.Position,true)
 U.state='Preview played for enabled feedback options'
end
-- Source-style ray feedback. This observes local visuals; it does not confirm server damage.
local shotTime=0;local shotTool;local shotConnection;local toolConnections={}
local function watchTool(tool)
 if tool==shotTool then return end
 if shotConnection then shotConnection:Disconnect();shotConnection=nil end
 for _,c in ipairs(toolConnections)do c:Disconnect()end;toolConnections={};shotTool=tool
 if not tool then return end
 local ammo=tool:FindFirstChild('Ammo',true)
 if ammo and(ammo:IsA('IntValue')or ammo:IsA('NumberValue'))then
  local previous=ammo.Value
  shotConnection=ammo:GetPropertyChangedSignal('Value'):Connect(function()local value=ammo.Value;if U.alive and value<previous then shotTime=os.clock()end;previous=value end)
 else
  table.insert(toolConnections,tool.Activated:Connect(function()if U.alive then shotTime=os.clock()end end))
 end
end
local watchClock=0
U.connect(RunService.Heartbeat,function(dt)
 watchClock=watchClock+dt;if watchClock<.2 then return end;watchClock=0
 local c=lp.Character;watchTool(c and c:FindFirstChildOfClass('Tool'))
end)
local lastFeedback=0
U.connect(workspace.DescendantAdded,function(o)
 if not S.HitObserve or o.Name~='BULLET_RAYS' or not o:IsA('BasePart')or os.clock()-shotTime>.2 then return end
 local c=lp.Character;local handle=shotTool and shotTool:FindFirstChild('Handle')
 if not handle or(o.Position-handle.Position).Magnitude>15 then return end
 if os.clock()-lastFeedback<.08 then return end
 local params=RaycastParams.new();params.FilterType=Enum.RaycastFilterType.Exclude;params.FilterDescendantsInstances={c,fx,o};params.IgnoreWater=true
 local hit=workspace:Raycast(o.Position,o.CFrame.LookVector*200,params)
 local model=hit and hit.Instance:FindFirstAncestorOfClass('Model')
 if model and model:FindFirstChildOfClass('Humanoid')then lastFeedback=os.clock();hitFeedback(model,hit.Position,false)end
end)
local stompIds={Glitch='12886574483',Explosion='12843483581',Airstrike='12868291219',Heart='12868779018',UFO='12876678129'}
local function playStomp(cf)
 local selected=S.StompEffect
 task.spawn(function()
  local ok,err=pcall(function()
   local o=asset(stompIds[selected]);if not U.alive then o:Destroy();return end
   positionEffect(o,cf);o.Parent=fx;Debris:AddItem(o,10)
   if selected=='Heart'then
    local top=o:FindFirstChild('PartOne');local base=o:FindFirstChild('Part')
    if top and top:IsA('BasePart')then top.CFrame=cf*CFrame.new(0,7,0)end
    if base and base:IsA('BasePart')then base.CFrame=cf end
    sound('1840977366',1,1,top or fx)
   elseif selected=='UFO'then
    local main=o:FindFirstChild('Main');local effect=o:FindFirstChild('Effect')
    if main and main:IsA('BasePart')then main.CFrame=cf*CFrame.new(0,-1,0);TweenService:Create(main,TweenInfo.new(4),{CFrame=main.CFrame+Vector3.new(0,20,0)}):Play()end
    if effect and effect:IsA('BasePart')then effect.CFrame=cf*CFrame.new(0,35,0);effect.Transparency=0;TweenService:Create(effect,TweenInfo.new(4),{CFrame=effect.CFrame+Vector3.new(0,20,0),Transparency=1}):Play()end
    sound('138207483',1,1)
   elseif selected=='Airstrike'and o:IsA('BasePart')then
    o.CFrame=cf*CFrame.new(0,200,-2000);TweenService:Create(o,TweenInfo.new(5.566,Enum.EasingStyle.Linear),{CFrame=cf*CFrame.new(0,200,2000)}):Play();sound('88858815',1,1.5)
   elseif selected=='Explosion'then
    for _,m in ipairs(o:GetDescendants())do if m:IsA('SpecialMesh')then TweenService:Create(m,TweenInfo.new(1),{Scale=m.Scale*2}):Play()end end
   elseif selected=='Glitch'then sound('8880764455',1,1)end
   emit(o)
   U.state='Played '..selected..' visual'
  end)
  if not ok then U.error('Stomp visual asset',err)end
 end)
end
U.previewStomp=function()local _,_,r=U.character(lp);assert(r,'Character not ready');playStomp(r.CFrame)end
local wanted,wantedConnection,stompClock
local function connectWanted()
 local d=lp:FindFirstChild('DataFolder');local info=d and d:FindFirstChild('Information');local value=info and info:FindFirstChild('Wanted')
 U.stompStatus=value and 'Wanted counter detected; E + increase of 50' or 'Unavailable: DataFolder.Information.Wanted missing'
 if value==wanted then return end
 if wantedConnection then wantedConnection:Disconnect();wantedConnection=nil end;wanted=value
 if not wanted then return end
 local previous=tonumber(wanted.Value)or 0
 wantedConnection=wanted:GetPropertyChangedSignal('Value'):Connect(function()
  local current=tonumber(wanted.Value)or 0;local difference=current-previous;previous=current
  if not U.alive or not S.StompObserve or difference~=50 or os.clock()-(U.lastStompInput or 0)>1.5 then return end
  local _,_,r=U.character(lp);if not r then return end
  local nearest,best=nil,10
  for _,p in ipairs(Players:GetPlayers())do if p~=lp then local c,_,root=U.character(p);if root and U.knocked(c)then local dist=(r.Position-root.Position).Magnitude;if dist<best then nearest=root;best=dist end end end end
  if nearest then playStomp(nearest.CFrame)end
 end)
end
stompClock=0
U.connect(RunService.Heartbeat,function(dt)stompClock=stompClock+dt;if stompClock>=1 then stompClock=0;connectWanted()end end)
local originalStop=U.stopRuntime
U.stopRuntime=function()
 originalStop();if shotConnection then shotConnection:Disconnect()end;if wantedConnection then wantedConnection:Disconnect()end;for _,c in ipairs(toolConnections)do c:Disconnect()end
end

-- Independent versioned configs. Older UNLEGIT feature configs are rejected.
local memory={};local dir='Kimqetras_UNLEGIT_HC_Source'
local disk=type(writefile)=='function'and type(readfile)=='function'and type(isfile)=='function'and type(makefolder)=='function'and type(isfolder)=='function'
local function configName(name)
 name=tostring(name):gsub('^%s+',''):gsub('%s+$','');assert(#name>0 and #name<=48 and name:match('^[%w_%-]+$'),'Use letters, numbers, underscores or hyphens');return name
end
local function path(name)return dir..'/'..configName(name)..'.json'end
local function ensure()if disk and not isfolder(dir)then makefolder(dir)end end
function U.saveConfig(name,create)
 local p=path(name);ensure()
 if create then assert(not(disk and isfile(p)or memory[p]),'Name exists; use Save')end
 local binds={};for label,b in pairs(bindingRecords)do if b.old then binds[label]=b.old.Name end end
 local encoded=Http:JSONEncode({schema='HC_SOURCE_1',settings=S,bindings=binds})
 if disk then writefile(p,encoded)else memory[p]=encoded end
 U.state=disk and 'Saved '..name or 'Saved for this session; file APIs unavailable'
end
function U.loadConfig(name)
 local p=path(name);local encoded
 if disk then assert(isfile(p),'Config not found');encoded=readfile(p)else encoded=memory[p];assert(encoded,'Config not found')end
 local data=Http:JSONDecode(encoded);assert(type(data)=='table'and data.schema=='HC_SOURCE_1'and type(data.settings)=='table','Not a config for this rebuild')
 -- Validate the complete config before changing any state.
 for k,v in pairs(data.settings)do
  assert(defaults[k]~=nil and type(v)==type(defaults[k]),'Invalid setting: '..tostring(k))
  if type(v)=='number'then assert(v==v and math.abs(v)<math.huge,'Invalid number')end
  if choices[k]then assert(table.find(choices[k],v),'Invalid choice')end
  if colorKeys[k]then assert(v:match('^#%x%x%x%x%x%x$'),'Invalid color')end
 end
 for k,v in pairs(defaults)do local value=data.settings[k];if value==nil then value=v end;U.set(k,value)end
 table.clear(toggleKeyActions)
 for _,b in pairs(bindingRecords)do b.old=nil;b.label.Text='None'end
 if type(data.bindings)=='table'then for label,key in pairs(data.bindings)do local b=bindingRecords[label];local ok,code=pcall(function()return Enum.KeyCode[key]end)
  if b and ok and code and code~=Enum.KeyCode.RightShift and code~=Enum.KeyCode.Unknown and not toggleKeyActions[code]then b.old=code;b.label.Text=code.Name;toggleKeyActions[code]=b.action end
 end end
 U.refresh();U.state='Loaded '..name
end
function U.deleteConfig(name)
 local p=path(name)
 if disk then assert(type(delfile)=='function','File deletion unavailable');assert(isfile(p),'Config not found');delfile(p)else assert(memory[p],'Config not found');memory[p]=nil end
 U.state='Deleted '..name
end
local configSec=section('Settings','Configurations','left')
local nameBox=field(configSec,'Config name','default',function()end)
button(configSec,'Create',function()U.saveConfig(nameBox.Text,true)end)
button(configSec,'Save',function()U.saveConfig(nameBox.Text,false)end)
button(configSec,'Load',function()U.loadConfig(nameBox.Text)end)
button(configSec,'Delete',function()U.deleteConfig(nameBox.Text)end)
local configList=note(configSec,'',44)
button(configSec,'List configs',function()
 local names={};if disk then ensure();assert(type(listfiles)=='function','File listing unavailable');for _,file in ipairs(listfiles(dir))do local n=file:gsub('\\','/'):match('/([%w_%-]+)%.json$');if n then table.insert(names,n)end end
 else for file in pairs(memory)do table.insert(names,file:match('/([^/]+)%.json$'))end end
 table.sort(names);configList.Text=(disk and 'Saved: 'or 'Session: ')..table.concat(names,', ')
end)
local statusSec=section('Settings','Status & session','left')
local statusLabel=note(statusSec,'Ready',68)
button(statusSec,'Disable all features',function()
 for k,v in pairs(defaults)do if type(v)=='boolean'then U.set(k,false)end end
 U.state='All features disabled'
end)
button(statusSec,'Reset settings',function()for k,v in pairs(defaults)do U.set(k,v)end;U.state='Defaults restored'end)
button(statusSec,'Unload UNLEGIT',function()U:Destroy()end)
note(statusSec,'Right Shift: menu. Click None beside a toggle to bind a key. Escape clears it.',58)
local hitSec=section('Hit Effects','Game support & preview','left')
note(hitSec,'Observes nearby BULLET_RAYS after your local shot. This is visual feedback, not proof of server damage.',78)
button(hitSec,'Preview enabled hit effects',U.previewHit)
local sourceSec=section('Visuals','Game support & preview','right')
local supportLabel=note(sourceSec,'Checking game support...',100)
button(sourceSec,'Preview stomp visual',U.previewStomp)
note(sourceSec,'Visual assets load on demand. Restricted or missing assets report an error in Settings.',65)
local aimSec=section('Aim Assist','Target status','right')
local targetLabel=note(aimSec,'No target',46)
note(aimSec,'Camera assist pauses while the menu or a text box is open. It does not redirect bullets.',65)
local characterSec=section('Character','Asset support','left')
note(characterSec,'Character meshes use the source asset IDs. Visibility depends on asset access in this experience.',65)
local clock=0
U.connect(RunService.Heartbeat,function(dt)
 clock=clock+dt;if clock<.25 then return end;clock=0
 statusLabel.Text=U.state
 supportLabel.Text=(U.soundStatus or 'Equip a gun')..'\n'..(U.stompStatus or 'Checking Wanted counter')
 targetLabel.Text=U.target and(U.target.player.DisplayName..' (@'..U.target.player.Name..')')or 'No eligible on-screen target'
end)
showPage('Aim Assist');U.refresh();U.ready=true;U.state='Ready • Right Shift opens / closes'

]========]
task.wait() -- Let the visible startup panel render before compiling the app.
local compiled,compileError=loadstring(source,'Kimqetras_UNLEGIT')
if not compiled then fail('Compile error',compileError);return end
local ran,result=xpcall(compiled,function(err)return debug and debug.traceback and debug.traceback(tostring(err),2)or tostring(err)end)
if not ran then
 local partial=_G.KimqetrasUNLEGIT
 if partial and partial.Destroy then pcall(function()partial:Destroy()end)end
 fail('Startup error',result);return
end
local app=_G.KimqetrasUNLEGIT
if not app or not app.ready or not app.gui or not app.gui.Parent then fail('Startup error','The interface did not finish initialization.');return end
app.gui.Enabled=true
boot:Destroy()
