warn("Kimqetras UNLEGIT build 4: HC controls")
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
-- Kimqetras UNLEGIT • independent build 1
-- Uses the equipped game's Tool and Hood-style MainEvent stomping; no universal damage bypass.
local Players=game:GetService('Players')
local RunService=game:GetService('RunService')
local UIS=game:GetService('UserInputService')
local CoreGui=game:GetService('CoreGui')
local RS=game:GetService('ReplicatedStorage')
local Http=game:GetService('HttpService')
local lp=Players.LocalPlayer
local pg=assert(lp:WaitForChild('PlayerGui',15),'PlayerGui unavailable')
local mouse=lp:GetMouse()
if _G.KimqetrasUNLEGIT and _G.KimqetrasUNLEGIT.Destroy then _G.KimqetrasUNLEGIT:Destroy()end
local U={alive=true,connections={},drawings={},objects={},whitelist={},selected={},waypoints={},deaths={},state='Ready',lastFire=0,lastStomp=0,angle=0}
_G.KimqetrasUNLEGIT=U
function U.connect(signal,fn)
 local lastError
 local c=signal:Connect(function(...)
  if not U.alive then return end
  local ok,err=pcall(fn,...)
  if not ok then
   U.lastError=tostring(err);U.state='Controller error: '..U.lastError:sub(1,120)
   if lastError~=U.lastError then warn('[UNLEGIT] '..U.lastError);lastError=U.lastError end
  end
 end)
 table.insert(U.connections,c);return c
end
function U.own(o)table.insert(U.objects,o);return o end
function U:Destroy()
 if not self.alive then return end;self.alive=false
 for _,c in ipairs(self.connections)do pcall(function()c:Disconnect()end)end
 for _,d in ipairs(self.drawings)do pcall(function()d:Remove()end)end
 for _,o in ipairs(self.objects)do pcall(function()o:Destroy()end)end
 if self.gui then pcall(function()self.gui:Destroy()end)end
 if _G.KimqetrasUNLEGIT==self then _G.KimqetrasUNLEGIT=nil end
end
local defaults={KillMode=false,VoidSpam=false,Spectate=false,Predict=false,Prediction=.12,RandomStomp=false,LowHPStomp=false,StompHP=15,
TeleportMode='Off',ReturnOrigin=true,Orbit=false,OrbitSpeed=3,OrbitRadius=7,TargetDistance=5,TargetMode='Selected',AimPart='Head',FOV=180,WallCheck=true,TeamCheck=false,
Camlock=false,CamSmooth=.18,Triggerbot=false,FireDelay=.15,ZoomAim=false,ZoomFOV=45,SilentAim=false,BulletVisualizer=false,TargetVisualizer=false,
ESP=false,Name=false,Distance=false,Skeleton=false,EngineHealth=false,Box=false,Box3D=false,GradientFill=false,Glow=false,Edges=false,HealthBar=false,ESPRange=1500,ESPColor='#F3A1D3',
WaypointESP=false,DeathMarkers=false,WaypointIcon=true,WaypointText=true,
CFrameSpeedEnabled=false,CFrameSpeed=2,WalkspeedEnabled=false,Walkspeed=16,FakeMacro=false,MacroSpeed=35,QuickStop=false,InstantFall=false,HipEnabled=false,HipHeight=2,
Freecam=false,FreecamSpeed=40,Fly=false,FlySpeed=45,JumpEnabled=false,JumpPower=50,GravityEnabled=false,Gravity=196.2,InfiniteJump=false,Spinbot=false,SpinSpeed=360,ForceHit=false,ForceHitRange=175,ForceHitDelay=.15,KnifeAssist=false,KnifeRange=8,CombatAutoEquip=false,SpeedBoost=false,SpeedBoostValue=32,DesyncPreview=false}
local S={};for k,v in pairs(defaults)do S[k]=v end
U.settings=S
local numericBounds={CFrameSpeed={1,60},Prediction={0,.6},StompHP={1,100},OrbitSpeed={.1,15},OrbitRadius={2,30},TargetDistance={2,30},FOV={10,800},CamSmooth={.01,1},FireDelay={.05,2},ZoomFOV={20,100},ESPRange={50,5000},Walkspeed={0,150},MacroSpeed={1,150},HipHeight={0,15},FreecamSpeed={1,200},FlySpeed={1,200},JumpPower={0,200},Gravity={0,400},SpinSpeed={0,1080},ForceHitRange={10,800},ForceHitDelay={.05,2},KnifeRange={2,18},SpeedBoostValue={16,150}}
local choices={TeleportMode={'Off','Behind','Above','Orbit'},TargetMode={'Selected','Closest Cursor','Closest Distance','Lowest Health'},AimPart={'Head','HumanoidRootPart','UpperTorso'}}
function U.character(p)local c=p and p.Character;return c,c and c:FindFirstChildOfClass('Humanoid'),c and c:FindFirstChild('HumanoidRootPart')end
function U.knocked(c)
 local b=c and c:FindFirstChild('BodyEffects');local v=b and(b:FindFirstChild('K.O')or b:FindFirstChild('KO'))
 return v and(v.Value==true or v.Value==1)or false
end
function U.color()local ok,c=pcall(Color3.fromHex,S.ESPColor);return ok and c or Color3.fromRGB(243,161,211)end
function U.set(k,v)
 if defaults[k]==nil or type(v)~=type(defaults[k])then return false end
 if type(v)=='number'then if v~=v or math.abs(v)==math.huge then return false end;local r=numericBounds[k];if r then v=math.clamp(v,r[1],r[2])end end
 if choices[k]and not table.find(choices[k],v)then return false end
 if k=='ESPColor'and not v:match('^#%x%x%x%x%x%x$')then return false end
 S[k]=v
 if k=='Freecam'and v then S.Spectate=false;S.Camlock=false;S.ZoomAim=false;S.KillMode=false;S.VoidSpam=false;S.Orbit=false;S.TeleportMode='Off' end
 if(k=='Spectate'or k=='Camlock'or k=='ZoomAim')and v then S.Freecam=false end
 if U.refresh then U.refresh()end
 return true
end

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
    local tabBar=Instance.new("Frame")
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


local TAB_NAMES={'Combat','Targets','ESP','Movement','Azure','Osiri','Lynx','Waypoints','Configs'}
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
  if input.KeyCode==Enum.KeyCode.RightShift then rec.label.Text=rec.old and rec.old.Name or 'None';return end
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
 local fractional={CFrameSpeed=1,Prediction=3,OrbitSpeed=1,OrbitRadius=1,TargetDistance=1,CamSmooth=2,FireDelay=3,ForceHitDelay=3,HipHeight=1}
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
-- Azure V4 original routines are bundled below, not rewritten as fake toggles.
local AZURE_ORIGINAL=[============[
if (not LPH_OBFUSCATED) then
    LPH_NO_VIRTUALIZE = function(...) return (...) end;
    LPH_JIT_MAX = function(...) return (...) end;
    LPH_JIT_ULTRA = function(...) return (...) end;
end


    --// Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    --// Variables
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace:FindFirstChildWhichIsA("Camera")
    local Hitsounds = {}

    --// Script Table
    local Script = {
        Functions = {},
        Locals = {
            Target = nil,
            IsTargetting = false,
            Resolver = {
                OldTick = tick(),
                OldPos = Vector3.new(0, 0, 0),
                ResolvedVelocity = Vector3.new(0, 0, 0)
            },
            AutoSelectTick = tick(),
            AntiAimViewer = {
                MouseRemoteFound = false,
                MouseRemote = nil,
                MouseRemoteArgs = nil,
                MouseRemotePositionIndex = nil
            },
            HitEffect = nil,
            Gun = {
                PreviousGun = nil,
                PreviousAmmo = 999,
                Shotguns = {"[Double-Barrel SG]", "[TacticalShotgun]", "[Shotgun]"}
            },
            PlayerHealth = {},
            JumpOffset = 0,
            BulletPath = {
                [4312377180] = Workspace:FindFirstChild("MAP") and Workspace.MAP:FindFirstChild("Ignored") or nil,
                [1008451066] = Workspace:FindFirstChild("Ignored") and Workspace.Ignored:FindFirstChild("Siren") and Workspace.Ignored.Siren:FindFirstChild("Radius") or nil,
                [3985694250] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [5106782457] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [4937639028] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [1958807588] = Workspace and Workspace:FindFirstChild("Ignored") or nil
            },
            World = {
                FogColor = Lighting.FogColor,
                FogStart = Lighting.FogStart,
                FogEnd = Lighting.FogEnd,
                Ambient = Lighting.Ambient,
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                ExposureCompensation = Lighting.ExposureCompensation
            },
            SavedCFrame = nil,
            NetworkPreviousTick = tick(),
            NetworkShouldSleep = false,
            FFlags = {
                ["DataSenderMaxJoinBandwidthBps"] = (type(getfflag)=="function" and getfflag("DataSenderMaxJoinBandwidthBps") or ""),
                ["PhysicsSenderMaxBandwidthBps"] = (type(getfflag)=="function" and getfflag("PhysicsSenderMaxBandwidthBps") or ""),
                ["S2PhysicsSenderRate"] = (type(getfflag)=="function" and getfflag("S2PhysicsSenderRate") or "")
            },
            OriginalVelocity = {},
            RotationAngle = 0
        },
        Utility = {
            Drawings = {},
            EspCache = {}
        },
        Connections = {
            GunConnections = {}
        },
        AzureIgnoreFolder = Instance.new("Folder", game:GetService("Workspace"))
    }

    --// Settings Table
    local Settings = {
        Combat = {
            Enabled = false,
            AimPart = "HumanoidRootPart",
            Silent = false,
            Mouse = false,
            Alerts = false,
            LookAt = false,
            Spectate = false,
            AntiAimViewer = false,
            AutoSelect = {
                Enabled = false,
                Cooldown = {
                    Enabled = false,
                    Amount = 0.5
                }
            },
            Checks = {
                Enabled = false,
                Knocked = false,
                Crew = false,
                Wall = false,
                Grabbed = false,
                Vehicle = false
            },
            Smoothing = {
                Horizontal = 1,
                Vertical = 1
            },
            Prediction = {
                Horizontal = 0.134,
                Vertical = 0.134
            },
            Resolver = {
                Enabled = false,
                RefreshRate = 30
            },
            Fov = {
                Enabled = false,
                Visualize = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Radius = 80
            },
            Visuals = {
                Enabled = false,
                Tracer = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Thickness = 2
                },
                Dot = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Filled = false,
                    Size = 6
                },
                Chams = {
                    Enabled = false,
                    Fill = {
                        Color = Color3.new(1, 1, 1),
                        Transparency = 0.5
                    },
                    Outline = {
                        Color = Color3.new(1, 1, 1),
                        Transparency = 0.5
                    }
                }
            },
            Air = {
                Enabled = false,
                AirAimPart = {
                    Enabled = false,
                    HitPart = "LowerTorso"
                },
                JumpOffset = {
                    Enabled = false,
                    Offset = 0.09
                }
            }
        },
        Visuals = {
            Esp = {
                Enabled = false,
                Boxes = {
                    Enabled = false,
                    Filled = {
                        Enabled = false,
                        Color = Color3.new(1, 1, 1),
                        Transparency = 0.3
                    },
                    Color = Color3.new(1, 1, 1)
                }
            },
            BulletTracers = {
                Enabled = false,
                Color = {
                    Gradient1 = Color3.new(1, 1, 1),
                    Gradient2 = Color3.new(0, 0, 0)
                },
                Duration = 1,
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            BulletImpacts = {
                Enabled = false,
                Color = Color3.new(1, 1, 1),
                Duration = 1,
                Size = 1,
                Material = "SmoothPlastic",
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            OnHit = {
                Enabled = false,
                Effect = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Sound = {
                    Enabled = false,
                    Volume = 5,
                    Value = "Skeet"
                },
                Chams = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Material = "ForceField",
                    Duration = 1
                }
            },
            World = {
                Enabled = false,
                Fog = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    End = 1000,
                    Start = 10000
                },
                Ambient = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Brightness = {
                    Enabled = false,
                    Value = 0
                },
                ClockTime = {
                    Enabled = false,
                    Value = 24
                },
                WorldExposure = {
                    Enabled = false,
                    Value = -0.1
                }
            },
            Crosshair = {
                Enabled = false,
                Color = Color3.new(1, 1, 1),
                Size = 10,
                Gap = 2,
                Rotation = {
                    Enabled = false,
                    Speed = 1
                }
            }
        },
        AntiAim = {
            VelocitySpoofer = {
                Enabled = false,
                Visualize = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Prediction = 0.134
                },
                Type = "Underground",
                Roll = 0,
                Pitch = 0,
                Yaw = 0
            },
            CSync = {
                Enabled = false,
                Type = "Custom",
                Visualize = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                RandomDistance = 16,
                Custom = {
                    X = 0,
                    Y = 0,
                    Z = 0
                },
                TargetStrafe = {
                    Speed = 1,
                    Distance = 1,
                    Height = 1
                }
            },
            Network = {
                Enabled = false,
                WalkingCheck = false,
                Amount = 0.1
            },
            VelocityDesync = {
                Enabled = false,
                Range = 1
            },
            FFlagDesync = {
                Enabled = false,
                SetNew = false,
                FFlags = {"S2PhysicsSenderRate"},
                SetNewAmount = 15,
                Amount = 2
            },
            InvisibleDesync = {
                Enabled = false
            }
        },
        Misc = {
            Movement = {
                Speed = {
                    Enabled = false,
                    Amount = 1
                },
            },
            Exploits = {
                Enabled = false,
                NoRecoil = false,
                NoJumpCooldown = false,
                NoSlowDown = false
            }
        }
    }

    --// Functions
    do
        --// Utility Functions
        do
            Script.Functions.WorldToScreen = function(Position: Vector3)
                if not Position then return end

                local ViewportPointPosition, OnScreen = Camera:WorldToViewportPoint(Position)
                local ScreenPosition = Vector2.new(ViewportPointPosition.X, ViewportPointPosition.Y)
                return {
                    Position = ScreenPosition,
                    OnScreen = OnScreen
                }
            end

            Script.Functions.Connection = function(ConnectionType: any, Function: any)
                local Connection = ConnectionType:Connect(Function)
                return Connection
            end

            Script.Functions.MoveMouse = function(Position: Vector2, SmoothingX: number, SmoothingY: number)
                local MousePosition = UserInputService:GetMouseLocation()

                mousemoverel((Position.X - MousePosition.X) / SmoothingX, (Position.Y - MousePosition.Y) / SmoothingY)
            end

            Script.Functions.CreateDrawing = function(DrawingType: string, Properties: any)
                local DrawingObject = Drawing.new(DrawingType)

                for Property, Value in pairs(Properties) do
                    DrawingObject[Property] = Value
                end
                return DrawingObject
            end

            Script.Functions.WallCheck = function(Part: any)
                local RayCastParams = RaycastParams.new()
                RayCastParams.FilterType = Enum.RaycastFilterType.Exclude
                RayCastParams.IgnoreWater = true
                RayCastParams.FilterDescendantsInstances = Script.AzureIgnoreFolder:GetChildren()

                local CameraPosition = Camera.CFrame.Position
                local Direction = (Part.Position - CameraPosition).Unit
                local RayCastResult = workspace:Raycast(CameraPosition, Direction * 10000, RayCastParams)

                return RayCastResult ~= nil and RayCastResult.Instance == Part
            end

            Script.Functions.Create = function(ObjectType: string, Properties: any)
                local Object = Instance.new(ObjectType)

                for Property, Value in pairs(Properties) do
                    Object[Property] = Value
                end
                return Object
            end

            Script.Functions.GetGun = function(Player: any)
                local Info = {
                    Tool = nil,
                    Ammo = nil,
                    IsGunEquipped = false
                }

                local Tool = Player.Character:FindFirstChildWhichIsA("Tool")

                if not Tool then return end

                if game.GameId == 1958807588 then
                    local ArmoryGun = Player.Information.Armory:FindFirstChild(Tool.Name)
                    if ArmoryGun then
                        Info.Tool = Tool
                        Info.Ammo = ArmoryGun.Ammo.Normal
                        Info.IsGunEquipped = true
                    else
                        for _, Object in pairs(Tool:GetChildren()) do
                            if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") then
                                Info.Tool = Tool
                                Info.IsGunEquipped = true
                                Info.Ammo = Object
                            end
                        end
                    end
                elseif game.GameId == 3634139746 then
                    for _, Object in pairs(Tool:getdescendants()) do
                        if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") and not Object.Name:lower():find("no") then
                            Info.Tool = Tool
                            Info.Ammo = Object
                            Info.IsGunEquipped = true
                        end
                    end
                else
                    for _, Object in pairs(Tool:GetChildren()) do
                        if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") then
                            Info.Tool = Tool
                            Info.IsGunEquipped = true
                            Info.Ammo = Object
                        end
                    end
                end


                return Info
            end

            Script.Functions.Beam = function(StartPos: Vector3, EndPos: Vector3)
                local ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Settings.Visuals.BulletTracers.Color.Gradient1),
                    ColorSequenceKeypoint.new(1, Settings.Visuals.BulletTracers.Color.Gradient2),
                })
                local Part = Instance.new("Part", Script.AzureIgnoreFolder)
                Part.Size = Vector3.new(0, 0, 0)
                Part.Massless = true
                Part.Transparency = 1
                Part.CanCollide = false
                Part.Position = StartPos
                Part.Anchored = true
                local Attachment = Instance.new("Attachment", Part)
                local Part2 = Instance.new("Part", Script.AzureIgnoreFolder)
                Part2.Size = Vector3.new(0, 0, 0)
                Part2.Transparency = 0
                Part2.CanCollide = false
                Part2.Position = EndPos
                Part2.Anchored = true
                Part2.Material = Enum.Material.ForceField
                Part2.Color = Color3.fromRGB(255, 0, 212)
                Part2.Massless = true
                local Attachment2 = Instance.new("Attachment", Part2)
                local Beam = Instance.new("Beam", Part)
                Beam.FaceCamera = true
                Beam.Color = ColorSequence
                Beam.Attachment0 = Attachment
                Beam.Attachment1 = Attachment2
                Beam.LightEmission = 6
                Beam.LightInfluence = 1
                Beam.Width0 = 1.5
                Beam.Width1 = 1.5
                Beam.Texture = "http://www.roblox.com/asset/?id=446111271"
                Beam.TextureSpeed = 2
                Beam.TextureLength = 1
                task.delay(Settings.Visuals.BulletTracers.Duration, function()
                    if Settings.Visuals.BulletTracers.Fade.Enabled then
                        local TweenValue = Instance.new("NumberValue")
                        TweenValue.Parent = Beam
                        local Tween = TweenService:Create(TweenValue, TweenInfo.new(Settings.Visuals.BulletTracers.Fade.Duration), {Value = 1})
                        Tween:Play()

                        local Connection
                        Connection = Script.Functions.Connection(TweenValue:GetPropertyChangedSignal("Value"), function()
                            Beam.Transparency = NumberSequence.new(TweenValue.Value, TweenValue.Value)
                        end)

                        Script.Functions.Connection(Tween.Completed, function()
                            Connection:Disconnect()
                            Part:Destroy()
                            Part2:Destroy()
                        end)
                    else
                        Part:Destroy()
                        Part2:Destroy()
                    end
                end)
            end

            Script.Functions.Impact = function(Pos: Vector3)
                local Part = Script.Functions.Create("Part", {
                    Parent = Script.AzureIgnoreFolder,
                    Color = Settings.Visuals.BulletImpacts.Color,
                    Size = Vector3.new(Settings.Visuals.BulletImpacts.Size, Settings.Visuals.BulletImpacts.Size, Settings.Visuals.BulletImpacts.Size),
                    Position = Pos,
                    Anchored = true,
                    Material = Enum.Material[Settings.Visuals.BulletImpacts.Material]
                })

                task.delay(Settings.Visuals.BulletImpacts.Duration, function()
                    if Settings.Visuals.BulletImpacts.Fade.Enabled then
                        local Tween = TweenService:Create(Part, TweenInfo.new(Settings.Visuals.BulletImpacts.Fade.Duration), {Transparency = 1})
                        Tween:Play()

                        Script.Functions.Connection(Tween.Completed, function()
                            Part:Destroy()
                        end)
                    else
                        Part:Destroy()
                    end
                end)
            end

            Script.Functions.GetClosestPlayerDamage = function(Position: Vector3, MaxRadius: number)
                local Radius = MaxRadius
                local ClosestPlayer

                for PlayerName, Health in pairs(Script.Locals.PlayerHealth) do
                    local Player = Players:FindFirstChild(PlayerName)
                    if Player and Player.Character then
                        local PlayerPosition = Player.Character.PrimaryPart.Position
                        local Distance = (Position - PlayerPosition).Magnitude
                        local CurrentHealth = Player.Character.Humanoid.Health
                        if (Distance < Radius) and (CurrentHealth < Health) then
                            Radius = Distance
                            ClosestPlayer = Player
                        end
                    end
                end
                return ClosestPlayer
            end


            Script.Functions.Effect = function(Part, Color)
                local Clone = Script.Locals.HitEffect:Clone()
                Clone.Parent = Part

                for _, Effect in pairs(Clone:GetChildren()) do
                    if Effect:IsA("ParticleEmitter") then
                        Effect.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                            ColorSequenceKeypoint.new(0.495, Settings.Visuals.OnHit.Effect.Color),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
                        })
                        Effect:Emit(1)
                    end
                end

                task.delay(2, function()
                    Clone:Destroy()
                end)
            end

            Script.Functions.PlaySound = function(SoundId, Volume)
                local Sound = Instance.new("Sound")
                Sound.Parent = Script.AzureIgnoreFolder
                Sound.Volume = Volume
                Sound.SoundId = SoundId

                Sound:Play()

                Script.Functions.Connection(Sound.Ended, function()
                    Sound:Destroy()
                end)
            end

            Script.Functions.Hitcham = function(Player, Color)
                for _, BodyPart in pairs(Player.Character:GetChildren()) do
                    if BodyPart.Name ~= "HumanoidRootPart" and BodyPart:IsA("BasePart") then
                        local Part = Instance.new("Part")
                        Part.Name = BodyPart.Name .. "_Clone"
                        Part.Parent = Script.AzureIgnoreFolder
                        Part.Material = Enum.Material[Settings.Visuals.OnHit.Chams.Material]
                        Part.Color = Settings.Visuals.OnHit.Chams.Color
                        Part.Transparency = 0
                        Part.Anchored = true
                        Part.Size = BodyPart.Size
                        Part.CFrame = BodyPart.CFrame

                        task.delay(Settings.Visuals.OnHit.Chams.Duration, function()
                            Part:Destroy()
                        end)
                    end
                end
            end

            Script.Functions.Rotate = function(Vector, Origin, Angle)
                local CosA = math.cos(Angle)
                local SinA = math.sin(Angle)
                local X = Vector.X - Origin.X
                local Y = Vector.Y - Origin.Y
                local NewX = X * CosA - Y * SinA
                local NewY = X * SinA + Y * CosA
                return Vector2.new(NewX + Origin.x, NewY + Origin.y)
            end
        end

        --// General Functions
        do
            Script.Functions.GetClosestPlayer = function()
                local Radius = Settings.Combat.Fov.Enabled and Settings.Combat.Fov.Radius or math.huge
                local ClosestPlayer
                local Mouse = UserInputService:GetMouseLocation()

                for _, Player in pairs(Players:GetPlayers()) do
                    if Player ~= LocalPlayer and Player.Character and Player.Character.PrimaryPart then
                        --// Variables
                        local ScreenPosition = Script.Functions.WorldToScreen(Player.Character.PrimaryPart.Position)
                        local Distance = (Mouse - ScreenPosition.Position).Magnitude

                        --// OnScreen Check
                        if not ScreenPosition.OnScreen then continue end

                        --// Checks
                        if (Settings.Combat.Checks.Enabled and (Settings.Combat.Checks.Vehicle and Player.Character:FindFirstChild("[CarHitBox]")) or (Settings.Combat.Checks.Knocked and Player.Character.BodyEffects["K.O"].Value == true) or (Settings.Combat.Checks.Grabbed and Player.Character:FindFirstChild("GRABBING_CONSTRAINT")) or (Settings.Combat.Checks.Crew and Player.DataFolder.Information.Crew.Value == LocalPlayer.DataFolder.Information.Crew.Value) or (Settings.Combat.Checks.Wall and Script.Functions.WallCheck(Player.Character.PrimaryPart))) then continue end

                        if (Distance < Radius) then
                            Radius = Distance
                            ClosestPlayer = Player
                        end
                    end
                end

                return ClosestPlayer
            end

            Script.Functions.GetPredictedPosition = function()
                local BodyPart = Script.Locals.Target.Character[Settings.Combat.AimPart]
                local Velocity = Settings.Combat.Resolver.Enabled and Script.Locals.Resolver.ResolvedVelocity or Script.Locals.Target.Character.HumanoidRootPart.Velocity
                local Position = BodyPart.Position + Velocity * Vector3.new(Settings.Combat.Prediction.Horizontal, Settings.Combat.Prediction.Vertical, Settings.Combat.Prediction.Horizontal)

                if Settings.Combat.Air.Enabled and Settings.Combat.Air.JumpOffset.Enabled then
                    Position = Position + Vector3.new(0, Script.Locals.JumpOffset, 0)
                end

                return Position
            end

            Script.Functions.Resolve = function()
                if Settings.Combat.Enabled and Settings.Combat.Resolver.Enabled and Script.Locals.IsTargetting and Script.Locals.Target then
                    --// Variables
                    local HumanoidRootPart = Script.Locals.Target.Character.HumanoidRootPart
                    local CurrentPosition = HumanoidRootPart.Position
                    local DeltaTime = tick() - Script.Locals.Resolver.OldTick
                    local NewVelocity = DeltaTime > 0.00001 and (CurrentPosition - Script.Locals.Resolver.OldPos) / DeltaTime or Vector3.zero

                    --// Set the velocity
                    Script.Locals.Resolver.ResolvedVelocity = NewVelocity

                    --// Update the old tick and old position
                    if tick() - Script.Locals.Resolver.OldTick >= 1 / Settings.Combat.Resolver.RefreshRate then
                        Script.Locals.Resolver.OldTick, Script.Locals.Resolver.OldPos = tick(), HumanoidRootPart.Position
                    end
                end
            end

            Script.Functions.MouseAim = function()
                if Settings.Combat.Enabled and Settings.Combat.Mouse and Script.Locals.IsTargetting and Script.Locals.Target then
                    local Position = Script.Functions.GetPredictedPosition()
                    local ScreenPosition = Script.Functions.WorldToScreen(Position)

                    if ScreenPosition.OnScreen then
                        Script.Functions.MoveMouse(ScreenPosition.Position, Settings.Combat.Smoothing.Horizontal, Settings.Combat.Smoothing.Vertical)
                    end
                end
            end

            Script.Functions.UpdateFieldOfView = function()
                Script.Utility.Drawings["FieldOfViewVisualizer"].Visible = Settings.Combat.Enabled and Settings.Combat.Fov.Enabled and Settings.Combat.Fov.Visualize.Enabled
                Script.Utility.Drawings["FieldOfViewVisualizer"].Color = Settings.Combat.Fov.Visualize.Color
                Script.Utility.Drawings["FieldOfViewVisualizer"].Radius = Settings.Combat.Fov.Radius
                Script.Utility.Drawings["FieldOfViewVisualizer"].Position = UserInputService:GetMouseLocation()
            end

            Script.Functions.UpdateTargetVisuals = function()
                --// ScreenPosition, Will be changed later
                local Position

                --// Variable to indicate if you"re targetting or not with a check if the target visuals are enabled
                local IsTargetting = Settings.Combat.Enabled and Settings.Combat.Visuals.Enabled and Script.Locals.IsTargetting and Script.Locals.Target or false

                --// Change the position
                if IsTargetting then
                    local PredictedPosition = Script.Functions.GetPredictedPosition()
                    Position = Script.Functions.WorldToScreen(PredictedPosition)
                end

                --// Variable to indicate if the drawing elements should show
                local TracerShow = IsTargetting and Settings.Combat.Visuals.Tracer.Enabled and Position.OnScreen or false
                local DotShow = IsTargetting and Settings.Combat.Visuals.Dot.Enabled and Position.OnScreen or false
                local ChamsShow = IsTargetting and Settings.Combat.Visuals.Chams.Enabled and Script.Locals.Target and Script.Locals.Target.Character or nil


                --// Set the drawing elements visibility
                Script.Utility.Drawings["TargetTracer"].Visible = TracerShow
                Script.Utility.Drawings["TargetDot"].Visible = DotShow
                Script.Utility.Drawings["TargetChams"].Parent = ChamsShow


                --// Update the drawing elements
                if TracerShow then
                    Script.Utility.Drawings["TargetTracer"].From = UserInputService:GetMouseLocation()
                    Script.Utility.Drawings["TargetTracer"].To = Position.Position
                    Script.Utility.Drawings["TargetTracer"].Color = Settings.Combat.Visuals.Tracer.Color
                    Script.Utility.Drawings["TargetTracer"].Thickness = Settings.Combat.Visuals.Tracer.Thickness
                end

                if DotShow then
                    Script.Utility.Drawings["TargetDot"].Position = Position.Position
                    Script.Utility.Drawings["TargetDot"].Radius = Settings.Combat.Visuals.Dot.Size
                    Script.Utility.Drawings["TargetDot"].Filled = Settings.Combat.Visuals.Dot.Filled
                    Script.Utility.Drawings["TargetDot"].Color = Settings.Combat.Visuals.Dot.Color
                end

                if ChamsShow then
                    Script.Utility.Drawings["TargetChams"].FillColor = Settings.Combat.Visuals.Chams.Fill.Color
                    Script.Utility.Drawings["TargetChams"].FillTransparency = Settings.Combat.Visuals.Chams.Fill.Transparency
                    Script.Utility.Drawings["TargetChams"].OutlineTransparency = Settings.Combat.Visuals.Chams.Outline.Transparency
                    Script.Utility.Drawings["TargetChams"].OutlineColor = Settings.Combat.Visuals.Chams.Outline.Color
                end
            end

            Script.Functions.AutoSelect = function()
                if (Settings.Combat.Enabled and Settings.Combat.AutoSelect.Enabled) and (tick() - Script.Locals.AutoSelectTick >= Settings.Combat.AutoSelect.Cooldown.Amount and Settings.Combat.AutoSelect.Cooldown.Enabled or true) then
                    local NewTarget = Script.Functions.GetClosestPlayer()
                    Script.Locals.Target = NewTarget or nil
                    Script.Locals.IsTargetting =  NewTarget and true or false
                    Script.Locals.AutoSelectTick = tick()
                end
            end

            Script.Functions.GunEvents = function()
                local CurrentGun = Script.Functions.GetGun(LocalPlayer)

                if CurrentGun and CurrentGun.IsGunEquipped and CurrentGun.Tool then
                    if CurrentGun.Tool ~= Script.Locals.Gun.PreviousGun then
                        Script.Locals.Gun.PreviousGun = CurrentGun.Tool
                        Script.Locals.Gun.PreviousAmmo = 999

                        --// Connections
                        for _, Connection in pairs(Script.Connections.GunConnections) do
                            Connection:Disconnect()
                        end
                        Script.Connections.GunConnections = {}
                    end

                    if not Script.Connections.GunConnections["GunActivated"] and Settings.Combat.Enabled and Settings.Combat.Silent and Script.Locals.AntiAimViewer.MouseRemoteFound then
                        Script.Connections.GunConnections["GunActivated"] = Script.Functions.Connection(CurrentGun.Tool.Activated, function()
                            if Script.Locals.IsTargetting and Script.Locals.Target then
                                if Settings.Combat.AntiAimViewer then
                                    local Arguments = Script.Locals.AntiAimViewer.MouseRemoteArgs

                                    Arguments[Script.Locals.AntiAimViewer.MouseRemotePositionIndex] = Script.Functions.GetPredictedPosition()
                                    Script.Locals.AntiAimViewer.MouseRemote:FireServer(unpack(Arguments))
                                end
                            end
                        end)
                    end


                    if not Script.Connections.GunConnections["GunAmmoChanged"] then
                        Script.Connections.GunConnections["GunAmmoChanged"] = Script.Functions.Connection(CurrentGun.Ammo:GetPropertyChangedSignal("Value") , function()
                            local NewAmmo = CurrentGun.Ammo.Value
                            if (NewAmmo < Script.Locals.Gun.PreviousAmmo or (game.GameId == 3985694250 and NewAmmo > Script.Locals.Gun.PreviousAmmo)) and Script.Locals.Gun.PreviousAmmo then

                                local ChildAdded
                                local ChildrenAdded = 0
                                ChildAdded = Script.Functions.Connection(Script.Locals.BulletPath[game.GameId].ChildAdded, function(Object)
                                    if Object.Name == "BULLET_RAYS" then
                                        ChildrenAdded += 1
                                        if (table.find(Script.Locals.Gun.Shotguns, CurrentGun.Tool.Name) and ChildrenAdded <= 5) or (ChildrenAdded == 1) then
                                            local GunBeam = Object:WaitForChild("GunBeam")
                                            local StartPos, EndPos = Object.Position, GunBeam.Attachment1.WorldPosition

                                            if Settings.Visuals.BulletTracers.Enabled then
                                                GunBeam:Destroy()
                                                Script.Functions.Beam(StartPos, EndPos)
                                            end

                                            if Settings.Visuals.BulletImpacts.Enabled then
                                                Script.Functions.Impact(EndPos)
                                            end

                                            if Settings.Visuals.OnHit.Enabled then
                                                local Player = Script.Functions.GetClosestPlayerDamage(EndPos, 20)
                                                if Player then
                                                    if Settings.Visuals.OnHit.Effect.Enabled then
                                                        Script.Functions.Effect(Player.Character.HumanoidRootPart)
                                                    end

                                                    if Settings.Visuals.OnHit.Sound.Enabled then
                                                        local Sound = string.format("hitsounds/%s", Settings.Visuals.OnHit.Sound.Value)
                                                        Script.Functions.PlaySound(getcustomasset(Sound), Settings.Visuals.OnHit.Sound.Volume)
                                                    end

                                                    if Settings.Visuals.OnHit.Chams.Enabled then
                                                        Script.Functions.Hitcham(Player, Settings.Visuals.OnHit.Chams.Color)
                                                    end
                                                end
                                            end
                                            ChildAdded:Disconnect()
                                        end
                                    else
                                        ChildAdded:Disconnect()
                                    end
                                end)
                            end
                            Script.Locals.Gun.PreviousAmmo = NewAmmo
                        end)
                    end
                end
            end

            Script.Functions.Air = function()
                if Settings.Combat.Enabled and Script.Locals.IsTargetting and Script.Locals.Target and Settings.Combat.Air.Enabled then
                    local Humanoid = Script.Locals.Target.Character.Humanoid

                    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                        Script.Locals.JumpOffset = Settings.Combat.Air.JumpOffset.Offset
                    else
                        Script.Locals.JumpOffset = 0
                    end
                end
            end

            Script.Functions.UpdateHealth = function()
                if Settings.Visuals.OnHit.Enabled then
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player.Character and Player.Character.Humanoid then
                            Script.Locals.PlayerHealth[Player.Name] = Player.Character.Humanoid.Health
                        end
                    end
                end
            end

            Script.Functions.UpdateAtmosphere = function()
                Lighting.FogColor = Settings.Visuals.World.Enabled and Settings.Visuals.World.Fog.Enabled and Settings.Visuals.World.Fog.Color or Script.Locals.World.FogColor
                Lighting.FogStart = Settings.Visuals.World.Enabled and Settings.Visuals.World.Fog.Enabled and Settings.Visuals.World.Fog.Start or Script.Locals.World.FogStart
                Lighting.FogEnd = Settings.Visuals.World.Enabled and Settings.Visuals.World.Fog.Enabled and Settings.Visuals.World.Fog.End or Script.Locals.World.FogEnd
                Lighting.Ambient = Settings.Visuals.World.Enabled and Settings.Visuals.World.Ambient.Enabled and Settings.Visuals.World.Ambient.Color or Script.Locals.World.Ambient
                Lighting.Brightness = Settings.Visuals.World.Enabled and Settings.Visuals.World.Brightness.Enabled and Settings.Visuals.World.Brightness.Value or Script.Locals.World.Brightness
                Lighting.ClockTime = Settings.Visuals.World.Enabled and Settings.Visuals.World.ClockTime.Enabled and Settings.Visuals.World.ClockTime.Value or Script.Locals.World.ClockTime
                Lighting.ExposureCompensation = Settings.Visuals.World.Enabled and Settings.Visuals.World.WorldExposure.Enabled and Settings.Visuals.World.WorldExposure.Value or Script.Locals.World.ExposureCompensation
            end

            Script.Functions.VelocitySpoof = function()
                local ShowVisualizerDot = Settings.AntiAim.VelocitySpoofer.Enabled and Settings.AntiAim.VelocitySpoofer.Visualize.Enabled

                Script.Utility.Drawings["VelocityDot"].Visible = ShowVisualizerDot


                if Settings.AntiAim.VelocitySpoofer.Enabled then
                    --// Variables
                    local Type = Settings.AntiAim.VelocitySpoofer.Type
                    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                    local Velocity = HumanoidRootPart.Velocity

                    --// Main
                    if Type == "Underground" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(0, -Settings.AntiAim.VelocitySpoofer.Yaw, 0)
                    elseif Type == "Sky" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(0, Settings.AntiAim.VelocitySpoofer.Yaw, 0)
                    elseif Type == "Multiplier" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(Settings.AntiAim.VelocitySpoofer.Yaw, Settings.AntiAim.VelocitySpoofer.Pitch, Settings.AntiAim.VelocitySpoofer.Roll)
                    elseif Type == "Custom" then
                        HumanoidRootPart.Velocity = Vector3.new(Settings.AntiAim.VelocitySpoofer.Yaw, Settings.AntiAim.VelocitySpoofer.Pitch, Settings.AntiAim.VelocitySpoofer.Roll)
                    elseif Type == "Prediction Breaker" then
                        HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end

                    if ShowVisualizerDot then
                        local ScreenPosition = Script.Functions.WorldToScreen(LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.Velocity * Settings.AntiAim.VelocitySpoofer.Visualize.Prediction)

                        Script.Utility.Drawings["VelocityDot"].Position = ScreenPosition.Position
                        Script.Utility.Drawings["VelocityDot"].Color = Settings.AntiAim.VelocitySpoofer.Visualize.Color
                    end

                    RunService.RenderStepped:Wait()
                    HumanoidRootPart.Velocity = Velocity
                end
            end

            Script.Functions.CSync = function()
                Script.Utility.Drawings["CFrameVisualize"].Parent = Settings.AntiAim.CSync.Visualize.Enabled and Settings.AntiAim.CSync.Enabled and Script.AzureIgnoreFolder or nil

                if Settings.AntiAim.CSync.Enabled then
                    local Type = Settings.AntiAim.CSync.Type
                    local FakeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    Script.Locals.SavedCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    if Type == "Custom" then
                        FakeCFrame = FakeCFrame * CFrame.new(Settings.AntiAim.CSync.Custom.X, Settings.AntiAim.CSync.Custom.Y, Settings.AntiAim.CSync.Custom.Z)
                    elseif Type == "Target Strafe" and Script.Locals.IsTargetting and Script.Locals.Target and Settings.Combat.Enabled then
                        local CurrentTime = tick()
                        FakeCFrame = CFrame.new(Script.Locals.Target.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 2 * math.pi * CurrentTime * Settings.AntiAim.CSync.TargetStrafe.Speed % (2 * math.pi), 0) * CFrame.new(0, Settings.AntiAim.CSync.TargetStrafe.Height, Settings.AntiAim.CSync.TargetStrafe.Distance)
                    elseif Type == "Local Strafe" then
                        local CurrentTime = tick()
                        FakeCFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 2 * math.pi * CurrentTime * Settings.AntiAim.CSync.TargetStrafe.Speed % (2 * math.pi), 0) * CFrame.new(0, Settings.AntiAim.CSync.TargetStrafe.Height, Settings.AntiAim.CSync.TargetStrafe.Distance)
                    elseif Type == "Random" then
                        FakeCFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance), math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance), math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance))) * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
                    elseif Type == "Random Target" and Script.Locals.IsTargetting and Script.Locals.Target and Settings.Combat.Enabled then
                        FakeCFrame = CFrame.new(Script.Locals.Target.Character.HumanoidRootPart.Position + Vector3.new(math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance), math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance), math.random(-Settings.AntiAim.CSync.RandomDistance, Settings.AntiAim.CSync.RandomDistance))) * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
                    end

                    Script.Utility.Drawings["CFrameVisualize"]:SetPrimaryPartCFrame(FakeCFrame)

                    for _, Part in pairs(Script.Utility.Drawings["CFrameVisualize"]:GetChildren()) do
                        Part.Color = Settings.AntiAim.CSync.Visualize.Color
                    end

                    LocalPlayer.Character.HumanoidRootPart.CFrame = FakeCFrame
                    RunService.RenderStepped:Wait()
                    LocalPlayer.Character.HumanoidRootPart.CFrame = Script.Locals.SavedCFrame
                end
            end

            Script.Functions.Network = function()
                if Settings.AntiAim.Network.Enabled then
                    if (tick() - Script.Locals.NetworkPreviousTick) >= ((Settings.AntiAim.Network.Amount / math.pi) / 10000) or (Settings.AntiAim.Network.WalkingCheck and LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0) then
                        Script.Locals.NetworkShouldSleep = not Script.Locals.NetworkShouldSleep
                        Script.Locals.NetworkPreviousTick = tick()
                        sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", Script.Locals.NetworkShouldSleep)
                    end
                end
            end

            Script.Functions.Speed = function()
                if Settings.Misc.Movement.Speed.Enabled then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * Settings.Misc.Movement.Speed.Amount
                end
            end

            Script.Functions.VelocityDesync = function()
                if Settings.AntiAim.VelocityDesync.Enabled then
                    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                    local Velocity = HumanoidRootPart.Velocity
                    local Amount = Settings.AntiAim.VelocityDesync.Range * 1000
                    HumanoidRootPart.Velocity = Vector3.new(math.random(-Amount, Amount), math.random(-Amount, Amount), math.random(-Amount, Amount))
                    RunService.RenderStepped:Wait()
                    HumanoidRootPart.Velocity = Velocity
                end
            end

            Script.Functions.FFlagDesync = function()
                if Settings.AntiAim.FFlagDesync.Enabled then
                    for FFlag, _ in pairs(Settings.AntiAim.FFlagDesync.FFlags) do
                        local Value = Settings.AntiAim.FFlagDesync.Amount
                        setfflag(FFlag, tostring(Value))

                        RunService.RenderStepped:Wait()
                        if Settings.AntiAim.FFlagDesync.SetNew then
                            setfflag(FFlag, Settings.AntiAim.FFlagDesync.SetNewAmount)
                        end
                    end
                end
            end


            --// Invisible Desync
            Script.Functions.InvisibleDesync = function()
                if Settings.AntiAim.InvisibleDesync.Enabled then
                    local NetworkShouldSleep = false
                    if not Script.Connections["Invisible Desync"] then
                        Script.Connections["Invisible Desync"] = Script.Functions.Connection(RunService.Heartbeat, function()
                            Script.Locals.NetworkShouldSleep = not Script.Locals.NetworkShouldSleep
                            setfflag("S2PhysicsSenderRate", tostring(2))
                            setfflag("PhysicsSenderMaxBandwidthBps", tostring(math.pi/3))

                            sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", Script.Locals.NetworkShouldSleep)
                            Script.Locals.OriginalVelocity[1] = LocalPlayer.Character.HumanoidRootPart.Velocity
                            Script.Locals.OriginalVelocity[2] = LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity

                            LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.HumanoidRootPart.Velocity + Vector3.new(math.random(-16000, 16000), math.random(-16000, 16000), math.random(-16000, 16000))
                            LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity + Vector3.new(math.random(-16000, 16000), math.random(-16000, 16000), math.random(-16000, 16000))

                            RunService.RenderStepped:Wait()

                            LocalPlayer.Character.HumanoidRootPart.Velocity = Script.Locals.OriginalVelocity[1]
                            LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Script.Locals.OriginalVelocity[2]
                            setfflag("S2PhysicsSenderRate", tostring(1))
                            NetworkShouldSleep = not NetworkShouldSleep
                        end)
                    end
                    RunService.RenderStepped:Wait()
                    sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", NetworkShouldSleep)
                    setfflag("S2PhysicsSenderRate", tostring(15))
                end
            end

            Script.Functions.NoSlowdown = function()
                if Settings.Misc.Exploits.NoSlowDown then
                    for _, Slowdown in pairs(LocalPlayer.Character.BodyEffects.Movement:GetChildren()) do
                        Slowdown:Destroy()
                    end
                end
            end

            --// Horrid code
            Script.Functions.UpdateCrosshair = function()
                if Settings.Visuals.Crosshair.Enabled then
                    local MouseX, MouseY
                    local RotationAngle = Script.Locals.RotationAngle
                    local RealSize = Settings.Visuals.Crosshair.Size * 2

                    if not MouseX or not MouseY then
                        MouseX, MouseY = UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y
                    end

                    local Gap = Settings.Visuals.Crosshair.Gap
                    if Settings.Visuals.Crosshair.Rotation.Enabled then
                        Script.Locals.RotationAngle = Script.Locals.RotationAngle + Settings.Visuals.Crosshair.Rotation.Speed
                    else
                        Script.Locals.RotationAngle = 0
                    end

                    Script.Utility.Drawings["CrosshairLeft"].Visible = true
                    Script.Utility.Drawings["CrosshairLeft"].Color = Settings.Visuals.Crosshair.Color
                    Script.Utility.Drawings["CrosshairLeft"].Thickness = 1
                    Script.Utility.Drawings["CrosshairLeft"].Transparency = 1
                    Script.Utility.Drawings["CrosshairLeft"].From = Vector2.new(MouseX + Gap, MouseY)
                    Script.Utility.Drawings["CrosshairLeft"].To = Vector2.new(MouseX + RealSize, MouseY)
                    if Settings.Visuals.Crosshair.Rotation.Enabled then
                        Script.Utility.Drawings["CrosshairLeft"].From = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairLeft"].From, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                        Script.Utility.Drawings["CrosshairLeft"].To = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairLeft"].To, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                    end

                    Script.Utility.Drawings["CrosshairRight"].Visible = true
                    Script.Utility.Drawings["CrosshairRight"].Color = Settings.Visuals.Crosshair.Color
                    Script.Utility.Drawings["CrosshairRight"].Thickness = 1
                    Script.Utility.Drawings["CrosshairRight"].Transparency = 1
                    Script.Utility.Drawings["CrosshairRight"].From = Vector2.new(MouseX - Gap, MouseY)
                    Script.Utility.Drawings["CrosshairRight"].To = Vector2.new(MouseX - RealSize, MouseY)
                    if Settings.Visuals.Crosshair.Rotation.Enabled then
                        Script.Utility.Drawings["CrosshairRight"].From = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairRight"].From, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                        Script.Utility.Drawings["CrosshairRight"].To = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairRight"].To, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                    end

                    Script.Utility.Drawings["CrosshairTop"].Visible = true
                    Script.Utility.Drawings["CrosshairTop"].Color = Settings.Visuals.Crosshair.Color
                    Script.Utility.Drawings["CrosshairTop"].Thickness = 1
                    Script.Utility.Drawings["CrosshairTop"].Transparency = 1
                    Script.Utility.Drawings["CrosshairTop"].From = Vector2.new(MouseX, MouseY + Gap)
                    Script.Utility.Drawings["CrosshairTop"].To = Vector2.new(MouseX, MouseY + RealSize)
                    if Settings.Visuals.Crosshair.Rotation.Enabled then
                        Script.Utility.Drawings["CrosshairTop"].From = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairTop"].From, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                        Script.Utility.Drawings["CrosshairTop"].To = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairTop"].To, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                    end

                    Script.Utility.Drawings["CrosshairBottom"].Visible = true
                    Script.Utility.Drawings["CrosshairBottom"].Color = Settings.Visuals.Crosshair.Color
                    Script.Utility.Drawings["CrosshairBottom"].Thickness = 1
                    Script.Utility.Drawings["CrosshairBottom"].Transparency = 1
                    Script.Utility.Drawings["CrosshairBottom"].From = Vector2.new(MouseX, MouseY - Gap)
                    Script.Utility.Drawings["CrosshairBottom"].To = Vector2.new(MouseX, MouseY - RealSize)
                    if Settings.Visuals.Crosshair.Rotation.Enabled then
                        Script.Utility.Drawings["CrosshairBottom"].From = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairBottom"].From, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                        Script.Utility.Drawings["CrosshairBottom"].To = Script.Functions.Rotate(Script.Utility.Drawings["CrosshairBottom"].To, Vector2.new(MouseX, MouseY), math.rad(RotationAngle))
                    end
                else
                    Script.Utility.Drawings["CrosshairBottom"].Visible = false
                    Script.Utility.Drawings["CrosshairTop"].Visible = false
                    Script.Utility.Drawings["CrosshairRight"].Visible = false
                    Script.Utility.Drawings["CrosshairLeft"].Visible = false
                end
            end

            Script.Functions.UpdateLookAt = function()
                if Settings.Combat.Enabled and Settings.Combat.LookAt and Script.Locals.IsTargetting and Script.Locals.Target then
                    LocalPlayer.Character.Humanoid.AutoRotate = false
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(Script.Locals.Target.Character.HumanoidRootPart.CFrame.X, LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y, Script.Locals.Target.Character.HumanoidRootPart.CFrame.Z))
                else
                    LocalPlayer.Character.Humanoid.AutoRotate = true
                end
            end

            Script.Functions.UpdateSpectate = function()
                if Settings.Combat.Enabled and Settings.Combat.Spectate and Script.Locals.IsTargetting and Script.Locals.Target then
                    Camera.CameraSubject = Script.Locals.Target.Character.Humanoid
                else
                    Camera.CameraSubject = LocalPlayer.Character.Humanoid
                end
            end
        end

        --// Esp Function
        do

        end
    end

    --// Drawing objects
    do
        Script.Utility.Drawings["FieldOfViewVisualizer"] = Script.Functions.CreateDrawing("Circle", {
            Visible = Settings.Combat.Fov.Visualize.Enabled,
            Color = Settings.Combat.Fov.Visualize.Color,
            Radius = Settings.Combat.Fov.Radius
        })

        Script.Utility.Drawings["TargetTracer"] = Script.Functions.CreateDrawing("Line",{
            Visible = false,
            Color = Settings.Combat.Visuals.Tracer.Color,
            Thickness = Settings.Combat.Visuals.Tracer.Thickness
        })

        Script.Utility.Drawings["TargetDot"] = Script.Functions.CreateDrawing("Circle", {
            Visible = false,
            Color = Settings.Combat.Visuals.Dot.Color,
            Radius = Settings.Combat.Visuals.Dot.Size
        })

        Script.Utility.Drawings["VelocityDot"] = Script.Functions.CreateDrawing("Circle", {
            Visible = false,
            Color = Settings.AntiAim.VelocitySpoofer.Visualize.Color,
            Radius = 6,
            Filled = true
        })

        Script.Utility.Drawings["TargetChams"] = Script.Functions.Create("Highlight", {
            Parent = nil,
            FillColor = Settings.Combat.Visuals.Chams.Fill.Color,
            FillTransparency = Settings.Combat.Visuals.Chams.Fill.Transparency,
            OutlineColor = Settings.Combat.Visuals.Chams.Fill.Color,
            OutlineTransparency = Settings.Combat.Visuals.Chams.Outline.Transparency
        })

        Script.Utility.Drawings["CrosshairTop"] = Script.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        Script.Utility.Drawings["CrosshairBottom"] = Script.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        Script.Utility.Drawings["CrosshairLeft"] = Script.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        Script.Utility.Drawings["CrosshairRight"] = Script.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })


        Script.Utility.Drawings["CFrameVisualize"] = game:GetObjects("rbxassetid://9474737816")[1]; Script.Utility.Drawings["CFrameVisualize"].Head.Face:Destroy(); for _, v in pairs(Script.Utility.Drawings["CFrameVisualize"]:GetChildren()) do v.Transparency = v.Name == "HumanoidRootPart" and 1 or 0.70; v.Material = "Neon"; v.Color = Settings.AntiAim.CSync.Visualize.Color; v.CanCollide = false; v.Anchored = false end
    end


    --// Hitsounds
   

    --// Hit Effects
    do
        --// Nova
        do
            local Part = Instance.new("Part")
            Part.Parent = ReplicatedStorage

            local Attachment = Instance.new("Attachment")
            Attachment.Name = "Attachment"
            Attachment.Parent = Part

            Script.Locals.HitEffect = Attachment

            local ParticleEmitter = Instance.new("ParticleEmitter")
            ParticleEmitter.Name = "ParticleEmitter"
            ParticleEmitter.Acceleration = Vector3.new(0, 0, 1)
            ParticleEmitter.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            })
            ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.5)
            ParticleEmitter.LightEmission = 1
            ParticleEmitter.LockedToPart = true
            ParticleEmitter.Rate = 1
            ParticleEmitter.Rotation = NumberRange.new(0, 360)
            ParticleEmitter.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 10),
                NumberSequenceKeypoint.new(1, 1),
            })
            ParticleEmitter.Speed = NumberRange.new(0, 0)
            ParticleEmitter.Texture = "rbxassetid://1084991215"
            ParticleEmitter.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(0.534, 0.25),
                NumberSequenceKeypoint.new(1, 0.5),
                NumberSequenceKeypoint.new(1, 0),
            })
            ParticleEmitter.ZOffset = 1
            ParticleEmitter.Parent = Attachment
            local ParticleEmitter1 = Instance.new("ParticleEmitter")
            ParticleEmitter1.Name = "ParticleEmitter"
            ParticleEmitter1.Acceleration = Vector3.new(0, 1, -0.001)
            ParticleEmitter1.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            })
            ParticleEmitter1.Lifetime = NumberRange.new(0.5, 0.5)
            ParticleEmitter1.LightEmission = 1
            ParticleEmitter1.LockedToPart = true
            ParticleEmitter1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
            ParticleEmitter1.Rate = 1
            ParticleEmitter1.Rotation = NumberRange.new(0, 360)
            ParticleEmitter1.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 10),
                NumberSequenceKeypoint.new(1, 1),
            })
            ParticleEmitter1.Speed = NumberRange.new(0, 0)
            ParticleEmitter1.Texture = "rbxassetid://1084991215"
            ParticleEmitter1.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(0.534, 0.25),
                NumberSequenceKeypoint.new(1, 0.5),
                NumberSequenceKeypoint.new(1, 0),
            })
            ParticleEmitter1.ZOffset = 1
            ParticleEmitter1.Parent = Attachment
        end
    end

    --// Connections
    do
        --// Combat Connections
        do
            Script.Functions.Connection(RunService.Heartbeat, function()
                Script.Functions.MouseAim()

                Script.Functions.Resolve()

                Script.Functions.Air()

                Script.Functions.UpdateLookAt()
            end)

            Script.Functions.Connection(RunService.RenderStepped, function()
                Script.Functions.UpdateFieldOfView()

                Script.Functions.UpdateTargetVisuals()

                Script.Functions.AutoSelect()

                Script.Functions.UpdateSpectate()
            end)
        end

        --// Visual Connections
        do
            Script.Functions.Connection(RunService.RenderStepped, function()
                Script.Functions.GunEvents()

                Script.Functions.UpdateHealth()

                Script.Functions.UpdateAtmosphere()

                Script.Functions.UpdateCrosshair()
            end)
        end

        --// Anti Aim Connection
        do
            Script.Functions.Connection(RunService.Heartbeat, function()
                Script.Functions.VelocitySpoof()

                Script.Functions.CSync()

                Script.Functions.Network()

                Script.Functions.VelocityDesync()

                Script.Functions.FFlagDesync()
            end)

            Script.Functions.Connection(RunService.Stepped, function()
                Script.Functions.InvisibleDesync()
            end)
        end

        --// Movement Connections
        do
            Script.Functions.Connection(RunService.Heartbeat, function()
                Script.Functions.Speed()

                Script.Functions.NoSlowdown()
            end)
        end
    end

    --// Hooks
    do
        local __namecall
        local __newindex
        local __index

        __index = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE(function(Self, Index)
            if not checkcaller() and Settings.AntiAim.CSync.Enabled and Script.Locals.SavedCFrame and Index == "CFrame" and Self == LocalPlayer.Character.HumanoidRootPart then
                return Script.Locals.SavedCFrame
            end
            return __index(Self, Index)
        end))

        __namecall = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(Self, ...)
            local Arguments = {...}
            local Method = tostring(getnamecallmethod())

            if not checkcaller() and Method == "FireServer" then
                for _, Argument in pairs(Arguments) do
                    if typeof(Argument) == "Vector3" then
                        Script.Locals.AntiAimViewer.MouseRemote = Self
                        Script.Locals.AntiAimViewer.MouseRemoteFound = true
                        Script.Locals.AntiAimViewer.MouseRemoteArgs = Arguments
                        Script.Locals.AntiAimViewer.MouseRemotePositionIndex = _

                        if Settings.Combat.Enabled and Settings.Combat.Silent and not Settings.Combat.AntiAimViewer and Script.Locals.IsTargetting and Script.Locals.Target then
                            Arguments[_] =  Script.Functions.GetPredictedPosition()
                        end

                        return __namecall(Self, unpack(Arguments))
                    end
                end
            end
            return __namecall(Self, ...)
        end))

        __newindex = hookmetamethod(game, "__newindex", LPH_NO_VIRTUALIZE(function(Self, Property, Value)
            local CallingScript = type(getcallingscript) == "function" and getcallingscript() or nil


            --// Atmosphere caching
            if not checkcaller() and Self == Lighting and Script.Locals.World[Property] ~= Value then
                Script.Locals.World[Property] = Value
            end

            --// No Recoil
            if CallingScript and CallingScript.Name == "Framework" and Self == Camera and Property == "CFrame" and Settings.Misc.Exploits.Enabled and Settings.Misc.Exploits.NoRecoil then
                return
            end

            --// No Jump Cooldown
            if CallingScript and CallingScript.Name == "Framework" and Self == LocalPlayer.Character.Humanoid and Property == "JumpPower" and Settings.Misc.Exploits.Enabled and Settings.Misc.Exploits.NoJumpCooldown then
                return
            end

            return __newindex(Self, Property, Value)
        end))
    end

   
        --// UI
       
 local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/DetainedMonkey2891/lin-customized/refs/heads/main/a'))()
    local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/DetainedMonkey2891/ThemeManager/refs/heads/main/Main'))()
    local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/refs/heads/main/addons/SaveManager.lua'))()
        --// Main Window
        local Window = Library:CreateWindow({
            Title = "Azure",
            Center = true,
            AutoShow = true,
            TabPadding = 8,
            MenuFadeTime = 0.2
        })

        local Tabs = {
            Combat = Window:AddTab("Combat"),
            Visuals = Window:AddTab("Visuals"),
            AntiAim = Window:AddTab("Anti Aim"),
            Misc = Window:AddTab("Misc"),
            Settings = Window:AddTab("Settings")
        }

        local Sections = {
            Combat = {
                Main = Tabs.Combat:AddLeftGroupbox("Main"),
                Checks = Tabs.Combat:AddRightGroupbox("Checks"),
                AutoSelect = Tabs.Combat:AddRightGroupbox("Auto Select"),
                Visuals = Tabs.Combat:AddRightGroupbox("Visuals"),
                Smoothing = Tabs.Combat:AddLeftGroupbox("Smoothing"),
                Resolver = Tabs.Combat:AddLeftGroupbox("Resolver"),
                FieldOfView = Tabs.Combat:AddLeftGroupbox("Field Of View"),
                Air = Tabs.Combat:AddRightGroupbox("Air")
            },
            Visuals = {
                --// Esp = Tabs.Visuals:AddLeftGroupbox("Esp"),
                Atmosphere = Tabs.Visuals:AddLeftGroupbox("Atmosphere"),
                Crosshair = Tabs.Visuals:AddLeftGroupbox("Crosshair"),
                BulletTracers = Tabs.Visuals:AddRightGroupbox("Bullet Tracers"),
                BulletImpacts = Tabs.Visuals:AddRightGroupbox("Bullet Impacts"),
                OnHit = Tabs.Visuals:AddRightGroupbox("On Hit")
            },
            AntiAim = {
                CSync = Tabs.AntiAim:AddLeftGroupbox("C-Sync"),
                Network = Tabs.AntiAim:AddLeftGroupbox("Network"),
                VelocitySpoofer = Tabs.AntiAim:AddRightGroupbox("Velocity Spoofer"),
                VelocityDesync = Tabs.AntiAim:AddRightGroupbox("Velocity Desync"),
                FFlag = Tabs.AntiAim:AddRightGroupbox("FFlag Desync"),
                InvisibleDesync = Tabs.AntiAim:AddLeftGroupbox("Invisible Desync (BETA)")
            },
            Misc = {
                Speed = Tabs.Misc:AddLeftGroupbox("CFrame Speed"),
                Exploits = Tabs.Misc:AddRightGroupbox("Exploits")
            }
        }

    
                Sections.Combat.Main:AddToggle("CombatMainEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                }):AddKeyPicker("CombatMainToggle", {
                    Default = "Q",
                    SyncToggleState = false,
                    Mode = "Toggle",
                    Text = "Targetting",
                    NoUI = false,
                })

                Toggles.CombatMainEnabled:OnChanged(function()
                    Settings.Combat.Enabled = Toggles.CombatMainEnabled.Value
                end)

                Options.CombatMainToggle:OnClick(function()
                    if Settings.Combat.Enabled then
                        Script.Locals.IsTargetting = not Script.Locals.IsTargetting

                        local NewTarget = Script.Functions.GetClosestPlayer()
                        Script.Locals.Target = Script.Locals.IsTargetting and NewTarget.Character and NewTarget or nil

                        if Settings.Combat.Alerts then
                            Library:Notify(string.format("Targetting: %s", Script.Locals.Target.Character.Humanoid.DisplayName))
                        end
                    end
                end)

                Sections.Combat.Main:AddToggle("CombatSilentEnabled", {
                    Text = "Silent",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatSilentEnabled:OnChanged(function()
                    Settings.Combat.Silent = Toggles.CombatSilentEnabled.Value
                end)

                Sections.Combat.Main:AddToggle("CombatMouseEnabled", {
                    Text = "Mouse",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatMouseEnabled:OnChanged(function()
                    Settings.Combat.Mouse = Toggles.CombatMouseEnabled.Value
                end)

                Sections.Combat.Main:AddToggle("CombatAlertsEnabled", {
                    Text = "Alerts",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatAlertsEnabled:OnChanged(function()
                    Settings.Combat.Alerts = Toggles.CombatAlertsEnabled.Value
                end)

                Sections.Combat.Main:AddToggle("CombatLookAtEnabled", {
                    Text = "Look At",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatLookAtEnabled:OnChanged(function()
                    Settings.Combat.LookAt = Toggles.CombatLookAtEnabled.Value
                end)

                Sections.Combat.Main:AddToggle("CombatSpectatEnabled", {
                    Text = "Spectate",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatSpectatEnabled:OnChanged(function()
                    Settings.Combat.Spectate = Toggles.CombatSpectatEnabled.Value
                end)

                Sections.Combat.Main:AddToggle("CombatAntiAimViewerEnabled", {
                    Text = "Anti AimViewer",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatAntiAimViewerEnabled:OnChanged(function()
                    Settings.Combat.AntiAimViewer = Toggles.CombatAntiAimViewerEnabled.Value
                end)

                Sections.Combat.Main:AddDropdown("CombatHitPartDropdown", {
                    Values = {"Head","HumanoidRootPart","LeftHand","RightHand","LeftLowerArm","RightLowerArm","LeftUpperArm","RightUpperArm","LeftFoot","LeftLowerLeg","UpperTorso","LeftUpperLeg","RightFoot","RightLowerLeg","LowerTorso","RightUpperLeg"},
                    Default = 2,
                    Multi = false,

                    Text = "Aim Part",
                    Tooltip = nil
                })

                Options.CombatHitPartDropdown:OnChanged(function()
                    Settings.Combat.AimPart = Options.CombatHitPartDropdown.Value
                end)

                Sections.Combat.Main:AddInput("CombatVerticalPrediction", {
                    Default = nil,
                    Numeric = false,
                    Finished = false,

                    Text = "Vertical Prediction",
                    Tooltip = nil,

                    Placeholder = "Vertical Prediction Amount"
                })

                Options.CombatVerticalPrediction:OnChanged(function()
                    Settings.Combat.Prediction.Vertical = tonumber(Options.CombatVerticalPrediction.Value)
                end)

                Sections.Combat.Main:AddInput("CombatHorizontalPrediction", {
                    Default = nil,
                    Numeric = false,
                    Finished = false,

                    Text = "Horizontal Prediction",
                    Tooltip = nil,

                    Placeholder = "Horizontal Prediction Amount"
                })


                Options.CombatHorizontalPrediction:OnChanged(function()
                    Settings.Combat.Prediction.Horizontal = tonumber(Options.CombatHorizontalPrediction.Value)
                end)
            
                Sections.Combat.Checks:AddToggle("CombatChecksEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksEnabled:OnChanged(function()
                    Settings.Combat.Checks.Enabled = Toggles.CombatChecksEnabled.Value
                end)

                Sections.Combat.Checks:AddToggle("CombatChecksKnockedEnabled", {
                    Text = "Knocked",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksKnockedEnabled:OnChanged(function()
                    Settings.Combat.Checks.Knocked = Toggles.CombatChecksKnockedEnabled.Value
                end)

                Sections.Combat.Checks:AddToggle("CombatChecksGrabbedEnabled", {
                    Text = "Grabbed",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksGrabbedEnabled:OnChanged(function()
                    Settings.Combat.Checks.Grabbed = Toggles.CombatChecksGrabbedEnabled.Value
                end)

                Sections.Combat.Checks:AddToggle("CombatChecksCrewEnabled", {
                    Text = "Crew",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksCrewEnabled:OnChanged(function()
                    Settings.Combat.Checks.Crew = Toggles.CombatChecksCrewEnabled.Value
                end)

                Sections.Combat.Checks:AddToggle("CombatChecksVehicleEnabled", {
                    Text = "Vehicle",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksVehicleEnabled:OnChanged(function()
                    Settings.Combat.Checks.Vehicle = Toggles.CombatChecksVehicleEnabled.Value
                end)

                Sections.Combat.Checks:AddToggle("CombatChecksWallEnabled", {
                    Text = "Wall",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatChecksWallEnabled:OnChanged(function()
                    Settings.Combat.Checks.Wall = Toggles.CombatChecksWallEnabled.Value
                end)
            

            --// Auto Select
            
                Sections.Combat.AutoSelect:AddToggle("CombatAutoSelectEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatAutoSelectEnabled:OnChanged(function()
                    Settings.Combat.AutoSelect.Enabled = Toggles.CombatAutoSelectEnabled.Value
                end)

                Sections.Combat.AutoSelect:AddToggle("CombatAutoSelectCooldownEnabled", {
                    Text = "Cooldown",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatAutoSelectCooldownEnabled:OnChanged(function()
                    Settings.Combat.AutoSelect.Cooldown.Enabled = Toggles.CombatAutoSelectCooldownEnabled.Value
                end)

                Sections.Combat.AutoSelect:AddSlider("CombatAutoSelectCooldownAmount", {
                    Text = "Cooldown Amount (MS)",
                    Default = 0.1,
                    Min = 0,
                    Max = 1,
                    Rounding = 3,
                    Compact = false
                })

                Options.CombatAutoSelectCooldownAmount:OnChanged(function()
                    Settings.Combat.AutoSelect.Cooldown.Amount = Options.CombatAutoSelectCooldownAmount.Value
                end)
            

            --// Smoothing
            
                Sections.Combat.Smoothing:AddSlider("CombatSmoothingVertical", {
                    Text = "Vertical Smoothing",
                    Default = 10,
                    Min = 1,
                    Max = 50,
                    Rounding = 2,
                    Compact = false
                })

                Options.CombatSmoothingVertical:OnChanged(function()
                    Settings.Combat.Smoothing.Vertical = Options.CombatSmoothingVertical.Value
                end)

                Sections.Combat.Smoothing:AddSlider("CombatSmoothingHorizontal", {
                    Text = "Horizontal Smoothing",
                    Default = 10,
                    Min = 1,
                    Max = 50,
                    Rounding = 2,
                    Compact = false
                })

                Options.CombatSmoothingHorizontal:OnChanged(function()
                    Settings.Combat.Smoothing.Horizontal = Options.CombatSmoothingHorizontal.Value
                end)
            

            --// Resolver
        
                Sections.Combat.Resolver:AddToggle("CombatResolverEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatResolverEnabled:OnChanged(function()
                    Settings.Combat.Resolver.Enabled = Toggles.CombatResolverEnabled.Value
                end)

                Sections.Combat.Resolver:AddSlider("CombatResolverRefreshRate", {
                    Text = "Refresh Rate",
                    Default = 200,
                    Min = 1,
                    Max = 200,
                    Rounding = 1,
                    Compact = false
                })

                Options.CombatResolverRefreshRate:OnChanged(function()
                    Settings.Combat.Resolver.RefreshRate = Options.CombatResolverRefreshRate.Value
                end)
            

            --// Field Of View
        
                Sections.Combat.FieldOfView:AddToggle("CombatFovEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatFovEnabled:OnChanged(function()
                    Settings.Combat.Fov.Enabled = Toggles.CombatFovEnabled.Value
                end)

                Sections.Combat.FieldOfView:AddToggle("CombatFovVisualizeEnabled", {
                    Text = "Visualize",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("CombatFovVisualizeColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Fov Visualize Color",
                    Transparency = nil
                })

                Toggles.CombatFovVisualizeEnabled:OnChanged(function()
                    Settings.Combat.Fov.Visualize.Enabled = Toggles.CombatFovVisualizeEnabled.Value
                end)

                Options.CombatFovVisualizeColor:OnChanged(function()
                    Settings.Combat.Fov.Visualize.Color = Options.CombatFovVisualizeColor.Value
                end)

                Sections.Combat.FieldOfView:AddSlider("CombatFieldOfViewRadius", {
                    Text = "Radius",
                    Default = 80,
                    Min = 1,
                    Max = 800,
                    Rounding = 2,
                    Compact = false
                })

                Options.CombatFieldOfViewRadius:OnChanged(function()
                    Settings.Combat.Fov.Radius = Options.CombatFieldOfViewRadius.Value
                end)
            

            --// Visuals
        
                Sections.Combat.Visuals:AddToggle("CombatVisualsEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatVisualsEnabled:OnChanged(function()
                    Settings.Combat.Visuals.Enabled = Toggles.CombatVisualsEnabled.Value
                end)

                Sections.Combat.Visuals:AddToggle("CombatVisualsTracerEnabled", {
                    Text = "Tracer",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("CombatVisualsTracerColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Tracer Color",
                    Transparency = nil
                })

                Toggles.CombatVisualsTracerEnabled:OnChanged(function()
                    Settings.Combat.Visuals.Tracer.Enabled = Toggles.CombatVisualsTracerEnabled.Value
                end)

                Options.CombatVisualsTracerColor:OnChanged(function()
                    Settings.Combat.Visuals.Tracer.Color = Options.CombatVisualsTracerColor.Value
                end)

                Sections.Combat.Visuals:AddSlider("CombatVisualsTracerThickness", {
                    Text = "Thickness",
                    Default = 2,
                    Min = 1,
                    Max = 10,
                    Rounding = 2,
                    Compact = false
                })

                Options.CombatVisualsTracerThickness:OnChanged(function()
                    Settings.Combat.Visuals.Tracer.Thickness = Options.CombatVisualsTracerThickness.Value
                end)

                Sections.Combat.Visuals:AddToggle("CombatVisualsDotEnabled", {
                    Text = "Dot",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("CombatVisualsDotColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Dot Color",
                    Transparency = nil
                })

                Toggles.CombatVisualsDotEnabled:OnChanged(function()
                    Settings.Combat.Visuals.Dot.Enabled = Toggles.CombatVisualsDotEnabled.Value
                end)

                Options.CombatVisualsDotColor:OnChanged(function()
                    Settings.Combat.Visuals.Dot.Color = Options.CombatVisualsDotColor.Value
                end)

                Sections.Combat.Visuals:AddToggle("CombatVisualsDotFilled", {
                    Text = "Dot Filled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatVisualsDotFilled:OnChanged(function()
                    Settings.Combat.Visuals.Dot.Filled = Toggles.CombatVisualsDotFilled.Value
                end)

                Sections.Combat.Visuals:AddSlider("CombatVisualsDotSize", {
                    Text = "Size",
                    Default = 6,
                    Min = 1,
                    Max = 20,
                    Rounding = 2,
                    Compact = false
                })

                Options.CombatVisualsDotSize:OnChanged(function()
                    Settings.Combat.Visuals.Dot.Size = Options.CombatVisualsDotSize.Value
                end)

                local TargetChamsToggle = Sections.Combat.Visuals:AddToggle("CombatVisualsChamsEnabled", {
                    Text = "Chams",
                    Default = false,
                    Tooltip = nil
                })

                TargetChamsToggle:AddColorPicker("CombatVisualsChamsFillColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Fill Color",
                    Transparency = 0.5
                })

                TargetChamsToggle:AddColorPicker("CombatVisualsChamsOutlineColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Outline Color",
                    Transparency = 0.5
                })

                Toggles.CombatVisualsChamsEnabled:OnChanged(function()
                    Settings.Combat.Visuals.Chams.Enabled = Toggles.CombatVisualsChamsEnabled.Value
                end)

                Options.CombatVisualsChamsFillColor:OnChanged(function()
                    Settings.Combat.Visuals.Chams.Fill.Color = Options.CombatVisualsChamsFillColor.Value
                    Settings.Combat.Visuals.Chams.Fill.Transparency = Options.CombatVisualsChamsFillColor.Transparency
                end)

                Options.CombatVisualsChamsOutlineColor:OnChanged(function()
                    Settings.Combat.Visuals.Chams.Outline.Color = Options.CombatVisualsChamsOutlineColor.Value
                    Settings.Combat.Visuals.Chams.Outline.Transparency = Options.CombatVisualsChamsOutlineColor.Transparency
                end)
            

            --// Air
            
                Sections.Combat.Air:AddToggle("CombatAirEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatAirEnabled:OnChanged(function()
                    Settings.Combat.Air.Enabled = Toggles.CombatAirEnabled.Value
                end)

                Sections.Combat.Air:AddToggle("CombatJumpOffsetEnabled", {
                    Text = "Jump Offset",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.CombatJumpOffsetEnabled:OnChanged(function()
                    Settings.Combat.Air.JumpOffset.Enabled = Toggles.CombatJumpOffsetEnabled.Value
                end)

                Sections.Combat.Air:AddSlider("CombatJumpOffSet", {
                    Text = "Offset",
                    Default = 0.09,
                    Min = -10,
                    Max = 10,
                    Rounding = 3,
                    Compact = false
                })

                Options.CombatJumpOffSet:OnChanged(function()
                    Settings.Combat.Air.JumpOffset.Offset = Options.CombatJumpOffSet.Value
                end)
    
     


                local BulletTracersToggle = Sections.Visuals.BulletTracers:AddToggle("VisualsBulletTracersEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                BulletTracersToggle:AddColorPicker("VisualsBulletTracersColor1", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Bullet Tracers Color Gradient 1",
                    Transparency = nil
                })

                BulletTracersToggle:AddColorPicker("VisualsBulletTracersColor2", {
                    Default = Color3.new(0, 0, 0),
                    Title = "Bullet Tracers Color Gradient 2",
                    Transparency = nil
                })

                Sections.Visuals.BulletTracers:AddToggle("VisualsBulletTracersFadeEnabled", {
                    Text = "Fade",
                    Default = false,
                    Tooltip = nil
                })

                Toggles.VisualsBulletTracersEnabled:OnChanged(function()
                    Settings.Visuals.BulletTracers.Enabled = Toggles.VisualsBulletTracersEnabled.Value
                end)

                Toggles.VisualsBulletTracersFadeEnabled:OnChanged(function()
                    Settings.Visuals.BulletTracers.Fade.Enabled = Toggles.VisualsBulletTracersFadeEnabled.Value
                end)

                Options.VisualsBulletTracersColor1:OnChanged(function()
                    Settings.Visuals.BulletTracers.Color.Gradient1 = Options.VisualsBulletTracersColor1.Value
                end)

                Options.VisualsBulletTracersColor2:OnChanged(function()
                    Settings.Visuals.BulletTracers.Color.Gradient2 = Options.VisualsBulletTracersColor2.Value
                end)

                Sections.Visuals.BulletTracers:AddSlider("VisualsBulletTracersDuration", {
                    Text = "Duration",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 1,
                    Compact = false
                })

                Sections.Visuals.BulletTracers:AddSlider("VisualsBulletTracersFadeDuration", {
                    Text = "Fade Duration",
                    Default = 0.5,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 1,
                    Compact = false
                })


                Options.VisualsBulletTracersDuration:OnChanged(function()
                    Settings.Visuals.BulletTracers.Duration = Options.VisualsBulletTracersDuration.Value
                end)

                Options.VisualsBulletTracersFadeDuration:OnChanged(function()
                    Settings.Visuals.BulletTracers.Fade.Duration = Options.VisualsBulletTracersFadeDuration.Value
                end)
            

      
                Sections.Visuals.BulletImpacts:AddToggle("VisualsBulletImpactsEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("VisualsBulletImpactsColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Bullet Impact Color",
                    Transparency = nil
                })

                Sections.Visuals.BulletImpacts:AddToggle("VisualsBulletImpactsFadeEnabled", {
                    Text = "Fade",
                    Default = false,
                    Tooltip = nil
                })

                Sections.Visuals.BulletImpacts:AddDropdown("VisualsBulletImpactsMaterial", {
                    Values = {"SmoothPlastic", "ForceField", "Neon"},
                    Default = 1,
                    Multi = false,

                    Text = "Material",
                    Tooltip = nil
                })

                Options.VisualsBulletImpactsMaterial:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Material = Options.VisualsBulletImpactsMaterial.Value
                end)

                Sections.Visuals.BulletImpacts:AddSlider("VisualsBulletImpactsSize", {
                    Text = "Size",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 2,
                    Compact = false
                })

                Sections.Visuals.BulletImpacts:AddSlider("VisualsBulletImpactsDuration", {
                    Text = "Duration",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 1,
                    Compact = false
                })

                Sections.Visuals.BulletImpacts:AddSlider("VisualsBulletImpactsFadeDuration", {
                    Text = "Fade Duration",
                    Default = 0.5,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 1,
                    Compact = false
                })


                Options.VisualsBulletImpactsDuration:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Duration = Options.VisualsBulletImpactsDuration.Value
                end)

                Options.VisualsBulletImpactsSize:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Size = Options.VisualsBulletImpactsSize.Value
                end)

                Options.VisualsBulletImpactsFadeDuration:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Fade.Duration = Options.VisualsBulletImpactsFadeDuration.Value
                end)

                Toggles.VisualsBulletImpactsEnabled:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Enabled = Toggles.VisualsBulletImpactsEnabled.Value
                end)

                Toggles.VisualsBulletImpactsFadeEnabled:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Fade.Enabled = Toggles.VisualsBulletImpactsFadeEnabled.Value
                end)

                Options.VisualsBulletImpactsColor:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Color = Options.VisualsBulletImpactsColor.Value
                end)
            

            --// On Hit
        
                Sections.Visuals.OnHit:AddToggle("VisualsOnHitEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil
                })

                Sections.Visuals.OnHit:AddToggle("VisualsOnHitEffectEnabled", {
                    Text = "Effect",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("VisualsOnHitEffectColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Bullet Impact Color",
                    Transparency = nil
                })

                Sections.Visuals.OnHit:AddToggle("VisualsOnHiSoundEnabled", {
                    Text = "Sound",
                    Default = false,
                    Tooltip = nil
                })

                Sections.Visuals.OnHit:AddSlider("VisualsOnHitSoundVolume", {
                    Text = "Sound Volume",
                    Default = 5,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 2,
                    Compact = false
                })

                local Sounds = {}

                for Sound, _ in pairs(Hitsounds) do
                    table.insert(Sounds, Sound)
                end

                Sections.Visuals.OnHit:AddDropdown("VisualsOnHitSound", {
                    Values = Sounds,
                    Default = 1,
                    Multi = false,
                    Text = "Sound To Play",
                    Tooltip = nil
                })


                Sections.Visuals.OnHit:AddToggle("VisualsOnHitChamsEnabled", {
                    Text = "Chams",
                    Default = false,
                    Tooltip = nil
                }):AddColorPicker("VisualsOnHitChamsColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Hit Chams Color",
                    Transparency = nil
                })

                Sections.Visuals.OnHit:AddSlider("VisualsOnHitChamsDuration", {
                    Text = "Duration",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 2,
                    Compact = false
                })

                Sections.Visuals.OnHit:AddDropdown("VisualsOnHitChamsMaterial", {
                    Values = {"ForceField", "Neon"},
                    Default = 1,
                    Multi = false,
                    Text = "Material",
                    Tooltip = nil
                })

                Options.VisualsOnHitChamsDuration:OnChanged(function()
                    Settings.Visuals.OnHit.Chams.Duration = Options.VisualsOnHitChamsDuration.Value
                end)

                Options.VisualsOnHitChamsMaterial:OnChanged(function()
                    Settings.Visuals.OnHit.Chams.Material = Options.VisualsOnHitChamsMaterial.Value
                end)

                Options.VisualsBulletImpactsMaterial:OnChanged(function()
                    Settings.Visuals.BulletImpacts.Material = Options.VisualsBulletImpactsMaterial.Value
                end)

                Toggles.VisualsOnHitEnabled:OnChanged(function()
                    Settings.Visuals.OnHit.Enabled = Toggles.VisualsOnHitEnabled.Value
                end)

                Toggles.VisualsOnHitChamsEnabled:OnChanged(function()
                    Settings.Visuals.OnHit.Chams.Enabled = Toggles.VisualsOnHitChamsEnabled.Value
                end)

                Options.VisualsOnHitChamsColor:OnChanged(function()
                    Settings.Visuals.OnHit.Chams.Color = Options.VisualsOnHitChamsColor.Value
                end)

                Toggles.VisualsOnHitEffectEnabled:OnChanged(function()
                    Settings.Visuals.OnHit.Effect.Enabled = Toggles.VisualsOnHitEffectEnabled.Value
                end)

                Options.VisualsOnHitEffectColor:OnChanged(function()
                    Settings.Visuals.OnHit.Effect.Color = Options.VisualsOnHitEffectColor.Value
                end)

                Toggles.VisualsOnHiSoundEnabled:OnChanged(function()
                    Settings.Visuals.OnHit.Sound.Enabled = Toggles.VisualsOnHiSoundEnabled.Value
                end)

                Options.VisualsOnHitSoundVolume:OnChanged(function()
                    Settings.Visuals.OnHit.Sound.Volume = Options.VisualsOnHitSoundVolume.Value
                end)

                Options.VisualsOnHitSound:OnChanged(function()
                    Settings.Visuals.OnHit.Sound.Value = Options.VisualsOnHitSound.Value
                end)
           

         
                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                })


                Toggles.VisualsAtmosphereEnabled:OnChanged(function()
                    Settings.Visuals.World.Enabled = Toggles.VisualsAtmosphereEnabled.Value
                end)

                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereFogEnabled", {
                    Text = "Fog",
                    Default = false,
                    Tooltip = nil,
                }):AddColorPicker("VisualsAtmosphereFogColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Fog Color",
                    Transparency = nil,
                })

                Toggles.VisualsAtmosphereFogEnabled:OnChanged(function()
                    Settings.Visuals.World.Fog.Enabled = Toggles.VisualsAtmosphereFogEnabled.Value
                end)

                Options.VisualsAtmosphereFogColor:OnChanged(function()
                    Settings.Visuals.World.Fog.Color = Options.VisualsAtmosphereFogColor.Value
                end)

                Sections.Visuals.Atmosphere:AddSlider("VisualsAtmosphereFogStart", {
                    Text = "Fog Start",
                    Default = 1000,
                    Min = 1,
                    Max = 10000,
                    Rounding = 0,
                    Compact = false,
                })

                Sections.Visuals.Atmosphere:AddSlider("VisualsAtmosphereFogEnd", {
                    Text = "Fog End",
                    Default = 1000,
                    Min = 1,
                    Max = 10000,
                    Rounding = 0,
                    Compact = false,
                })

                Options.VisualsAtmosphereFogStart:OnChanged(function()
                    Settings.Visuals.World.Fog.Start = Options.VisualsAtmosphereFogStart.Value
                end)

                Options.VisualsAtmosphereFogEnd:OnChanged(function()
                    Settings.Visuals.World.Fog.End = Options.VisualsAtmosphereFogEnd.Value
                end)

                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereAmbientEnabled", {
                    Text = "Ambient",
                    Default = false,
                    Tooltip = nil,
                }):AddColorPicker("VisualsAtmosphereAmbientColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Ambient Color",
                    Transparency = nil,
                })

                Toggles.VisualsAtmosphereAmbientEnabled:OnChanged(function()
                    Settings.Visuals.World.Ambient.Enabled = Toggles.VisualsAtmosphereAmbientEnabled.Value
                end)

                Options.VisualsAtmosphereAmbientColor:OnChanged(function()
                    Settings.Visuals.World.Ambient.Color = Options.VisualsAtmosphereAmbientColor.Value
                end)

                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereBrightnessChangerEnabled", {
                    Text = "Brightness Changer",
                    Default = false,
                    Tooltip = nil,
                })

                Sections.Visuals.Atmosphere:AddSlider("VisualsAtmosphereBrightnessChangerValue", {
                    Text = "Brightness Value",
                    Default = 0,
                    Min = 0,
                    Max = 10,
                    Rounding = 2,
                    Compact = false,
                })

                Toggles.VisualsAtmosphereBrightnessChangerEnabled:OnChanged(function()
                    Settings.Visuals.World.Brightness.Enabled = Toggles.VisualsAtmosphereBrightnessChangerEnabled.Value
                end)

                Options.VisualsAtmosphereBrightnessChangerValue:OnChanged(function()
                    Settings.Visuals.World.Brightness.Value = Options.VisualsAtmosphereBrightnessChangerValue.Value
                end)

                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereTimeChangerEnabled", {
                    Text = "Clock Time",
                    Default = false,
                    Tooltip = nil,
                })

                Sections.Visuals.Atmosphere:AddSlider("VisualsAtmosphereTimeChangerValue", {
                    Text = "Time",
                    Default = 1,
                    Min = 0.1,
                    Max = 24,
                    Rounding = 1,
                    Compact = false,
                })

                Toggles.VisualsAtmosphereTimeChangerEnabled:OnChanged(function()
                    Settings.Visuals.World.ClockTime.Enabled = Toggles.VisualsAtmosphereTimeChangerEnabled.Value
                end)

                Options.VisualsAtmosphereTimeChangerValue:OnChanged(function()
                    Settings.Visuals.World.ClockTime.Value = Options.VisualsAtmosphereTimeChangerValue.Value
                end)

                Sections.Visuals.Atmosphere:AddToggle("VisualsAtmosphereExposureChangerEnabled", {
                    Text = "Exposure Changer",
                    Default = false,
                    Tooltip = nil,
                })

                Sections.Visuals.Atmosphere:AddSlider("VisualsAtmosphereExposureChangerValue", {
                    Text = "Exposure",
                    Default = 1,
                    Min = -3,
                    Max = 3,
                    Rounding = 1,
                    Compact = false,
                })

                Toggles.VisualsAtmosphereExposureChangerEnabled:OnChanged(function()
                    Settings.Visuals.World.WorldExposure.Enabled = Toggles.VisualsAtmosphereExposureChangerEnabled.Value
                end)

                Options.VisualsAtmosphereExposureChangerValue:OnChanged(function()
                    Settings.Visuals.World.WorldExposure.Value = Options.VisualsAtmosphereExposureChangerValue.Value
                end)
            

            --// Crosshair
           
                Sections.Visuals.Crosshair:AddToggle("VisualsCrosshairEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddColorPicker("VisualsCrossahairColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Crosshair Color",
                    Transparency = nil,
                })

                Toggles.VisualsCrosshairEnabled:OnChanged(function()
                    Settings.Visuals.Crosshair.Enabled = Toggles.VisualsCrosshairEnabled.Value
                end)

                Options.VisualsCrossahairColor:OnChanged(function()
                    Settings.Visuals.Crosshair.Color = Options.VisualsCrossahairColor.Value
                end)

                Sections.Visuals.Crosshair:AddSlider("VisualsCrosshairSize", {
                    Text = "Size",
                    Default = 1,
                    Min = 0.1,
                    Max = 30,
                    Rounding = 3,
                    Compact = false,
                })

                Options.VisualsCrosshairSize:OnChanged(function()
                    Settings.Visuals.Crosshair.Size = Options.VisualsCrosshairSize.Value
                end)

                Sections.Visuals.Crosshair:AddSlider("VisualsCrosshairGap", {
                    Text = "Gap",
                    Default = 2,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 3,
                    Compact = false,
                })

                Options.VisualsCrosshairGap:OnChanged(function()
                    Settings.Visuals.Crosshair.Gap = Options.VisualsCrosshairGap.Value
                end)

                Sections.Visuals.Crosshair:AddToggle("VisualsCrosshairRotateEnabled", {
                    Text = "Rotate",
                    Default = false,
                    Tooltip = nil,
                })

                Sections.Visuals.Crosshair:AddSlider("VisualsCrosshairRotateAmount", {
                    Text = "Rotation Speed",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 3,
                    Compact = false,
                })

                Toggles.VisualsCrosshairRotateEnabled:OnChanged(function()
                    Settings.Visuals.Crosshair.Rotation.Enabled = Toggles.VisualsCrosshairRotateEnabled.Value
                end)

                Options.VisualsCrosshairRotateAmount:OnChanged(function()
                    Settings.Visuals.Crosshair.Rotation.Speed = Options.VisualsCrosshairRotateAmount.Value
                end)
            

       
                Sections.AntiAim.VelocitySpoofer:AddToggle("AntiAimVelocitySpooferEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.AntiAimVelocitySpooferEnabled:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Enabled = Toggles.AntiAimVelocitySpooferEnabled.Value
                end)

                Sections.AntiAim.VelocitySpoofer:AddDropdown("AntiAimVelocitySpooferType", {
                    Values = {"Underground", "Sky", "Multiplier", "Prediction Breaker", "Custom"},
                    Default = 1,
                    Multi = false,

                    Text = "Type",
                    Tooltip = nil
                })

                Options.AntiAimVelocitySpooferType:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Type = Options.AntiAimVelocitySpooferType.Value
                end)

                Sections.AntiAim.VelocitySpoofer:AddToggle("AntiAimVelocitySpooferVisualizeEnabled", {
                    Text = "Visualize",
                    Default = false,
                    Tooltip = nil,
                }):AddColorPicker("AntiAimVelocitySpooferVisualizeColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "Velocity Visualize Color",
                    Transparency = nil,
                })

                Sections.AntiAim.VelocitySpoofer:AddInput("AntiAimVelocitySpooferVisualizePrediction", {
                    Default = nil,
                    Numeric = false,
                    Finished = false,

                    Text = "Visualize Prediction",
                    Tooltip = nil,

                    Placeholder = "Visualize Prediction Amount"
                })

                Options.AntiAimVelocitySpooferVisualizePrediction:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Visualize.Prediction = tonumber(Options.AntiAimVelocitySpooferVisualizePrediction.Value)
                end)

                Toggles.AntiAimVelocitySpooferVisualizeEnabled:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Visualize.Enabled = Toggles.AntiAimVelocitySpooferVisualizeEnabled.Value
                end)

                Options.AntiAimVelocitySpooferVisualizeColor:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Visualize.Color = Options.AntiAimVelocitySpooferVisualizeColor.Value
                end)

                Sections.AntiAim.VelocitySpoofer:AddSlider("AntiAimVelocitySpooferYaw", {
                    Text = "Yaw",
                    Default = 0,
                    Min = 0,
                    Max = 100,
                    Rounding = 3,
                    Compact = false
                })

                Options.AntiAimVelocitySpooferYaw:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Yaw = Options.AntiAimVelocitySpooferYaw.Value
                end)

                Sections.AntiAim.VelocitySpoofer:AddSlider("AntiAimVelocitySpooferPitch", {
                    Text = "Pitch",
                    Default = 0,
                    Min = 0,
                    Max = 100,
                    Rounding = 3,
                    Compact = false
                })

                Options.AntiAimVelocitySpooferPitch:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Pitch = Options.AntiAimVelocitySpooferPitch.Value
                end)

                Sections.AntiAim.VelocitySpoofer:AddSlider("AntiAimVelocitySpooferRoll", {
                    Text = "Roll",
                    Default = 0,
                    Min = 0,
                    Max = 100,
                    Rounding = 3,
                    Compact = false
                })

                Options.AntiAimVelocitySpooferRoll:OnChanged(function()
                    Settings.AntiAim.VelocitySpoofer.Roll = Options.AntiAimVelocitySpooferRoll.Value
                end)
            

            --// C-Sync
            
                Sections.AntiAim.CSync:AddToggle("CSyncAntiAimEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("CSyncAntiAimKeyPicker", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "C-Sync",
                    NoUI = false,
                })

                Toggles.CSyncAntiAimEnabled:OnChanged(function()
                    Settings.AntiAim.CSync.Enabled = Toggles.CSyncAntiAimEnabled.Value
                end)

                Sections.AntiAim.CSync:AddToggle("CSyncAntiAimVisualizeEnabled", {
                    Text = "Visualize",
                    Default = false,
                    Tooltip = nil,
                }):AddColorPicker("CSyncAntiAimVisualizeColor", {
                    Default = Color3.new(1, 1, 1),
                    Title = "CFrame Visualize Color",
                    Transparency = nil,
                })

                Sections.AntiAim.CSync:AddDropdown("CSyncAntiAimType", {
                    Values = {"Custom", "Random", "Random Target", "Target Strafe", "Local Strafe"},
                    Default = 1,
                    Multi = false,
                    Text = "Type",
                    Tooltip = nil,
                })

                Toggles.CSyncAntiAimVisualizeEnabled:OnChanged(function()
                    Settings.AntiAim.CSync.Visualize.Enabled = Toggles.CSyncAntiAimVisualizeEnabled.Value
                end)

                Options.CSyncAntiAimVisualizeColor:OnChanged(function()
                    Settings.AntiAim.CSync.Visualize.Color = Options.CSyncAntiAimVisualizeColor.Value
                end)

                Options.CSyncAntiAimType:OnChanged(function()
                    Settings.AntiAim.CSync.Type = Options.CSyncAntiAimType.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimRandomRange", {
                    Text = "Random Range",
                    Default = 0.1,
                    Min = 0,
                    Max = 20,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimRandomRange:OnChanged(function()
                    Settings.AntiAim.CSync.RandomDistance = Options.CSyncAntiAimRandomRange.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimCustomX", {
                    Text = "Custom X",
                    Default = 0.1,
                    Min = 0,
                    Max = 500,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimCustomX:OnChanged(function()
                    Settings.AntiAim.CSync.Custom.X = Options.CSyncAntiAimCustomX.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimCustomY", {
                    Text = "Custom Y",
                    Default = 0.1,
                    Min = 0,
                    Max = 500,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimCustomY:OnChanged(function()
                    Settings.AntiAim.CSync.Custom.Y = Options.CSyncAntiAimCustomY.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimCustomZ", {
                    Text = "Custom Z",
                    Default = 0.1,
                    Min = 0,
                    Max = 500,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimCustomZ:OnChanged(function()
                    Settings.AntiAim.CSync.Custom.Z = Options.CSyncAntiAimCustomZ.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimTargetStrafeSpeed", {
                    Text = "Target Strafe Speed",
                    Default = 1,
                    Min = 0,
                    Max = 20,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimTargetStrafeSpeed:OnChanged(function()
                    Settings.AntiAim.CSync.TargetStrafe.Speed = Options.CSyncAntiAimTargetStrafeSpeed.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimTargetStrafeDistance", {
                    Text = "Target Strafe Distance",
                    Default = 1,
                    Min = 0,
                    Max = 20,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimTargetStrafeDistance:OnChanged(function()
                    Settings.AntiAim.CSync.TargetStrafe.Distance = Options.CSyncAntiAimTargetStrafeDistance.Value
                end)

                Sections.AntiAim.CSync:AddSlider("CSyncAntiAimTargetStrafeHeight", {
                    Text = "Target Strafe Height",
                    Default = 1,
                    Min = 0,
                    Max = 20,
                    Rounding = 1,
                    Compact = false,
                })

                Options.CSyncAntiAimTargetStrafeHeight:OnChanged(function()
                    Settings.AntiAim.CSync.TargetStrafe.Height = Options.CSyncAntiAimTargetStrafeHeight.Value
                end)
            

            --// Fake Lag
            
                Sections.AntiAim.Network:AddToggle("AntiAimNetworkEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("AntiAimNetworkKeyPicker", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "Network",
                    NoUI = false,
                })

                Toggles.AntiAimNetworkEnabled:OnChanged(function()
                    Settings.AntiAim.Network.Enabled = Toggles.AntiAimNetworkEnabled.Value
                end)

                Sections.AntiAim.Network:AddToggle("AntiAimNetworkWalkingCheck", {
                    Text = "Walking Check",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.AntiAimNetworkWalkingCheck:OnChanged(function()
                    Settings.AntiAim.Network.WalkingCheck = Toggles.AntiAimNetworkWalkingCheck.Value
                end)

                Sections.AntiAim.Network:AddSlider("AntiAimNetworkAmount", {
                    Text = "Amount",
                    Default = 0.1,
                    Min = 0,
                    Max = 30,
                    Rounding = 3,
                    Compact = false,
                })

                Options.AntiAimNetworkAmount:OnChanged(function()
                    Settings.AntiAim.Network.Amount = Options.AntiAimNetworkAmount.Value
                end)
            

            --// Velocity Desync
           
                Sections.AntiAim.VelocityDesync:AddToggle("AntiAimVelocityDesyncEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("AntiAimVelocityDesyncKeyPicker", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "Velocity Desync",
                    NoUI = false,
                })

                Toggles.AntiAimVelocityDesyncEnabled:OnChanged(function()
                    Settings.AntiAim.VelocityDesync.Enabled = Toggles.AntiAimVelocityDesyncEnabled.Value
                end)

                Sections.AntiAim.VelocityDesync:AddSlider("AntiAimVelocityDesyncRange", {
                    Text = "Range",
                    Default = 1,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 3,
                    Compact = false,
                })

                Options.AntiAimVelocityDesyncRange:OnChanged(function()
                    Settings.AntiAim.VelocityDesync.Range = Options.AntiAimVelocityDesyncRange.Value
                end)
            

       
                Sections.AntiAim.FFlag:AddToggle("AntiAimFFlagDesyncEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("AntiAimFFlagDesyncKeyPicker", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "FFlag Desync",
                    NoUI = false,
                })

                Toggles.AntiAimFFlagDesyncEnabled:OnChanged(function()
                    Settings.AntiAim.FFlagDesync.Enabled = Toggles.AntiAimFFlagDesyncEnabled.Value

                    if not Settings.AntiAim.FFlagDesync.Enabled then
                        for FFlag, Value in pairs(Script.Locals.FFlags) do
                            setfflag(FFlag, Value)
                        end
                    end
                end)

                Sections.AntiAim.FFlag:AddToggle("AntiAimFFlagDesyncSetNew", {
                    Text = "Set New",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.AntiAimFFlagDesyncSetNew:OnChanged(function()
                    Settings.AntiAim.FFlagDesync.SetNew = Toggles.AntiAimFFlagDesyncSetNew.Value
                end)

                Sections.AntiAim.FFlag:AddDropdown("AntiAimFFlagDesyncFFlags", {
                    Values = {"S2PhysicsSenderRate", "PhysicsSenderMaxBandwidthBps", "DataSenderMaxJoinBandwidthBps"},
                    Default = {"S2PhysicsSenderRate"},
                    Multi = true,
                    Text = "FFlags",
                    Tooltip = nil,
                })

                Options.AntiAimFFlagDesyncFFlags:OnChanged(function()
                    Settings.AntiAim.FFlagDesync.FFlags = Options.AntiAimFFlagDesyncFFlags.Value
                end)

                Sections.AntiAim.FFlag:AddSlider("AntiAimFFlagDesyncAmount", {
                    Text = "Amount",
                    Default = 2,
                    Min = 0.1,
                    Max = 10,
                    Rounding = 3,
                    Compact = false,
                })

                Options.AntiAimFFlagDesyncAmount:OnChanged(function()
                    Settings.AntiAim.FFlagDesync.Amount = Options.AntiAimFFlagDesyncAmount.Value
                end)

                Sections.AntiAim.FFlag:AddSlider("AntiAimFFlagDesyncSetnewAmount", {
                    Text = "Set New Amount",
                    Default = 15,
                    Min = 0.1,
                    Max = 20,
                    Rounding = 3,
                    Compact = false,
                })

                Options.AntiAimFFlagDesyncSetnewAmount:OnChanged(function()
                    Settings.AntiAim.FFlagDesync.SetNewAmount = Options.AntiAimFFlagDesyncSetnewAmount.Value
                end)
            

            --// Invisible Desync
           
                Sections.AntiAim.InvisibleDesync:AddToggle("AntiAimInvisibleDesync", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("AntiAimInvisibleDesyncKeyPicker", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "Invisible Desync",
                    NoUI = false,
                })

                Toggles.AntiAimInvisibleDesync:OnChanged(function()
                    Settings.AntiAim.InvisibleDesync.Enabled = Toggles.AntiAimInvisibleDesync.Value
end)

     
                Sections.Misc.Speed:AddToggle("MiscCFrameSpeedEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                }):AddKeyPicker("MiscCFrameSpeedKeybind", {
                    Default = "b",
                    SyncToggleState = true,
                    Mode = "Toggle",

                    Text = "Speed",
                    NoUI = false,
                })

                Toggles.MiscCFrameSpeedEnabled:OnChanged(function()
                    Settings.Misc.Movement.Speed.Enabled = Toggles.MiscCFrameSpeedEnabled.Value
                end)

                Sections.Misc.Speed:AddSlider("MiscCFrameSpeedAmount", {
                    Text = "Amount",
                    Default = 0.1,
                    Min = 0,
                    Max = 10,
                    Rounding = 3,
                    Compact = false,
                })

                Options.MiscCFrameSpeedAmount:OnChanged(function()
                    Settings.Misc.Movement.Speed.Amount = Options.MiscCFrameSpeedAmount.Value
                end)
            

            --// Exploits
            
                Sections.Misc.Exploits:AddToggle("MiscExploitsEnabled", {
                    Text = "Enabled",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.MiscExploitsEnabled:OnChanged(function()
                    Settings.Misc.Exploits.Enabled = Toggles.MiscExploitsEnabled.Value
                end)

                Sections.Misc.Exploits:AddToggle("MiscExploitsNoRecoil", {
                    Text = "No Recoil",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.MiscExploitsNoRecoil:OnChanged(function()
                    Settings.Misc.Exploits.NoRecoil = Toggles.MiscExploitsNoRecoil.Value
                end)

                Sections.Misc.Exploits:AddToggle("MiscExploitsNoJumpCooldown", {
                    Text = "No Jumpcooldown",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.MiscExploitsNoJumpCooldown:OnChanged(function()
                    Settings.Misc.Exploits.NoJumpCooldown = Toggles.MiscExploitsNoJumpCooldown.Value
                end)

                Sections.Misc.Exploits:AddToggle("MiscExploitsNoSlowdown", {
                    Text = "No Slowdown",
                    Default = false,
                    Tooltip = nil,
                })

                Toggles.MiscExploitsNoSlowdown:OnChanged(function()
                    Settings.Misc.Exploits.NoSlowDown = Toggles.MiscExploitsNoSlowdown.Value
                end)
         

        --// Settings Tab
       
            local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu")

            Library.KeybindFrame.Visible = true

            MenuGroup:AddToggle("KeybindsListEnabled", {
                Text = "Keybinds List",
                Default = true,
                Tooltip = nil,
            })

            Toggles.KeybindsListEnabled:OnChanged(function()
                Library.KeybindFrame.Visible = Toggles.KeybindsListEnabled.Value
            end)

            MenuGroup:AddButton("Unload", function() Library:Unload() end)
            MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "End", NoUI = true, Text = "Menu keybind" })
            Library.ToggleKeybind = Options.MenuKeybind

            ThemeManager:SetLibrary(Library)
            SaveManager:SetLibrary(Library)

            ThemeManager:SetFolder("Azure")
            SaveManager:SetFolder("Azure/Hood")

            SaveManager:BuildConfigSection(Tabs.Settings)
            ThemeManager:ApplyToTab(Tabs.Settings)
        
    

-- External unverified Pastebin payload disabled; rest of original code preserved.
--load()

]============]
local azureSec=section('Azure','Original Azure V4','left')
note(azureSec,'Runs the original Azure source: Combat, Visuals, Anti Aim, Misc, Settings and its own GUI. Kept separate from UNLEGIT controls.',85)
local azureStatus=note(azureSec,'Not launched',95)
local azureRunning=false
button(azureSec,'Launch original Azure V4',function()
 if azureRunning then azureStatus.Text='Already attempted; rejoin before retrying.';return end
 azureRunning=true
 azureStatus.Text='Compiling original Azure source...'
 task.spawn(function()
  local fn,err=loadstring(AZURE_ORIGINAL,'AzureV4_Original')
  if not fn then azureStatus.Text='Azure compile error: '..tostring(err):sub(1,450);warn('[Azure] '..tostring(err));azureRunning=false;return end
  azureStatus.Text='Starting original Azure systems...'
  local ok,result=xpcall(fn,function(e)return debug and debug.traceback and debug.traceback(tostring(e),2) or tostring(e)end)
  if not ok then
   azureStatus.Text='Azure startup error: '..tostring(result):sub(1,550)
   warn('[Azure startup] '..tostring(result))
   azureRunning=false
  else
   azureStatus.Text='Azure source returned. Original GUI may be open (Azure menu key: End).'
  end
 end)
end)
local helpSec=section('Azure','Compatibility','right')
note(helpSec,'Azure uses separate executor hooks and remote GUI libraries. This build preserves its source but cannot guarantee it loads or that each feature works. Its settings remain in the original Azure menu.',125)
button(helpSec,'Copy latest Azure error',function()
 if type(setclipboard)=='function' then setclipboard(azureStatus.Text);U.state='Azure status copied' else U.state=azureStatus.Text end
end)
local OSIRI_ORIGINAL=[================[
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
    RegularModeVisualizer = true, -- This will the place where silent aim will hit.

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
    Visible = true,
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



getgenv().HitParts = "HumanoidRootPart"

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
			if not getgenv().UniversalSettings.FFAMode then
				local eq = Player1.Team == Player2.Team
				return eq
			else
				return getgenv().UniversalSettings.FFAMode
			end
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
				if Head and Head:IsA("RootPart") then
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
							return Vector3.new(Hit.X + (Velocity.X * getgenv().Silent.Prediction), getgenv().SafetyMeasures.NoFloorShots and Hit.Y or Hit.Y + (Velocity.Y * getgenv().Silent.Prediction), Hit.Z + (Velocity.Z * getgenv().Silent.Prediction)), Target
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
					return Vector3.new(Hit.X + (Velocity.X * getgenv().Camlock.Prediction), true and Hit.Y or Hit.Y + (Velocity.Y * getgenv().Camlock.Prediction), Hit.Z + (Velocity.Z * getgenv().Camlock.Prediction)), Target, HitPart2
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
			if (TeamCheck and not Osiris:CheckTeam(Client, Player)) then
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
			local Cameras = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule):GetCameras()
			local Controller = Cameras.activeCameraController
            --
			Utility:Connection(UserInputService.InputBegan, function(Input, Processed)
				if not Processed then
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
						local split = Split(pingvalue, '(')
						local ping = tonumber(split[1])
						if ping < 130 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping130_140
						elseif ping < 120 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping120_130
						elseif ping < 110 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping110_120
						elseif ping < 100 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping100_110
						elseif ping < 90 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping90_100
						elseif ping < 80 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping80_90
						elseif ping < 70 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping70_80
						elseif ping < 60 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping60_70
						elseif ping < 50 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping50_60
						elseif ping < 40 then
							getgenv().Silent.Prediction = getgenv().PredefinedPredictions.Ping40_50
						elseif ping < 30 then
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
						if getgenv().HitChance.AutoReload then
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


local vim = game:GetService("VirtualInputManager")
setfpscap(5000)

game.DescendantAdded:Connect(function(d)
  if d.Name == "MainView" and d.Parent.Name == "DevConsoleUI" and getgenv().Misc.FPSBoost then
      task.wait()
      local screen = d.Parent.Parent.Parent
      screen.Enabled = false;
  end
end)

vim:SendKeyEvent(true, "F9", 0, game)    
wait()
vim:SendKeyEvent(false, "F9", 0, game)  

while true do
  task.wait()
  if not getgenv().Misc.FPSBoost then
      continue;
  end
 

  warn("")
 
  if not game:GetService("CoreGui"):FindFirstChild("DevConsoleUI", true):FindFirstChild("MainView") then
       vim:SendKeyEvent(true, "F9", 0, game)    
        wait()
        vim:SendKeyEvent(false, "F9", 0, game)  
        continue
    end
end
]================]
local osiriSec=section('Osiri','Original Osiri remake','left')
note(osiriSec,'Original uploaded source included in this file. Runs separately from UNLEGIT and Azure. It may still need original external resources or game-specific compatibility.',105)
local osiriStatus=note(osiriSec,'Not launched',110)
local osiriBusy=false
button(osiriSec,'Launch original Osiri',function()
 if osiriBusy then osiriStatus.Text='Already started or starting. Rejoin before attempting another launch.';return end
 osiriBusy=true
 osiriStatus.Text='Compiling original Osiri...'
 task.spawn(function()
  local fn,err=loadstring(OSIRI_ORIGINAL,'Osiri_Original')
  if not fn then osiriStatus.Text='Compile error: '..tostring(err):sub(1,500);warn('[Osiri] '..tostring(err));osiriBusy=false;return end
  osiriStatus.Text='Starting original Osiri systems...'
  local ok,result=xpcall(fn,function(e)return debug and debug.traceback and debug.traceback(tostring(e),2) or tostring(e)end)
  if not ok then
   osiriStatus.Text='Startup error: '..tostring(result):sub(1,600)
   warn('[Osiri startup] '..tostring(result))
   osiriBusy=false
  else
   osiriStatus.Text='Original Osiri source returned; check its own GUI.'
  end
 end)
end)
local osiriHelp=section('Osiri','Compatibility','right')
note(osiriHelp,'The uploaded Osiri remake warns some features are fake or buggy. It relies on exploit-specific hooks and may not contain a functional GUI. Keep original scripts separate; avoid launching multiple systems simultaneously.',150)
button(osiriHelp,'Copy Osiri status',function()
 if type(setclipboard)=='function' then setclipboard(osiriStatus.Text);U.state='Osiri status copied' else U.state=osiriStatus.Text end
end)
local LYNX_ORIGINAL=[================[
local ui = {}
-- 
local uis = game:GetService('UserInputService')
local txtservice = game:GetService('TextService')
local ts = game:GetService('TweenService')
-- 
local repo = "https://raw.githubusercontent.com/f1nobe7650/Lynx/main/"
-- Getting the functions n stuff
local Color = loadstring(game:HttpGet(repo .."Color.lua"))();
local Math = loadstring(game:HttpGet(repo .."Math.lua"))();
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ESPs/main/3D%20Drawing%20Api.lua"))();
local WatermarkLUA = loadstring(game:HttpGet("https://pastebin.com/raw/FhFwETdS"))();
--
local InputService, TeleportService, RunService, Workspace, Lighting, Players, HttpService, StarterGui, ReplicatedStorage, TweenService, VirtualUser, PathFindingService = game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("RunService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("Players"), game:GetService("HttpService"), game:GetService("StarterGui"), game:GetService("ReplicatedStorage"), game:GetService("TweenService"), game:GetService("VirtualUser"), game:GetService("PathfindingService")
local Mouse, Camera, LocalPlayer = Players.LocalPlayer:GetMouse(), Workspace.Camera, Players.LocalPlayer
local NewVector2, NewVector3, NewCFrame, NewAngle, NewRGB, NewHex, NewInstance, Spawn, Wait, Create, Resume, SpinAngle, SpinSize, SpinSpeed, Huge, Pi, Clamp, Round, Abs, Floor, Random, Sin, Cos, Rad, Halfpi, Find, Clear, Sub, Upper, Lower, Insert = Vector2.new, Vector3.new, CFrame.new, CFrame.Angles, Color3.fromRGB, Color3.fromHex, Instance.new, task.spawn, task.wait, coroutine.create, coroutine.resume, 0, 25, 0, math.huge, math.pi, math.clamp, math.round, math.abs, math.floor, math.random, math.sin, math.cos, math.rad, math.pi/2, table.find, table.clear, string.sub, string.upper, string.lower, table.insert
local Wanted, ShopPath, bodyParts, viewportSize = LocalPlayer:WaitForChild("DataFolder").Information.Wanted, workspace.Ignored.Shop, {}, Camera.ViewportSize
local OldWanted = Wanted.Value
--
for i,v in pairs(LocalPlayer.Character:GetChildren()) do 
    if v:IsA("BasePart") then 
        table.insert(bodyParts,v.Name)
    end 
end 
-- 
local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", Lighting); ColorCorrectionEffect.Enabled = false; ColorCorrectionEffect.Brightness = 0; ColorCorrectionEffect.Contrast = 0; ColorCorrectionEffect.Saturation = 0; ColorCorrectionEffect.TintColor = Color3.fromRGB(255,255,255)
-- 
setfpscap(999)
--
getgenv().Lynx, getgenv().Visuals, getgenv().utility = 
{
	["Connections"] = {},
	["Account"] = {
		Username = (lgVarsTbl and lgVarsTbl["DiscordUsername"] or "User"),
		UserID = LocalPlayer.UserId,
		Game = "Da Hood"
	},
	["Locals"] = { 
		Window = {},
	},
	["Silent"] = {
		Target = nil,
		Check = true,
		Prediction = 0, 
		Resolver = {false, nil}, 
		Offset = 0, 
		Check = true, 
		Hitpart = nil, 
		Position = nil,
	},
	["Assist"] = {
		Target = nil,
		Prediction = 0, 
		Resolver = false, 
	},
	["Files"] = {
		Folders = {"Lynx", "Lynx/Configs", "Lynx/Luas", "Lynx/Assets"},
		Luas = {
			["ChinaHat"] = game:HttpGet("https://raw.githubusercontent.com/f1nobe7650/Lynx/main/LUAs/ChinaHat"),
			["Minecraft"] = game:HttpGet("https://raw.githubusercontent.com/f1nobe7650/Lynx/main/LUAs/Minecraft"),
			["BetterGame"] = game:HttpGet("https://raw.githubusercontent.com/f1nobe7650/Lynx/main/LUAs/BetterGame")
		}, 
	}
}, 
{
	["Drawings"] = {},
	["Bases"] = {},
	["Base"] = {},
	["Settings"] = {
		["Line"] = {
		    Thickness = 1,
		    Color = Color3.fromRGB(0, 255, 0)
	    },
		["Text"] = {
			Size = 13,
			Center = true,
			Outline = true,
			Font = Drawing.Fonts.Plex,
			Color = Color3.fromRGB(255, 255, 255)
		},
		["Square"] = {
			Thickness = 1,
			Color = Color3.fromRGB(255, 255, 255),
			Filled = false,
		},
		["Triangle"] = {
			Color = Color3.fromRGB(255, 255, 255),
			Filled = true,
			Visible = false,
			Thickness = 1,
		},
		["Image"] = {
			Transparency = 1,
			Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
		}
	},
	["KeyBindList"] = {}
}, 
{
	["Cursor"] = {Lines = {}, Outlines = {}, Dots = {}}, 
	["Renders"] = {}, 
	["Parts"] = {},
	["Desyncs"] = {
		["None"] = NewVector3(0, 0, 0),
		["HvH"] = NewVector3(0, -16384, 0),
		["AntiBot"] = NewVector3(0, 100, 0),
		["Horizontal"] = NewVector3(-16384, 0, 0),
		["Sky"] = NewVector3(0, 16384, 0),
		["Ground"] = NewVector3(0, -100, 0),
		["Desync"] = NewVector3(-16384, -16384, -16384)
	},
    ["Ignore"] = {}, 
	["LastTick"] = tick(), 
	["ShitTalk"] = {
		["Lynx"] = {
			"WHAT THE HELL IS AN AZURE 🤡🤡",
			"LYNX ONTOP LYNX ONTOP LYNX ONTOP",
			"IS THAT LYNX???!! | .gg/lynx",
			"Here is a wild lynx user in its habitat | .gg/lynx",
			"LYNX >> ALL",
			"LYNX ON TOP | .gg/lynx",
			"LYNX > U",
			".gg/lynx"
		},
		["AntiAim"] = {
			"CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! CANT HIT ME?! ",
			"Hmmm why arent u hitting me? Lynx too good XDDD",
			"RESOLVER SUCCESSFULLY HIT 0 SHOTS",
			"I think 0 prediction can hit more shots :(",
			"Uphillian Aim???!!!!",
			"Cmon man resolve my beanbot desync :^)",
			"SKID DETECTED NOT RESOLVING!",
			"Azure hits better cmon bro up the game :rofl:"
		},
	},
	["TracerTextures"] = {
        ["1"] = 7136858729,
        ["2"] = 6333823534,
        ["3"] = 5864341017,
		["4"] = 9150663556,
        ["5"] = 446111271,
        ["6"] = 2950987173,
        ["7"] = 7151778302,  
        ["8"] = 11226108137,
        ["9"] = 6511613786,
    },
	["sfx"] = {
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
    },
	["SkyBoxes"] = {
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
    },
	["LightingBackUp"] = {
		["Ambient"] = Lighting.Ambient,
		["OutdoorAmbient"] = Lighting.OutdoorAmbient,
		["ColorShift_Top"] = Lighting.ColorShift_Top,
		["FogColor"] = Lighting.FogColor,
		["FogEnd"] = Lighting.FogEnd,
		["FogStart"] = Lighting.FogStart,
		["ClockTime"] = Lighting.ClockTime,
		["Brightness"] = Lighting.Brightness
	},
	["Angle"] = 0,
	--[[["Maps"] = {
		["MM2 MAP"] = {game:GetObjects("rbxassetid://6961429165")[1], NewCFrame(-2279.90967, 5337.09326, -5520.67969, -4.37113883e-08, 0, -1, -1, -4.37113883e-08, 4.37113883e-08, -4.37113883e-08, 1, 1.91068547e-15), NewVector3(-8000,5000,-5504)},
		["Parkour"] = {game:GetObjects("rbxassetid://5172031164")[1], NewCFrame(-12906.4688, 13095.1973, -11499.5381, 0.318712622, 1.4782394e-08, 0.947851419, -4.15312478e-08, 1, -1.63091063e-09, -0.947851419, -3.88456591e-08, 0.318712622), NewVector3(-12922,13090,-11418)},
		["Office"] = {game:GetObjects("rbxassetid://6882056127")[1], NewCFrame(-10773.5635, 6006.16406, -14860.6035, 1, 8.80185169e-08, -1.60622491e-07, -8.80185098e-08, 1, 6.82912145e-08, 1.60622491e-07, -6.82912003e-08, 1), NewVector3(-17608,5510,-10917)},
		["Anarchy"] = {game:GetObjects("rbxassetid://2782284003")[1], NewCFrame(-5820.18994, 5510.59863, -8075.72021, -0.286452234, -7.80991627e-08, 0.958094537, 5.32952846e-08, 1, 9.74493801e-08, -0.958094537, 7.89765124e-08, -0.286452234), NewVector3(-8190,5431,-9629)},
	},]]
	["Characters"] = {
		AmongUs = {Vector3.new(0.15,0.15,0.15), "6686375937", "6686375902"}, 
		SpongeBob = {Vector3.new(5,5,5), "5408463358", "5408463211"},
		Patrick = {Vector3.new(0.4,0.4,0.4), "5730253510", "5730253467"}, 
		Maxell = {Vector3.new(0.2,0.2,0.2), "12303996609", "12303996327"},
		Brian = {Vector3.new(1.7,1.7,1.7), "512454212", "512454192"},
		CapyBara = {Vector3.new(2,2,2), "11255227067", "11255226712"},
		Chicken = {Vector3.new(3, 3, 3), "2114220248", "2114220154"},
		Sonic = {Vector3.new(0.15,0.15,0.15), "6901422268", "6901422170"},
	}
}
-- 
local Stomps = {}
do 
	function Stomps:Explode(VictimChar)
        spawn(function()
            local Explosion = game:GetObjects("rbxassetid://12843483581")[1]
            Explosion.Position = VictimChar.UpperTorso.Position
            for i,v in pairs(Explosion:GetChildren()) do
                if v:IsA('Part') then
                    local RandomOffsets = {
                        [3] = {
                            [1] = CFrame.new(0, 0, 0, 0.291951358, -0.454637647, 0.841468394, 0.837198734, -0.303921342, -0.454675913, 0.462452948, 0.837219477, 0.291891754),
                            [2] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            [3] = CFrame.new(0, 0, 0, 0.980090559, 0.139680177, 0.141109571, -0.159390777, 0.977284014, 0.139680177, -0.118393585, -0.159390777, 0.980090559),
                            [4] = CFrame.new(0, 0, 0, 0.173127294, 0.378437281, 0.909292102, -0.722461104, -0.578677535, 0.378394246, 0.669385433, -0.722438574, 0.17322135),
                            [5] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
                        },
                        [4] = {
                            [1] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                            [2] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
                            [3] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
                            [4] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
                            [5] = CFrame.new(0, 0, 0, 0.427273333, -0.494724542, -0.756759584, 0.120325297, 0.860679626, -0.494724542, 0.896079957, 0.120325297, 0.427273333)
                        },
                        [5] = {
                            [1] = CFrame.new(0, 0, 0, 0.291951358, 0.454619884, -0.841477931, -0.0720763057, 0.887764454, 0.454619884, 0.953713477, -0.0720763057, 0.291951358),
                            [2] = CFrame.new(0, 0, 0, 0.17322135, -0.378349423, -0.909310758, 0.0343255848, 0.925026178, -0.378349423, 0.98428458, 0.0343255848, 0.17322135),
                            [3] = CFrame.new(0, 0, 0, 0.980090559, -0.13969931, -0.141090572, 0.11998871, 0.982897162, -0.13969931, 0.158193409, 0.11998871, 0.980090559),
                            [4] = CFrame.new(0, 0, 0, 0.427273333, 0.494663626, 0.756799459, -0.869062901, -0.00613296032, 0.494663626, 0.249333531, -0.869062901, 0.427273333)
                        }
                    }
                    v.CFrame = Explosion.CFrame * RandomOffsets[i][math.random(1, #RandomOffsets[i])]
                end
            end
            Explosion.Parent = workspace.Ignored
            Explosion.Explosion:Play()
            spawn(function()
                local Tween1 = TweenService:Create(Explosion.Mesh, TweenInfo.new(5, Enum.EasingStyle.Circular), {Scale = Vector3.new(27.5, 27.5, 27.5)})
                Tween1:Play()
                for i,v in pairs(Explosion:GetChildren()) do
                    if v:FindFirstChild('Mesh') then
                        spawn(function()
                            local Tween1 = TweenService:Create(v.Mesh, TweenInfo.new(0.1125, Enum.EasingStyle.Circular), {Scale = Vector3.new(12.5, 12.5, 12.5)})
                            local Tween2 = TweenService:Create(v.Mesh, TweenInfo.new(1.5875, Enum.EasingStyle.Circular), {Scale = Vector3.new(13.75, 13.75, 13.75)})
                            local Tween3 = TweenService:Create(v, TweenInfo.new(0.165), {Transparency = 0.35})
                            local Tween4 = TweenService:Create(v, TweenInfo.new(0.9), {Transparency = 1})
                            Tween1:Play()
                            Tween3:Play()
                            Tween1.Completed:Connect(function()
                                Tween2:Play()
                            end)
                            delay(1.425, function()
                                Tween4:Play()
                            end)
                        end)
                    end
                end
                local Tween2 = TweenService:Create(Explosion, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Transparency = 1})
                wait(0.8)
                Tween2:Play()
            end)
            game:GetService('Debris'):AddItem(Explosion, 5)
        end)
    end

    function Stomps:AirStrike(VictimChar)
        spawn(function()
            local Radio = Instance.new("Sound", VictimChar.UpperTorso)
            Radio.SoundId = "http://www.roblox.com/asset/?id=88858815"
            Radio.PlaybackSpeed = 1.5
            Radio.Volume = 1
            Radio:Play()
            local Jet = game:GetObjects("rbxassetid://12868291219")[1]
            Jet.Parent = workspace.Ignored
            Jet.Position = VictimChar.UpperTorso.CFrame.Position + Vector3.new(0, 200, -2000)
            Jet.Sound:Play()
            local function AddExplosion()
                local ExplosionSound = Instance.new("Sound", VictimChar.UpperTorso)
                ExplosionSound.SoundId = "rbxassetid://3802269741"
                local Explosion = Instance.new("Explosion", Jet)
                Explosion.DestroyJointRadiusPercent = 0
                Explosion.BlastPressure = 10000
                Explosion.Position = VictimChar.UpperTorso.Position + Vector3.new(math.random(0,50) * 0.1, 0, math.random(0,50) * 0.1)
                ExplosionSound:Play()
            end
            task.spawn(function()
                task.wait(2.78333333333)
                for i = 1,4 do
                    AddExplosion()
                    wait(math.random(0, 100) * 0.001)
                end
            end)
            local Tween = TweenService:Create(Jet, TweenInfo.new(5.566666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Position = Jet.go.WorldPosition
            })
            Tween:Play()
            Tween.Completed:Wait()
            Jet:Destroy()
        end)
    end

    function Stomps:Heart(VictimChar)
        spawn(function()
            local Table = {}
            local Heart = game:GetObjects("rbxassetid://12868779018")[1]
            Heart.Parent = workspace.Ignored
            Heart.PartOne.Position = VictimChar.UpperTorso.Position + Vector3.new(0,7,0)
            Heart.PartOne.Anchored = true
            Heart.Part.Position = VictimChar.UpperTorso.Position
            Heart.Part.Anchored = true
            for i,v in pairs(Heart.PartOne:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    table.insert(Table, v)
                end
            end
            for i, v in pairs(Heart.Part:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    table.insert(Table, v);
                end;
            end;
            for i, v in pairs(Table) do
                if v:GetAttribute("EmitDelay") then
                    task.delay(v:GetAttribute("EmitDelay"), function()
                        v:Emit(v:GetAttribute("EmitCount"));
                    end);
                else
                    v:Emit(v:GetAttribute("EmitCount"));
                end;
            end;
            local Sound = Instance.new("Sound", Heart.PartOne)
            Sound.Volume = 1
            Sound.SoundId = "rbxassetid://1840977366"
            Sound.PlayOnRemove = true
            Sound:Destroy()
            task.wait(0.35)
            for i,v in pairs(VictimChar:GetDescendants()) do
                if v:IsA("BasePart") then
                    TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                        Transparency = 1
                    }):Play()
                end
            end
            game.Debris:AddItem(Heart, 10)
        end)
    end

    function Stomps:UFO(VictimChar)
        spawn(function()
            local UFO = game:GetObjects("rbxassetid://12876678129")[1]
            UFO.Parent = workspace.Ignored

            local Sound = Instance.new("Sound", VictimChar.UpperTorso)
            Sound.SoundId = "rbxassetid://138207483"
            Sound:Play()
            game.Debris:AddItem(Sound, 5)
            local Effect = UFO.Effect
            Effect.CFrame = CFrame.new(VictimChar.UpperTorso.Position.X, VictimChar.UpperTorso.Position.Y + 35, VictimChar.UpperTorso.Position.Z)
            TweenService:Create(Effect, TweenInfo.new(0.5), {
                Transparency = 0
            }):Play()
            game.Debris:AddItem(Effect, 5)
            task.wait(0.5)
            local Main = UFO.Main
            Main.CFrame = CFrame.new(VictimChar.UpperTorso.Position.X, VictimChar.UpperTorso.Position.Y - 1, VictimChar.UpperTorso.Position.Z)
            game.Debris:AddItem(Main, 4)
            TweenService:Create(Main, TweenInfo.new(4), {
                CFrame = CFrame.new(Main.Position.X, Main.Position.Y + 20, Main.Position.Z)
            }):Play()
            TweenService:Create(Effect, TweenInfo.new(4), {
                CFrame = CFrame.new(Effect.Position.X, Effect.Position.Y + 20, Effect.Position.Z)
            }):Play()
            for i,v in pairs(VictimChar:GetDescendants()) do
                if not (not v:IsA("BasePart")) or not (not v:IsA("MEshPart")) or v:IsA("Decal") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Transparency = 1
                    }):Play()
                end
            end
            task.delay(4, function()
                TweenService:Create(Effect, TweenInfo.new(4), {
                    Transparency = 1
                }):Play()
            end)
        end)
    end

    function Stomps:Glitch(VictimChar)
        spawn(function()
            local Glitch = game:GetObjects("rbxassetid://12886574483")[1]
            Glitch.Parent = workspace.Ignored
            Glitch.CFrame = VictimChar.UpperTorso.CFrame + Vector3.new(0, -0.5, 0)
            Glitch.Orientation = VictimChar.UpperTorso.Orientation
            for i,v in pairs(VictimChar:GetDescendants()) do
                if not (not v:IsA("BasePart")) or not (not v:IsA("MEshPart")) or v:IsA("Decal") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Transparency = 1
                    }):Play()
                end
            end	
            game.Debris:AddItem(Glitch, 4.5)
            for i,v in pairs(Glitch:GetChildren()) do
                if v:IsA("ParticleEmitter") then
                    TweenService:Create(v, TweenInfo.new(4), {
                        Rate = 0
                    }):Play()
                end
            end
            local Sound = Instance.new("Sound", VictimChar.UpperTorso)
            Sound.SoundId = "rbxassetid://8880764455"
            Sound:Play()
        end)
    end

    function Stomps:CosmicSlash(VictimChar)
        spawn(function()
            local Tween = game:GetObjects("rbxassetid://12888729215")[1]
            local XSlash = game:GetObjects("rbxassetid://12888745636")[1]
            local Folder = Instance.new("Folder", workspace.Ignored)
            local sucess, err = pcall(function()
                for i,v in pairs(VictimChar:GetDescendants()) do
                    if not (not v:IsA("BasePart")) or not (not v:IsA("MeshPart")) or v:IsA("Decal") then
                        TweenService:Create(v, TweenInfo.new(4), {
                            Transparency = 1
                        }):Play()
                    end
                end
                local Part = Instance.new("Part")
                local HRP = VictimChar:FindFirstChild("HumanoidRootPart")
                Part.CFrame = CFrame.new(VictimChar.UpperTorso.CFrame.p) * CFrame.new(0,2.2,0)
                local Particles = XSlash.particles
                local Particles2 = XSlash.particles2
                local Beams = XSlash.Beams
                local Main = XSlash.Main
                Main.CFrame = Part.CFrame * CFrame.new(0, -2.7, 0)
                Main.Parent = Folder
                game.Debris:AddItem(Main, 3)
                Sound:Play()
                game.Debris:AddItem(Sound, 3)
                Particles2.CFrame = Part.CFrame * CFrame.Angles(0, -2.3935096295999836, 0)
                Particles2.Parent = Folder
                game.Debris:AddItem(Particles2, 3)
                Particles.CFrame = Part.CFrame * CFrame.Angles(0, -0.8226958495125671, 0)
                Particles.Parent = Folder
                game.Debris:AddItem(Particles, 3)
                Main.Attachment.OUT3:Emit(6)
                Main.Attachment.OUT2:Emit(6)
                Main.Attachment.OUT:Emit(4)
                Main.Attachment.ParticleEmitter:Emit(2)
                TweenService:Create(Main.PointLight, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {
                    Brightness = 5
                }):Play()
                wait(0.06)
                Main.Attachment.IN:Emit(4)
                wait(0.1)
                Main.Attachment2.ParticleEmitter:Emit(39)
                wait(0.28)
                Main.Attachment.OUTFX:Emit(4)
                Main.Attachment.OUTFX2:Emit(4)
                Main.Attachment2.ParticleEmitterOUT:Emit(39)
                for i,v in pairs(Particles:GetChildren()) do
                    v:Emit(v:GetAttribute("EmitCount"))
                end
                for i,v in pairs(Particles2:GetChildren()) do
                    v:Emit(v:GetAttribute("EmitCount"))
                end
                spawn(function()
                    Tween.Parent = game.Lighting
                    game.TweenService:Create(Tween, TweenInfo.new(0.2), {
                        TintColor = Color3.fromRGB(172, 78, 255), 
                        Brightness = 0.5, 
                        Contrast = 1, 
                        Saturation = -1
                    }):Play();
                    wait(0.2);
                    game.TweenService:Create(Tween, TweenInfo.new(0.3), {
                        TintColor = Color3.fromRGB(255, 255, 255), 
                        Brightness = 0, 
                        Contrast = 0, 
                        Saturation = 0
                    }):Play();
                    game.Debris:AddItem(Tween, 0.3);
                end)
                local PrimartyPart = Beams.PrimaryPart
                spawn(function()
                    PrimartyPart.CFrame = Part.CFrame * CFrame.new(0, -2.7, 0)
                    Beams.Parent = Folder
                    for i = 0, 1, 0.1 do
                        Beams:FindFirstChild("Part1").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part1").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part2").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part3").BEAM7.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM1.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM2.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM3.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM4.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM5.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM6.Transparency = NumberSequence.new(i);
                        Beams:FindFirstChild("Part4").BEAM7.Transparency = NumberSequence.new(i);
                        wait(0.001);
                    end
                end)
                wait(0.4)
                TweenService:Create(Main.PointLight, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {
                    Brightness = 0
                }):Play();
        end)
            if sucess then
                task.delay(25, function()
                    Folder:Destroy()
                end)
                return
            end
            Folder:Destroy()
            Tween:Destroy()
        end)
    end
end 	
-- 
local Highlights = Instance.new("Folder")
Highlights.Parent = game.CoreGui
-- 
if not LPH_OBFUSCATED then 
    LPH_JIT_MAX = function(...) return (...) end;
    LPH_NO_VIRTUALIZE = function(...) return (...) end;
	LPH_JIT = function(...) return (...) end;
end
-- 
for i,v in pairs(Lynx.Files.Folders) do
	makefolder(v)
end 
-- 
for LuaName, Contents in pairs(Lynx.Files.Luas) do
	writefile("Lynx/Luas/" .. LuaName .. ".lua", Contents)
end 
-- 
if not isfile("Lynx/Assets/Auto Prediction.txt") then 
	writefile("Lynx/Assets/Auto Prediction.txt", "10 ping value\n20 ping value\n30 ping value\n40 ping value\n50 ping value\n60 ping value\n70 ping value\n80 ping value\n90 ping value\n100 ping value")
end 
-- 
-- 
if not isfile("Lynx/Assets/Shit Talk.txt") then 
	writefile("Lynx/Assets/Shit Talk.txt", "You're a dog nn\nGet Good Get Lynx\nLOL")
end 
--
utility.ShitTalk.Custom = readfile("Lynx/Assets/Shit Talk.txt"):split("\n")
--
local ui = {}
-- 
local uis = game:GetService('UserInputService')
local txtservice = game:GetService('TextService')
local ts = game:GetService('TweenService')
local rs = game:GetService('RunService')
local hs = game:GetService('HttpService')

local HttpService = game:GetService("HttpService")
local ENABLE_TRACEBACK = false
local Signal = {}
do
	Signal.__index = Signal
	Signal.ClassName = "Signal"
    --[=[
        Returns whether a class is a signal
        @param value any
        @return boolean
    ]=]
	function Signal.isSignal(value)
		return type(value) == "table" and getmetatable(value) == Signal
	end
    --[=[
        Constructs a new signal.
        @return Signal<T>
    ]=]
	function Signal.new()
		local self = setmetatable({}, Signal)
		self._bindableEvent = Instance.new("BindableEvent")
		self._argMap = {}
		self._source = ENABLE_TRACEBACK and debug.traceback() or ""

		self._bindableEvent.Event:Connect(function(key)
			self._argMap[key] = nil
			if (not self._bindableEvent) and (not next(self._argMap)) then
				self._argMap = nil
			end
		end)
		return self
	end
    --[=[
        Fire the event with the given arguments. All handlers will be invoked. Handlers follow
        @param ... T -- Variable arguments to pass to handler
    ]=]
	function Signal:Fire(...)
		if not self._bindableEvent then
			warn(("Signal is already destroyed. %s"):format(self._source))
			return
		end
		local args = table.pack(...)
		local key = HttpService:GenerateGUID(false)
		self._argMap[key] = args
		self._bindableEvent:Fire(key)
	end
    --[=[
        Connect a new handler to the event. Returns a connection object that can be disconnected.
        @param handler (... T) -> () -- Function handler called when `:Fire(...)` is called
        @return RBXScriptConnection
    ]=]
	function Signal:Connect(handler)
		if not (type(handler) == "function") then
			error(("connect(%s)"):format(typeof(handler)), 2)
		end
		return self._bindableEvent.Event:Connect(function(key)
			local args = self._argMap[key]
			if args then
				handler(table.unpack(args, 1, args.n))
			else
				error("Missing arg data, probably due to reentrance.")
			end
		end)
	end
    --[=[
        Wait for fire to be called, and return the arguments it was given.
        @yields
        @return T
    ]=]
	function Signal:Wait()
		local key = self._bindableEvent.Event:Wait()
		local args = self._argMap[key]
		if args then
			return table.unpack(args, 1, args.n)
		else
			error("Missing arg data, probably due to reentrance.")
			return nil
		end
	end
    --[=[
        Disconnects all connected events to the signal. Voids the signal as unusable.
        Sets the metatable to nil.
    ]=]
	function Signal:Destroy()
		if self._bindableEvent then
			self._bindableEvent:Destroy()
			self._bindableEvent = nil
		end
		setmetatable(self, nil)
	end
end

local Connections = {}

local function Tween(frame,time,style,direction,props)
	local a = ts:Create(frame,TweenInfo.new(time,Enum.EasingStyle[style],Enum.EasingDirection[direction]),props)
	a:Play()
	return a
end
local function formatTable(t)
	local t = t or {}
	local new = {}
	for i,v in pairs(t) do
		new[tostring(i):lower()] = v
	end
	return new
end
local function create(className,options)
	local options = options or {}
	local inst = Instance.new(className)
	for i,v in pairs(options) do
		inst[i] = v
	end
	return inst
end
local function TabInsert(t,v)
	if not table.find(t,v) then
		table.insert(t,v)
	end
end
local function TabRemove(t,v)
	local a = table.find(t,v)
	if a then
		table.remove(t,a)
	end
end
local function Dragify(frame,frame2)
	local frame2 = frame2 or frame
	local dragging = false 
	local dragInput 
	local dragStart 
	local startPos 
	local function update(input) 
		local delta = input.Position - dragStart 
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end 
	frame2.InputBegan:Connect(function(input) 
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
			dragging = true 
			dragStart = input.Position 
			startPos = frame.Position 
			input.Changed:Connect(function() 
				if input.UserInputState == Enum.UserInputState.End then 
					dragging = false 
				end 
			end) 
		end 
	end) 
	frame2.InputChanged:Connect(function(input) 
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
			dragInput = input 
		end 
	end)
	uis.InputChanged:Connect(function(input) 
		if input == dragInput and dragging then 
			update(input) 
		end 
	end)
end
local function SetupFrame(frame,options)
	local options = formatTable(options)
	local uiCorner,stroke,list,pad
	if options.corner then
		local cornerOptions = formatTable(options.corner)
		uiCorner = create('UICorner',{
			Parent = frame,
			CornerRadius = cornerOptions.radius or UDim.new(),
		})
	end
	if options.stroke then
		local strokeOptions = formatTable(options.stroke)
		stroke = create('UIStroke',{
			Name = 'Stroke',
			Parent = frame,
			Thickness = 1,
			Transparency = 0,
			Color = strokeOptions.Color or Color3.fromRGB(40,40,40), -- ps it doesnt even change
			LineJoinMode = 'Round',
			ApplyStrokeMode = 'Contextual'
		})
	end
	if options.list then
		local listOptions = formatTable(options.list)
		list = create('UIListLayout',{
			Parent = frame,
			Padding = listOptions.pad or UDim.new(),
			FillDirection = listOptions.direction or 'Vertical',
			HorizontalAlignment = listOptions.horizontalalignment or 'Left',
			SortOrder = listOptions.order or 'LayoutOrder',
			VerticalAlignment = listOptions.verticalalignment or 'Top',
		})
	end
	if options.pad then
		local padOptions = formatTable(options.pad)
		pad = create('UIPadding',{
			Parent = frame,
			PaddingBottom = padOptions.bottom or UDim.new(),
			PaddingTop = padOptions.top or UDim.new(),
			PaddingRight = padOptions.right or UDim.new(),
			PaddingLeft = padOptions.left or UDim.new(),
		})
	end
	return uiCorner,stroke,list,pad
end
local function CreateElement(element) -- aka create holder
	local holder = element._holder
	local elementHolder = create('Frame',{
		Name = #holder:GetChildren()-(element._settingMenu and 0 or 3),
		Parent = holder,
		Size = UDim2.new(1,0,0,15),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = holder.ZIndex+1,
	})
	local holder = create('Frame',{
		Name = 'Holder',
		Parent = elementHolder,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = element._holderPosition or UDim2.new(0,80,0,0),
		Size = element._holderSize or UDim2.new(0,100,1,0),
		ZIndex = elementHolder.ZIndex+1,
	})
	SetupFrame(holder,{
		List = {Pad = UDim.new(0,5),Direction = 'Horizontal',horizontalalignment = 'Right',verticalalignment = 'Top'},
	})
	return holder
end
local function CreateSlider(frame,options)
	local options = formatTable(options)
	local side = options.side or 'X'
	local offset = side == 'Y' and 36 or 0

	local min = options.min or 0
	local max = options.max or 100
	local default = options.default or 0
	local float = options.float or 1

	local set = options.set or function() end


	local button = create('Frame',{
		Parent = frame,
		Name = 'Button',
		BackgroundTransparency = 1,
		Position = UDim2.new(),
		Size = UDim2.new(1,0,1,0),
		ZIndex = frame.ZIndex+1,
	})

	local function slide(input)
		local x = (input.Position[side]-frame.AbsolutePosition[side])/frame.AbsoluteSize[side]

		local value = ((max-min)*x)+min
		value = math.floor(value*(1/float))/(1/float)
		value = math.clamp(value,min,max)
		set(value)
	end
	set(default)
	local sliding = false
	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = true
			slide(input)
		end
	end)
	button.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			sliding = false
			slide(input)
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and sliding then
			slide(input)
		end
	end)
	return button
end
local function CreateInput(textlabel,options)
	local textbox = create('TextBox',{
		Parent = textlabel.Parent,
		ClearTextOnFocus = false,
		Font = textlabel.Font,
		FontFace = textlabel.FontFace,
		LineHeight = textlabel.LineHeight,
		Position = textlabel.Position,
		Size = textlabel.Size,
		Text = textlabel.Text,
		TextColor3 = textlabel.TextColor3,
		TextScaled = textlabel.TextScaled,
		TextSize = textlabel.TextSize,
		Name = textlabel.Name,
		ZIndex = textlabel.ZIndex,
		BackgroundTransparency = textlabel.BackgroundTransparency,
		TextTransparency = textlabel.TextTransparency,
		TextXAlignment = textlabel.TextXAlignment,
		BorderSizePixel = textlabel.BorderSizePixel,
	})
	textlabel:Destroy()
	local options = formatTable(options)
	local callback = options.callback or function() end
	if options.focuses then
		textbox.Focused:Connect(function()
			callback(false,textbox.Text)
		end)
		textbox.FocusLost:Connect(function(a,b)
			callback(true,textbox.Text,a,b)
		end)
	else
		textbox:GetPropertyChangedSignal('Text'):Connect(function()
			callback(textbox.Text)
		end)
	end
	return textbox
end
-- im master of sphagetti code when it comes to uis LOL

local Elements = {}
Elements.__index = Elements

local function CombineTables(t,t2)
	local t3 = {}
	for i,v in pairs(t) do
		t3[i] = v
	end
	for i,v in pairs(t2) do
		t3[i] = v
	end

	return setmetatable(t3,Elements)
end
local Segment = {} -- i have no clue how to call it srry
Segment.__index = Segment
function Segment:CreateSegment(options)
	local options = formatTable(options)
	local holder = CreateElement(self)

	local elementsClass = {_holder = holder,_window = self._window,_sector = self._sector,_tabSector = self._tabSector,_segment = true}
	if options.name then
		elementsClass._title = true
		create('TextLabel',{
			Name = 'Title',
			Parent = holder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = holder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	return setmetatable(elementsClass,Elements)
end

function Elements:Colorpicker(options)
	local options = formatTable(options)
	local mainHolder = self._holder
	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	local sector = self._tabSector
	local zindexadd = 300+300*#sector:GetChildren()
	local colorpickerIcon = create('ImageLabel',{
		Parent = mainHolder,
		Name = (10-#mainHolder:GetChildren()),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 46, 0, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = mainHolder.ZIndex+1,
		Image = "http://www.roblox.com/asset/?id=14259665095",
		ImageColor3 = Color3.fromRGB(200, 200, 200),
		SliceScale = 4.000,
	})
	local scroll = self._tabSector
	local scrollY = scroll.CanvasSize.Y.Offset
	
	local edgeX = scroll.AbsolutePosition.X+scroll.AbsoluteSize.X
	local sizex = 125
	local offset = 15

	local posX = ((colorpickerIcon.AbsolutePosition.X+offset >= edgeX or colorpickerIcon.AbsolutePosition.X+offset+sizex >= edgeX) and -(sizex+offset) or offset+(colorpickerIcon.AbsoluteSize.X/2))
	local posY = math.clamp(colorpickerIcon.AbsolutePosition.Y-60,scroll.AbsolutePosition.Y,scroll.AbsolutePosition.Y+scrollY)

	local colorpickerFrame = create('Frame',{
		Name = 'ColorpickerFrame',
		Parent = colorpickerIcon,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, posX, 0, posY-colorpickerIcon.AbsolutePosition.Y+2),
		Size = UDim2.new(0, sizex, 0, 135),
		ZIndex = zindexadd+1,
		Visible = false,
	})
	SetupFrame(colorpickerFrame,{corner = {radius = UDim.new(0,4)},stroke = {}})
	local button = create('TextButton',{
		Parent = colorpickerIcon,
		Size = UDim2.new(1,0,1,0),
		TextTransparency = 1,
		BackgroundTransparency = 1,
		ZIndex = zindexadd+1
	})
	button.MouseButton1Down:Connect(function()
		colorpickerFrame.Visible = not colorpickerFrame.Visible
	end)
	
	scroll:GetPropertyChangedSignal('CanvasSize'):Connect(function()
		scrollY = scroll.CanvasSize.Y.Offset
		posY = math.clamp(colorpickerIcon.AbsolutePosition.Y-60,scroll.AbsolutePosition.Y,scroll.AbsolutePosition.Y+scrollY)
		colorpickerFrame.Position = UDim2.new(0, posX, 0, posY-colorpickerIcon.AbsolutePosition.Y+2)
	end)
	
	-- 5 fucking frames 3 textlables and 1 image i fucking hate colorpicker i made
	local mainColorpicker = create('Frame',{
		Name = 'Colorpicker',
		Parent = colorpickerFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0, 5),
		Size = UDim2.new(0, 100, 0, 90),
		ZIndex = zindexadd+2,
	})
	SetupFrame(mainColorpicker,{Corner = {radius = UDim.new(0,4)}})
	local image = create('ImageLabel',{
		ZIndex = zindexadd+3,
		Parent = mainColorpicker,
		Image = 'rbxassetid://4155801252',
		Size = UDim2.new(1,0,1,0)
	})

	local hue = create('Frame',{
		Name = 'Hue',
		Parent = colorpickerFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0, 100),
		Size = UDim2.new(0, 115, 0, 11),
		ZIndex = zindexadd+2,
	})
	SetupFrame(hue,{corner = {radius = UDim.new(0,4)}})
	create('UIGradient',{
		Parent = hue,
		Enabled = true,
		Rotation = 0,
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), 
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)), 
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), 
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), 
			ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), 
			ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)), 
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
		}
	})
	local alpha = create('ImageLabel',{
		Name = 'Alpha',
		Parent = colorpickerFrame,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 110, 0, 5),
		Size = UDim2.new(0, 10, 0, 90),
		ZIndex = zindexadd+2,
		Image = "rbxassetid://14248403322",
	})


	local alphaslideFrame = create('Frame',{
		BackgroundTransparency = 1,
		Parent = alpha,
		Size = UDim2.new(1,0,1,-2)
	})
	local alphapicker = create('Frame',{
		Parent = alphaslideFrame,
		BorderSizePixel = 1,
		Size = UDim2.new(1,-2,0,2),
		Position = UDim2.new(0,1,0,0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = zindexadd+4
	})

	local hueslideFrame = create('Frame',{
		BackgroundTransparency = 1,
		Parent = hue,
		Size = UDim2.new(1,-2,1,0)
	})
	local huepicker = create('Frame',{
		Parent = hueslideFrame,
		BorderSizePixel = 1,
		Size = UDim2.new(0,2,1,-2),
		Position = UDim2.new(0,0,0,1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = zindexadd+4
	})

	local colorpickerSlide = create('Frame',{
		Parent = mainColorpicker,
		Name = 'SlideFrame',
		Size = UDim2.new(1,-3,1,-3),
		Position = UDim2.new(0,1,0,1),
		BackgroundTransparency = 1,
	})
	local colorpointer = create('Frame',{
		Parent = colorpickerSlide,
		Name = 'Picker',
		Size = UDim2.new(0,6,0,6),
		Position = UDim2.new(),
		BorderSizePixel = 1,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = zindexadd+4
	})

	local inputs = {}
	for i=1,3 do -- i am NOT doing 3 20 lines of code
		local mainFrame = create('Frame',{
			Name = tostring(i),
			Parent = colorpickerFrame,
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BackgroundTransparency = 0.500,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 6+(39*(i-1)), 0, 116),
			Size = UDim2.new(0, 35, 0, 14),
			ZIndex = zindexadd+2,
		})
		local a = create('TextLabel',{
			Name = tostring(i),
			Parent = mainFrame,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 0),
			Size = UDim2.new(1, 0, 1, -1),
			ZIndex = zindexadd+3,
			Font = Enum.Font.Gotham,
			Text = "255",
			TextColor3 = Color3.fromRGB(180, 180, 180),
			TextSize = 11.000,
			TextWrapped = true,
		})
		SetupFrame(mainFrame,{corner = {radius = UDim.new(0,4)},pad = {top = UDim.new(0,1),bottom = UDim.new(0,1),left = UDim.new(0,8),right = UDim.new(0,8)},stroke = {}})
		table.insert(inputs,a)
	end
	local window = self._window
	local callback = options.callback or function() end
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	local callback = options.callback or function() end


	local default = {Color = Color3.fromRGB(255, 255, 255),Alpha = 0}
	if options.default then
		if typeof(options.default) == 'Color3' then
			default.Color = options.default
		elseif typeof(options.default) == 'table' then
			default = options.default
		end
	end
	window.flags[flag] = {Color = default.Color,Alpha = default.Alpha or 0}
	local h,s,v = default.Color:ToHSV()
	
	local a = default.Alpha or 0
	
	local function set(color,setpos)
		local newhue,newsat,newval = color:ToHSV()

		if setpos then
			h = newhue
			s = newsat
			v = newval

			alphapicker.Position = UDim2.new(0,1,a,0)
			huepicker.Position = UDim2.new(h,0,0,1)
			colorpointer.Position = UDim2.new(1-s,-3,1-v,-3)
		end
		image.ImageColor3 = Color3.fromHSV(h,1,1)

		alpha.BackgroundColor3 = Color3.fromHSV(h,1,1)

		inputs[1].Text = math.floor(color.R*255) 
		inputs[2].Text = math.floor(color.G*255)
		inputs[3].Text = math.floor(color.B*255) 

		window.flags[flag].Color = color
		window.flags[flag].Alpha = a
		callback(window.flags[flag])
	end
	local function SetA(newa)
		a = newa
		alphapicker.Position = UDim2.new(0,1,a,0)
		set(Color3.fromHSV(h,1-s,1-v))
	end
	local function SetH(value)
		h = value
		huepicker.Position = UDim2.new(h,0,0,1)
		set(Color3.fromHSV(h,1-s,1-v))
	end
	local function SetS(value)
		s = value
		colorpointer.Position = UDim2.new(s,-3,v,-3)
		set(Color3.fromHSV(h,1-s,1-v))
	end
	local function SetV(value)
		v = value
		colorpointer.Position = UDim2.new(s,-3,v,-3)
		set(Color3.fromHSV(h,1-s,1-v))
	end

	CreateSlider(alphaslideFrame,{side = 'Y',min=0,max=1,float=0.01,default=0,set=SetA})
	CreateSlider(hueslideFrame,{side = 'X',min=0,max=1,float=0.01,default=0,set=SetH})

	CreateSlider(colorpickerSlide,{side = 'X',min=0,max=1,float=0.01,default=0,set=SetS})
	CreateSlider(colorpickerSlide,{side = 'Y',min=0,max=1,float=0.01,default=0,set=SetV})

	set(default.Color,true)

	local r,g,b


	local textbox;textbox = CreateInput(inputs[1],{focuses = true,callback = function(a,text,b,c)
		if not a then
			r = text
		else
			if tonumber(text) then
				set(Color3.fromRGB(text,inputs[2].Text,inputs[3].Text),true)
			else
				textbox.Text = r
			end
		end
	end})
	inputs[1] = textbox
	local textbox;textbox = CreateInput(inputs[2],{focuses = true,callback = function(a,text,b,c)
		if not a then
			g = text
		else
			if tonumber(text) then
				set(Color3.fromRGB(inputs[1].Text,text,inputs[3].Text),true)
			else
				textbox.Text = g
			end
		end
	end})
	inputs[2] = textbox
	local textbox;textbox = CreateInput(inputs[3],{focuses = true,callback = function(a,text,b,c)
		if not a then
			b = text
		else
			if tonumber(text) then
				set(Color3.fromRGB(inputs[1].Text,inputs[2].Text,text),true)
			else
				textbox.Text = b
			end
		end
	end})
	inputs[3] = textbox
	
	local function SetValue(color)
		a = typeof(color) == 'table' and color.Alpha or 0
		local color = typeof(color) == 'table' and color.Color or color
		set(color,true)
	end
	
	window._FlagsSet[flag] = SetValue
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	return setmetatable({Set = SetValue},{__index = newmt})

end
function Elements:Settings(options)
	local options = formatTable(options)
	
	local mainHolder = self._holder
	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	local scroll = self._tabSector

	local edgeX = scroll.AbsolutePosition.X+scroll.AbsoluteSize.X
	
	local zindexadd = 200+#self._sector:GetChildren()*200
	local settingIcon = create('ImageLabel',{
		Parent = mainHolder,
		Name = (10-#mainHolder:GetChildren()),
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 46, 0, 0),
		Size = UDim2.new(0, 15, 0, 15),
		ZIndex = mainHolder.ZIndex+1,
		Image = "http://www.roblox.com/asset/?id=14259672152",
		ImageColor3 = Color3.fromRGB(200, 200, 200),
		SliceScale = 4.000,
	})
	local sizex = 150
	local offset = 10
	
	local posX = ((settingIcon.AbsolutePosition.X+offset >= edgeX or settingIcon.AbsolutePosition.X+offset+sizex >= edgeX) and -(sizex+offset) or offset+(settingIcon.AbsoluteSize.X/2))
	local posY = math.clamp(settingIcon.AbsolutePosition.Y,scroll.AbsolutePosition.Y,scroll.AbsolutePosition.Y+scroll.AbsoluteSize.Y)
	
	local button = create('TextButton',{
		Parent = settingIcon,
		Name = 'Button',
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		TextTransparency = 1,
		ZIndex = mainHolder.ZIndex+2,
	})
	local settingFrame = create('Frame',{
		Name = 'Setting',
		Parent = settingIcon,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Position = UDim2.new(0, posX, 0, posY-settingIcon.AbsolutePosition.Y+2),
		Size = UDim2.new(0, sizex, 0, 10),
		ZIndex = zindexadd,
		Visible = false,
	})
	SetupFrame(settingFrame,{Corner = {radius = UDim.new(0, 4)},stroke = {}})
	button.MouseButton1Down:Connect(function()
		settingFrame.Visible = not settingFrame.Visible
	end)
	local settingsHolder = create('Frame',{
		Parent = settingFrame,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(),
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = zindexadd+1,
	})
	SetupFrame(settingsHolder,
		{
			list = {pad = UDim.new(0,5),directing = 'Vertical',horizontalalignment = 'Left',verticalalignment = 'Top'},
			pad = {bottom = UDim.new(0,5),top = UDim.new(0,5),left = UDim.new(0,6), right = UDim.new(0,6)}
		}
	)

	local list = settingsHolder.UIListLayout
	local function UpdatePos()
		local contentSize = list.AbsoluteContentSize.Y + 25

		local posY = math.clamp(settingIcon.AbsolutePosition.Y+(-contentSize/2+7),scroll.AbsolutePosition.Y,scroll.AbsolutePosition.Y+scroll.AbsoluteSize.Y)

		settingFrame.Size = UDim2.new(0,sizex,0,contentSize)
		settingFrame.Position = UDim2.new(0, posX, 0, posY-settingIcon.AbsolutePosition.Y+2)	
	end
	list:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(UpdatePos)
	scroll:GetPropertyChangedSignal('CanvasSize'):Connect(UpdatePos)
	return setmetatable(
		{
			_holder = settingsHolder,
			_window = self._window,
			_tabSector = self._tabSector,
			_sector = self._sector,
			_settingMenu = true,
			_holderSize = UDim2.new(1,-60,1,0),
			_holderPosition = UDim2.new(1,-80,0,0)
		},
		{__index = Elements}
	)
end
function Elements:Title(options)
	local options = formatTable(options)
	local oldMainholder = CreateElement(self)
	local mainHolder = oldMainholder.Parent
	oldMainholder:Destroy() 

	local title = options.title or ''
	local description = options.description

	if description then
		mainHolder.Size = UDim2.new(1, 0, 0, 28)
	end 

	SetupFrame(mainHolder,{
		list = {Pad = UDim.new(0,4),direction = 'Vertical',horizontalalignment = 'Left',verticalalignment = 'Center'}
	})
	create('TextLabel',{
		Parent = mainHolder,
		Name = 'Title',
		LayoutOrder = 1,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, description and 12 or 15),
		ZIndex = mainHolder.ZIndex+1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = title
	})

	if description then
		create('TextLabel',{
			Parent = mainHolder,
			Name = 'Description',
			LayoutOrder = 2,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.Gotham,
			Text = description,
			TextColor3 = Color3.fromRGB(108, 108, 108),
			TextSize = 12.000,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end
end
function Elements:Toggle(options)
	local options = formatTable(options)
	local mainHolder = self._holder

	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	local toggle = create('Frame',{
		Name = 'Toggle',
		LayoutOrder = (10-#mainHolder:GetChildren()),
		Parent = mainHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.5,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 1, 0, 1),
		Size = UDim2.new(0, 33, 1, 0),
		ZIndex = mainHolder.ZIndex+2,
	})
	SetupFrame(toggle,{
		corner = {radius = UDim.new(1,0)},
		pad = {bottom = UDim.new(0,1),top = UDim.new(0,1),right = UDim.new(0,1),left = UDim.new(0,1)},
		stroke = {}
	})
	local circle = create('Frame',{
		Name = 'Circle',
		Parent = toggle,
		BackgroundColor3 = Color3.fromRGB(125, 125, 125),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 1, 0, 0),
		Size = UDim2.new(0, 12, 1, 0),
		ZIndex = mainHolder.ZIndex+3,
	})
	local btn = create('TextButton',{
		Name = 'Callback Handler',
		Parent = toggle,
		BackgroundTransparency = 1,
		Text = '',
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = mainHolder.ZIndex+4,
	})
	SetupFrame(circle,{corner = {radius = UDim.new(1,0)}})

	local window = self._window
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	local callback = options.callback or function() end
	window.flags[flag] = (options.default ~= nil)

	local function OnCallback()
		if window.flags[flag] then
			Tween(circle,0.25,'Quad','Out',{BackgroundColor3 = Color3.new(1, 1, 1),Position = UDim2.new(1, -13, 0,0)})
		else
			Tween(circle,0.25,'Quad','Out',{BackgroundColor3 = Color3.fromRGB(125, 125, 125),Position = UDim2.new(0, 1,0,0)})
		end
		--Tween(circle,0.25,'Quad','Out',{BackgroundColor3 = (window.flags[flag] and Color3.new(1, 1, 1) or Color3.fromRGB(125, 125, 125)),Position = UDim2.new(window.flags[flag] and 1 or 0, window.flags[flag] and -13 or 1,0,0)})
		callback(window.flags[flag])
	end
	local function Set(val)
		window.flags[flag] = val
		OnCallback()
	end
	Set(window.flags[flag])
	local _ = toggle.AbsolutePosition -- abs position doesnt get updated until indexes lmao
	btn.MouseButton1Down:Connect(function() Set(not window.flags[flag]) end)
	
	window._FlagsSet[flag] = Set
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	return setmetatable({Set = Set},{__index = newmt})
end
function Elements:Input(options)
	local options = formatTable(options)
	local mainHolder = self._holder

	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	local window = self._window
	local callback = options.callback or function() end
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	local input = create('Frame',{
		Name = 'Input',
		LayoutOrder = (10-#mainHolder:GetChildren()),
		Parent = mainHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 1, 0, 1),
		Size = UDim2.new(0, 100, 1, 0),
		ZIndex = mainHolder.ZIndex+2,
	})
	SetupFrame(input,{pad = {Bottom = UDim.new(0,1),top = UDim.new(0,1),right = UDim.new(0,8),left = UDim.new(0,8)},corner = {radius = UDim.new(1,0)},stroke = {}})
	local inputTextlabel = create('TextLabel',{
		Parent = input,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = mainHolder.ZIndex+3,
		Font = Enum.Font.Gotham,
		Text = "0",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		TextSize = 14,
		TextWrapped = true,
	})
	local function set(text)
		inputTextlabel.Text = text
		window.flags[flag] = text
		callback(text)
	end
	inputTextlabel = CreateInput(inputTextlabel,{focuses = options.focuses,callback = function(...)
		window.flags[flag] = inputTextlabel.Text
		callback(...)
	end,})
	
	window._FlagsSet[flag] = set
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	
	return setmetatable({Set = set},{__index = newmt})
end
function Elements:Slider(options)
	local options = formatTable(options)
	local mainHolder = self._holder

	local window = self._window
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	local callback = options.callback or function() end
	local min = options.min or 0
	local max = options.max or 100
	local default = options.default or min
	local float = options.float or 1
	local showvalue = true
	if options.showvalue == false then showvalue = false end


	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end

	local SlideHolder = create('Frame',{
		Name = 'Slider',
		LayoutOrder = (10-#mainHolder:GetChildren()),
		Parent = mainHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 70+(showvalue and txtservice:GetTextSize(tostring(max),12,Enum.Font['GothamMedium'],Vector2.new(math.huge,math.huge)).X+5 or 0), 1, 0),
		ZIndex = mainHolder.ZIndex+2,
	})
	SetupFrame(SlideHolder,{pad = {bottom = UDim.new(0,1),top = UDim.new(0,1),left = UDim.new(0,1),right = UDim.new(0,1)},corner = {radius = UDim.new(1,0)}})
	local slider = create('Frame',{
		Name = 'Slide',
		Parent = SlideHolder,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -65, 0.5, -1),
		Size = UDim2.new(0, 60, 0, 2),
		ZIndex = mainHolder.ZIndex+3
	})
	local circle = create('Frame',{
		Parent = slider,
		Name = 'Circle',
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Position = UDim2.new(0, -5, 0, 6),
		Size = UDim2.new(0, 12, 0, 12),
		ZIndex = mainHolder.ZIndex+3
	})
	SetupFrame(circle,{corner = {radius = UDim.new(1,0)}})
	SetupFrame(slider,{corner = {radius = UDim.new(1,0)}})

	local textLabel;
	if showvalue then
		textLabel = create('TextLabel',{
			Parent = SlideHolder,
			Name = 'Counter',
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(0, txtservice:GetTextSize(tostring(max),12,Enum.Font['GothamMedium'],Vector2.new(math.huge,math.huge)).X, 1, 0),
			ZIndex = SlideHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = 'Right'
		})
	end
	local function set(newval)
		newval = math.clamp(newval,min,max)

		circle.Position = UDim2.new((newval-min)/(max-min),-3,0,-6)

		if textLabel then
			textLabel.Text = tostring(newval)
		end
		window.flags[flag] = newval
		callback(newval)
	end

	local a = CreateSlider(slider,{min = min,max = max,default = default,float = float,side = 'X',set = set})
	a.Position = UDim2.new(0,0,0,-6)
	a.Size = UDim2.new(0,60,0,12)

	set(default)
	
	window._FlagsSet[flag] = set
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	return setmetatable({
		Set = set,
		
	},{__index = newmt})
end
function Elements:Dropdown(options)
	local options = formatTable(options)
	local mainHolder = self._holder

	if not self._segment then
		mainHolder = CreateElement(self)
	end
	if not mainHolder.Parent:FindFirstChild('Title') then
		create('TextLabel',{
			Name = 'Title',
			Parent = mainHolder.Parent,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 12),
			ZIndex = mainHolder.ZIndex+1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12.000,
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = options.name or ''
		})
	end
	local choices = options.options or {}
	local current = options.default or {}

	local min = options.min or 0
	local max = options.max or #choices

	if min>max then error('kill yourself (min is bigger than max)',2) end
	
	local currentChild = #self._sector:GetChildren()
	local zindexadd = 100
	
	local dropdownHolder = create('Frame',{
		Parent = mainHolder,
		Name = 'Dropdown',
		LayoutOrder = (10-#mainHolder:GetChildren()),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 1, 0, 1),
		Size = UDim2.new(0, 90, 1, 0),
		ZIndex = zindexadd,
	})
	SetupFrame(dropdownHolder,{Corner = {radius = UDim.new(0,2)},stroke = {}})

	local btn = create('TextButton',{
		Parent = dropdownHolder,
		Name = 'Handler',
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = zindexadd+1,
		Text = '',
		TextTransparency = 1,
	})

	local choiceText = create('TextLabel',{
		Parent = dropdownHolder,
		Name = 'Choice',
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0, 2),
		Size = UDim2.new(1, -20, 0, 9),
		ZIndex = zindexadd+1,
		Font = Enum.Font.Gotham,
		Text = '',
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local arrow = create('ImageLabel',{
		Parent = dropdownHolder,
		Name = 'Arrow',
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -12, 0, 5),
		Size = UDim2.new(0, 7, 0, 4),
		ZIndex = dropdownHolder.ZIndex+1,
		Image = "http://www.roblox.com/asset/?id=14259608577",
		ImageColor3 = Color3.fromRGB(200, 200, 200),
	})
	dropdownHolder:GetPropertyChangedSignal('ZIndex'):Connect(function()
		arrow.ZIndex = dropdownHolder.ZIndex+1
	end)
	local optionsHolder = create('ScrollingFrame',{
		Parent = dropdownHolder,
		Name = 'OptionsHolder',
		Active = true,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 17),
		Size = UDim2.new(1, 0, 0, 73),
		Visible = false,
		ZIndex = zindexadd+1,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = 'Y',
		ScrollBarImageTransparency = 1,
	})
	SetupFrame(optionsHolder,{list = {pad = UDim.new(0,5),direction = 'Vertical',horizontalalignment = 'Left',verticalalignment = 'Top'},pad = {Top = UDim.new(0,1),Bottom = UDim.new(0,1),right = UDim.new(0,4),left = UDim.new(0,4)}})

	local window = self._window
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	local callback = options.callback or function() end
	
	local function Update()
		local str = ''
		if #current == 0 then str = 'None' choiceText.TextColor3 = Color3.fromRGB(125,125,125) else
			choiceText.TextColor3 = Color3.fromRGB(255,255,255)
			for i,v in pairs(current) do
				local len = txtservice:GetTextSize(v,choiceText.TextSize,Enum.Font.Gotham,choiceText.AbsoluteSize).X
				if txtservice:GetTextSize(str,choiceText.TextSize,Enum.Font.Gotham,choiceText.AbsoluteSize).X + len >= choiceText.AbsoluteSize.X-7 then
					str = str..'...'
					break
				end
				str = str..tostring(v)..(#current ~= 1 and (i==#current and '' or ', ') or '')
			end
		end
		choiceText.Text = str

		window.flags[flag] = (max == 1 and current[1] or current)
		callback(window.flags[flag])
	end
	Update()
	
	local ChosenFrames = {}
	local FramesChosen = {}
	local function OnClick(frame) -- last time it took like a day or something
		if not FramesChosen[frame] then
			if #ChosenFrames == max then -- causes double update + stack overflow otherwise
				local frame = ChosenFrames[1]
				Tween(frame,0.25,'Quad','In',{TextColor3 = Color3.fromRGB(125, 125, 125)})
				TabRemove(current,frame.Text)
				TabRemove(ChosenFrames,frame)
				FramesChosen[frame] = false
			end
			Tween(frame,0.25,'Quad','In',{TextColor3 = Color3.fromRGB(255, 255, 255)})
			TabInsert(current,frame.Text)
			TabInsert(ChosenFrames,frame)
			FramesChosen[frame] = true
		else -- trying to remove
			if #current <= min then return end
			Tween(frame,0.25,'Quad','In',{TextColor3 = Color3.fromRGB(125, 125, 125)})
			TabRemove(current,frame.Text)
			TabRemove(ChosenFrames,frame)
			FramesChosen[frame] = false
		end
		Update()
	end
	local indx = 1
	local choicesholders = {}
	for i,v in pairs(choices) do
		local frame = create('TextLabel',{
			Parent = optionsHolder,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(1, -5, 0, 12),
			ZIndex = zindexadd+11,
			Font = Enum.Font.Gotham,
			Text = tostring(v),
			TextColor3 = Color3.fromRGB(125, 125, 125),
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		choicesholders[tostring(v)] = frame
		local button = create('TextButton',{
			Parent = frame,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1,0,1,0),
			ZIndex = frame.ZIndex+1,
		})
		frame.MouseEnter:Connect(function()
			if FramesChosen[frame] then return end
			Tween(frame,0.25,'Quad','In',{TextColor3 = Color3.fromRGB(200, 200, 200)})
		end)
		frame.MouseLeave:Connect(function()
			if FramesChosen[frame] then return end
			Tween(frame,0.25,'Quad','In',{TextColor3 = Color3.fromRGB(125, 125, 125)})
		end)
		button.MouseButton1Down:Connect(function()
			OnClick(frame)
		end)
		optionsHolder:GetPropertyChangedSignal('ZIndex'):Connect(function()
			frame.ZIndex = optionsHolder.ZIndex + 1
			button.ZIndex = frame.ZIndex + 1
		end)
		if min >= indx then
			OnClick(frame)
		end
		indx += 1
	end
	optionsHolder.Size = UDim2.new(1,-5,0,0)
	
	
	self._sector.ChildAdded:Connect(function()

		zindexadd = 100+(#self._sector:GetChildren()-currentChild)*100
		dropdownHolder.ZIndex = zindexadd
		optionsHolder.ZIndex = zindexadd+1
		choiceText.ZIndex = zindexadd+1
		btn.ZIndex = zindexadd+1
	end)
	btn.MouseButton1Down:Connect(function()
		optionsHolder.Visible = not optionsHolder.Visible
		local time = optionsHolder.Visible and 0.4 or 0.3
		local size = optionsHolder.Visible and UDim2.new(0,90,1,math.clamp(optionsHolder.AbsoluteCanvasSize.Y,20,100)+5) or UDim2.new(0, 90, 1, 0)
		local size2 =optionsHolder.Visible and UDim2.new(1,0,0,math.clamp(optionsHolder.AbsoluteCanvasSize.Y,20,100)+5) or UDim2.new(1,0,0,0)
		Tween(dropdownHolder,time,'Quad','InOut',{Size = size})
		Tween(optionsHolder,time,'Quad','InOut',{Size = size2})
	end)
	local function SetValue(newoptions)
		if typeof(newoptions) == 'table' then
			for i,v in pairs(newoptions) do
				if not choices[i] then newoptions[i] = nil end
			end
		else
			newoptions = {newoptions}
		end
		current = newoptions
		for i,v in pairs(choicesholders) do
			local a = table.find(current,i)
			v.TextColor3 = a and Color3.fromRGB(255,255,255) or Color3.fromRGB(125, 125, 125)
			FramesChosen[v] = a ~= nil
			local b = table.find(ChosenFrames,v)
			if b then table.remove(ChosenFrames,b) end
		end
		Update()
	end
	window._FlagsSet[flag] = SetValue
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	return setmetatable({Set = SetValue},{__index = newmt})
end
function Elements:Label(options)
	local options = formatTable(options)
	local mainHolder = CreateElement(self)
	create('TextLabel',{
		Name = 'Title',
		Parent = mainHolder.Parent,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 12),
		ZIndex = mainHolder.ZIndex+1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12.000,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = options.name or ''
	})
	mainHolder:Destroy()
end
function Elements:Button(options)
	local options = formatTable(options)
	local mainHolder = self._holder

	if not self._segment then
		mainHolder = CreateElement(self)
	end
	local callback = options.callback or function() end
	mainHolder.Position = UDim2.new(0,1,0,-1)
	mainHolder.Size = UDim2.new(0,180,1,2)

	local button = create('Frame',{
		Name = 'Button',
		LayoutOrder = 0,
		Parent = mainHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 1, 0, 1),
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = mainHolder.ZIndex+2,
	})
	SetupFrame(button,{corner = {radius = UDim.new(0,2)},stroke = {}})
	create('TextLabel',{
		Parent = button,
		Name = 'Label',
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 3, 0, 1),
		Size = UDim2.new(1, 0, 1, -3),
		ZIndex = mainHolder.ZIndex+3,
		Font = Enum.Font.Gotham,
		Text = options.name or '',
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12.000,
	})

	local btn = create('TextButton', {
		Parent = button,
		Name = 'Handler',
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = mainHolder.ZIndex + 4,
		Text = '',
	})

	btn.MouseButton1Down:Connect(callback)
end


local keys = { -- took mostly from vozoid, not doing allat
	[Enum.KeyCode.LeftShift] = 'L-SHIFT',
	[Enum.KeyCode.RightShift] = 'R-SHIFT',
	[Enum.KeyCode.One] = '1',
	[Enum.KeyCode.Two] = '2',
	[Enum.KeyCode.Three] = '3',
	[Enum.KeyCode.Four] = '4',
	[Enum.KeyCode.Five] = '5',
	[Enum.KeyCode.Six] = '6',
	[Enum.KeyCode.Seven] = '7',
	[Enum.KeyCode.Eight] = '8',
	[Enum.KeyCode.Nine] = '9',
	[Enum.KeyCode.Zero] = '0',
	[Enum.KeyCode.LeftControl] = 'L-CTRL',
	[Enum.KeyCode.RightControl] = 'R-CTRL',
	[Enum.KeyCode.RightAlt] = 'R-ALT',
	[Enum.KeyCode.LeftAlt] = 'L-ALT',
	[Enum.KeyCode.CapsLock] = 'CAPSLOCK',
	[Enum.KeyCode.KeypadOne] = 'NUM-1',
	[Enum.KeyCode.KeypadTwo] = 'NUM-2',
	[Enum.KeyCode.KeypadThree] = 'NUM-3',
	[Enum.KeyCode.KeypadFour] = 'NUM-4',
	[Enum.KeyCode.KeypadFive] = 'NUM-5',
	[Enum.KeyCode.KeypadSix] = 'NUM-6',
	[Enum.KeyCode.KeypadSeven] = 'NUM-7',
	[Enum.KeyCode.KeypadEight] = 'NUM-8',
	[Enum.KeyCode.KeypadNine] = 'NUM-9',
	[Enum.KeyCode.KeypadZero] = 'NUM-0',
	[Enum.KeyCode.Minus] = "-",
	[Enum.KeyCode.Equals] = "=",
	[Enum.KeyCode.Tilde] = "~",
	[Enum.KeyCode.LeftBracket] = "[",
	[Enum.KeyCode.RightBracket] = "]",
	[Enum.KeyCode.RightParenthesis] = ")",
	[Enum.KeyCode.LeftParenthesis] = "(",
	[Enum.KeyCode.Semicolon] = ",",
	[Enum.KeyCode.Quote] = "'",
	[Enum.KeyCode.BackSlash] = "\\",
	[Enum.KeyCode.Comma] = ",",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Slash] = "/",
	[Enum.KeyCode.Asterisk] = "*",
	[Enum.KeyCode.Plus] = "+",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Backquote] = "`",
	[Enum.UserInputType.MouseButton1] = "MOUSE-1",
	[Enum.UserInputType.MouseButton2] = "MOUSE-2",
	[Enum.UserInputType.MouseButton3] = "MOUSE-3"
}
local function GetEnum(EnumList, EnumChild)
	local s,result = pcall(function() return EnumList[EnumChild] end)
	if not s then return end
	return result
end
local function GetKeyCode(name)
	for i,v in pairs(keys) do
		if v == name then return i end
	end
	return GetEnum(Enum.KeyCode,name) or GetEnum(Enum.UserInputType,name) or name
end
function Elements:Keybind(options)
	local options = formatTable(options)
	local mainHolder = CreateElement(self)

	local window = self._window
	local callback = options.callback or function() end

	mainHolder.Size += UDim2.new(0,0,0,1)
	create('TextLabel',{
		Name = 'Title',
		Parent = mainHolder.Parent,
		BackgroundTransparency = 1.000,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 12),
		ZIndex = mainHolder.ZIndex+1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12.000,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = options.name or ''
	})
	local keybindHolder = create("Frame",{
		Name = 'KeybindHolder',
		Parent = mainHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 75, 1, 0),
		ZIndex = mainHolder.ZIndex+2,
	})

	local btn = create('TextButton',{
		Name = 'Handler',
		Parent = keybindHolder,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 10, 1, 0),
		Position = UDim2.new(0,-5,0,0),
		ZIndex = mainHolder.ZIndex+5,
		Text = ''
	})
	SetupFrame(keybindHolder,
		{
			corner = {radius = UDim.new(0,2)},
			pad = {bottom = UDim.new(0,1),top = UDim.new(0,1),Left = UDim.new(0,8),right = UDim.new(0,8)},
			stroke = {}
		}
	)
	local keyText = create('TextLabel',{
		Parent = keybindHolder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = mainHolder.ZIndex+3,
		Font = Enum.Font.Gotham,
		Text = "NONE",
		TextColor3 = Color3.fromRGB(125, 125, 125),
		TextSize = 12,
		TextWrapped = false,
	})
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	local Update
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	window.flags[flag] = {
		Active = options.active,
		Type = options.Type or 1,
		Binding = false,
	} -- 1 toggle 2 hold

	local typechoser = create('Frame',{
		Parent = keybindHolder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5,0,0.5,0),
		Size = UDim2.new(),
		ZIndex = mainHolder.ZIndex+5,
		Visible = false,
	})
	SetupFrame(typechoser,{stroke = {},corner = {radius = UDim.new(0,2)}})
	local button1 = create('TextButton',{
		Parent = typechoser,
		BackgroundColor3 = Color3.fromRGB(125, 125, 125),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 0.5, 0),
		ZIndex = mainHolder.ZIndex+6,
		Font = Enum.Font.SourceSans,
		Text = "TOGGLE",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
	})
	local button2 = create('TextButton',{
		Parent = typechoser,
		BackgroundColor3 = Color3.fromRGB(125, 125, 125),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 0.5, 0),
		ZIndex = mainHolder.ZIndex+6,
		Font = Enum.Font.SourceSans,
		Text = "HOLD",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
	})
	
	local scroll = self._tabSector
	local scrollY = scroll.AbsoluteCanvasSize.Y

	local edgeX = scroll.AbsolutePosition.X+scroll.AbsoluteSize.X
	local sizex = 50
	local offset = 15

	local reverse = (keybindHolder.AbsolutePosition.X+keybindHolder.AbsoluteSize.X+offset >= edgeX or keybindHolder.AbsolutePosition.X+keybindHolder.AbsoluteSize.X+offset+sizex >= edgeX)

	local function UpdateVisibility(set)
		if set == false or typechoser.Visible then
			Tween(button1,0.5,'Quad','Out',{TextTransparency = 1})
			Tween(button2,0.5,'Quad','Out',{TextTransparency = 1})
			Tween(typechoser,0.5,'Quad','Out',{Position = UDim2.new(0.5,0,0.5,0),Size = UDim2.new()}).Completed:Wait()
			typechoser.Visible = false
		else
			local posY = math.clamp(keybindHolder.AbsolutePosition.Y-8,scroll.AbsolutePosition.Y,scroll.AbsolutePosition.Y+scrollY)
			typechoser.Visible = true
			Tween(button1,0.5,'Quad','Out',{TextTransparency = 0})
			Tween(button2,0.5,'Quad','Out',{TextTransparency = 0})
			Tween(typechoser,0.5,'Quad','Out',{Position = (reverse and UDim2.new(0,-65, 0, -8) or UDim2.new(1,15,0,-8)),Size = UDim2.new(0, 50, 0, 30)}).Completed:Wait()
		end
	end
	btn.MouseButton2Down:Connect(function() UpdateVisibility() end)
	button1.MouseButton1Down:Connect(function()
		window.flags[flag].Type = 1
		Update()
		UpdateVisibility(false)
	end)
	button2.MouseButton1Down:Connect(function()
		window.flags[flag].Type = 2
		Update()
		UpdateVisibility(false)
	end)
	button1.MouseEnter:Connect(function()
		if window.flags[flag].Type ~= 1 then
			Tween(button1,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
		end
	end)
	button2.MouseEnter:Connect(function()
		if window.flags[flag].Type ~= 2 then
			Tween(button2,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
		end
	end)
	button1.MouseLeave:Connect(function()
		if window.flags[flag].Type ~= 1 then
			Tween(button1,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(125,125,125)})
		end
	end)
	button2.MouseLeave:Connect(function()
		if window.flags[flag].Type ~= 2 then
			Tween(button2,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(125,125,125)})
		end
	end)
	
	local key
	local function setkey(newkey)
		local keyName = keys[newkey] or tostring(newkey):match("Enum%.%a+%.(%a+)") or newkey

		local color = (keyName == 'NONE' or keyName == '...') and Color3.fromRGB(125, 125, 125) or Color3.fromRGB(255, 255, 255)
		Tween(keyText,0.1,'Quad','In',{TextColor3 = color})
		keyText.Text = keyName
		keybindHolder.Size = UDim2.new(0,keyText.TextBounds.X+10,1,0)
		key = GetKeyCode(keyName)
		
		window.flags[flag]['Key'] = keyName
	end
	setkey('NONE')
	local defaultKey = options.key
	if defaultKey then
		if typeof(defaultKey) == 'EnumItem' then
			setkey(defaultKey)
		else
			setkey(Enum.KeyCode[defaultKey] or Enum.UserInputType.MouseButton1)
		end
	end
	Update = function()
		local val = window.flags[flag]
		
		if val.Type == 1 then
			Tween(button1,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(255,255,255)})
			Tween(button2,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(125,125,125)})
		else
			Tween(button1,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(125,125,125)})
			Tween(button2,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(255,255,255)})
		end
		callback(val)
	end
	Update()
	
	

	local bindingSignal

	btn.MouseButton1Click:Connect(function()
		window.flags[flag].Binding = true
		setkey('...')
		bindingSignal = uis.InputBegan:Connect(function(input,a)
			--if a then return end
			if input.KeyCode == Enum.KeyCode.Backspace then
				setkey('NONE')
			elseif input.KeyCode == Enum.KeyCode.Unknown then
				setkey(input.UserInputType)
			else
				setkey(input.KeyCode)
			end
			window.flags[flag].Binding = false
			bindingSignal:Disconnect()
			Update()
		end)
	end)
	Connections[math.random()] = uis.InputBegan:Connect(function(input,a)
		--if a then return end
		if key == input.KeyCode or key == input.UserInputType then
			if window.flags[flag].Type == 1 then
				window.flags[flag].Active = not window.flags[flag].Active
			else
				window.flags[flag].Active = true
			end
			Update()
		end
	end)
	Connections[math.random()] = uis.InputEnded:Connect(function(input,a)
		--if a then return end
		if key == input.KeyCode or key == input.UserInputType then
			if window.flags[flag].Type == 2 then
				window.flags[flag].Active = false
				Update()
			end
		end
	end)
	
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------

	
	local function SetValue(value)
		assert(typeof(value) == 'table')
		local value = formatTable(value)
		window.flags[flag].Binding = false
		window.flags[flag].Active = value.active
		window.flags[flag].Type = value.type or window.flags[flag].Type
		setkey(GetKeyCode(value.key or 'NONE'))
	end
	window._FlagsSet[flag] = SetValue
	
	local newmt = table.clone(self)
	newmt._holder = mainHolder
	newmt._segment = true
	setmetatable(newmt,Elements)
	return setmetatable({Set = SetValue},{__index = newmt})
end
function SetupSector(window,tab)
	SetupFrame(tab,{
		list = {pad = UDim.new(0,14),direction = 'Horizontal',horizontalalignment = 'Left',verticalalignment = 'Top'},
		pad = {top = UDim.new(0,1), left = UDim.new(0, 1),right = UDim.new(0,3)}
	})
	local rightRow = create('Frame',{
		Name = 'Row 1',
		Parent = tab,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5, -7, 1, 0),
	})
	local leftRow = create('Frame',{
		Name = 'Row 2',
		Parent = tab,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5,-7,1,0)
	})
	local _, _, rightList = SetupFrame(rightRow,{
		list = {pad = UDim.new(0,14),verticalalignment = 'Top',direction = 'Vertical'}
	})
	local _, _, leftList = SetupFrame(leftRow,{
		list = {pad = UDim.new(0,14),verticalalignment = 'Top',direction = 'Vertical'}
	})

	local function handleCanvas()
		task.wait()

		tab.CanvasSize = UDim2.new(0, 0, 0, math.max(leftList.AbsoluteContentSize.Y, rightList.AbsoluteContentSize.Y) + tab.Parent.UIPadding.PaddingTop.Offset + tab.Parent.UIPadding.PaddingBottom.Offset)
	end

	rightList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(handleCanvas)
	leftList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(handleCanvas)

	local SectionsHandler = {}
	function SectionsHandler:Sector(options)
		local options = formatTable(options)
		local row = options.side == 1 and rightRow or leftRow
		local section = create('Frame',{
			Parent = row,
			ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(30,30,30),
			BackgroundTransparency = 0.5,
			Size = UDim2.new(),
			Name = 'Sector'
		})
		SetupFrame(section,{
			list = {pad = UDim.new(0,12),direction = 'Vertical',horizontalalignment = 'Left',verticalalignment = 'Top'},
			corner = {radius = UDim.new(0,4)},
			pad = {Bottom = UDim.new(0,16),top = UDim.new(0,16),right = UDim.new(0,16),left = UDim.new(0,16)},
			stroke = {}
		})
		local list = section.UIListLayout
		list:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function(newval)
			local contentSize = list.AbsoluteContentSize.Y + 32

			section.Size = UDim2.new(1,0,0,contentSize)
			handleCanvas()
		end)
		return setmetatable(
			{
				_holder = section,
				_window = window,
				_side = options.side,
				_tabSector = tab,
				_sector = section,
				_holderSize = UDim2.new(0,100,1,0),
				_holderPosition = UDim2.new(0,80,0,0)
			},
			{__index = function(a,b) return Segment[b] or Elements[b] end}
		)
	end

	return SectionsHandler
end
local Tabs = {}
Tabs.__index = Tabs
function Tabs.normal(tabholder,window)
	local tab = create('ScrollingFrame',{
		Parent = tabholder,
		Name = 'Sector',
		LayoutOrder = #window._tabs+1,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		BottomImage = "",
		CanvasSize = UDim2.new(0, 0, 1, 0),
		ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50),
		ScrollBarThickness = 1,
		TopImage = "",
		Active = true,
		ZIndex = 3,
		Visible = false
	})


	return tab,SetupSector(window,tab)
end

local skins = {}
skins.__index = skins
function skins.new(options,window,tab)
	local options = formatTable(options)
	
	local self = setmetatable(
		{
			_window = window,
			_CurrentChoices = {},
		},
		skins
	)
	local flag = options.flag; if not flag then window._undefinedFlags += 1; flag = 'undefined_'..window._undefinedFlags end
	window.flags[flag] = {choices = {},options = {}}	
	self._flag = flag
	
	tab.Visible = false
	local background = create('Frame',{
		Parent = tab,
		Name = 'Background',
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = 0.500,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 2,
	})
	SetupFrame(background,{
		corner = {radius = UDim.new(0,4)},stroke = {}
	})
	local addframe = create('Frame',{
		Parent = tab,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 2,
		Visible = false,
	})
	local content = create('ScrollingFrame',{
		Name = 'Content',
		Parent = tab,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = true,
		ZIndex = 2,
		BottomImage = "",
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 1,
		TopImage = "",
	})
	self._ChoicesHolder = content
	do
		create('UIGridLayout',{
			Parent = content,
			CellPadding = UDim2.new(0,4,0,4),
			CellSize = UDim2.new(0,80,0,85),
			FillDirection = 'Horizontal',
			SortOrder = 'LayoutOrder'
		})
		SetupFrame(content,{pad = {top = UDim.new(0,14),bottom = UDim.new(0,14),left = UDim.new(0,12),right = UDim.new(0,11)}})

		local addbutton = create('Frame',{
			Parent = content,
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Size = UDim2.new(0, 100, 0, 100),
			ZIndex = 3,
		})
		SetupFrame(addbutton,{corner = {radius = UDim.new(0,4)},pad = {top = UDim.new(0,3),bottom = UDim.new(0,3),left = UDim.new(0,3),right = UDim.new(0,3)},stroke = {}})

		for i=0,1 do -- best for loop
			create('Frame',{
				Parent = addbutton,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, -5, 0.5, -20),
				Rotation = i*90,
				Size = UDim2.new(0, 10, 0, 40),
				ZIndex = 4,
			})
		end
		create('TextButton',{
			Parent = addbutton,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			ZIndex = addbutton.ZIndex + 1,
			Size = UDim2.new(1,0,1,0),
		}).MouseButton1Down:Connect(function()
			content.Visible = not content.Visible
			addframe.Visible = not addframe.Visible
		end)

	end
	do
		local options = create('ScrollingFrame',{
			Name = 'Options',
			Parent = addframe,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 30),
			Size = UDim2.new(1, -5, 1, -30),
			ZIndex = 3,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 1,
		})
		SetupFrame(options,{list = {pad = UDim.new(0,5),horizontalalignment = 'Left',direction = 'Vertical',SortOrder = 'Name',Verticalalignment = 'Top'},pad = {bottom = UDim.new(0,10),top = UDim.new(0,10),right = UDim.new(0,15),left = UDim.new(0,15)}})
		self._OptionsHolder = options
		local menu = create('Frame',{
			Parent = addframe,
			Name = 'Menu',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 3,
		})
		SetupFrame(menu,{
			corner = {radius = UDim.new(0,4)},
			list = {pad = UDim.new(0,6),direction = 'Horizontal',order = 'LayoutOrder',HorizontalAlignment = 'Left',verticalalignment = 'Top'},
			pad = {top = UDim.new(0,5),bottom = UDim.new(0,5),left = UDim.new(0,5),right = UDim.new(0,5)},
			stroke = {}
		})
		
		local add = create('Frame',{
			Parent = menu,
			Name = 'Add',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Size = UDim2.new(0, 140, 1, 0),
			ZIndex = 4,
		})
		
		local back = create('Frame',{
			Parent = menu,
			Name = 'Back',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Size = UDim2.new(0, 60, 1, 0),
			ZIndex = 4,
		})
		
		local search = create('Frame',{
			Parent = menu,
			Name = 'Search',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = 3,
			Size = UDim2.new(0, 200, 1, 0),
			ZIndex = 4,
		})
		SetupFrame(add,{corner = {radius = UDim.new(0,2)},stroke = {}})
		SetupFrame(back,{corner = {radius = UDim.new(0,2)},stroke = {}})
		SetupFrame(search,{corner = {radius = UDim.new(0,2)},stroke = {}})
		
		create('TextButton',{
			Parent = back,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 1),
			Size = UDim2.new(1, 0, 1, 0),
			ZIndex = 4,
			Font = Enum.Font.GothamMedium,
			Text = "Back",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14.000,
		}).MouseButton1Down:Connect(function()
			content.Visible = true
			addframe.Visible = false
		end)
		create('TextButton',{
			Parent = add,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 3),
			TextScaled = true,
			TextWrapped = true,
			Size = UDim2.new(1, 0, 1, -5),
			ZIndex = 4,
			Font = Enum.Font.GothamMedium,
			Text = "Add Selected (0)",
			TextColor3 = Color3.fromRGB(125, 125, 125),
			TextSize = 14.000,
		}).MouseButton1Down:Connect(function()
			return self:_HandleChoices()
		end)
		local searchbox = create('TextBox',{
			Parent = search,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 5, 0, 3),
			Size = UDim2.new(1, -5, 1, -5),
			TextScaled = true,
			ZIndex = 5,
			Font = Enum.Font.GothamMedium,
			Text = "Search",
			TextColor3 = Color3.fromRGB(125, 125, 125),
			TextSize = 14.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		local isEmpty = true
		local ignore = false
		searchbox.Focused:Connect(function()
			searchbox.TextColor3 = Color3.fromRGB(255, 255, 255)
			if isEmpty then
				searchbox.Text = ''
			end
		end)
		searchbox.FocusLost:Connect(function()
			searchbox.ClearTextOnFocus = searchbox.Text == ''
			isEmpty = searchbox.Text == ''
			if searchbox.Text == '' then
				searchbox.TextColor3 = Color3.fromRGB(125,125,125)
				ignore = true
				searchbox.Text = 'Search'
			end
		end)
		searchbox:GetPropertyChangedSignal('Text'):Connect(function()
			if ignore then
				ignore = false
				isEmpty = true
			else
				isEmpty = searchbox.Text == ''
			end
			for i,v in pairs(options:GetChildren()) do
				if not v:IsA('Frame') then continue end
	
				if v.Name:match(searchbox.Text) or isEmpty then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end)
	end
	
	self:AddOptions(options.options or {})
	self:AddChoices(options.choices or {})
end
function skins:AddOption(suffix,option)
	local holder = self._OptionsHolder
	local option = formatTable(option)
	local name = option.name or ''
	local window = self._window
	local flag = self._flag
	
	local suffix = suffix or ''
	
	local holder = create('Frame',{
		Parent = holder,
		Name = (suffix or '')..' | '..(name or ''),
		LayoutOrder = #holder:GetChildren()-1,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 0, 40),
		ZIndex = 4,
	})
	SetupFrame(holder,{pad = {bottom = UDim.new(0,5),top = UDim.new(0,5),left = UDim.new(),right = UDim.new(0,5)}})
	create('ImageLabel',{
		Parent = holder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 30, 1, 0),
		ZIndex = 4,
		Image = option.image or '',
	})
	create('TextLabel',{
		Parent = holder,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 35, 0, 0),
		Size = UDim2.new(0, 200, 1, 0),
		ZIndex = 4,
		Font = Enum.Font.GothamMedium,
		Text = (suffix or '')..' | '..(name or ''),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14.000,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	local button = create('Frame',{
		Name = 'Button',
		Parent = holder,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -75, 0, 0),
		Size = UDim2.new(0, 75, 1, 0),
		ZIndex = 4,
	})
	SetupFrame(button,{corner = {radius = UDim.new(0,2)},stroke = {}})
	
	window.flags[self._flag].options[suffix] = window.flags[self._flag].options[suffix] or {}
	local data = {image = option.image or '',name = option.name or ''}
	table.insert(window.flags[self._flag].options[suffix],data)
	local id = #window.flags[self._flag].options[suffix]
	local btn = create('TextButton',{
		Name = 'Button',
		Parent = button,
		BackgroundColor3 = Color3.fromRGB(200, 200, 200),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 4,
		Font = Enum.Font.GothamMedium,
		Text = "ADD",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14.000,
	})
	btn.MouseButton1Down:Connect(function()
		if window.flags[flag].choices[suffix] and window.flags[flag].choices[suffix].name == data.name then return end
		if self._CurrentChoices[suffix] then
			self._CurrentChoices[suffix] = nil
			self:_SetSelection(self:_GetSelection()-1)
			Tween(btn,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
		else
			self._CurrentChoices[suffix] = data

			self:_SetSelection(self:_GetSelection()+1)
			Tween(btn,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(125,125,125)})
		end
		self:FilterOptions()
	end)
	btn.MouseEnter:Connect(function()
		if self._CurrentChoices[suffix] ~= data and (not window.flags[flag].choices[suffix] or window.flags[flag].choices[suffix].name ~= data.name) then
			Tween(btn,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(255,255,255)})
		end
	end)
	btn.MouseLeave:Connect(function()
		if self._CurrentChoices[suffix] ~= data and (not window.flags[flag].choices[suffix] or window.flags[flag].choices[suffix].name ~= data.name) then
			Tween(btn,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
		end
	end)
end
function skins:AddChoice(suffix,data)
	if self._window.flags[self._flag].choices[suffix] then return end
	local holder = self._ChoicesHolder
	local option = formatTable(data)
	local frame = create('Frame',{
		Parent = holder,
		LayoutOrder = #holder:GetChildren()-1,
		Name = 'Choice',
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 100, 0, 100),
		ZIndex = 3,
	})
	SetupFrame(frame,{corner = {radius = UDim.new(0,4)},pad = {Bottom = UDim.new(0,3),top = UDim.new(0,3),right = UDim.new(0,3),left = UDim.new(0,3)},stroke = {}})
	local button = create('ImageButton',{
		Parent = frame,
		BackgroundColor3 = Color3.fromRGB(200, 200, 200),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 4,
		Image = option.image or ''
	})
	button.MouseButton1Down:Connect(function()
		self._window.flags[self._flag].choices[suffix] = nil
		frame:Destroy()
		self:FilterOptions()
	end)
	self._window.flags[self._flag].choices[suffix] = option

end
function skins:AddChoices(options)
	for i,v in pairs(options) do
		for _,v2 in pairs(v) do
			self:AddChoice(i,v2)
		end
	end
end
function skins:AddOptions(options)
	for i,v in pairs(options) do
		for _,v2 in pairs(v) do
			self:AddOption(i,v2)
		end
	end
end
function skins:_HandleChoices()
	for i,v in pairs(self._CurrentChoices) do
		self:AddChoice(i,v)
	end
	
	table.clear(self._CurrentChoices)
	self:FilterOptions()
	self:_SetSelection(0)
end
function skins:_SetSelection(n)
	local text = "Add Selection ("..n..')'
	self._OptionsHolder.Parent.Menu.Add.TextButton.Text = text
	Tween(self._OptionsHolder.Parent.Menu.Add.TextButton,0.2,'Quad','Out',{TextColor3 = tonumber(n) == 0 and Color3.fromRGB(125,125,125) or Color3.fromRGB(255,255,255)})
end
function skins:_GetSelection()
	return self._OptionsHolder.Parent.Menu.Add.TextButton.Text:match("%d+")
end


function skins:FilterOptions()
	for i,v in pairs(self._OptionsHolder:GetChildren()) do
		if not v:IsA('Frame') then continue end
		local data = v.Name:split(' | ')
		local value = self._CurrentChoices[data[1]]
		local value2 = self._window.flags[self._flag].choices[data[1]]
		if (value and value.name ~= data[2]) or (value2 and value2.name ~= data[2]) then
			v.Visible = false
			Tween(v.Button.Button,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
		else
			if not (value or value2) then
				Tween(v.Button.Button,0.2,'Quad','Out',{TextColor3 = Color3.fromRGB(200,200,200)})
			end
			v.Visible = true
		end
	end
end

function Tabs.skins(tabholder,window,options) -- whatever name it yourself
	local options = formatTable(options)
	
	return tabholder,skins.new(options,window,tabholder)
end

local Notify = {}
Notify.__index = Notify
function Notify.new(options,notifsholder)
	local options = typeof(options) == 'table' and formatTable(options) or {text=tostring(options)}
	local holder = create('Frame',{
		Parent = notifsholder,
		Name = 'Holder',
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(50, 0, 0, 20),
		ZIndex = 3,
		ClipsDescendants = true,
	})
	SetupFrame(holder,{corner = {radius = UDim.new(0,4)},stroke = {}})
	
	options.color = options.color or Color3.fromRGB(255,255,255)
	options.time = options.time or 1.3
	
	if options.grad ~= false then
		create('Frame',{
			Name = 'Color',
			Parent = holder,
			BackgroundColor3 = options.color,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 1),
			Size = UDim2.new(0, 1, 1, -2),
			ZIndex = 4,
		})
		create('Frame',{
			Name = 'Color2',
			Parent = holder,
			BackgroundColor3 = options.color,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0,1,0,0),
			Size = UDim2.new(0, 1, 1, 0),
			ZIndex = 4,
		})
	end
	local text = create('TextLabel',{
		Parent = holder,
		Name = 'Text',
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 7, 0, 0),
		Size = UDim2.new(1, -10, 1, 0),
		ZIndex = 4,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14.000,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = options.text or ''
	})
	
	holder.Size = UDim2.new(0,text.TextBounds.X+15,0,25)
	
	local mt = setmetatable({_holder = holder,_options = options},Notify)
	task.spawn(Notify[options.style and options.style:lower() or 'normal'],mt)
	return mt
end
function Notify:_Animate()
	local signals = {
		OnFinish = Signal.new(),
		OnAnimation = Signal.new(),
	}
	coroutine.wrap(function()
		local size = self._holder.AbsoluteSize
		self._holder.Size = UDim2.new(0,0,0,size.Y)

		Tween(self._holder,0.6,'Quad','Out',{Size = UDim2.new(0,size.X,0,size.Y)})

		wait(self._options.time)
		
		signals.OnAnimation:Fire()
		Tween(self._holder,0.2,'Quad','Out',{BackgroundTransparency = 1,Position = UDim2.new(-1,0,0,0)})
		Tween(self._holder.Color,0.2,'Quad','Out',{BackgroundTransparency = 1})
		Tween(self._holder.Stroke,0.2,'Quad','Out',{Transparency = 1})
		Tween(self._holder.Color2,0.2,'Quad','Out',{BackgroundTransparency = 1})
		local t = Tween(self._holder.Text,0.2,'Quad','Out',{TextTransparency = 1})
		t.Completed:Wait()
		
		signals.OnFinish:Fire()
		self._holder:Destroy()
	end)()
	return signals
end
function Notify:normal()
	return self:_Animate()
end
function Notify:warning()
	local shouldbreak = false
	local grad,grad2 = self._holder.Color,self._holder.Color2
	coroutine.wrap(function()
		local a = 0
		while not shouldbreak do
			Tween(grad,0.25,'Linear','In',{BackgroundColor3 = Color3.new() or self._options.color})
			local t = Tween(grad2,0.25,'Linear','In',{BackgroundColor3 = Color3.new() or self._options.color})
			t.Completed:Wait()
			a+=1
		end
	end)()

	local signals = self:_Animate()
	signals.OnFinish:Connect(function()
		shouldbreak = true
	end)
	return signals
end
function Notify:time()
	local shouldbreak = false
	local time = self._options.time
	local timer = create('Frame',{
		Parent = self._holder,
		Position = UDim2.new(0,2,1,-1),
		Size = UDim2.new(0,0,0,1),
		BackgroundColor3 = self._options.color,
		ZIndex = 4,
		BorderSizePixel = 0,
	})
	local ct = 0
	local loop = rs.RenderStepped:Connect(function(dt)
		ct += dt
		timer.Size = UDim2.new(math.min(ct/time,1),-6,0,1)
	end)

	local signals = self:_Animate()
	signals.OnAnimation:Connect(function()
		loop:Disconnect()
		Tween(timer,0.2,'Quad','Out',{BackgroundTransparency = 1})
	end)
	return signals
end
function Notify:loading()
	local shouldbreak = false
	local grad,grad2 = self._holder.Color,self._holder.Color2
	local bar = create('Frame',{
		Parent = self._holder,
		Position = UDim2.new(0,1,1,-1),
		Size = UDim2.new(0,0,0,1),
		BackgroundColor3 = self._options.color,
		ZIndex = 4,
		BorderSizePixel = 0,
	})
	coroutine.wrap(function()
		local a = 0
		while not shouldbreak do
			local sizex = self._holder.AbsoluteSize.X/3
			local x = (sizex/2)
			
			local t = Tween(bar,0.6,'Linear','Out',{Position = UDim2.new(0.5,a%2 == 0 and x or -x,1,-1),Size = UDim2.new(0,a%2 == 0 and -sizex or sizex,0,1)})
			t.Completed:Wait()
			local t = Tween(bar,0.6,'Quad','Out',{Position = a%2==0 and UDim2.new(1,-2,1,-1) or UDim2.new(0,2,1,-1),Size = UDim2.new(0,1,0,1)})
			t.Completed:Wait()
			a+=1
			task.wait(.15)
		end
	end)()

	local signals = self:_Animate()
	signals.OnAnimation:Connect(function()
		shouldbreak = true
		Tween(bar,0.2,'Quad','Out',{BackgroundTransparency = 1})
	end)
	return signals
end
function Notify:SetText(text)
	self._holder.Text.Text = text
	self._holder.Size = UDim2.new(0,self._holder.Text.TextBounds.X+10,0,25)
end
local Watermark = {}
Watermark.__index = Watermark
function Watermark.new(watermark,options)
	local mt = setmetatable({_watermark = watermark},Watermark)

	mt:Edit(options or {})
	return mt
end
function Watermark:Edit(options) -- background, textcolor, richtext
	local options = formatTable(options)
	if options.text then
		self._watermark.Text.Text = tostring(options.text)
	end
end
function ui:Init(options)
	local options = formatTable(options)

	local parent = options.parent or script.Parent or game:GetService('CoreGui')

	local UIsHolder = create('ScreenGui',{
		Name = 'UIHolder',
		Parent = parent,
		ZIndexBehavior = 'Global',
		ResetOnSpawn = false
	})

	function ui:Unload()
		for _, connection in next, Connections do
			connection:Disconnect()
		end
		
		UIsHolder:Destroy()
	end

	function ui:SetToggled(bool)
		UIsHolder.Enabled = bool
	end

	function ui:Toggle()
		self:SetToggled(not UIsHolder.Enabled)
	end

	function ui:Watermark(options)
		local options = formatTable(options)

		local text = options.text or 'Lynx'

		local watermark = create('Frame',{
			Name = "Watermark",
			Parent = UIsHolder,
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 32, 0, 32),
			Size = UDim2.new(0, 32, 0, 32),
		})
		Dragify(watermark)
		SetupFrame(watermark, {
			corner = {radius = UDim.new(0, 8)},
			pad = {bottom = UDim.new(0, 8), top = UDim.new(0, 8), left = UDim.new(0, 16), right = UDim.new(0, 16)},
			stroke = {}
		})

		local text = create('TextLabel', {
			Name = "Text",
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			RichText = true,
			Text = text,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextScaled = false,
			TextWrapped = false,
			TextXAlignment = "Left",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Parent = watermark
		})

		text:GetPropertyChangedSignal('TextBounds'):Connect(function()
			task.wait()

			local bounds = text.TextBounds
			watermark.Size = UDim2.new(0, bounds.X + 32, 0, bounds.Y + 16)
		end)
		
		return Watermark.new(watermark,options)
	end
	do
	--super duper cool uilistlayout
		local notifs = create("ScreenGui",{
			Parent = UIsHolder.Parent,
			Name = 'Notifications'
		})
		local notifsholder = create('Frame',{
			Name = 'NotificationsHolder',
			Parent = notifs,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 50, 0, 50),
			Size = UDim2.new(0, 34, 50, 0),
			ZIndex = 2,
		})
		local childs = {}
		local offsets = {}
		notifsholder.ChildAdded:Connect(function(child)
			if child.Name == 'Holder' then
				local y = #childs*30 -- was meant to have getpropchangedsignal but lazy to change allat
				child.Position = UDim2.new(0,child.AbsolutePosition.X,0,y)
				table.insert(childs,child)
				offsets[child] = y
			end
		end)
		notifsholder.ChildRemoved:Connect(function(child)
			if child.Name == 'Holder' then
				local t = table.find(childs,child)
				local curY = offsets[child]

				for i=t+1,#childs do
					local child = childs[i]

					local oldy = curY
					curY = offsets[child]
					offsets[child] = oldy
					Tween(child,0.2,'Quad','Out',{Position = UDim2.new(0,child.AbsolutePosition.X-notifsholder.AbsolutePosition.X,0,oldy)})
				end
				offsets[child] = nil
				table.remove(childs,t)
			end
		end)
		function ui:Notify(options)
			return Notify.new(options,notifsholder)
		end
	end
	
	function ui:SetupLoader(options)
		local options = formatTable(options)

		local span = options.time or 2

		local loaderFrame = create('Frame',{
			Parent = UIsHolder,
			Name = 'Loading',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, -50, 0.5, -50),
			Size = UDim2.fromOffset(100, 100),
		})

		SetupFrame(loaderFrame, {
			corner = {radius = UDim.new(1, 0)},
			pad = {bottom = UDim.new(0, 16),top = UDim.new(0, 16),left = UDim.new(0, 16),right = UDim.new(0, 16)}
		})

		local circle = create('ImageLabel', {
			Name = "Circle",
			Image = "rbxassetid://6331335348",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			Parent = loaderFrame		
		})

		local startTick = tick()

		task.spawn(function()
			while task.wait() do
				if tick() - startTick >= (span - 2) then 
					task.spawn(function()
						Tween(circle, 0.1, 'Quad', 'In', {ImageTransparency = 1})
						task.wait(.1)
						circle.Rotation = 0
						circle.Image = 'rbxassetid://1202200114'
						Tween(circle, 0.1, 'Quad', 'In', {ImageTransparency = 0})
						task.wait(1)
						Tween(loaderFrame, 0.2, 'Quad', 'In', {BackgroundTransparency = 1})
						Tween(circle, 0.2, 'Quad', 'In', {ImageTransparency = 1})
						task.wait(.9)
						loaderFrame:Destroy()
					end)
					break 
				end

				circle.Rotation = (circle.Rotation + 5) % 360
			end
		end)
	end

	function ui:NewWindow(options)
		local options = formatTable(options)

		local windowOptions = formatTable(options.window)
		local windowName = windowOptions.name or 'Lynx'
		local windowDescription = windowOptions.description or 'Universal'

		local userOptions= formatTable(options.user)
		local username = userOptions.name or 'Finobe'
		local role = userOptions.role or 'Developer'
		local icon = userOptions.icon



		local windowFrame = create('Frame',{
			Parent = UIsHolder,
			Name = 'Window',
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BackgroundTransparency = 0.030,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(0, 640, 0, 500),
		})
		windowFrame.Position = UDim2.new(0.5, -windowFrame.AbsoluteSize.X/2, 0.5, -windowFrame.AbsoluteSize.Y/2)

		SetupFrame(windowFrame,{
			corner = {radius = UDim.new(0,8)},
			stroke = {Color = Color3.fromRGB(40,40,40)}
		})
		local sideBar = create('Frame',{
			Parent = windowFrame,
			Name = 'Sidebar',
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1.000,
			Size = UDim2.new(0.270000011, 0, 1, 0),
			BorderSizePixel = 0,
		})
		Dragify(windowFrame,sideBar)
		local window = {
			_tabs = {},
			_undefinedFlags = 0,
			_FlagsSet = {},
			_DefaultFlags = {},
			flags = {},
		}
		window['Flags'] = window.flags
		function window:SaveConfig(name)
			local cfg = {}
			for i,v in pairs(window.flags) do
				local val = v
				if typeof(v) == 'table' and v.Color and typeof(v.Color) == 'Color3' then
					val = {Color = {R = v.Color.R,G=v.Color.G,B=v.Color.B},Alpha = v.Alpha}
				end
				cfg[i] = val
			end
			return hs:JSONEncode(cfg)
		end
		function window:LoadConfig(input)
			local load = hs:JSONDecode(input)
			for flag,val in pairs(load) do
				if typeof(val) == 'table' and typeof(val.Color) == 'table' then
					val.Color = Color3.new(val.Color.R,val.Color.G,val.Color.B)
				end
				if window._FlagsSet[flag] then
					window._FlagsSet[flag](val)
				end
			end
		end
		do -- content setup
			local content = create('Frame',{
				Name = 'Content',
				Parent = sideBar,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 1, 0),            
			})
			create('UIPadding',{
				Parent = content,
				PaddingBottom = UDim.new(0, 16),
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
				PaddingTop = UDim.new(0, 16),
			})	
			---------------------------------------------------------
			local windowsInfo = create('Frame',{
				Parent = content,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0.150000006, -16),
			})
			create('UIListLayout',{
				Parent = windowsInfo,
				Padding = UDim.new(0,4),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			})
			create('TextLabel',{
				Name = 'a_name',
				Parent = windowsInfo,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 18),
				Font = Enum.Font.GothamBlack,
				Text = windowName,
				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Bottom,
			})
			create('TextLabel',{
				Name = 'b_Description',
				Parent = windowsInfo,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 18),
				Font = Enum.Font.Gotham,
				Text = windowDescription,
				RichText = true,
				TextColor3 = Color3.fromRGB(108, 108, 108),
				TextSize = 14.000,
				TextStrokeColor3 = Color3.fromRGB(92, 92, 92),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
			})
			------------------------------------------------------------
			local userInfo = create('Frame',{
				Name = 'UserInfo',
				Parent = content,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.9, 0),
				Size = UDim2.new(1, 0, 0.1, 0),	
			})
			SetupFrame(userInfo,{list = {pad = UDim.new(0,16),sort = 'LayoutOrder',direction = 'Horizontal',horizontalalignment = 'Left'}})

			if icon then
				SetupFrame(create('ImageLabel',{
					Name = 'Img',
					Parent = userInfo,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.5, -12),
					Size = UDim2.new(0, 24, 0, 24),
					Image = icon,
				}),{corner = {radius = UDim.new(1,0),stroke = {}}})
			end

			local info = create('Frame',{
				Name = 'Info',
				Parent = userInfo,
				BackgroundTransparency = 1.000,
				BorderSizePixel = 0,
				Position = UDim2.new(0, icon and 56 or 0, 0, 0),
				Size = UDim2.new(1, icon and -40 or 0, 1, 0),
			})
			SetupFrame(info,{list = {pad = UDim.new(0,4)}})
			create('TextLabel',{
				Parent = info,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 56, 0.5, -18),
				Size = UDim2.new(1, 0, 0, 14),
				Font = Enum.Font.GothamBold,
				Text = username,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14.000,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Bottom,		
			})
			create('TextLabel',{
				Parent = info,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 56, 0.5, -18),
				Size = UDim2.new(1, 0, 0, 14),
				Font = Enum.Font.Gotham,
				Text = role,
				TextColor3 = Color3.fromRGB(108, 108, 108),
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
			})


			--------------------------------------------------------------
			local tabs = create('ScrollingFrame',{
				Name = 'Tabs',
				Parent = content,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.150000006, 0),
				Selectable = false,
				Size = UDim2.new(1, 0, 0.75, -24),
				BottomImage = "",
				CanvasSize = UDim2.new(0, 0, 0, 145),
				ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50),
				ScrollBarThickness = 1,
				TopImage = "",
			})
			local _, _, list, pad = SetupFrame(tabs,{
				list = {pad = UDim.new(0,8),VerticalAlignment = 'Top'},
				Pad = {left = UDim.new(0,1),top = UDim.new(0,1), right = UDim.new(0, 8)}
			})

			list:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				task.wait()
				local abs = list.AbsoluteContentSize
				tabs.CanvasSize = UDim2.new(0, abs.X, 0, abs.Y)
			end)

			
			local function _tween(fp, is)
				Tween(fp, 0.25, 'Quad', 'In', {BackgroundTransparency = is and 0 or 1})
				Tween(fp:FindFirstChildOfClass('UIStroke'), 0.25, 'Quad', 'In', {Transparency = is and 0 or 1})
			end
			function window:Tab(options)
				local options = formatTable(options)
				
				local type = options.type and options.type:lower() or 'normal'
				local icon = options.icon

				----------------------------------------------------------------------------------
				local section = create('Frame',{
					Name = ('1'):rep(#tabs:GetChildren()-1),
					Parent = tabs,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, -1, 0, 32),
					ZIndex = 2,
				})

				local _clickHandler = create('TextButton', {
					Name = 'Handler',
					Parent = section,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 5,
					Size = UDim2.new(1, 0, 1, 0),
					Text = '',
				})

				local tab_a = create('Frame',{
					Name = 'Tab',
					Parent = section,
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
				})
				local _,stroke,_,_ = SetupFrame(tab_a,{
					corner = {radius = UDim.new(0,4)},
					list = {pad = UDim.new(0,8),horizontalalignment = 'Left',verticalalignment = 'Center',direction = 'Horizontal'},
					pad = {bottom = UDim.new(0,10),top = UDim.new(0,10),left = UDim.new(0,10),right = UDim.new(0,10)},
					stroke = {}
				})
				stroke.Transparency = 1

				if icon then
					create('ImageLabel',{
						Name = 'a_icon',
						Parent = tab_a,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1.000,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(0, 16, 1, 0),
						ZIndex = 4,
						Image = icon,
						ScaleType = Enum.ScaleType.Fit,
					})
				end
				create('TextLabel',{
					Name = 'b_text',
					Parent = tab_a,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, icon and -28 or 0, 1, 0),
					ZIndex = 4,
					Font = Enum.Font.GothamMedium,
					Text = options.name or '[NO NAME]',
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
				----------------------------------------------------------------------------------
				local tabHolder = create('Frame',{
					Parent = windowFrame,
					Name = 'SectorHolder_'..(#window._tabs+1),
					Size = UDim2.new(0.73, 0,1, 0),
					Position = UDim2.new(0.27,0,0,0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
				})

				SetupFrame(tabHolder, {
					pad = {bottom = UDim.new(0,14),top = UDim.new(0,14),right = UDim.new(0,14),left = UDim.new(0,14)}
				})
				local tab,funcs = Tabs[type](tabHolder,window,options)
				_clickHandler.MouseButton1Down:Connect(function()
					if window._CurrentTab[1] ~= section then

						task.spawn(function()
							_tween(window._CurrentTab[1].Tab, false)
							window._CurrentTab[2].Visible = false
							window._CurrentTab[2].ZIndex -= 1	

							window._CurrentTab = {section,tab}
							tab.ZIndex += 1
							_tween(section.Tab, true)
						end)
						tab.Visible = true
					end
				end)
				if not window._CurrentTab then
					window._CurrentTab = {section,tab}

					_tween(window._CurrentTab[1].Tab, true)
					tab.Visible = true
					tab.ZIndex += 1
				end


				table.insert(window._tabs,tab)
				return funcs
			end
			function window:Separator()
				create('Frame',{
					Name = 'Separator',
					Parent = create('Frame',{
						Name = ('1'):rep(#tabs:GetChildren()-1),
						Parent = tabs,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, -1, 0, 32),
						ZIndex = 2,
					}),
					BackgroundColor3 = Color3.fromRGB(40, 40, 40),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 0, 1),
				})
			end
		end
		create('Frame',{
			Name = "Separator",
			Parent = sideBar,
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.new(0, 1, 1, 0),
		})


		return window
	end
end
-- UI END 
ui:Init()
--
ui:SetupLoader({time = 2})
--
Wait(2)
--
local Window = ui:NewWindow{window = {Name = [[<b>osiris.<font color="rgb(220, 20, 60)">cool</font></b>]], Description = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name}, User = {Name = LocalPlayer.Name,Role = 'Buyer Build'}}
local flags = Window.flags
-- Functions , Renders 
local Backtrack = Instance.new("Folder")
Backtrack.Parent = Workspace.Terrain 
Backtrack.Name = "Backtrack"
-- 
local NovaPart = game:GetObjects("rbxassetid://14745759584")[1]; NovaPart.Parent = game:GetService("ReplicatedStorage");
local Nova = NovaPart.Attachment 
-- 
local HitChams = Instance.new("Folder")
HitChams.Parent = Workspace.Terrain 
HitChams.Name = "HitChams"
-- 
local VisualizeCFrame = game:GetObjects("rbxassetid://8246626421")[1]; VisualizeCFrame.Humanoid:Destroy(); VisualizeCFrame.Head.Face:Destroy(); VisualizeCFrame.Parent = game.Workspace; VisualizeCFrame.HumanoidRootPart.Velocity = Vector3.new(); VisualizeCFrame.HumanoidRootPart.CFrame = CFrame.new(9999,9999,9999); VisualizeCFrame.HumanoidRootPart.Transparency = 1; VisualizeCFrame.HumanoidRootPart.CanCollide = false; local hitmodule = game:GetObjects("rbxassetid://7255773215")[1]; hitmodule.Parent = game:GetService("ReplicatedStorage")
-- 
for i,v in pairs(VisualizeCFrame:GetChildren()) do 
	if v:IsA("BasePart") then 
		v.CanCollide = false 
		v.Material = Enum.Material.Neon 
		v.Transparency= 0.99
	end 
end 
-- 
local Chams = {} 
do 
	function Lynx:Cham_Character(Player, Color1, Color2, Fill1, Fill2) 
		local Highlight = NewInstance("Highlight", Highlights)
		Highlight.Adornee = Player.Character
		Highlight.Enabled = true
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.FillColor = Color1
		Highlight.OutlineColor = Color2
		Highlight.OutlineTransparency = Fill1
		Highlight.FillTransparency = Fill2
		-- 
		Chams[Player] = Highlight
		-- 
		Player.CharacterAdded:Connect(function(Character)
			Highlight.Adornee = Character 
			Highlight.Parent = game.CoreGui 
		end)
	end 

	function Lynx:Cham_Remove(Player)
		if Player and Chams[Player] then 
			Chams[Player]:Destroy()
			Chams[Player].Parent = nil 
			Chams[Player].Adornee = nil 
		end 
	end 
	-- 
	function Lynx:PlayerDraw(Type, Outline, Name, Filled)
        local drawing = Drawing.new(Type)
        for i, v in pairs(Visuals["Settings"][Type]) do
            drawing[i] = v
        end
        --
        if Outline then
            drawing.Color = Color3.new(0,0,0)
            drawing.Thickness = 3
        end
        --
        if Filled then 
            drawing.Filled = true 
        end 
        --
        return drawing
    end
    -- 
    function Lynx:Add(Player)
        if not Visuals["Drawings"][Player] then
            Visuals["Drawings"][Player] = {
                Name = Lynx:PlayerDraw("Text", nil, "Name", false),
                Tool = Lynx:PlayerDraw("Text", nil, "Tool", false),
                BoxOutline = Lynx:PlayerDraw("Square", true, "BoxOutline", false),
                Box = Lynx:PlayerDraw("Square", nil, "Box",false),
                HealthOutline = Lynx:PlayerDraw("Square", false, "HealthOutline", false),
                Health = Lynx:PlayerDraw("Square", nil, "Health", false),
                HealthText = Lynx:PlayerDraw("Text",nil, "HealthText", false),
                HealthBarGradient = Lynx:PlayerDraw("Image", nil, "HealthBarGradient", false), 
                BoxFill = Lynx:PlayerDraw("Square", nil, "BoxFill", true),
                ArmorBar = Lynx:PlayerDraw("Line", nil, "ArmorBar", false),
                ArrowOutline = Lynx:PlayerDraw("Triangle", false, "ArrowOutline", false),
                Arrow = Lynx:PlayerDraw("Triangle", nil, "Arrow", false),
				Flag = Lynx:PlayerDraw("Text",nil, "Flag", false)
            }
            -- 
            Visuals["Drawings"][Player]["Corners"] = {}
            -- 
            for Index = 9, 16 do
                Visuals["Drawings"][Player]["Corners"][Index] = Lynx:PlayerDraw("Line", nil, "Corners", false)
                Visuals["Drawings"][Player]["Corners"][Index].Thickness = 3
            end
            --
            for Index = 1, 8 do
                Visuals["Drawings"][Player]["Corners"][Index] = Lynx:PlayerDraw("Line", nil, "Corners", false)
                Visuals["Drawings"][Player]["Corners"][Index].Thickness = 0 
            end
        end
    end
	-- 
	function HitMarker(Gap, Color, Time) 
        local Lines = {} 
        -- 
        for i = 1, 4 do 
            Lines[i] = Lynx:newDrawing("Line", {Color = Color, Visible = true, Transparency = 1, Thickness = 1})
        end 
        -- 
        Lines[1].From = Vector2.new(Mouse.X + Gap, (Mouse.Y + 36) + Gap)
        Lines[1].To = Vector2.new(Mouse.X + (Gap * 2.5), (Mouse.Y + 36) + (Gap * 2.5))
        --
        Lines[2].From = Vector2.new(Mouse.X + Gap, (Mouse.Y + 36) - Gap)
        Lines[2].To = Vector2.new(Mouse.X + (Gap * 2.5), (Mouse.Y + 36) - (Gap * 2.5))
        --
        Lines[3].From = Vector2.new(Mouse.X - Gap, (Mouse.Y + 36) + Gap)
        Lines[3].To = Vector2.new(Mouse.X - (Gap * 2.5), (Mouse.Y + 36) + (Gap * 2.5))
        --
        Lines[4].From = Vector2.new(Mouse.X - Gap, (Mouse.Y + 36) - Gap)
        Lines[4].To = Vector2.new(Mouse.X - (Gap * 2.5), (Mouse.Y + 36) - (Gap * 2.5))
        -- 
        delay(Time, function()
            for i = Time, 0, -0.1 do
                task.wait()
                for _, Value in next, Lines do
                    Value.Transparency = i
                end
            end
            -- 
            for _, Value in next, Lines do
                Value:Remove()
            end
        end)
    end 
    -- 
    function HitMarker3D(Gap, Color, Time, Hit) 
        local Lines = {} 
        -- 
        for i = 1, 4 do 
            Lines[i] = Lynx:newDrawing("Line", {Color = Color, Visible = true, Transparency = 1, Thickness = 1})
        end     
        -- 
        local Loop = RunService.RenderStepped:Connect(function()
            local Position3D, OnScreen = Camera:WorldToViewportPoint(Hit)
            -- 
			Lines[1].From = Vector2.new(Position3D.X + Gap, Position3D.Y + Gap)
			Lines[1].To = Vector2.new(Position3D.X + (Gap * 2.5), Position3D.Y + (Gap * 2.5))
			--
			Lines[2].From = Vector2.new(Position3D.X + Gap, Position3D.Y - Gap)
			Lines[2].To = Vector2.new(Position3D.X + (Gap * 2.5), Position3D.Y - (Gap * 2.5))
			--
			Lines[3].From = Vector2.new(Position3D.X - Gap, Position3D.Y + Gap)
			Lines[3].To = Vector2.new(Position3D.X - (Gap * 2.5), Position3D.Y + (Gap * 2.5))
			--
			Lines[4].From = Vector2.new(Position3D.X - Gap, Position3D.Y - Gap)
			Lines[4].To = Vector2.new(Position3D.X - (Gap * 2.5), Position3D.Y - (Gap * 2.5))
			-- 
			for _, Value in next, Lines do
				Value.Visible = OnScreen
			end
        end)
        -- 
        delay(Time, function()
            for i = Time, 0, -0.1 do
                task.wait()
                for _, Value in next, Lines do
                    Value.Transparency = i
                end
            end
            -- 
            for _, Value in next, Lines do
                Value:Remove()
            end
            Loop:Disconnect()
        end)
    end 
	--
	function Lynx:HitEffect(Type, Character)
		local function convert(color)
			return color.r/5, color.g/5, color.b/5
		end 
		-- 
		local function Weld(x,y)
			local W = Instance.new("Weld")
			W.Part0 = x
			W.Part1 = y
			local CJ = CFrame.new(x.Position)
			local C0 = x.CFrame:inverse()*CJ
			local C1 = y.CFrame:inverse()*CJ
			W.C0 = C0
			W.C1 = C1
			W.Parent = x
		end
		-- 
		if Type == "Confetti" then 
			task.spawn(function()
				local Confetti_Amount = 20000
				local RootPart = Character.HumanoidRootPart
				local ConfettiClone = hitmodule:Clone()
				ConfettiClone.RainbowParticles.Rate = Confetti_Amount
				ConfettiClone.Parent = workspace
				ConfettiClone.CanCollide = false
				ConfettiClone.CFrame = RootPart.CFrame
				-- 
				for i = Confetti_Amount, 0 , -(Confetti_Amount/50) do 
					task.wait()
					ConfettiClone.RainbowParticles.Rate = i
				end 
				-- 
				delay(5, function()
					ConfettiClone:Destroy()
				end)
			end)
		else 
			local Effect = Nova:Clone() 
			Effect.Parent = Character.HumanoidRootPart
			--	
			for i,v in pairs(Effect:GetChildren()) do 
				v.Rate = 0
				v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(convert(flags["Hit Effects Color"].Color))),ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),})
				v:Emit()
			end 
			-- 	
			delay(2, function()
				Effect:Destroy()
			end)
		end 
	end 
	-- 
	Lynx:HitEffect("Confetti", LocalPlayer.Character)
	-- 
	function Lynx:ThreadFunction(Func, Name, ...)
        local Func = Name and function()
            local Passed, Statement = pcall(Func)
            --
            if not Passed and not Lynx.Safe then
                warn("Lynx:\n", "              " .. Name .. ":", Statement)
            end
        end or Func
        local Thread = Create(Func)
        --
        Resume(Thread, ...)
        return Thread
    end
    -- 
    function Lynx:RayCast(Part, Origin, Ignore, Distance)
        local IgnoreList = Ignore
        local Distance = Distance or 5000
        --
        local Cast = Ray.new(Origin, (Part.Position - Origin).Unit * Distance)
        local Hit = Workspace:FindPartOnRayWithIgnoreList(Cast, IgnoreList)
        --
        return (Hit and Hit:IsDescendantOf(Part.Parent)) == true, Hit
    end
	-- 
	function Lynx:KnockCheck(Player)
		if Player.Character then 
			if Player.Character.BodyEffects ~= nil then
				if Player.Character.BodyEffects["K.O"].Value == true then 
					return false 
				end 
			end 
		end 
		return true
	end 
    -- 
    function Lynx:newDrawing(type, prop)
        local obj = Drawing.new(type)
        --
        if prop then
            for i,v in next, prop do
                obj[i] = v
            end
        end
        return obj  
    end
    -- 
    function Lynx:GetPlayerStatus(Player)
        if not Player then Player = LocalPlayer end
        return Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.Humanoid.Health > 0 and true or false
    end 
    --
    function Lynx:CreateBeam(Origin, End, Color1, Color2, Texture)
        local BeamPart = NewInstance("Part", workspace)
        BeamPart.Name = "BeamPart"
        BeamPart.Transparency = 1
        --
        local Part = NewInstance("Part", BeamPart)
        Part.Size = NewVector3(1, 1, 1)
        Part.Transparency = 1
        Part.CanCollide = false
        Part.CFrame = typeof(Origin) == "CFrame" and Origin or CFrame.new(Origin)
        Part.Anchored = true
        local Attachment = NewInstance("Attachment", Part)
        local Part2 = NewInstance("Part", BeamPart)
        Part2.Size = NewVector3(1, 1, 1)
        Part2.Transparency = 1
        Part2.CanCollide = false
        Part2.CFrame = typeof(End) == "CFrame" and End or CFrame.new(End)
        Part2.Anchored = true
        Part2.Color = Color3.fromRGB(255, 255, 255)
        local Attachment2 = NewInstance("Attachment", Part2)
        local Beam = NewInstance("Beam", Part)
        Beam.FaceCamera = true
        Beam.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color1),
            ColorSequenceKeypoint.new(1, Color2),
        }
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment2
        Beam.LightEmission = 6
        Beam.LightInfluence = 1
        Beam.Width0 = 1
        Beam.Width1 = 0.6
        Beam.Texture = "rbxassetid://".. Texture ..""
        Beam.LightEmission = 1
        Beam.LightInfluence = 1
        Beam.TextureMode = Enum.TextureMode.Wrap 
        Beam.TextureLength = 3 
        Beam.TextureSpeed = 3
        delay(1, function()
			for i = 0.5, 1, 0.02 do
				wait()
				Beam.Transparency = NumberSequence.new(i)
			end
			Part:Destroy()
			Part2:Destroy()
			BeamPart:Destroy()
        end)
    end
    -- 
    function Lynx:GetTool() 
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and Lynx:GetPlayerStatus() then 
            return LocalPlayer.Character:FindFirstChildWhichIsA("Tool") 
        end 
    end 
	-- 
	function Lynx:Map(N, OldMin, OldMax, Min, Max)
		return (N - OldMin) / (OldMax - OldMin) * (Max - Min) + Min
	end
    -- 
    function Lynx:Rainbow(Speed)
        return Color3.fromHSV(Abs(Sin(tick()) / (5 - Speed)),1,1)
    end 
    --
    function Lynx:CheckIfEven(Number)
        if (Number % 2 == 0) then
            return true
        else
            return false 
        end
    end
    --
    function Lynx:Connection(Type, Callback)
        local Connection = Type:Connect(Callback)
        Lynx.Connections[#Lynx.Connections + 1] = Connection
        --
        return Connection
    end
    --
    function Lynx:GetBodyParts(Character, RootPart, Indexes, Hitboxes)
        local Parts = {}
        local Hitboxes = Hitboxes or {"Head", "Torso", "Arms", "Legs"}
        --
        for Index, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") and Part ~= RootPart then
                if Find(Hitboxes, "Head") and Part.Name:lower():find("head") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Torso") and Part.Name:lower():find("torso") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Arms") and Part.Name:lower():find("arm") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif Find(Hitboxes, "Legs") and Part.Name:lower():find("leg") then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                elseif (Find(Hitboxes, "Arms") and Part.Name:lower():find("hand")) or (Find(Hitboxes, "Legs ") and Part.Name:lower():find("foot")) then
                    Parts[Indexes and Part.Name or #Parts + 1] = Part
                end
            end
        end
        --
        return Parts
    end
    -- 
    function Lynx:GetClosestPlayer()
        local shortestDistance = Huge
        --  
        local closestPlayer
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Lynx:GetPlayerStatus(Player) then
                local pos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                --
                if magnitude < shortestDistance and OnScreen then
                        closestPlayer = Player
                        shortestDistance = magnitude
                    end
                end
            end 
        return closestPlayer
    end

	-- 
    function Lynx:UpdateVisuals()
        if flags["lighting_masterswitch"] then 
            if flags["lighting_ambient"] then 
                if Lighting.Ambient ~= flags["lighting_ambient1"] then 
                    Lighting.Ambient = flags["lighting_ambient1"]
                end 
                if Lighting.OutdoorAmbient ~= flags["lighting_ambient2"] then 
                    Lighting.OutdoorAmbient = flags["lighting_ambient2"]
                end 
            end 
            --
            if flags["lighting_ambientcolorshift"] then 
                if Lighting.ColorShift_Bottom ~= flags["lighting_ambientcolorshift1"] then 
                    Lighting.ColorShift_Bottom = flags["lighting_ambientcolorshift1"]
                end 
                if Lighting.ColorShift_Top ~= flags["lighting_ambientcolorshift2"] then 
                    Lighting.ColorShift_Top = flags["lighting_ambientcolorshift2"]
                end 
            end 
            --
            if flags["lighting_fog"] then 
                if Lighting.FogColor ~= flags["lighting_fog1"] then 
                    Lighting.FogColor = flags["lighting_fog1"]
                end 
                if Lighting.FogEnd ~= flags["lighting_fog_end"] then 
                    Lighting.FogEnd = flags["lighting_fog_end"]
                end 
                if Lighting.FogStart ~= flags["lighting_fog_start"] then 
                    Lighting.FogStart = flags["lighting_fog_start"]
                end 
            end 
            --
            if flags["lighting_clocktime"] then
                if Lighting.ClockTime ~= flags["lighting_clocktime_slider"] then 
                    Lighting.ClockTime = flags["lighting_clocktime_slider"]
                end 
            end
            --
            if flags["lighting_brightness"] then 
                if Lighting.Brightness ~= flags["lighting_brightness_slider"] then
                    Lighting.Brightness = flags["lighting_brightness_slider"]
                end
            end 
        end 
    end 
    --
    function Lynx:GetPlayerParent(Player)
        return Player.Parent
    end
	-- 
	function Lynx:AngleToEdge(angle, inset) -- pasted from the grenade indicators lmao
		local pos
		local ox = Cos(angle)
		local oy = Sin(angle)
		local slope = oy / ox
		-- 
		local h_edge = viewportSize.x - inset
		local v_edge = viewportSize.y - inset
		if oy < 0 then
			v_edge = inset
		end
		if ox < 0 then
			h_edge = inset
		end
		local y = (slope * h_edge) + (viewportSize.y / 2) - slope * (viewportSize.x / 2)
		if y > 0 and y < viewportSize.y - inset then
			pos = Vector2.new(h_edge, y)
		else
			pos = Vector2.new(
				(v_edge - viewportSize.y / 2 + slope * (viewportSize.x / 2)) / slope,
				v_edge
			)
		end
		return pos
	end
    --
    function Lynx:GetCharacter(Player)
        return Player.Character
    end
    --
    function Lynx:GetHumanoid(Player, Character)
        return Character:FindFirstChildOfClass("Humanoid")
    end
    --
    function Lynx:GetRootPart(Player, Character, Humanoid)
        return Humanoid.RootPart
    end
    --
    function Lynx:GetHealth(Player, Character, Humanoid)
        if Humanoid then
            return Clamp(Humanoid.Health, 0, Humanoid.MaxHealth), Humanoid.MaxHealth
        end
    end
    --
    function Lynx:ValidateClient(Player)
        local Object = Lynx:GetCharacter(Player)
        local Humanoid = (Object and Lynx:GetHumanoid(Player, Object))
        local RootPart = (Humanoid and Lynx:GetRootPart(Player, Object, Humanoid))
        --
        return Object, Humanoid, RootPart
    end
    -- 
    function Lynx:ClientAlive(Player, Character, Humanoid)
        local Health, MaxHealth = Lynx:GetHealth(Player, Character, Humanoid)
        --
        return (Health > 0)
    end
    --
	function Lynx:getRotate(Vec, Rads)
		local vec = Vec.Unit
		local sin = math.sin(Rads)
		local cos = math.cos(Rads)
		local x = (cos * vec.x) - (sin * vec.y)
		local y = (sin * vec.x) + (cos * vec.y)
		--
		return Vector2.new(x, y).Unit * Vec.Magnitude
	end
	-- 
    function Lynx:Unload()
        for Index, Connection in next, Lynx.Connections do
            Connection:Disconnect()
        end
		-- 
		if ui then 
			ui:Unload() 
		end 
		-- 

    end
	--[[
	function Lynx:Update_Configs()
		all_cfgs = listfiles("Lynx\\")
		for _,cfg in next, all_cfgs do
			all_cfgs[_] = string.gsub(string.gsub(cfg, "Lynx\\", ""), ".txt", "")
			list:add_value(all_cfgs[_])
		end
	end 
	Lynx:Update_Configs()
    --]]
    function Lynx:ClampString(String, Length, Font)
        local Font = (Font or 2)
        local Split = String:split("\n")
        --
        local Clamped = ""
        --
        for Index, Value2 in pairs(Split) do
            if (Index * 13) <= Length then
                Clamped = Clamped .. Value2 .. (Index == #Split and "" or "\n")
            end
        end
        --
        return (Clamped ~= String and (Clamped == "" and "" or Clamped:sub(0, #Clamped - 1) .. " ...") or Clamped)
    end
    -- 
    function Lynx:GetTeam(Player)
        return Player.Team
    end
    -- 
    function Lynx:CheckTeam(Player1, Player2)
        return (Lynx:GetTeam(Player1) ~= Lynx:GetTeam(Player2))
    end
    -- 
    function Lynx:GetClosestPart(Player, List)
        local shortestDistance = Huge
        local closestPart = nil
        if Lynx:GetPlayerStatus(Player) then
            for Index, Value in pairs(Player.Character:GetChildren()) do
                if Value:IsA("BasePart") then 
                    local pos = Camera:WorldToViewportPoint(Value.Position)
                    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y + 36)).magnitude
                    if magnitude < shortestDistance and Find(List, Value.Name) then
                        closestPart = Value
                        shortestDistance = magnitude
                    end
                end
            end 
            return closestPart
        end
    end 
	-- 
	function Lynx:findNearestTargetInRadius(origin, radius)
		local minDistance = radius
		local nearestTarget = nil
		-- 							
		for _, target in pairs(Players:GetPlayers()) do
			if target ~= LocalPlayer and Lynx:GetPlayerStatus() and Lynx:GetPlayerStatus(target) then
				local Object, Humanoid, RootPart = Lynx:ValidateClient(target)
				if Object and Humanoid and RootPart then 
					local Check = true 
					-- 
					if (Find(flags["Silent_Aim_Checks"], "Wall") and not Lynx:RayCast(RootPart, Lynx:GetOrigin("Handle"), {Lynx:GetCharacter(LocalPlayer)})) then Check = false end
					if (Find(flags["Silent_Aim_Checks"], "ForceField") and Object:FindFirstChildOfClass("ForceField")) then Check = false end
					if (Find(flags["Silent_Aim_Checks"], "Knocked") and not Lynx:KnockCheck(target)) then Check = false end
					-- 
					local distance = (target.Character.HumanoidRootPart.Position - origin).Magnitude
					if distance < minDistance and Check == true then
						minDistance = distance
						nearestTarget = target
					end
				end 
			end
		end
		-- 
		return nearestTarget
	end	
	-- 	
	function Lynx:movePlayerAlongPath(path, offset)
		local waypoints = path:GetWaypoints()
		-- 
		for _, waypoint in pairs(waypoints) do
			local waypointPosition = waypoint.Position + Vector3.new(0, offset, 0) 
			player.Character.HumanoidRootPart.CFrame = CFrame.new(waypointPosition)
			task.wait()
		end
	end
    -- 
    function Lynx:RandomChance(Percentage)
        local Chance = Percentage
        --
        if Random(1,100) <= Chance then
            return true 
        else
            return false
        end
    end
    -- 
	function Lynx:CloneCharacter(Player, Color, Material, Transparency, Parent, Time)
		Player.Character.Archivable = true
		local Clone = Player.Character:Clone()
		Clone.Parent = Parent
	
		for _, Part in pairs(Clone:GetDescendants()) do
			if Part:IsA("Highlight") or Part:IsA("Humanoid") or Part:IsA("LocalScript") or Part:IsA("Script") or Part:IsA("Decal") or Part:IsA("Accessory") then
				Part:Destroy()
			end 
			-- 
			if Part:IsA("BasePart") or Part:IsA("Meshpart") or Part:IsA("Part") then
				if Part.Transparency ~= 1 then
					Part.Anchored = true
					Part.Material = Material
					Part.Color = Color
					Part.Transparency = Transparency
					Part.Size = Part.Size + NewVector3(0.03, 0.03, 0.03)
				else
					Part:Destroy()
				end
			end
			-- 
			if Part:IsA("Attachment") or Part:IsA("StringValue") or Part:IsA("Shirt") or Part:IsA("Pants") or Part:IsA("Vector3Value") or Part:IsA("WrapTarget") or Part:IsA("Folder") or Part:IsA("Motor6D") or Part:IsA("BodyColors") then 
				Part:Destroy()
			end 
			-- 
			pcall(function()
				Part.CanCollide = false
			end)
		end
		-- 
		delay(Time, function()
			Clone:Destroy()
		end)
	end 
	-- 
	function Lynx:CloneCharacter2(Player, Color, Enabled, Time, Material, Transparency, Parent)
		local Model = NewInstance("Model")
		Model.Name = "Model"
		Model.Parent = Parent 		
		-- 
        for i,v in pairs(Player.Character:GetChildren()) do 
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
                local ClonedPart = Instance.new("Part")
                ClonedPart.Anchored = true 
                ClonedPart.CanCollide = false 
                ClonedPart.Position = v.Position
                ClonedPart.Parent = Model
                ClonedPart.Material = Enum.Material[Material]
                ClonedPart.Shape = Enum.PartType.Block 
                ClonedPart.Transparency = Transparency 
                ClonedPart.Color = Color
                ClonedPart.Size = v.Size + NewVector3(0.01,0.01,0.01)
                ClonedPart.Name = v.Name
                ClonedPart.Rotation = v.Rotation
            end 
		end 
		-- 
		if Enabled then 
			delay(Time, function()
				Model:Destroy()
			end)
		end 
	end 
    -- 
    function Lynx:CalculateAbsolutePosition(Player)
        if Lynx:GetPlayerStatus(Player) then
            local root = Player.Character.HumanoidRootPart
            local character = Player.Character 
            --
            local currentPosition = root.Position
            local currentTime = tick() 
            --
            Wait()
            --
            local newPosition = root.Position
            local newTime = tick()
            --
            local distanceTraveled = (newPosition - currentPosition) 
            --
            local timeInterval = newTime - currentTime
            local velocity = distanceTraveled / timeInterval
            currentPosition = newPosition
            currentTime = newTime
            --
            return velocity
        end
    end 
    -- 
    function Lynx:GetOrigin(Origin)
        if Origin == "Head" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            local Head = Object:FindFirstChild("Head")
            --
            if Head and Head:IsA("RootPart") then
                return Head.CFrame.Position
            end
        elseif Origin == "Torso" then
            local Object, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
            --
            if RootPart then
                return RootPart.CFrame.Position
            end
		elseif Origin == "Handle" then 
			local Tool = Lynx:GetTool()
			-- 
			if Tool then 
				return Tool.Handle.CFrame.Position
			end 
		end 
        --
        return Workspace.CurrentCamera.CFrame.Position
    end
	-- 
	function Lynx:HitSound(Id, Volume, Pitch)
		local Sound = Instance.new("Sound", Workspace); local PitchSound = Instance.new("PitchShiftSoundEffect", Sound)
		-- 
		Sound.SoundId = "rbxassetid://".. Id ..""
		Sound.Volume = Volume
		PitchSound.Octave = Pitch
		Sound:Play()
		Sound.Ended:Connect(function()
			Sound:Destroy()
			PitchSound:Destroy()
		end)	
	end 
    --
    function Lynx:ValidateArguments(Args, RayMethod)
        local Matches = 0
            --
        if #Args < RayMethod.ArgCountRequired then
            return false
        end
        --
        for Pos, Argument in next, Args do
            if typeof(Argument) == RayMethod.Args[Pos] then
                Matches = Matches + 1
            end
        end
            --
        return Matches >= RayMethod.ArgCountRequired
    end
    --
    function Lynx:GetDirection(Origin, Position)
        return (Position - Origin).Unit * 1000
    end
	-- 
	for Index = 1, 4 do
        local line = Lynx:newDrawing("Line",{
            Visible =  true,
            Color = NewRGB(255,255,255),
            Thickness = 2,
            ZIndex = 2,
            Transparency = 1
        })
        --
        local line_outline = Lynx:newDrawing("Line",{
            Visible =  true,
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = 4,
            ZIndex = 1,
            Transparency = 1
        })
        --
        utility.Cursor.Lines[Index] = line
        utility.Cursor.Outlines[Index] = line_outline
    end
    -- 
    for Index = 1, 2 do 
        local Square = Lynx:newDrawing("Square",{
            Visible = true,
            Size = NewVector2(2, 2),
            Color = NewRGB(255,255,255),
            Filled = true,
            ZIndex = 1000,
            Transparency = 1
        })
        utility.Cursor.Dots[Index] = Square
    end     
    -- 
    for Index = 1, 5 do 
        local FieldOfView = Lynx:newDrawing("Circle",{
            Visible = false,
            Color = NewRGB(255,255,255),
            Thickness = 1,
            ZIndex = 2,
            Transparency = 0.5,
            Filled = true 
        })
        utility.Renders[Index] = FieldOfView
    end
	-- 
	utility.Parts[1] = NewInstance("Part")
	utility.Parts[1].Anchored = false 
	utility.Parts[1].CanCollide = false 
	utility.Parts[1].Parent = game.Workspace
	utility.Parts[1].Material = Enum.Material.Neon
	utility.Parts[1].Shape = Enum.PartType.Block 
	utility.Parts[1].Transparency = 0.8  
	utility.Parts[1].Color = Color3.fromRGB(255,255,255) 
	-- 
	for Index = 6, 7 do 
		utility.Renders[Index] = Lynx:newDrawing("Line", {Visible =  true, Color = Color3.fromRGB(255, 255, 255), Thickness = 1, ZIndex = 1, Transparency = 1})
	end 
	-- 
	utility.Renders[6].Thickness = 1
	utility.Renders[7].Color = Color3.fromRGB(255, 255, 255)
	utility.Renders[7].Thickness = 3
	utility.Renders[6].ZIndex = 999999
	utility.Renders[7].ZIndex = 1	
	utility.Renders[5].Radius = 2
	-- 
	local Visualize = Library:New3DCircle()
	Visualize.ZIndex = 4 
	Visualize.Visible = false 
	Visualize.Transparency = 1
	Visualize.Color = Color3.fromRGB(255,255,255)
	Visualize.Thickness = 1 
	Visualize.Position = LocalPlayer.Character.HumanoidRootPart.Position
	Visualize.Radius = 20
	-- 
	local Size = {200, 20}
	local Position = {10,(Workspace.CurrentCamera.ViewportSize.Y/2)-50}
	-- 
	Visuals["KeyBindList"] = {
		["Drawings"] = {
			Accent = Lynx:newDrawing("Square", {Size = NewVector2(Size[1] - 2,1.5), Color = Color3.fromRGB(0,193,255), Visible = false , Position = NewVector2(Position[1] + 1, Position[2]), Filled = true, ZIndex = 999}),
			Text = Lynx:newDrawing("Text", {Text = "Keybinds", Color = NewRGB(255,255,255), Size = 13, Center = false, Font = 1, Visible = false, Position = NewVector2(79,Position[2]+2), Outline = true, ZIndex = 9999}),
			Frame = Lynx:newDrawing("Square", {Size = NewVector2(Size[1],Size[2]), Visible = false, Color = NewRGB(0, 0, 0), Position = NewVector2(Position[1],Position[2]), Filled = true}),
			Inner = Lynx:newDrawing("Square", {Size = NewVector2(Size[1]-2,Size[2]-2), Visible = false , Color = NewRGB(30, 30, 30), Position = NewVector2(Position[1]+1,Position[2]+1), Filled = true}),
			Gradient = Lynx:newDrawing("Image", {Size = NewVector2(Size[1]-2,Size[2]-2), Visible = false , Position = NewVector2(Position[1]+1,Position[2]+1), Transparency = 1, Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/gradient_new.png"), Transparency = 0.5}),
			Key = Lynx:newDrawing("Text", {Text = "", Color = NewRGB(255,255,255), Size = 13, Center = false, Font = 1, Visible = false, Position = NewVector2(13,Position[2]+17), Outline = true, ZIndex = 9999}),
		}, 
		["Text"] = ""
	} 
	-- 
	function Visuals.KeyBindList.SetVisibleList(Bool)
		for _, Drawing in next, Visuals["KeyBindList"]["Drawings"] do
			Drawing.Visible = Bool
		end 
	end 
	-- 
	function Visuals.KeyBindList.AddValue(Bool, Bool2, Name, Key)
		if Bool and Bool2 then 
			Visuals["KeyBindList"]["Text"] ..= ("%s\n"):format("".. Name .." [" .. Key .. "] ")
		end 
	end 
end
-- Combat
do 
	local Silent_Aim_Tab = Window:Tab{Name = 'Silent Aim', icon = "rbxassetid://6034509987"}
	local Aim_Assist_Tab = Window:Tab{Name = 'Assist Tab', icon = "rbxassetid://4483345998"}
	local On_Hit = Window:Tab{Name = 'Settings', icon = "rbxassetid://3605022185"}
    -- 
    local Aimbot = Aim_Assist_Tab:Sector{Side = 1}
    do 
		Aimbot:Title{Title = 'Aim Assist'}
		--
        THL = Aimbot:Toggle{Name = 'Enabled',flag = 'Aim Assist Enabled'}
		--
        S = THL:Settings()
		--
        S:Keybind{name = 'Key', flag = "Aim Assist Key", type = 1, callback = function(Bool)
			if Bool and flags["Aim Assist Enabled"] then 
				Lynx.Assist.Target = Lynx:GetClosestPlayer()
			end 
		end}
		--
        S:Toggle{Name = 'Sticky Aim', flag = 'Sticky Aim'}
		--
		Aimbot:Input({Name = "Prediction:", Flag = "Aim Assist Prediction", Focuses = true, Editable = true})
		--
        THL = Aimbot:Dropdown{Name = 'Hit-Part', flag = 'Aim Assist HitPart', options = bodyParts, min = 1}
		--
        Aimbot:Toggle{Name = 'Smoothness',flag = 'Smoothness'}
		--
        Aimbot:Slider{Name = 'Amount', flag = 'Smoothness Amount', min = 1, max = 100, default = 1, float = 0.1}
		--
        Aimbot:Dropdown{Name = 'Checks', flag = 'Aim_Assist_Checks', options = {"Visible", "Wall", "ForceField", "Knocked"}, min = 0}
		--
		local serversideQqwdqQW = Aimbot:CreateSegment{Name = 'Stutter'}
		--
		serversideQqwdqQW:Slider{flag = 'Stutter Amount', min = 0, max = 50, default = 0, float = 0.1}
		-- 
		Aimbot:Slider{Name = 'Distance', flag = 'Aim Assist Distance', min = 1, max = 7500, default = 7500, float = 0.1}
    end 
	-- 
	local CameraShake = Aim_Assist_Tab:Sector{Side = 2}
	do 
		CameraShake:Toggle{Name = "Camera Shake", flag = "Camera Shake"}
		--
		CameraShake:Slider{Name = 'X', flag = 'X', min = 0.01, max = 5, default = 0.00001, float = 0.01}
		--
		CameraShake:Slider{Name = 'Y', flag = 'Y', min = 0.01, max = 5, default = 0.00001, float = 0.01}
		--
		CameraShake:Slider{Name = 'Z', flag = 'Z', min = 0.01, max = 5, default = 0.00001, float = 0.01}
	end
	-- FOV
	local FieldOfView = On_Hit:Sector{Side = 2}
	do 
		FieldOfView:Title{Title = 'Field Of View', Description = "Only aimbots in the circle."}
		--
		S = FieldOfView:CreateSegment{Name = 'Silent Aim FOV'}
		--
		THL = S:Toggle{flag = 'Silent Aim FOV Enabled', callback = function(Bool)
			utility.Renders[1].Visible = Bool
		end}
		-- 
		Sl = THL:Settings()
		-- 
		Sl:Toggle{Name = "Filled", flag = 'Silent Aim FOV Filled', callback = function(Bool)
			utility.Renders[1].Filled = Bool
		end}
		--
		S:Colorpicker{flag = "Silent Aim FOV Color", transparency = 0.5, callback = function()
			utility.Renders[1].Color = flags["Silent Aim FOV Color"].Color
			utility.Renders[1].Transparency = 1 - flags["Silent Aim FOV Color"].Alpha
		end}
		--
		FieldOfView:Slider{Name = 'Radius', flag = 'Silent Aim FOV Radius', min = 1, max = 500, default = 1, float = 1, callback = function(Int)
			utility.Renders[1].Radius = Int
		end}
		--
		S = FieldOfView:CreateSegment{Name = 'Aim Assist FOV'}
		--
		THL = S:Toggle{flag = 'Aim Assist FOV Enabled', callback = function(Bool)
			utility.Renders[2].Visible = Bool
		end}
		-- 
		Sl = THL:Settings()
		-- 
		Sl:Toggle{Name = "Filled", flag = 'Aim Assist FOV Filled', callback = function(Bool)
			utility.Renders[2].Filled = Bool
		end}
		--
		S:Colorpicker{flag = "Aim Assist FOV Color", transparency = 0.5, callback = function()
			utility.Renders[2].Color = flags["Aim Assist FOV Color"].Color
			utility.Renders[2].Transparency = 1 - flags["Aim Assist FOV Color"].Alpha
		end}
		--
		FieldOfView:Slider{Name = 'Radius', flag = 'Aim Assist FOV Radius', min = 1, max = 500, default = 1, float = 0.1, callback = function(Int)
			utility.Renders[2].Radius = Int
		end}
		--
		S = FieldOfView:CreateSegment{Name = 'Render Deadzone'}
		-- 
		THL = S:Toggle{flag = 'Deadzone Enabled', callback = function(Bool)
			utility.Renders[3].Visible = Bool
		end}
		--
		Sl = THL:Settings()
		-- 
		Sl:Toggle{Name = "Filled", flag = 'Deadzone FOV Filled', callback = function(Bool)
			utility.Renders[3].Filled = Bool
		end}
		-- 
		S:Colorpicker{flag = 'Deadzone Color', transparency = 0.5, callback = function()
			utility.Renders[3].Color = flags["Deadzone Color"].Color
			utility.Renders[3].Transparency = 1 - flags["Deadzone Color"].Alpha
		end}
		-- 
		FieldOfView:Slider{Name = 'Radius', flag = 'Deadzone Radius', min = 1, max = 500, default = 1, float = 0.1, callback = function(Int)
			utility.Renders[3].Radius = Int
		end}
	end 
	-- 
	local GunShootSound = On_Hit:Sector{Side = 2}
	do 
		GunShootSound:Title{Title = 'Custom Gun Sound'}
		GunShootSound:Toggle{Name = "Enabled", flag = "Custom Gun Sounds"}
		GunShootSound:Dropdown{Name = 'Sound', flag = 'Sound Effect', options = {"Bameware", "Skeet", "Bonk", "Lazer Beam", "Windows XP Error", "TF2 Hitsound", "TF2 Critical", "TF2 Bat", "Bow Hit", "Bow", "OSU", "Minecraft Hit", "Steve", "1nn", "Rust", "TF2 Pan", "Neverlose", "Mario"}, min = 1, max = 1}
		GunShootSound:Slider{Name = 'Volume', flag = 'Volume', min = 0, max = 30, default = 3, float = 0.5}
		GunShootSound:Slider{Name = 'Pitch', flag = 'Play Back Time', min = 0, max = 10, default = 0, float = 0.5}
	end
    -- Silent Aim
    local Silent_Aim = Silent_Aim_Tab:Sector{Side = 1}
    do 
		Silent_Aim:Title{Title = 'Silent Aim'}
		S = Silent_Aim:CreateSegment{Name = 'On'}
		S:Dropdown{Name = 'Type', flag = 'Silent Aim Type', options = {"Target Aim", "Silent Aim"}, min = 1, max = 1}
		KHL = S:Toggle{Name = 'Enabled', flag = 'Silent Aim Enabled'}
		S = KHL:Settings()
		S:Keybind{name = 'Key', type = 1, flag = "Silent Aim Key", callback = function(Bool) 
			if flags["Silent Aim Enabled"] == true then 
				-- 
				if flags["Silent Aim Key"].Active then 
					Lynx.Silent.Target = Lynx:GetClosestPlayer()
					if not Lynx.Silent.Target then return end 
					if Lynx.Silent.Target.Character and flags["Silent Aim Type"] == "Target Aim" and flags["RageBot"] == false then 
						local currentHealth = Lynx.Silent.Target.Character:WaitForChild("Humanoid").Health
						-- 
						if Find(flags["Silent Aim Notify"], "Locked") then 
							ui:Notify{text = "Locked onto: ".. Lynx.Silent.Target.Name.. " (".. Lynx.Silent.Target.DisplayName .. ")", time = 2, style = "loading"}
						end 
						-- 
						if flags["Visualize Part Chams Enabled"] then 
							Lynx:CloneCharacter2(Lynx.Silent.Target, flags["Visualize Part Chams Color"].Color, false, 0, flags["Visualize Part Chams Material"],flags["Visualize Part Chams Color"].Alpha, Workspace.Terrain["Backtrack"])
						end 
						-- 
						if flags["Cham Player Enabled"] then 
							Highlight = NewInstance("Highlight", Lynx.Silent.Target.Character)
							Highlight.Enabled = true
							Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							Highlight.FillColor = flags["Cham Player Color1"].Color
							Highlight.OutlineColor = flags["Cham Player Color2"].Color
							Highlight.OutlineTransparency = flags["Cham Player Color2"].Alpha
							Highlight.FillTransparency = flags["Cham Player Color1"].Alpha
						end 
						-- 
						--[[Lynx.Connections["On-Hit"] = Lynx.Silent.Target.Character:WaitForChild("Humanoid").HealthChanged:Connect(function(newHealth)
							if newHealth < currentHealth then 
								if Find(flags["Silent Aim Notify"], "Hit Log") then 
									ui:Notify{text = "".. Lynx.Silent.Target.Name.. " got hit for: ".. Floor(Abs(newHealth - currentHealth)), time = 5, style = "loading"}
								end 
							end 
							currentHealth = newHealth
						end)]]
						-- 
						Lynx.Connections["On-Respawn"] = Lynx.Silent.Target.CharacterAdded:Connect(function()
							Wait(2)
							if flags["Cham Player Enabled"] then 
								Highlight = NewInstance("Highlight", Lynx.Silent.Target.Character)
								Highlight.Enabled = true
								Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								Highlight.FillColor = flags["Cham Player Color1"].Color
								Highlight.OutlineColor = flags["Cham Player Color2"].Color
								Highlight.OutlineTransparency = flags["Cham Player Color2"].Alpha
								Highlight.FillTransparency = flags["Cham Player Color1"].Alpha
							end 
						end)
					end 
				else 
					if Lynx.Connections["On-Hit"] then 
						Lynx.Connections["On-Hit"]:Disconnect() 
					end 
					-- 
					if Lynx.Connections["On-Respawn"] then 
						Lynx.Connections["On-Respawn"]:Disconnect() 
					end
					-- 
					if Find(flags["Silent Aim Notify"], "Unlocked") then 
						ui:Notify{text = "Unlocked !", time = 2, style = "loading"}
					end 
					-- 
					utility.Parts[1].CFrame = CFrame.new(9999,9999,9999)
					LocalPlayer.Character.Humanoid.AutoRotate = true 
					Workspace.Terrain["Backtrack"]:ClearAllChildren() 
					-- 
					for Index = 5, 7 do 
						utility.Renders[Index].Visible = false
					end 
					-- 
					if Highlight then 
					Highlight:Destroy()
					end 
				end 
			end 	
		end}
		S:Toggle{Name = 'Look-At', flag = 'Look-At'}	
		Lynx.Connections["Anti Aim Viewer"] = {}
		S:Toggle{Name = 'Bypass Aim Viewer', flag = 'Bypass Aim Viewer', callback = function(Bool) 
			if Bool then 
				for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
					if v:IsA("Tool") and not Lynx.Connections["Anti Aim Viewer"][v] then
						Lynx.Connections["Anti Aim Viewer"][v] = v.Activated:Connect(Lynx.AimViwerBypass)
					end
				end
				for i, v in pairs(LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") and not Lynx.Connections["Anti Aim Viewer"][v] then
						Lynx.Connections["Anti Aim Viewer"][v] = v.Activated:Connect(Lynx.AimViwerBypass)
					end
				end
				LocalPlayer.Character.ChildAdded:connect(function(v)
					if v:IsA("Tool") and not Lynx.Connections["Anti Aim Viewer"][v] then
						Lynx.Connections["Anti Aim Viewer"][v] = v.Activated:Connect(Lynx.AimViwerBypass)
					end
				end)
				LocalPlayer.CharacterAdded:connect(function(v)
					for i = 1, #Lynx.Connections["Anti Aim Viewer"] do
						Lynx.Connections["Anti Aim Viewer"][i]:Disconnect()
						Lynx.Connections["Anti Aim Viewer"][i] = nil
					end
					v.ChildAdded:connect(function(v)
						if v:IsA("Tool") and not Lynx.Connections["Anti Aim Viewer"][v] then
							Lynx.Connections["Anti Aim Viewer"][v] = v.Activated:Connect(Lynx.AimViwerBypass)
						end
					end)
				end)
			else 
				for i = 1, #Lynx.Connections["Anti Aim Viewer"] do
					Lynx.Connections["Anti Aim Viewer"][i]:Disconnect()
					Lynx.Connections["Anti Aim Viewer"][i] = nil
				end
			end 
		end}
		S:Toggle{Name = 'RageBot', flag = 'RageBot'}
		S:Toggle{Name = 'Auto-Shoot', flag = 'Auto-Shoot'}
		Silent_Aim:Input{Name = "Prediction:", flag = "Silent Aim Prediction", Focuses = true, Editable = true, callback = function(Text)
			Lynx.Silent.Prediction = flags["Silent Aim Prediction"]
		end}
		S:Toggle{Name = 'Auto Prediction', flag = 'Auto Prediction'}
		S:Toggle{Name = 'Use Ping', flag = 'Use Ping'}
		Silent_Aim:Dropdown{Name = 'Hit-Part', flag = 'Silent Aim HitPart', options = bodyParts, min = 1, default = {"HumanoidRootPart"}}
        Silent_Aim:Dropdown{Name = 'Checks', flag = 'Silent_Aim_Checks', options = {"Wall", "Visible", "ForceField", "Knocked"}, min = 0, max = 5}
		KHL = Silent_Aim:Toggle{Name = 'Resolver', flag = 'Resolver'}
		S = KHL:Settings()
		S:Keybind{name = 'Key', flag = "Resolver Key", type = 1}
		Silent_Aim:Dropdown{Name = 'Notify', flag = 'Silent Aim Notify', options = {"Locked", "Unlocked", "Hit Log", "Left"}, min = 1}
	end  
	-- 
	local AirPrediction = Silent_Aim_Tab:Sector{Side = 1}
	do 
		AirPrediction:Toggle{Name = "Air Prediction", flag = "Hits more shots."}
		--
		AirPrediction:Dropdown{Name = 'Method', flag = 'Air Prediction Method', options = {"Offset", "Part"}, default = {"Offset"}, min = 1, max = 1}
		-- 
		AirPrediction:Input{Name = "Jump Offset:", flag = "Jump Offset", Focuses = true, Editable = true, callback = function(Text)
			Lynx.Silent.Offset = flags["Jump Offset"]
		end}
		-- 
		AirPrediction:Dropdown{Name = 'Part', flag = 'Air Prediction Part', options = bodyParts, min = 1, max = 1}
	end
	-- 
	local VisualizeSilent = Silent_Aim_Tab:Sector{Side = 2}
	do 
		VisualizeSilent:Title{Title = 'Visualize', Description = "Shows ur targets position"}
		--
		S = VisualizeSilent:CreateSegment{Name = 'Part'}
        KHS = S:Toggle{flag = 'Visualize Part Enabled'}
        S:Colorpicker{flag = "Visualize Part Color", callback = function()
			utility.Parts[1].Color = flags["Visualize Part Color"].Color
			utility.Parts[1].Transparency = flags["Visualize Part Color"].Alpha
		end}
		Sl = KHS:Settings()
		Sl:Toggle{Name = "Show hitbox", flag = 'Hitbox', callback = function()
			utility.Parts[1].Size = Vector3.new(LocalPlayer.Character.HumanoidRootPart.Size.X * 3 ,5,LocalPlayer.Character.HumanoidRootPart.Size.X * 3)
		end}
		Sl:Toggle{Name = "Show Prediction", flag = 'Show Prediction'}
		VisualizeSilent:Slider{Name = 'Size', flag = 'Visualize Part Size', min = 1, max = 50, default = 1, callback = function()
			utility.Parts[1].Size = Vector3.new(flags["Visualize Part Size"],flags["Visualize Part Size"],flags["Visualize Part Size"])
			if flags["Hitbox"] then 
				utility.Parts[1].Size = Vector3.new(LocalPlayer.Character.HumanoidRootPart.Size.X * 3 ,5,LocalPlayer.Character.HumanoidRootPart.Size.X * 3)
			end 
		end}
		VisualizeSilent:Dropdown{Name = 'Material', flag = 'Part Material', options = {"ForceField", "Neon", "Plastic"}, min = 1,max = 1}
		-- 
		S = VisualizeSilent:CreateSegment{Name = 'Visualize Part Chams'}
        S:Toggle{flag = 'Visualize Part Chams Enabled'}
        S:Colorpicker{flag = "Visualize Part Chams Color"}
		VisualizeSilent:Dropdown{Name = 'Material', flag = 'Visualize Part Chams Material', options = {"ForceField", "Neon", "Plastic"}, min = 1,max = 1}
	end 
	-- 
	local VisualizeDrawings = Silent_Aim_Tab:Sector{Side = 2}
	do 
		S = VisualizeDrawings:CreateSegment{Name = 'Cham Player'}
		S:Toggle{flag = 'Cham Player Enabled'}
        S:Colorpicker{flag = "Cham Player Color1"}
		S:Colorpicker{flag = "Cham Player Color2"}
		-- 
		S = VisualizeDrawings:CreateSegment{Name = 'Draw Tracer'}
        KHS = S:Toggle{flag = 'Draw Tracer Enabled', function()
			utility.Renders[6].Visible = false 
			utility.Renders[7].Visible = false
		end}
        S:Colorpicker{flag = "Draw Tracer Settings", callback = function()
			utility.Renders[6].Color = flags["Draw Tracer Settings"].Color
			utility.Renders[6].Transparency = 1 - flags["Draw Tracer Settings"].Alpha
		end}
		Sl = KHS:Settings()
		Sl:Toggle{flag = 'Tracer Outline', callback = function(Bool)
			utility.Renders[7].Visible = false
		end}
		VisualizeDrawings:Slider{Name = 'Thickness', flag = 'Draw Tracer Thickness', min = 0, max = 3, default = 1, float = 0.1, callback = function(Int)
			utility.Renders[6].Thickness = Int
			utility.Renders[7].Thickness = Int + 3
		end}
		-- 
		S = VisualizeDrawings:CreateSegment{Name = 'Draw Dot'}
        S:Toggle{flag = 'Draw Dot', callback = function(Bool)
			if not Bool then 
				utility.Renders[5].Visible = false
			end 
		end}
        S:Colorpicker{flag = "Draw Dot Settings", callback = function()
			utility.Renders[5].Transparency = 1 - flags["Draw Dot Settings"].Alpha
			utility.Renders[5].Color = flags["Draw Dot Settings"].Color
		end}		
		utility.Renders[5].Filled = true 
		utility.Renders[5].Radius = 10
	end
	-- 
	local On_Hit_Sector = On_Hit:Sector{Side = 1}  
	do 
		On_Hit_Sector:Title{Title = 'On-Hit', Description = "Visualizes on target hit"}
		-- 
		On_Hit_Sector:Toggle{Name = 'Enabled', flag = "On-Hit-Raycast"}
		-- 
		local Hit_Chams = On_Hit:Sector{Side = 1}  
		do 
			Hit_Chams:Title{Title = 'Hit-Chams', Description = "Visualizes a clone"}
			S = Hit_Chams:CreateSegment{Name = 'Enabled'}
			S:Toggle{flag = 'Hit Chams Enabled'}
			S:Colorpicker{flag = "Hit Chams Color"}
			Hit_Chams:Toggle{flag = 'Optimized Chams', Name = "Optimized"}
			Hit_Chams:Dropdown{Name = 'Material', flag = 'Hit Chams Material', options = {"ForceField", "Neon", "Plastic"}, default = {"ForceField"}, min = 1, max = 1}
			Hit_Chams:Slider{Name = 'Time', flag = 'Hit Chams Time', min = 0.1, max = 5, default = 1, float = 0.1}
		end 
		-- 
		local Hit_Chams = On_Hit:Sector{Side = 1}  
		do 
			Hit_Chams:Title{Title = 'Hit-Markers', Description = "Shows a crosshair when shot"}
			S = Hit_Chams:CreateSegment{Name = 'Enabled'}
			S:Toggle{flag = 'Hit Markers Enabled'}
			S:Colorpicker{flag = "Hit Markers Color"}
			Hit_Chams:Dropdown{Name = 'Type', flag = 'HitMarker Type', options = {"3D", "2D"}, min = 1, max = 1}
			Hit_Chams:Slider{Name = 'Time', flag = 'Hit Markers Time', min = 0.1, max = 5, default = 1, float = 0.1}
		end 
		-- 
		local Hit_Sounds = On_Hit:Sector{Side = 1}  
		do 
			Hit_Sounds:Title{Title = 'Hit Sounds', Description = "Plays a sound when hit"}
			Hit_Sounds:Toggle{Name = "Hit Sound", flag = 'Hit Sound'}
			Hit_Sounds:Dropdown{Name = 'Sound', flag = 'Hit Sound Effect', options = {"Bameware", "Skeet", "Bonk", "Lazer Beam", "Windows XP Error", "TF2 Hitsound", "TF2 Critical", "TF2 Bat", "Bow Hit", "Bow", "OSU", "Minecraft Hit", "Steve", "1nn", "Rust", "TF2 Pan", "Neverlose", "Mario"}, min = 1, max = 1}
			Hit_Sounds:Slider{Name = 'Volume', flag = 'Hit Sound Volume', min = 0.1, max = 10, default = 10, float = 0.1}
			Hit_Sounds:Slider{Name = 'Pitch', flag = 'Hit Sound Pitch', min = 0.1, max = 10, default = 1, float = 0.1}
		end 
		-- 
		local Hit_Effects = On_Hit:Sector{Side = 1}  
		do 
			S = Hit_Effects:CreateSegment{Name = 'Hit Effects'}
			S:Toggle{flag = 'Hit Effects'}
			S:Colorpicker{flag = "Hit Effects Color"}
			Hit_Effects:Dropdown{Name = 'Texture', flag = 'Hit Effect', options = {"Bubble", "Confetti"}, min = 1, max = 1}
		end 
	end 
end 
Window:Separator()
-- ESP
do
    local ESP = Window:Tab{Name = 'ESP', icon = "rbxassetid://6031251516"}
    -- 
    local ESP1 = ESP:Sector{Side = 1}  
    ESP1:Title{Title = 'ESP'} 
    do 
		ESP1:Toggle{Name = 'Enabled', flag = 'PlayerESP_Enabled'}
		S = ESP1:CreateSegment{Name = 'Name'}
        S:Toggle{flag = 'PlayerESP_Name'}
        S:Colorpicker{flag = "PlayerESP_Name_Color"}
		S = ESP1:CreateSegment{Name = 'Box'}
        THL = S:Toggle{flag = 'PlayerESP_Box'}
        S:Colorpicker{flag = "PlayerESP_Box_Color1", default = {Color = NewRGB(255, 255, 255), Alpha = 1}}
		S:Colorpicker{flag = "PlayerESP_Box_Color2", default = {Color = NewRGB(0, 0, 0), Alpha = 1}}
		Se = THL:Settings()
		Se:Toggle{Name = 'Corner Boxes', flag = 'PlayerESP_Box_Type'}
		S = ESP1:CreateSegment{Name = 'Healthbar'}
        THL = S:Toggle{flag = 'PlayerESP_HealthBar'}
		S:Colorpicker{flag = "PlayerESP_HealthBar_Color_High", default = {Color = Color3.fromRGB(0, 255, 0), Alpha = 1}}
		S:Colorpicker{flag = "PlayerESP_HealthBar_Color_Low", default = {Color = Color3.fromRGB(255, 0, 0), Alpha = 1}}
		Se = THL:Settings()
		Se:Toggle{Name = 'Apply Gradient', flag = 'PlayerESP_HealthBarGradient'}
		Se:Toggle{Name = 'Health Text', flag = 'PlayerESP_HealthNumber'}
		ESP1:Slider{Name = 'Thickness', flag = 'PlayerESP_HealthBar_Thickness', min = 2, max = 5, default = 2, float = 0.01}
		S = ESP1:CreateSegment{Name = 'Weapon'}
        S:Toggle{flag = 'PlayerESP_Weapon'}
        S:Colorpicker{flag = "PlayerESP_Weapon_Color"}
		S = ESP1:CreateSegment{Name = 'Flag'}
        S:Toggle{flag = 'PlayerESP_Flags'}
        S:Colorpicker{flag = "PlayerESP_FlagsColor"}
		ESP1:Dropdown{Name = 'Flags:', flag = 'PlayerESP_Flag_Options', options = {"Distance", "Money", "Knocked"}, min = 0}
    end 
    -- 
    local ESP_Settings = ESP:Sector{Side = 2}
    ESP_Settings:Title{Title = 'Out Of View'}
    do 
		S = ESP_Settings:CreateSegment{Name = 'Out of view'}
        S:Toggle{flag = 'PlayerESP_Arrows'}
        S:Colorpicker{flag = "PlayerESP_ArrowColor", alpha = 0.5}
		S:Colorpicker{flag = "PlayerESP_ArrowOutline"}
		ESP_Settings:Slider{Name = 'Arrow Size', flag = 'PlayerESP_ArrowSize', min = 0, max = 30, default = 12, float = 1}
		ESP_Settings:Slider{Name = 'Arrow Radius', flag = 'PlayerESP_ArrowRadius', min = 0, max = 100, default = 50, float = 1}
		-- 
		S = ESP_Settings:CreateSegment{Name = 'Box-Fill'}
        S:Toggle{flag = 'PlayerESP_BoxFill'}
        S:Colorpicker{flag = "PlayerESP_BoxFill_Color"}
		-- 
		ESP_Settings:Slider{Name = 'Render Distance', flag = 'ESP Distance', min = 0, max = 10000, default = 7500, float = 1}
    end 
	-- 
	local ESP_Chams = ESP:Sector{Side = 2}
	do 
		ESP_Chams:Title{Title = 'Chams'}
		-- 
		S = ESP_Chams:CreateSegment{Name = 'Enabled'}
        S:Toggle{flag = 'PlayerESP_Chams', callback = function(Bool)
			for Index, Player in pairs(Players:GetPlayers()) do
				if Player ~= LocalPlayer then
					if Bool then 
						Lynx:Cham_Character(Player, flags["Highlight_Fill_Color"].Color, flags["Highlight_Outline_Color"].Color, flags["Highlight_Fill_Color"].Alpha, flags["Highlight_Outline_Color"].Alpha) 
					else 
						Lynx:Cham_Remove(Player)
					end 	
				end
			end
		end}
        S:Colorpicker{flag = "Highlight_Fill_Color", default = {Color = Color3.fromRGB(0, 255, 0), Alpha = 0.5}, callback = function()
			for i,v in pairs(game.CoreGui.Folder:GetChildren()) do 
				v.FillColor = flags["Highlight_Fill_Color"].Color
				v.FillTransparency = flags["Highlight_Fill_Color"].Alpha
			end 
		end}
		S:Colorpicker{flag = "Highlight_Outline_Color", default = {Color = Color3.fromRGB(255, 255, 0), Alpha = 0}, callback = function()
			for i,v in pairs(game.CoreGui.Folder:GetChildren()) do 
				v.OutlineColor = flags["Highlight_Outline_Color"].Color
				v.OutlineTransparency = flags["Highlight_Outline_Color"].Alpha
			end 
		end}
	end 
end  
-- Visuals
do 
	local Visuals = Window:Tab{Name = 'Visuals', icon = "rbxassetid://6031075931"}
    -- 
	local GunShootSound = Visuals:Sector{Side = 1}
	do 
		GunShootSound:Title{Title = 'Custom Stomps'}
		GunShootSound:Toggle{Name = "Enabled", flag = "Custom Stomps"}
		GunShootSound:Dropdown{Name = 'Stomp', flag = 'Stomp Effect', options = {"Glitch","Explosion","Airstrike","Heart","UFO"}, min = 1, max = 1}
	end
	-- 
    local Crosshair = Visuals:Sector{Side = 2}
    Crosshair:Title{Title = 'Crosshair'} 
    do 
		S = Crosshair:CreateSegment{Name = 'Enabled'}
		THS = S:Toggle{flag = 'Cursor', callback = LPH_JIT(function(Bool) 
            if flags["Cursor"] then 
                InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
                for i,v in next, utility.Cursor.Outlines do 
                    v.Visible = true
                end 
                -- 
                for i,v in next, utility.Cursor.Lines do 
                    v.Visible = true
                end  
            else 
                InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow 
                for i,v in next, utility.Cursor.Outlines do 
                    v.Visible = false
                end 
                -- 
                for i,v in next, utility.Cursor.Lines do 
                    v.Visible = false
                end 
            end 
        end)}
		S:Colorpicker{flag = "Cursor Color", callback = LPH_JIT(function(Color)
			for i,v in next, utility.Cursor.Lines do 
				v.Color = flags["Cursor Color"].Color
			end 
			--
			utility.Cursor.Dots[1].Color = flags["Cursor Color"].Color
		end)}
		--
		S = THS:Settings()
		--
        S:Toggle{Name = "Dot", flag = 'Dot', callback = LPH_JIT(function(Bool)
			utility.Cursor.Dots[1].Visible = Bool 
			utility.Cursor.Dots[2].Visible = Bool 
		end)}
		--
		S = Crosshair:CreateSegment{Name = 'Dynamic'}
		--
		S:Toggle{flag = 'Dynamic Gap Enabled'}
		--
		S:Slider{Name = "Speed", flag = 'Dynamic Gap Speed', min = 0, max = 5, default = 1, float = 0.01}
		--
		S = Crosshair:CreateSegment{Name = 'Spin'}
		--
		S:Toggle{flag = 'Spin'}
		--
        S:Slider{flag = 'Spin Speed', min = 0, max = 360, default = 90, float = 1}
		--
		Crosshair:Slider{Name = "Radius", flag = 'Cursor Radius', min = 0, max = 50, default = 5, float = 0.1}
		--
		Crosshair:Slider{Name = "Gap", flag = 'Cursor Gap', min = 0, max = 50, default = 10, float = 0.1}
		--
		Crosshair:Slider{Name = "Thickness", flag = 'Cursor Thickness', min = 0, max = 3, default = 1.5, float = 0.01, callback = LPH_JIT(function(int)
			for i,v in next, utility.Cursor.Outlines do 
				v.Thickness = int + 2
			end 
			--
			for i,v in next, utility.Cursor.Lines do 
				v.Thickness = int
			end 
		end)}
    end 
	-- 
	local DaHoodCursor = Visuals:Sector{Side = 2}
	do 
		DaHoodCursor:Title{Title = 'Da Hood Cursor'}
		DaHoodCursor:Toggle{Name = "Spin", flag = "Da Hood Cursor Spin", callback = function()
			LocalPlayer.PlayerGui.MainScreenGui.Aim.Rotation = 0
		end}
		DaHoodCursor:Slider{Name = 'Speed', flag = 'Cursor Spin Speed for DH', min = 2, max = 10, default = 2, float = 0.01}
		DaHoodCursor:Colorpicker{Name = "Color", flag = "Cursor Color", callback = function()
			LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = flags["Cursor Color"].Color
			for i,v in next, LocalPlayer.PlayerGui.MainScreenGui.Aim:GetChildren() do 
				v.BackgroundColor3 = flags["Cursor Color"].Color
			end 
		end}
	end
end 
-- World
do 
	local World_Visuals = Window:Tab{Name = 'World', icon = "rbxassetid://6026568295"}
	-- 
	local World = World_Visuals:Sector{Side = 1}
	-- 
    World:Title{Title = 'World'}
    do 
		World:Toggle{Name = 'Enabled', flag = "World Visuals Enabled", callback = function(Bool)
			if not Bool then 
				for i, v in pairs(utility.LightingBackUp) do 
					Lighting[i] = v 
				end
			end 
		end}
		S = World:CreateSegment{Name = 'Ambient'}
        S:Toggle{flag = 'Ambient Enabled'}
        S:Colorpicker{flag = "Ambient1 Color"}
		S:Colorpicker{flag = "Ambient2 Color"}
		S = World:CreateSegment{Name = 'Color Shift'}
		S:Toggle{flag = 'Color Shift'}
        S:Colorpicker{flag = 'Color Shift1'}
		S:Colorpicker{flag = 'Color Shift2'}
		S = World:CreateSegment{Name = 'Fog'}
        S:Toggle{flag = 'Fog Enabled'}
        S:Colorpicker{flag = "Fog Color"}
		World:Slider{Name = 'Fog Start', flag = 'Fog Start', min = 0, max = 10000, default = 7500, float = 1}
		World:Slider{Name = 'Fog End', flag = 'Fog Start', min = 0, max = 10000, default = 7500, float = 1}
		S = World:CreateSegment{Name = 'Time'}
        S:Toggle{flag = 'Time Enabled'}
		S:Slider{flag = 'Time', min = 1, max = 24, default = 12, float = 1}
		World:Toggle{Name = 'Custom Skybox', flag = "Custom Skybox"}
		World:Dropdown{Name = 'Skybox:', flag = 'Skybox', options = {"Normal", "DoomSpire", "CatGirl", "Vibe", "Blue Aurora","Purple Clouds","Purple Nebula","Purple and Blue","Vivid Skies","Twighlight"}, min = 1, max = 1, callback = function()
			local Sky = Lighting:FindFirstChildWhichIsA("Sky")
			if flags["Custom Skybox"] then 
				Sky.SkyboxLf = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][1]..""
				Sky.SkyboxBk = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][2]..""
				Sky.SkyboxDn = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][3]..""
				Sky.SkyboxFt = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][4]..""
				Sky.SkyboxRt = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][5]..""
				Sky.SkyboxUp = "rbxassetid:// "..utility.SkyBoxes[flags["Skybox"]][6]..""
			else 
				Sky.SkyboxLf = "rbxassetid://600886090"
				Sky.SkyboxBk = "rbxassetid://600830446"
				Sky.SkyboxDn = "rbxassetid://600831635"
				Sky.SkyboxFt = "rbxassetid://600832720"
				Sky.SkyboxRt = "rbxassetid://600833862"
				Sky.SkyboxUp = "rbxassetid://600835177"			
			end 
		end}
    end
	-- 
	local Effects = World_Visuals:Sector{Side = 1}
    Effects:Title{Title = 'World Effects'} 
    do 
		Effects:Toggle{Name = "Enabled", flag = 'Color Correction', callback = function(Bool)
			ColorCorrectionEffect.Enabled = Bool
		end}
		--
		Effects:Colorpicker{Name = "Tint", flag = "Tint Color", callback = function()
			ColorCorrectionEffect.TintColor = flags["Tint Color"].Color
		end}
		-- 
		Effects:Slider{Name = "Saturation", flag = 'Saturation', min = 0, max = 2, default = 0, float = 0.01, callback = function(s)
			ColorCorrectionEffect.Saturation = s
		end}
		-- 
		Effects:Slider{Name = "Contrast", flag = 'Contrast', min = 0, max = 5, default = 0, float = 0.01, callback = function(s)
			ColorCorrectionEffect.Contrast = s
		end}
		-- 
		Effects:Slider{Name = "Brightness", flag = 'Brightness', min = 0, max = 1, default = 0, float = 0.01, callback = function(s)
			ColorCorrectionEffect.Brightness = s
		end}
		-- 
    end
	-- 
	local Local = World_Visuals:Sector{Side = 2}
    Local:Title{Title = 'Local'}
    do 	
		S = Local:CreateSegment{Name = 'Bullet Tracers'}
    	KHL = S:Toggle{flag = 'Bullet Tracers Enabled'}
		S:Colorpicker{flag = "Bullet Tracers Color1"}
		S:Colorpicker{flag = "Bullet Tracers Color2"}
		Sl = KHL:Settings()
        Sl:Toggle{Name = "Rainbow", flag = 'Rainbow Bullet Tracers'}
		Local:Dropdown{Name = 'Texture:', flag = 'Bullet Tracers Texture', options = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}, min = 1, max = 1}
		Local:Dropdown{Name = 'Type:', flag = 'Bullet Tracers Mode', options = {"Local", "Global"}, min = 1, max = 1}
		S = Local:CreateSegment{Name = 'Impact Points'}
    	KHL = S:Toggle{flag = 'Impact Points Enabled'}
		S:Colorpicker{flag = "Impact Points Color"}
		Local:Dropdown{Name = 'Material:', flag = 'Impact Points Material', options = {"ForceField", "Neon", "Plastic"}, min = 1, max = 1}
    end 	
end 
Window:Separator()
-- Character
do 
    local Character = Window:Tab{Name = 'Character', icon = "rbxassetid://6031215978"}	
	-- 
	local Movement = Character:Sector{Side = 1}
    do 
		Movement:Title{Title = 'Movement', Description = "Movement Stuffs >w<"}
		-- 
		local Speed = Movement:CreateSegment{Name = 'Speed'}
		Speed:Toggle{flag = 'Speed Enabled'}
		Movement:Slider{Name = "Speed", flag = 'Speed Amount', min = 1, max = 100, default = 1, editable = true}
		Movement:Slider{Name = "Float Height", flag = 'Float Height', min = 1, max = 100, default = 1, editable = true}
		S = Speed:Settings()
		S:Keybind{flag = "Speed Key", name = 'Key', type = 1}
		S:Toggle{Name = "Auto Jump", flag = 'Auto Jump'}
		S:Toggle{Name = "Float", flag = 'Float'}
		-- 
		local BHOP = Movement:CreateSegment{Name = "B-Hop"}
		BHOP:Toggle{flag = 'Bunny Hop'}
		Movement:Slider{Name = "Speed", flag = 'Bunny Hop Amount', min = 1, max = 10, default = 1, editable = true}
		S = BHOP:Settings()
		S:Keybind{Flag = "Bhop Key", name = 'Key', type = 1}
		-- 
		local Fly = Movement:CreateSegment{Name = 'Fly'}
		Fly:Toggle{flag = 'Fly Enabled', callback = function() 
			LocalPlayer.Character.HumanoidRootPart.Anchored = false
		end}
		Movement:Slider{Name = "Fly Speed", flag = 'Fly Amount', min = 1, max = 200, default = 1, editable = true}
		S = Fly:Settings()
		S:Keybind{Flag = "Fly Key", name = 'Key', type = 1, callback = function()
			LocalPlayer.Character.HumanoidRootPart.Anchored = false
		end}
    end 
	-- 
	local Character_Customization = Character:Sector{Side = 2}
	do 
		S = Character_Customization:CreateSegment{Name = 'Character Material'}
		KHL = S:Toggle{flag = 'Forcefield Character Enabled', callback = function()
			for i, v in pairs(LocalPlayer.Character:GetChildren()) do 
				if v:IsA("BasePart") then 
					v.Material = Enum.Material.Plastic
				end 
			end 
		end}
		S:Colorpicker{flag = "Forcefield Character Color"}
		Se = KHL:Settings()
		Se:Toggle{Name = "Rainbow", flag = "Rainbow Character"}
		S = Character_Customization:CreateSegment{Name = 'Gun Material'}
		KHL = S:Toggle{flag = 'Gun Material Enabled'}
		S:Colorpicker{flag = "Gun Material Color"}
		Sl = KHL:Settings()
		Sl:Toggle{Name = "Rainbow", flag = 'Rainbow Gun'}
		Sl:Toggle{Name = "Sine", flag = 'Sine Gun'}
		Character_Customization:Dropdown{Name = 'Material:', flag = 'Gun Material', options = {"ForceField", "Neon", "Plastic"}, min = 1, max = 1}
	end 
	-- 
	local Custom_Characters = Character:Sector{Side = 2}
	do 
		Custom_Characters:Title{Title = 'Custom Character'}
		Custom_Characters:Toggle{Name = "Enabled", flag = "Custom Character", callback = function()
			local function Weld(x,y)
				local W = Instance.new("Weld")
				W.Part0 = x
				W.Part1 = y
				local CJ = CFrame.new(x.Position)
				local C0 = x.CFrame:inverse()*CJ
				local C1 = y.CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = x
			end

			if flags["Custom Character"] then 
				for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
					if v:IsA("BasePart") or v:IsA("Decal") then 
						v.Transparency = 1 
					end 
				end 
				-- 
				Lynx["Connections"]["Custom Character"] = LocalPlayer.CharacterAdded:Connect(function()
					if Part then 
						Part:Destroy()
					end 
					-- 
					delay(5, function()
						Part = Instance.new("Part", Workspace) 
						Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
						Part.CanCollide = false
						--
						Character = Instance.new("SpecialMesh")
						Character.Parent = Part
						Character.MeshType = "FileMesh"
						--
						Character.Scale = utility.Characters[flags["CharacterFunny1"]][1]
						Character.TextureId= "http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][2]  .. "" 
						Character.MeshId="http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][3] ..""
						-- 
						Weld(LocalPlayer.Character.HumanoidRootPart, Part)
						-- 
						for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
							if v:IsA("BasePart") or v:IsA("Decal") then 
								v.Transparency = 1
							end 
						end 
					end)
				end)
				
				Part = Instance.new("Part", Workspace) 
				Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
				Part.CanCollide = false
				--
				Character = Instance.new("SpecialMesh")
				Character.Parent = Part
				Character.MeshType = "FileMesh"
				--
				Character.Scale = utility.Characters[flags["CharacterFunny1"]][1]
				Character.TextureId= "http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][2]  .. "" 
				Character.MeshId="http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][3] ..""
				-- 
				Weld(LocalPlayer.Character.HumanoidRootPart, Part)
			else 
				if Part then 
					Part:Destroy()
				end 
				-- 
				for i,v in pairs(LocalPlayer.Character:GetDescendants()) do 
                    if v:IsA("BasePart") or v:IsA("Decal") and v.Name ~= "CUFF" then 
                        v.Transparency = 0
                    end 
                    -- 
                    if v.Name == "CUFF" then 
                        v:Destroy()
                    end 
					-- 
					if v.Name == "LeftLowerArmFake" or v.Name == "HumanoidRootPart" or v.Name == "RightLowerArmFake" or v.Name == "LeftLowerLegFake" or v.Name == "RightLowerLegFake" then 
						v.Transparency = 1
					end 	
                end 
				-- 
				if Lynx["Connections"]["Custom Character"] then 
					Lynx["Connections"]["Custom Character"]:Disconnect()
				end 
				-- 
				if Lynx:GetTool() then 
					Lynx:GetTool().Handle.Transparency = 0 
				end 
			end 
		end}
		Custom_Characters:Dropdown{Name = 'Character', flag = 'CharacterFunny1', options = {"AmongUs", "SpongeBob", "Patrick", "Maxell", "Brian", "CapyBara", "Chicken", "Sonic"}, min = 1, max = 1, callback = function()
			if flags["Custom Character"] then 
				Character.Scale = utility.Characters[flags["CharacterFunny1"]][1]
				Character.TextureId = "http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][2]  .. "" 
				Character.MeshId ="http://www.roblox.com/asset/?id="..  utility.Characters[flags["CharacterFunny1"]][3] ..""
			end 
		end}
	end
	-- 
	local GripPosition = Character:Sector{Side = 2}
	do
		GripPosition:Title{Title = 'Grip Position', Description = "Changes Tool Position"}
		-- 
		GripPosition:Toggle{Name = "Enabled", flag = 'Grip Position'}
		--
		GripPosition:Slider{Name = 'X', flag = 'XX', min = -10, max = 10, default = 1, float = 0.01}
		GripPosition:Slider{Name = 'Y', flag = 'YY', min = -10, max = 10, default = 1, float = 0.01}
		GripPosition:Slider{Name = 'Z', flag = 'ZZ', min = -10, max = 10, default = 1, float = 0.01}
	end
end 
-- Anti-Aim
do 
    local Anti = Window:Tab{Name = 'Anti-Aim', icon = "rbxassetid://6034754445"}
    -- 
    local CFrame_Desync = Anti:Sector{Side = 1}
    do 
		CFrame_Desync:Title{Title = 'CFrame Desync', Description = "Serverside Position Changer"}
		-- 
		local THS = CFrame_Desync:Toggle{Name = "Enabled", flag = 'CFrame Desync', callback = function()
			if utility.Desyncs.OldCFrame then 
				LocalPlayer.Character.HumanoidRootPart.CFrame = utility.Desyncs.OldCFrame
			end 
		end}
		-- 
		S = THS:Settings()
		-- 
		S:Keybind{flag = "CFrame Desync Key", name = 'Key', type = 1, callback = LPH_JIT(function(Bool)
			if flags["CFrame Desync"] then 
				if not flags["CFrame Desync Key"].Active then 
					VisualizeCFrame:SetPrimaryPartCFrame(NewCFrame(999,999,999))
				end 
			end 
			-- 
			if utility.Desyncs.OldCFrame then 
				LocalPlayer.Character.HumanoidRootPart.CFrame = utility.Desyncs.OldCFrame
			end 
		end)}
		-- 
		CFrame_Desync:Dropdown{Name = 'Type', flag = 'CFrame Desync Preset', options = {"Nothing", "Upside Down", "Floor Plant", "Random", "Void"}, min = 1, max = 1}
		-- 
		CFrame_Desync:Slider{Name = "Random Range", flag = 'Random Teleport Range', min = 0, max = 30, default = 12, float = 1}
    end 
	-- 
	local CFrame_Desync1 = Anti:Sector{Side = 1}
	do  	
		CFrame_Desync1:Title{Title = 'Visualize', Description = "Visualizes Serverside Position"}
		-- 
		S = CFrame_Desync1:CreateSegment{Name = 'Enabled'}
		--
		S:Toggle{flag = "Visualize CFrame Desync", callback = function()
			VisualizeCFrame:SetPrimaryPartCFrame(CFrame.new(999,999,999))
		end}
		--
		S:Colorpicker{flag = "CFrame Visualizer Color", callback = function()
			for _, Part in next, VisualizeCFrame:GetChildren() do 
				if Part.Name ~= "HumanoidRootPart" then 
					Part.Color = flags["CFrame Visualizer Color"].Color
					Part.Transparency = flags["CFrame Visualizer Color"].Alpha
				end 
			end 
		end}
	end
	-- 
	local CFrame_Desync2 = Anti:Sector{Side = 1}
	do  	
		CFrame_Desync2:Title{Title = 'Custom Offset', Description = "Customize Your Position: XYZ"}
		-- 
		CFrame_Desync2:Slider{Name = "X", flag = 'XXX', min = -50, max = 50, default = 0, float = 0.5}
		-- 
		CFrame_Desync2:Slider{Name = "Y", flag = 'YYY', min = -50, max = 50, default = 0, float = 0.5}
		-- 
		CFrame_Desync2:Slider{Name = "Z", flag = 'ZZZ', min = -50, max = 50, default = 0, float = 0.5}
	end
	-- 
	local CFrame_Desync3 = Anti:Sector{Side = 1}
	do  	
		CFrame_Desync3:Title{Title = 'Custom Rotation', Description = "Customize Your Rotation: XYZ"}
		-- 
		CFrame_Desync3:Slider{Name = "X", flag = 'X Rotation', min = -180, max = 180, default = 0, float = 1}
		-- 
		CFrame_Desync3:Slider{Name = "Y", flag = 'Y Rotation', min = -180, max = 180, default = 0, float = 1}
		-- 
		CFrame_Desync3:Slider{Name = "Z", flag = 'Z Rotation', min = -180, max = 180, default = 0, float = 1}
		-- 
		CFrame_Desync3:Button{Name = 'Reset', callback = LPH_JIT(function()
			Window._FlagsSet["XXX"](0)
			Window._FlagsSet["YYY"](0)
			Window._FlagsSet["ZZZ"](0)
			Window._FlagsSet["X Rotation"](0)
			Window._FlagsSet["Y Rotation"](0)
			Window._FlagsSet["Z Rotation"](0)
		end)}
	end
    -- 
    local Velocity_Desync = Anti:Sector{Side = 2}
    do 
		Velocity_Desync:Title{Title = 'Anti-Lock', Description = "Messes up lockers prediction."}
		-- 
		local KHL = Velocity_Desync:Toggle{Name = "Enabled", flag = 'Velocity Desync'}
		-- 
		S = KHL:Settings()
		-- 
		S:Keybind{flag = "Velocity Desync Key", name = 'Key', type = 1, callback = LPH_JIT(function(Bool)
			if flags["Velocity Desync Notify"] then 
				ui:Notify{text = "Desync:".. tostring(flags["Velocity Desync Key"].Active).."", time = 5, style = "loading"}
			end 
		end)}
		-- 
		S:Toggle{Name = "Notify", flag = 'Velocity Desync Notify'}
		-- 
		Velocity_Desync:Dropdown{Name = 'Type', flag = 'Velocity Desync Preset', options = {"None", "HvH", "AntiBot", "Horizontal", "Sky", "Ground", "Desync"}, min = 1, max = 1}
	end 
end 
-- Misc
do 
	local Misc = Window:Tab{Name = 'Misc', icon = "rbxassetid://6031104650"}
	-- 
	local TargetStrafeSector = Misc:Sector{Side = 1}
	-- 
	do 
		TargetStrafeSector:Title{Title = 'Target Strafe', Description = "Strafes your target"}
		-- 
		TargetStrafeSector:Toggle{Name = "Enabled", flag = "Target Strafe"}
		-- 
		S = TargetStrafeSector:CreateSegment{Name = 'Visualize'}
		--
    	KHL = S:Toggle{flag = 'Visualize Strafe'}
		--
		S:Colorpicker{flag = "Visualize Strafe Color"}
		--
		TargetStrafeSector:Slider{Name = "Speed", flag = 'Target Strafe Speed', min = 0, max = 20, default = 5, float = 0.5}
		-- 
		TargetStrafeSector:Slider{Name = "Height", flag = 'Target Strafe Height', min = 0, max = 10, default = 0, float = 0.5}
		-- 
		TargetStrafeSector:Slider{Name = "Radius", flag = 'Target Strafe Radius', min = 0, max = 10, default = 5, float = 0.5}
	end 
	-- 
	local Teleports = Misc:Sector{Side = 2}
	do 
		Teleports:Title{Title = 'Buys', Description = "Auto-Buy Items"}
		-- 		
		Teleports:Toggle{Name = "Buy Ammo", flag = 'Buy Ammo'}
		-- 
		Teleports:Slider{Name = 'Amount', flag = 'Buy Ammo Amount', min = 1, max = 20, default = 5, float = 1}
		-- 
		Teleports:Button{Name = 'Buy', callback = LPH_JIT(function()
			local Old_Position = LocalPlayer.Character.HumanoidRootPart.CFrame
			-- 	
			LocalPlayer.Character.HumanoidRootPart.CFrame = utility["Auto Buy"]["Guns"][flags["Gun Name"]][1].Head.CFrame
			-- 
			Wait(0.3)
			-- 
			for i = 1, 20 do 
				Wait()
				fireclickdetector(utility["Auto Buy"]["Guns"][flags["Gun Name"]][1].ClickDetector)
			end 
			-- 
			Wait(0.3)
			-- 	
			LocalPlayer.Character.HumanoidRootPart.CFrame = Old_Position
			-- 
			if flags["Buy Ammo"] then 
				for i = 1, flags["Buy Ammo Amount"] do 
					Wait(0.175)
					local Old_Ammo_Position = LocalPlayer.Character.HumanoidRootPart.CFrame
					LocalPlayer.Character.HumanoidRootPart.CFrame = utility["Auto Buy"]["Guns"][flags["Gun Name"]][2].Head.CFrame
					Wait(0.175)
					-- 
					for i = 1, 10 do 
						Wait() 
						fireclickdetector(utility["Auto Buy"]["Guns"][flags["Gun Name"]][2].ClickDetector)
					end 
					-- 
					Wait(0.175)
					LocalPlayer.Character.HumanoidRootPart.CFrame = Old_Ammo_Position
					Wait(0.175)
				end 
			end 
		end)}	
		-- 
		Teleports:Toggle{Name = "Auto Buy Armor", flag = 'Auto Buy Armor'}
	end 
end 
Window:Separator()
-- Lua
do 
    local Settings = Window:Tab{Name = 'Settings', icon = "rbxassetid://6035067857"}
    -- 
    local Configs_Sector = Settings:Sector{Side = 1}
    Configs_Sector:Title{Title = 'Configuration', Description = "Save configurations."}
    do 
		Configs_Sector:Input({Name = "Name:", Flag = "Config Name", Focuses = true, Editable = true})
		--
		Configs_Sector:Button{Name = 'Save', callback = LPH_JIT(function()
			local config_name = flags["Config Name"]
            if config_name == "" then
                ui:Notify{text = 'Enter a config name!', time = 5, style = "loading"}
            end
            writefile("Lynx/Configs/" .. config_name .. ".cfg", Window:SaveConfig())
			ui:Notify{text = "Saved your config to: " .. config_name, time = 5, style = "loading"}
		end)}
		Configs_Sector:Button{Name = 'Load', callback = LPH_JIT(function()
			local config_name = flags["Config Name"]
			Window:LoadConfig(readfile("Lynx/Configs/" .. config_name .. ".cfg"))
			ui:Notify{text = "" .. config_name .. " has succesfully loaded!.", time = 5, style = "loading"}
		end)}
		Configs_Sector:Button{Name = 'Delete', callback = LPH_JIT(function()
			local selected_config = flags["Config Name"]
            if selected_config then
                delfile("Lynx/Configs/" .. selected_config .. ".cfg")
				ui:Notify{text = "" .. selected_config .. " has been deleted.", time = 5, style = "loading"}
			else 
				ui:Notify{text = "" .. selected_config .. " doesnt exist..", time = 5, style = "loading"}
            end
		end)}
    end Configs_Sector:Button{Name = 'Load', callback = LPH_JIT(function()
			local config_name = flags["Config Name"]
			Window:LoadConfig(readfile("Lynx/Configs/" .. config_name .. ".cfg"))
			ui:Notify{text = "" .. config_name .. " has succesfully loaded!.", time = 5, style = "loading"}
		end)}
    -- 
    local Settings_Sector = Settings:Sector{Side = 2}
    Settings_Sector:Title{Title = 'Settings'}
    do 
		Settings_Sector:Button{Name = 'Unload Cheat', callback = Lynx.Unload}
		-- 
		Settings_Sector:Keybind{Flag = "UI Bind", name = 'Key',key = Enum.KeyCode.Insert, type = 2, callback = LPH_JIT(function() ui:Toggle() end)}
		ui:Toggle()
		--
		Settings_Sector:Slider{Name = 'Rainbow Speed', flag = 'Rainbow Speed', min = 0.1, max = 5, default = 2, float = 0.1}
		-- 
		S = Settings_Sector:CreateSegment{Name = 'Keybind List'}
		-- 
		S:Toggle{Name = "Enabled", flag = "Keybind List", callback = function(Bool)
			Visuals.KeyBindList.SetVisibleList(Bool)
		end}
		-- 
		S:Colorpicker{flag = "Keybind List Color", callback = function()
			Visuals["KeyBindList"]["Drawings"]["Accent"].Color = flags["Keybind List Color"].Color
		end}
		-- 
		S = Settings_Sector:CreateSegment{Name = 'Watermark'}
		-- 
		S:Toggle{Name = "Enabled", flag = "Keybind List", callback = function(Bool)
			if Watermark ~= nil then 
				WatermarkLUA:SetVisible(Bool)
			end 
		end}
		-- 
		S:Colorpicker{flag = "Watermark Color", callback = function()
			WatermarkLUA["Drawings"].Accent.Color = flags["Watermark Color"].Color
		end}
	end 
end 
-- Scripts
do
    local Scripts = Window:Tab{Name = 'Scripts', icon = "rbxassetid://11419714821"}
    -- 
	local Settings_Sector = Scripts:Sector{Side = 1}
    Settings_Sector:Title{Title = 'Settings'}
    do 
		Settings_Sector:Dropdown{Name = 'LUAs', flag = 'LUAs', options = {"ChinaHat", "BetterGame", "Minecraft"}, min = 1, max = 1}
		-- 
		Settings_Sector:Button{Name = 'Load', callback = function()
			loadfile("Lynx/Luas/".. flags["LUAs"]..".lua")()
		end}
    end 
	-- 
	--[[local Map_Sector = Scripts:Sector{Side = 2}
	-- 
	Map_Sector:Dropdown{Name = 'Maps', flag = 'Map', options = {"MM2 MAP","Parkour","Office","Anarchy"}, min = 1, max = 1}
	-- 
	Map_Sector:Button{Name = 'Load', callback = function()
		LocalPlayer.Character.HumanoidRootPart.CFrame = utility["Maps"][flags["Map"]]--[[[2]]
	--end}
	--
end 
-- Looped Functions
do 
	--LOOPED FUNCTIONS
	function Lynx:Cursor(Frame)
		if flags["Cursor"] and flags["Spin"] then 
			local MousePosition = NewVector2(Mouse.X, Mouse.Y + 36)
			-- 
			local SpinSize = flags["Dynamic Gap Enabled"] and (Abs(Sin(tick() * flags["Dynamic Gap Speed"])) * flags["Cursor Gap"] / 4) + (flags['dot'] and 5 or 1) or flags["Cursor Gap"] / 4
			local SpinSpeed = flags["Spin Speed"] / 5
			local Radius = flags["Cursor Radius"] / 4 * 5
			-- 
			SpinAngle = SpinAngle + Rad((SpinSpeed * 10) * Frame);
			-- 
			if flags['Dot'] then 
				utility.Cursor.Dots[1].Position = NewVector2(Mouse.X - 1, Mouse.Y + 36 - 1)
				utility.Cursor.Dots[2].Position = NewVector2(Mouse.X - 2, Mouse.Y + 36 - 2)
				utility.Cursor.Dots[2].Color = NewRGB(0,0,0)
			end 
			--
			do -- // Inlines
				utility.Cursor.Lines[1].From = (MousePosition + (NewVector2(Cos(SpinAngle), Sin(SpinAngle))* (SpinSize + 1)))
				utility.Cursor.Lines[1].To = (utility.Cursor.Lines[1].From + (NewVector2(Cos(SpinAngle), Sin(SpinAngle)) * (Radius * 5)))
				--
				utility.Cursor.Lines[2].From = (MousePosition + (NewVector2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi))* (SpinSize + 1)))
				utility.Cursor.Lines[2].To = (utility.Cursor.Lines[2].From + (NewVector2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi)) * (Radius * 5)))
				--
				utility.Cursor.Lines[3].From = (MousePosition + (NewVector2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi))* (SpinSize + 1)))
				utility.Cursor.Lines[3].To = (utility.Cursor.Lines[3].From + (NewVector2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi)) * (Radius * 5)))
				--
				utility.Cursor.Lines[4].From = (MousePosition + (NewVector2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (SpinSize + 1)))
				utility.Cursor.Lines[4].To = (utility.Cursor.Lines[4].From + (NewVector2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (Radius * 5)))
			end
			--
			do -- // Outlines 
				utility.Cursor.Outlines[1].From = (MousePosition + (NewVector2(Cos(SpinAngle), Sin(SpinAngle)) * (SpinSize + 1)))
				utility.Cursor.Outlines[1].To = (utility.Cursor.Outlines[1].From + (NewVector2(Cos(SpinAngle), Sin(SpinAngle)) * ((Radius * 5) + 0.05)))
				--
				utility.Cursor.Outlines[2].From = (MousePosition + (NewVector2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi))* (SpinSize + 1)))
				utility.Cursor.Outlines[2].To = (utility.Cursor.Outlines[2].From + (NewVector2(Cos(SpinAngle + Pi), Sin(SpinAngle + Pi)) * ((Radius * 5) + 0.05)))
				--
				utility.Cursor.Outlines[3].From = (MousePosition + (NewVector2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi))* (SpinSize + 1)))
				utility.Cursor.Outlines[3].To = (utility.Cursor.Outlines[3].From + (NewVector2(Cos(SpinAngle + Halfpi), Sin(SpinAngle + Halfpi)) * ((Radius * 5) + 0.05)))
				--
				utility.Cursor.Outlines[4].From = (MousePosition + (NewVector2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * (SpinSize + 1)))
				utility.Cursor.Outlines[4].To = (utility.Cursor.Outlines[4].From + (NewVector2(Cos(SpinAngle + Halfpi * 3), Sin(SpinAngle + Halfpi * 3)) * ((Radius * 5) + 0.05)))
			end
		end     
	end
	--
	function Lynx:CharacterMaterial()
		if flags["Forcefield Character Enabled"] then 
			for i, v in pairs(LocalPlayer.Character:GetChildren()) do 
				if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then 
					v.Material = Enum.Material.ForceField
					v.Transparency = flags["Forcefield Character Color"].Transparency
					if flags["Rainbow Character"] then 
						v.Color = Lynx:Rainbow(flags["Rainbow Speed"])
					else 
						v.Color = flags["Forcefield Character Color"].Color
					end 
				end 
			end 
		end 
	end 
	-- 
	function Lynx:GunMaterial()
		if flags["Gun Material Enabled"] then 
			local Tool = Lynx:GetTool()
			if Tool ~= nil then 
				for i, v in pairs(Tool:GetChildren()) do 
					if v:IsA("MeshPart") then 
						v.TextureID = ""
						v.Material = Enum.Material[flags["Gun Material"]]
						v.Color = flags["Rainbow Gun"] and Lynx:Rainbow(flags["Rainbow Speed"]) or flags["Gun Material Color"].Color
						v.Transparency = flags["Sine Gun"] and utility.Sine + 0.4 or flags["Gun Material Color"].Transparency
					end 
				end 
			end 
		end 
	end 
	-- 
	function Lynx:Speed()
		if flags["Speed Enabled"] and flags["Speed Key"].Active then 
			local Char, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
			if Char and Humanoid and RootPart then  
				RootPart.CFrame = RootPart.CFrame + (Humanoid.MoveDirection * flags["Speed Amount"] * 0.03) 
				-- 
				if flags["Auto Jump"] and Humanoid.FloorMaterial ~= Enum.Material.Air and not flags["Float"] then     
					Humanoid:ChangeState("Jumping")
					Humanoid.UseJumpPower = false  
				end 	
				-- 
				if flags["Float"] then 
					local X, Y, Z = RootPart.CFrame:ToEulerAnglesYXZ()
					RootPart.CFrame = NewCFrame(RootPart.CFrame.X, flags["Float Height"], RootPart.CFrame.Z) * NewAngle(X, Y, Z)
					Humanoid:ChangeState("Freefall")
				end 
			end 
		end 
	end 
	-- 
	function Lynx:Bhop()
		if flags["Bunny Hop"] and flags["Bhop Key"].Active then 
			local Char, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
			if Char and Humanoid and RootPart then 
				if Humanoid.FloorMaterial == Enum.Material.Air then 
					RootPart.CFrame = RootPart.CFrame + (Humanoid.MoveDirection * flags["Bunny Hop Amount"] * 0.03) 	
					Humanoid.UseJumpPower = false  
				end 
			end 
		end 
	end 
	-- 
	function Lynx:Fly() 
		if flags["Fly Enabled"] and flags["Fly Key"].Active then 
			local Char, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
			if Char and Humanoid and RootPart then 
				local FlyPosition = Vector3.new(0, 0, 0)
				local CCV = Camera.CFrame.lookVector
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.W) then
					FlyPosition = FlyPosition + CCV
				end
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.S) then
					FlyPosition = FlyPosition - CCV
				end
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.D) then
					FlyPosition = FlyPosition + Vector3.new(-CCV.Z, 0, CCV.X)
				end
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.A) then
					FlyPosition = FlyPosition + Vector3.new(CCV.Z, 0, -CCV.x)
				end
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.Space) then
					FlyPosition = FlyPosition + Vector3.new(0, 1, 0)
				end
				-- 
				if InputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					FlyPosition = FlyPosition - Vector3.new(0, 1, 0)
				end
				-- 
				if FlyPosition.Unit.y == FlyPosition.Unit.y then
					LocalPlayer.Character.HumanoidRootPart.Anchored = false 
					LocalPlayer.Character.HumanoidRootPart.Velocity = FlyPosition.Unit * flags["Fly Amount"]
				else 
					LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
					LocalPlayer.Character.HumanoidRootPart.Anchored = true
				end 
			end 
		end 
	end 
	-- 
	function Lynx:GripPosition()
		if flags["Grip Position"] and Lynx:GetTool() ~= nil and Lynx:GetTool().GripPos ~= Vector3.new(flags["XX"],flags["YY"],flags["ZZ"]) then 
			local tool = Lynx:GetTool()
			if tool ~= nil then 
				tool.Parent = LocalPlayer.Backpack
				tool.GripPos = Vector3.new(flags["XX"],flags["YY"],flags["ZZ"])
				tool.Parent = LocalPlayer.Character
			end 
		end 
	end  
	-- 
	function Lynx:RotateCursor() 
		if flags["Da Hood Cursor Spin"] then 
			LocalPlayer.PlayerGui.MainScreenGui.Aim.Rotation = LocalPlayer.PlayerGui.MainScreenGui.Aim.Rotation + flags["Cursor Spin Speed for DH"]
		end 
	end 
	-- 
	function Lynx:SilentAim()
		if flags["Silent Aim Enabled"] and flags["Silent Aim Key"].Active then 
			Lynx.Silent.Check = true 
			-- 
			if flags["Silent Aim Type"] ~= "Target Aim" and flags["RageBot"] == false then 
				Lynx.Silent.Target = Lynx:GetClosestPlayer()
			elseif (flags["RageBot"] == true) then 
				Lynx.Silent.Target = Lynx:findNearestTargetInRadius(LocalPlayer.Character.HumanoidRootPart.Position, math.huge)
			end 
			-- 
			if Lynx.Silent.Target and Lynx.Silent.Target.Character and Lynx:GetPlayerStatus() then 
				if (Find(flags["Silent_Aim_Checks"], "Wall") and not Lynx:RayCast(Lynx.Silent.Target.Character.HumanoidRootPart, Lynx:GetOrigin("Handle"), {Lynx:GetCharacter(LocalPlayer)})) then Lynx.Silent.Check = false end
				if (Find(flags["Silent_Aim_Checks"], "Visible") and (Lynx.Silent.Target.Character.HumanoidRootPart.Transparency ~= 1)) then Lynx.Silent.Check = false end 
				if (Find(flags["Silent_Aim_Checks"], "ForceField") and Lynx.Silent.Target.Character.HumanoidRootPart:FindFirstChildOfClass("ForceField")) then Lynx.Silent.Check = false end
				if (Find(flags["Silent_Aim_Checks"], "Knocked") and not Lynx:KnockCheck(Lynx.Silent.Target)) then Lynx.Silent.Check = false end
				-- 
				Lynx.Silent.HitPart = ((flags["Air Prediction Method"] == "Part" and Lynx.Silent.Target.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall) and flags["Air Prediction Part"]) or Lynx:GetClosestPart(Lynx.Silent.Target, flags["Silent Aim HitPart"]).Name
				Lynx.Silent.Prediction = (flags["Auto-Prediction"] and Lynx:AutoPrediction()) or Lynx.Silent.Prediction
				--
				if not Lynx.Silent.HitPart then return end 
				-- 
				if (flags["Resolver"] == true and flags["Resolver Key"].Active == true) then 
					Lynx.Silent.Resolver[1] = Lynx:CalculateAbsolutePosition(Lynx.Silent.Target)
				end 
				-- 
				if flags["Bypass Aim Viewer"] then 
					local Offset = (flags["Air Prediction Method"] == "Offset" and Lynx.Silent.Target.Character.Humanoid.FloorMaterial == Enum.Material.Air) and NewVector3(0.0001, Lynx.Silent.Offset, 0.0001) or NewVector3(0.001, 0.001, 0.001)
					-- 
					if (flags["Resolver"] == true and flags["Resolver Key"].Active == true and Lynx.Silent.Resolver[1]) then 
						Lynx.Silent.Position = (Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Resolver[1] * Lynx.Silent.Prediction) + Offset) 
					else 
						Lynx.Silent.Position = (Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Target.Character.HumanoidRootPart.Velocity * Lynx.Silent.Prediction) + Offset) 
					end 
				end 
				-- 
				if Lynx.Silent.Position then 
					if flags["Auto-Shoot"] then 
						local Tool = Lynx:GetTool()
						if Tool and Tool:FindFirstChild("Ammo") and Tool:FindFirstChild("Ammo") ~= 0 then
							if (Lynx.Silent.Check == true) and InputService:GetFocusedTextBox() == nil then  
								VirtualUser:Button1Down(Vector2.new(), Workspace.CurrentCamera.CFrame)
								RunService.RenderStepped:Wait()
								VirtualUser:Button1Down(Vector2.new(), Workspace.CurrentCamera.CFrame)
							end 
							-- 
							if Tool:FindFirstChild("Ammo") then
								local Ammo = Tool:FindFirstChild("Ammo").Value
								if Ammo == 0 then
									game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", Tool)
								end
							end
						end 
					end
					-- 
					local Position1, OnScreen = Camera:WorldToViewportPoint(Lynx.Silent.Position)
					local MousePosition = NewVector2(Mouse.X, Mouse.Y + 36)
					local Magn = (MousePosition - NewVector2(Position1.X, Position1.Y)).Magnitude
					-- 
					if utility.Renders[1].Visible then 
						if (Magn >= utility.Renders[1].Radius) then  Lynx.Silent.Check = false end 
					end
					-- 
					if flags["Visualize Part Enabled"] then 
						utility.Parts[1].CFrame = flags["Show Prediction"] and CFrame.new(Lynx.Silent.Position) or Lynx.Silent.Target.Character.HumanoidRootPart.CFrame 
						utility.Parts[1].Material = Enum.Material[flags["Part Material"]]
					else 
						utility.Parts[1].CFrame = CFrame.new(999,999,999)
					end 
					-- 
					if flags["Visualize Part Chams Enabled"] then 	
						if game.Workspace.Terrain["Backtrack"].Model == nil then return end 
						for _, Value in pairs(game.Workspace.Terrain["Backtrack"].Model:GetChildren()) do 
							if Value:IsA("BasePart") then 
								Value.Position = Lynx.Silent.Target.Character[Value.Name].Position + Lynx.Silent.Target.Character.HumanoidRootPart.Velocity * Lynx.Silent.Prediction
								Value.Rotation = Lynx.Silent.Target.Character[Value.Name].Rotation
							end     
						end 						
					end
					-- 
					if flags["Look-At"] then 
						LocalPlayer.Character.Humanoid.AutoRotate = false 
						local NearestPos = CFrame.new(LocalPlayer.Character.PrimaryPart.Position, Vector3.new(Lynx.Silent.Target.Character.HumanoidRootPart.Position.X, LocalPlayer.Character.PrimaryPart.Position.Y, Lynx.Silent.Target.Character.HumanoidRootPart.Position.Z))
						LocalPlayer.Character:SetPrimaryPartCFrame(NearestPos)
					end 
					-- 
					if flags["Draw Dot"] then 
						if OnScreen then 
							utility.Renders[5].Position = NewVector2(Position1.X, Position1.Y)
							utility.Renders[5].Visible = true  
						else 
							utility.Renders[5].Visible = false   
						end 
					end 
					-- 
					if flags["Draw Tracer Enabled"] then  
						if OnScreen then 
							utility.Renders[6].From = NewVector2(Mouse.X, Mouse.Y + 36)
							utility.Renders[6].To = NewVector2(Position1.X, Position1.Y)
							utility.Renders[6].Visible = true 
							utility.Renders[7].Color = Color3.fromRGB(0, 0, 0)
							-- 
							if flags["Tracer Outline"] then 
								utility.Renders[7].From = NewVector2(Mouse.X, Mouse.Y + 36)
								utility.Renders[7].To = NewVector2(Position1.X, Position1.Y)
								utility.Renders[7].Visible = true 
							end 
						else 
							utility.Renders[6].Visible = false   
							utility.Renders[7].Visible = false   
						end 
					end
				end 
			end 
		end 
	end 
	-- 
	Lynx.AimViwerBypass = function()
        if flags["Bypass Aim Viewer"] then 
			if flags["Silent Aim Enabled"] and flags["Silent Aim Key"].Active then 
				local Offset = (flags["Air Prediction Method"] == "Offset" and Lynx.Silent.Target.Character.Humanoid.FloorMaterial == Enum.Material.Air) and NewVector3(0.0001, Lynx.Silent.Offset, 0.0001) or NewVector3(0.001, 0.001, 0.001)
				--
				if (flags["Resolver"] == true and flags["Resolver Key"].Active == true and Lynx.Silent.Resolver[1]) then 
					ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Resolver[1] * Lynx.Silent.Prediction) + Offset) 
				else 
					ReplicatedStorage.MainEvent:FireServer("UpdateMousePos", Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Target.Character.HumanoidRootPart.Velocity * Lynx.Silent.Prediction) + Offset) 
				end 
			end 
        end 
    end
	-- 
	function Lynx:AimAssist()
		if flags["Aim Assist Enabled"] and flags["Aim Assist Key"].Active and Lynx.Assist.Target and Lynx:GetPlayerStatus(Lynx.Assist.Target) then 
			local Char, Humanoid, RootPart = Lynx:ValidateClient(Lynx.Assist.Target)
			if Char and Humanoid and RootPart then 
				-- 
				if not flags["Sticky Aim"] then 
					Lynx.Assist.Target = Lynx:GetClosestPlayer()
				end 
				--
				local MousePosition = NewVector2(Mouse.X, Mouse.Y + 36)
				local HitPart = Lynx:GetClosestPart(Lynx.Assist.Target, flags["Aim Assist HitPart"]).Name
				local Prediction = flags["Aim Assist Prediction"] or 0 
				local Shake = flags["Camera Shake"] and NewVector3(Random(0, flags["X"] * 20)/50, Random(0, flags["Y"] * 20)/50, Random(0, flags["Z"] * 20)/50) or NewVector3(0, 0, 0)
				--
				local Tick = tick()
				-- FOVs 
				local Position1, OnScreen = Camera:WorldToViewportPoint(Char[HitPart].Position)
				local Magn = (MousePosition - NewVector2(Position1.X, Position1.Y)).Magnitude
				--
				if flags["Aim Assist FOV Enabled"] then 
					if (Magn >= flags["Aim Assist FOV Radius"]) then return end 
				end 
				--
				if flags["Deadzone Enabled"] then 
					if (Magn <= flags["Deadzone Radius"]) then return end 
				end 
				-- Dropdown Checks
				if ((Find(flags["Aim_Assist_Checks"], "Wall")) and not Lynx:RayCast(Char[HitPart], Lynx:GetOrigin("Torso"), {Lynx:GetCharacter(LocalPlayer)})) then return end
				if ((Find(flags["Aim_Assist_Checks"], "Alive")) and not Lynx:ClientAlive(Lynx.Assist.Target, Char, Humanoid)) then return end
				if ((Find(flags["Aim_Assist_Checks"], "Team")) and not (Lynx:CheckTeam(LocalPlayer, Lynx.Assist.Target))) then return end
				if ((Find(flags["Aim_Assist_Checks"], "ForceField")) and Char:FindFirstChildOfClass("ForceField")) then return end 
				if (not ((Camera.CFrame.Position - RootPart.Position).Magnitude <= flags["Aim Assist Distance"])) then return end
				if (Find(flags["Aim_Assist_Checks"], "Knocked") and not Lynx:KnockCheck(Lynx.Assist.Target)) then return end

				-- Moving Camera
				if ((Tick - utility.LastTick) >= (flags["Stutter Amount"] / 1000)) then 
					utility.LastTick = Tick
					Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.p, Char[HitPart].Position + (RootPart.Velocity * Prediction) + (Shake)), (100 - flags["Smoothness Amount"]) / 100)
				end 
			end
		end 
	end 
	-- 
	function Lynx:AntiLock()
		local Character, Humanoid, RootPart = Lynx:ValidateClient(LocalPlayer)
		if Character and Humanoid and RootPart then 
			utility.Desyncs.OldVelocity = LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity
			utility.Desyncs.OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
			-- 	
			if flags["Velocity Desync"] and flags["Velocity Desync Key"].Active then 
				LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = utility.Desyncs[flags["Velocity Desync Preset"]]
				if flags["Velocity Desync Preset"] == "Desync" then 
					LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * NewAngle(0,Rad(0.001),0)   
				end 
			end 	
			--
			if flags["CFrame Desync"] and flags["CFrame Desync Key"].Active then 
				local CFramePositions = {
					["Nothing"] = LocalPlayer.Character.HumanoidRootPart.CFrame,
					["Random"] = (CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position) + NewVector3(Random(-flags["Random Teleport Range"], flags["Random Teleport Range"]), Random(-flags["Random Teleport Range"], flags["Random Teleport Range"]), Random(-flags["Random Teleport Range"], flags["Random Teleport Range"]))) * NewAngle(Rad(Random(-180, 180)), Rad(Random(-180, 180)), Rad(Random(-180, 180))),
					["Upside Down"] = LocalPlayer.Character.HumanoidRootPart.CFrame * NewAngle(0, 0, Rad(-180)),
					["Floor Plant"] = LocalPlayer.Character.HumanoidRootPart.CFrame * NewCFrame(0, -4, 0) * NewAngle(0, Rad(Random(1,360)), Rad(-180)),					
					["Void"] = LocalPlayer.Character.HumanoidRootPart.CFrame * NewCFrame(0, -2^20, 0)
				}
				-- 
				LocalPlayer.Character.HumanoidRootPart.CFrame = CFramePositions[flags["CFrame Desync Preset"]] * NewCFrame(flags["XXX"], flags["YYY"], flags["ZZZ"]) * NewAngle(Rad(flags["X Rotation"]), Rad(flags["Y Rotation"]), Rad(flags["Z Rotation"]))
				-- 
				if flags["Target Strafe"] and Lynx.Silent.Target and flags["Silent Aim Enabled"] and flags["Silent Aim Key"].Active and Lynx:GetPlayerStatus(Lynx.Silent.Target) then 
					utility.Angle += flags["Target Strafe Speed"]
					LocalPlayer.Character.HumanoidRootPart.CFrame = Lynx.Silent.Target.Character.HumanoidRootPart.CFrame * NewAngle(0, Rad(utility.Angle), 0) * NewCFrame(0, flags["Target Strafe Height"], flags["Target Strafe Radius"])
				end 
				-- 
				if flags["Visualize CFrame Desync"] then 
					VisualizeCFrame:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame)
				end 
			end 
			-- 
			RunService.RenderStepped:Wait() 
			-- 	
			LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = utility.Desyncs.OldVelocity
			if flags["CFrame Desync"] and flags["CFrame Desync Key"].Active then
				LocalPlayer.Character.HumanoidRootPart.CFrame = utility.Desyncs.OldCFrame
			end 
		end 
	end 
	-- 
	function Lynx:GunSound() 
		local Tool = Lynx:GetTool()
		-- 
		if Tool and Tool:FindFirstChild("Handle") and flags["Custom Gun Sounds"] and Tool:FindFirstChild("Ammo") then 
			for _, Value in pairs(Tool.Handle:GetChildren()) do 
				if Value:IsA("Sound") and Value.Name ~= "NoAmmo" and Tool.Handle ~= nil then 
                    Value.SoundId = "rbxassetid://"..utility.sfx[flags["Sound Effect"]]
				end 
			end
		end 	
	end 
	-- 
	function Lynx:WorldVisuals() 
		if flags["World Visuals Enabled"] == true then 
			if flags["Ambient Enabled"] then 
                if Lighting.Ambient ~= flags["Ambient1 Color"].Color then 
                    Lighting.Ambient = flags["Ambient1 Color"].Color
                end 
                if Lighting.OutdoorAmbient ~= flags["Ambient2 Color"].Color then 
                    Lighting.OutdoorAmbient = flags["Ambient2 Color"].Color
                end 
            end 
			--
			if flags["Color Shift"] then 
                if Lighting.ColorShift_Bottom ~= flags["Color Shift1"].Color then 
                    Lighting.ColorShift_Bottom = flags["Color Shift1"].Color
                end 
                if Lighting.ColorShift_Top ~= flags["Color Shift2"].Color then 
                    Lighting.ColorShift_Top = flags["Color Shift2"].Color
                end 
            end 
			-- 
			if flags["Fog Enabled"] then 
                if Lighting.FogColor ~= flags["Fog Color"].Color then 
                    Lighting.FogColor = flags["Fog Color"].Color
                end 
                if Lighting.FogEnd ~= flags["Fog Start"] then 
                    Lighting.FogEnd = flags["Fog Start"]
                end 
                if Lighting.FogStart ~= flags["Fog End"] then 
                    Lighting.FogStart = flags["Fog End"]
                end 
            end 
			-- 
			if flags["Time Enabled"] then
                if Lighting.ClockTime ~= flags["Time"] then 
                    Lighting.ClockTime = flags["Time"]
                end 
            end
		end 
	end 
	-- 
	function Lynx:AutoPrediction()
		local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    	local split = string.split(pingvalue,'(')
    	local ping = tonumber(split[1])
		local Predictions = readfile("Lynx/Assets/Auto Prediction.txt"):split("\n")
		--  
		local Prediction = nil 
		--
		for Index = 1, #Predictions do 
			if ping < Index*10 then 
				Prediction = Predictions[Index]
				return Prediction
			end 
		end 
		-- 
		if flags["Ping Based"] then 
			Prediction = pingvalue/1000*2.5
			return Prediction
		end
		-- 
		if Prediction == nil then 
			return 0.1413
		end 
	end 
end 
-- Main Loop
Lynx:Connection(RunService.Heartbeat, LPH_JIT(function(Frame)
	Lynx:Cursor(Frame)
	-- 
	Lynx:SilentAim()
	-- 
	Lynx:Speed()
	-- 
	if flags["Target Strafe"] and Lynx.Silent.Target ~= nil and flags["Silent Aim Enabled"] == true and flags["Silent Aim Key"].Active and flags["CFrame Desync"] == false then 
		utility.Angle += flags["Target Strafe Speed"]
		LocalPlayer.Character.HumanoidRootPart.CFrame = Lynx.Silent.Target.Character.HumanoidRootPart.CFrame * NewAngle(0, Rad(utility.Angle), 0) * NewCFrame(0, flags["Target Strafe Height"], flags["Target Strafe Radius"])
	end 
	-- 
	if Lynx:GetPlayerStatus() then 
		Lynx:AimAssist()
		-- 
		Lynx:RotateCursor() 
		-- 
		Lynx:GripPosition()
		-- 
		Lynx:GunSound() 
		-- 
		for _, Script in pairs(LocalPlayer.Character:GetChildren()) do
			if Script:IsA("Script") and Script.Name ~= "Health" and Script.Name ~= "Sound" and Script:FindFirstChild("LocalScript") then
				Script:Destroy()
			end
		end
	end
	-- 
	if Visuals["KeyBindList"]["Drawings"]["Accent"].Visible == true then 
		Visuals["KeyBindList"]["Text"] = ""
		--
		Visuals.KeyBindList.AddValue(flags["Velocity Desync Key"].Active, flags["Velocity Desync"], "Velocity Desync", flags["Velocity Desync Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Silent Aim Key"].Active, flags["Silent Aim Enabled"], flags["Silent Aim Type"], flags["Silent Aim Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Aim Assist Key"].Active, flags["Aim Assist Enabled"], "Aim Assist", flags["Aim Assist Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Speed Key"].Active, flags["Speed Enabled"], "CFrame Speed", flags["Speed Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Fly Key"].Active, flags["Fly Enabled"], "Fly", flags["Fly Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Bhop Key"].Active, flags["Bunny Hop"], "B-Hop", flags["Bhop Key"].Key)
		Visuals.KeyBindList.AddValue(flags["CFrame Desync Key"].Active, flags["CFrame Desync"], "CFrame Desync", flags["CFrame Desync Key"].Key)
		Visuals.KeyBindList.AddValue(flags["Resolver Key"].Active, flags["Resolver"], "Resolver", flags["Resolver Key"].Key)
		-- 
		Visuals["KeyBindList"]["Drawings"].Key.Text = Visuals["KeyBindList"]["Text"] 
		--
		Visuals["KeyBindList"]["Drawings"].Frame.Size = Vector2.new(Visuals["KeyBindList"]["Drawings"].Frame.Size.X, Visuals["KeyBindList"]["Drawings"].Key.TextBounds.Y + 20)
		Visuals["KeyBindList"]["Drawings"].Inner.Size = Vector2.new(Visuals["KeyBindList"]["Drawings"].Frame.Size.X - 2, Visuals["KeyBindList"]["Drawings"].Key.TextBounds.Y + 18)
		Visuals["KeyBindList"]["Drawings"].Gradient.Size = Visuals["KeyBindList"]["Drawings"].Inner.Size
	end 
	-- 
	Lynx:Bhop() 
	Lynx:Fly() 	
end))
-- 
Lynx:Connection(RunService.Heartbeat, LPH_JIT(function(Frame)
	Lynx:AntiLock()
end)) 
-- 
local Tick = tick() 
Lynx:Connection(RunService.RenderStepped, LPH_JIT(function()
	if flags["PlayerESP_Enabled"] then 
		for _,Player in pairs(Players:GetPlayers()) do
			local PlayerDrawing = Visuals["Drawings"][Player]
			-- 
			if not PlayerDrawing then continue end
			-- 
			for _,Drawing in pairs(PlayerDrawing) do
				Drawing.Visible = false
			end
			-- 
			for _, Drawing in pairs(Visuals["Drawings"][Player]["Corners"]) do
				if Drawing then 
					Drawing.Visible = false 
				end 
			end 
			-- 
			local Character = Player.Character
			local RootPart, Humanoid, Head = Character and Character:FindFirstChild("HumanoidRootPart"), Character and Character:FindFirstChildOfClass("Humanoid"), Character and Character:FindFirstChild("Head")
			-- 
			if not Character or not RootPart or not Humanoid then continue end
			-- 
			local DistanceFromCharacter = (Camera.CFrame.Position - RootPart.Position).Magnitude
			local MaxDistance = flags["ESP Distance"] or 25000
			local Hightlight_Target = false -- EDIT LATER or flags and flags["esp_hightlight_target"]
			-- 
			local Pos, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
			--
			if MaxDistance < DistanceFromCharacter then continue end 
			--
			if not OnScreen then
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Arrows"] then
					local Tri = PlayerDrawing.Arrow
					local Tri2 = PlayerDrawing.ArrowOutline
					-- 		
					local rootpartpos = RootPart.Position
					-- 
					Tri.Visible = true
					Tri2.Visible = true
					-- 
					local relativePos = Camera.CFrame:PointToObjectSpace(rootpartpos)
					local angle = math.atan2(-relativePos.y, relativePos.x)

					local size = Floor(viewportSize.x * 0.0078125)
					local max_size = Floor(viewportSize.x * 0.0260416666667)

					local distance = Vector3.new().Dot(relativePos.Unit, relativePos)
					local arrow_dist = flags["PlayerESP_ArrowRadius"]
					local arrow_size = flags["PlayerESP_ArrowSize"] and Lynx:Map(distance, 1, 100, max_size, size) or size
					-- 
					arrow_size = arrow_size > max_size and max_size or arrow_size < size and size or arrow_size
					direction = Vector2.new(math.cos(angle), math.sin(angle))
					-- 
					local pos
					if arrow_dist ~= 101 then
						pos = ( direction * viewportSize.x * arrow_dist / 200) + (viewportSize * 0.5)
					end
					-- 
					if not pos or pos.y > viewportSize.y - 5 or pos.y < 5 then
						pos = Lynx:AngleToEdge(angle, 5)
					end
					-- 
					Tri.PointA = pos
					Tri2.PointA = pos  
					Tri.PointB = pos - Lynx:getRotate(direction, 0.5) * arrow_size 
					Tri2.PointB = pos - Lynx:getRotate(direction, 0.5) * arrow_size 
					Tri.PointC = pos - Lynx:getRotate(direction, -0.5) * arrow_size 
					Tri2.PointC = pos - Lynx:getRotate(direction, -0.5) * arrow_size
					-- 
					Tri.Color = flags["PlayerESP_ArrowColor"].Color
					Tri.Transparency = 1 - flags["PlayerESP_ArrowColor"].Alpha
					-- 
					Tri2.Color = flags["PlayerESP_ArrowOutline"].Color
					Tri2.Transparency = 1 - flags["PlayerESP_ArrowOutline"].Alpha
					Tri2.Filled = false
				end
			else
				local Size = (Camera:WorldToViewportPoint(RootPart.Position - NewVector3(0, 3, 0)).Y - Camera:WorldToViewportPoint(RootPart.Position + NewVector3(0, 2.6, 0)).Y) / 2
				local BoxSize = NewVector2(Floor(Size * 1.5), Floor(Size * 1.9))
				local BoxPos = NewVector2(Floor(Pos.X - Size * 1.5 / 2), Floor(Pos.Y - Size * 1.6 / 2))
				-- 
				if flags["PlayerESP_Box"] and flags["PlayerESP_Box_Type"] then -- // Corner Boxes
					BoxCenter = Math:RoundVector(NewVector2(BoxPos.X + BoxSize.X / 2, BoxPos.Y + BoxSize.Y / 2));
					TL = Math:RoundVector(NewVector2(BoxCenter.X - BoxSize.X / 2, BoxCenter.Y - BoxSize.Y / 2));
					BL = Math:RoundVector(NewVector2(BoxCenter.X - BoxSize.X / 2, BoxCenter.Y + BoxSize.Y / 2));
					TR = Math:RoundVector(NewVector2(BoxCenter.X + BoxSize.X / 2, BoxCenter.Y - BoxSize.Y / 2));
					BR = Math:RoundVector(NewVector2(BoxCenter.X + BoxSize.X / 2, BoxCenter.Y + BoxSize.Y / 2));
				end
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Box"] then
					local Box = PlayerDrawing.Box
					local BoxOutline = PlayerDrawing.BoxOutline
					if flags["PlayerESP_Box_Type"] then 
						local BoxCorners, BoxColor1, BoxColor2 = Visuals["Drawings"][Player]["Corners"], flags["PlayerESP_Box_Color1"].Color, flags["PlayerESP_Box_Color2"].Color
						-- Inlines
						do
							BoxCorners[1].Visible = true
							BoxCorners[1].From = TL
							BoxCorners[1].To = BoxCorners[1].From + NewVector2(0, BoxSize.X / 3)  
							BoxCorners[1].Color = BoxColor1
							--
							BoxCorners[2].Visible = true
							BoxCorners[2].From = TL + NewVector2(1, 0)
							BoxCorners[2].To = BoxCorners[2].From + NewVector2(BoxSize.X / 3, 0)
							BoxCorners[2].Color = BoxColor1
							--
							BoxCorners[3].Visible = true
							BoxCorners[3].From = TR
							BoxCorners[3].To = BoxCorners[3].From + NewVector2(-BoxSize.X / 3, 0)
							BoxCorners[3].Color = BoxColor1
							--
							BoxCorners[4].Visible = true
							BoxCorners[4].From = TR
							BoxCorners[4].To = BoxCorners[4].From + NewVector2(0, BoxSize.X / 3)
							BoxCorners[4].Color = BoxColor1
							--
							BoxCorners[5].Visible = true
							BoxCorners[5].From = BR + NewVector2(0, 1)
							BoxCorners[5].To = BoxCorners[5].From + NewVector2(0, -BoxSize.X / 3)
							BoxCorners[5].Color = BoxColor1
							--
							BoxCorners[6].Visible = true
							BoxCorners[6].From = BR
							BoxCorners[6].To = BoxCorners[6].From + NewVector2(-BoxSize.X / 3, 0)
							BoxCorners[6].Color = BoxColor1
							--
							BoxCorners[7].Visible = true
							BoxCorners[7].From = BL + NewVector2(0, 1)
							BoxCorners[7].To = BoxCorners[7].From + NewVector2(0, -BoxSize.X / 3)
							BoxCorners[7].Color = BoxColor1
							--
							BoxCorners[8].Visible = true
							BoxCorners[8].From = BL
							BoxCorners[8].To = BoxCorners[8].From + NewVector2(BoxSize.X / 3, 0)
							BoxCorners[8].Color = BoxColor1
						end
						-- // Outlines
						do
							BoxCorners[9].Visible = true
							BoxCorners[9].From = BoxCorners[1].From + NewVector2(0, -1)
							BoxCorners[9].To = BoxCorners[1].To + NewVector2(0, 1)
							BoxCorners[9].Color = BoxColor2
							--
							BoxCorners[10].Visible = true
							BoxCorners[10].From = BoxCorners[2].From
							BoxCorners[10].To = BoxCorners[2].To + NewVector2(1, 0)
							BoxCorners[10].Color = BoxColor2
							--
							BoxCorners[11].Visible = true
							BoxCorners[11].From = BoxCorners[3].From + NewVector2(2, 0)
							BoxCorners[11].To = BoxCorners[3].To + NewVector2(-1, 0)
							BoxCorners[11].Color = BoxColor2
							--
							BoxCorners[12].Visible = true
							BoxCorners[12].From = BoxCorners[4].From
							BoxCorners[12].To = BoxCorners[4].To + NewVector2(0, 1)
							BoxCorners[12].Color = BoxColor2
							--
							BoxCorners[13].Visible = true
							BoxCorners[13].From = BoxCorners[5].From
							BoxCorners[13].To = BoxCorners[5].To + NewVector2(0, -1)
							BoxCorners[13].Color = BoxColor2
							--
							BoxCorners[14].Visible = true
							BoxCorners[14].From = BoxCorners[6].From + NewVector2(2, 0)
							BoxCorners[14].To = BoxCorners[6].To + NewVector2(-1, 0)
							BoxCorners[14].Color = BoxColor2
							--
							BoxCorners[15].Visible = true
							BoxCorners[15].From = BoxCorners[7].From
							BoxCorners[15].To = BoxCorners[7].To + NewVector2(0, -1)
							BoxCorners[15].Color = BoxColor2
							--
							BoxCorners[16].Visible = true
							BoxCorners[16].From = BoxCorners[8].From + NewVector2(-1, 0)
							BoxCorners[16].To = BoxCorners[8].To + NewVector2(1, 0)
							BoxCorners[16].Color = BoxColor2
						end
					else 
						Box.Size = BoxSize
						Box.Position = BoxPos
						Box.Visible = true
						Box.Color = flags["PlayerESP_Box_Color1"].Color
						BoxOutline.Size = BoxSize
						BoxOutline.Color = flags["PlayerESP_Box_Color2"].Color
						BoxOutline.Position = BoxPos
						BoxOutline.Visible = true
					end 
				end
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Name"] then
					local Name = PlayerDrawing.Name
					Name.Text = ""..Player.Name..""
					Name.Position = NewVector2(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
					Name.Color = flags["PlayerESP_Name_Color"].Color
					Name.Visible = true
				end
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_HealthBar"] then
					local Health         = PlayerDrawing.Health
					local HealthOutline  = PlayerDrawing.HealthOutline
					local HealthText     = PlayerDrawing.HealthText
					local HealthBarGradient = PlayerDrawing.HealthBarGradient
					local Color = Color:Lerp(Humanoid.Health / Humanoid.MaxHealth, flags["PlayerESP_HealthBar_Color_High"].Color, flags["PlayerESP_HealthBar_Color_Low"].Color)
					local HealthSize = (Floor(BoxSize.Y * (Humanoid.Health / Humanoid.MaxHealth)))
					local Height = ((BoxPos.Y + BoxSize.Y) - HealthSize) 
					-- 
					Health.Size = NewVector2(flags["PlayerESP_HealthBar_Thickness"], HealthSize)
					Health.Position = NewVector2(BoxPos.X - (flags["PlayerESP_HealthBar_Thickness"] * 2.5), Height)
					Health.Color = Color
					Health.Visible = true
					Health.Filled = true 
					-- 
					HealthOutline.Size = NewVector2(flags["PlayerESP_HealthBar_Thickness"] + 2, BoxSize.Y + 2)
					HealthOutline.Position = NewVector2(BoxPos.X - (flags["PlayerESP_HealthBar_Thickness"] * 2.5) - 1, BoxPos.Y - 1)
					HealthOutline.Visible = true 
					HealthOutline.Color = NewRGB(0, 0, 0)
					HealthOutline.Filled = true 
					-- 
					if flags["PlayerESP_HealthBarGradient"] then 
						HealthBarGradient.Size = NewVector2(flags["PlayerESP_HealthBar_Thickness"] + 2, BoxSize.Y + 2)
						HealthBarGradient.Position = NewVector2(BoxPos.X - (flags["PlayerESP_HealthBar_Thickness"] * 2.5) - 1, BoxPos.Y - 1)
						HealthBarGradient.Visible = true 
					end 
					-- 
					if flags["PlayerESP_Enabled"] and flags["PlayerESP_HealthNumber"] then
						HealthText.Text = "".. Floor(Humanoid.Health) .. ""
						HealthText.Color = Color
						HealthText.Visible = true
						-- 
						local HealthNumberPos = NewVector2((BoxPos.X + 1), BoxPos.Y + BoxSize.Y)
						HealthText.Position = NewVector2(HealthOutline.Position.X - (flags["PlayerESP_HealthBar_Thickness"] + 8), HealthNumberPos.Y - (Humanoid.Health / Humanoid.MaxHealth) * BoxSize.Y)
					end 
				end
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Weapon"] then
					local Tool = PlayerDrawing.Tool
					local BottomOffset = BoxSize.Y + BoxPos.Y + 1
					local Equipped = Player.Character:FindFirstChildOfClass("Tool") and Player.Character:FindFirstChildOfClass("Tool").Name or ""
					Tool.Text = ""..Equipped..""
					Tool.Position = NewVector2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
					Tool.Color = flags["PlayerESP_Weapon_Color"].Color
					Tool.Visible = true
					BottomOffset = BottomOffset + 15
				end
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_BoxFill"] then 
					local BoxFill = PlayerDrawing.BoxFill
					BoxFill.Size = BoxSize
					BoxFill.Position = BoxPos
					BoxFill.Visible = true
					BoxFill.Color = flags["PlayerESP_BoxFill_Color"].Color
					BoxFill.Transparency = 1 - flags["PlayerESP_BoxFill_Color"].Alpha
				end 
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Distance"] then
					local BottomOffset = (BoxSize.Y * 2) + 1
					Distance.Text = ""..Floor(DistanceFromCharacter).."m"
					if flags["PlayerESP_Weapon"] and Tool.Text ~= "" then 
						Distance.Position = NewVector2(BoxSize.X / 2 + BoxPos.X, BottomOffset + 10)
					else 
						Distance.Position = NewVector2(BoxSize.X / 2 + BoxPos.X, BottomOffset)
					end 
					Distance.Color = flags["PlayerESP_Distance_Color"].Color
					Distance.Visible = true
					BottomOffset = BottomOffset + 15
				end 
				-- 
				if flags["PlayerESP_Enabled"] and flags["PlayerESP_Flags"] then
					local Flag = PlayerDrawing.Flag
					local FlagStr = ""
					-- 
					if Find(flags["PlayerESP_Flag_Options"], "Distance") then
						FlagStr ..= ("%sm\n"):format(Round(DistanceFromCharacter))
					end
					--
					if Find(flags["PlayerESP_Flag_Options"], "Money") and Player and Player.DataFolder then
						FlagStr ..= ("$%s\n"):format(tostring(Player.DataFolder.Currency.Value or 0))
					end
					-- 
					if Find(flags["PlayerESP_Flag_Options"], "Knocked") and Player.Character.BodyEffects then
						FlagStr ..= ("%s\n"):format(tostring(Player.Character.BodyEffects["K.O"].Value and "KNOCKED" or ""))
					end
					--
					Flag.Text = FlagStr
					Flag.Position = NewVector2(BoxSize.X + BoxPos.X + 3, BoxPos.Y - 2)
					Flag.Visible = true
					Flag.Color = flags["PlayerESP_FlagsColor"].Color
					Flag.Transparency = 1 - flags["PlayerESP_FlagsColor"].Alpha
				end
			end 
		end
	else 
		for _,Player in pairs(Players:GetPlayers()) do
			local PlayerDrawing = Visuals["Drawings"][Player]
			-- 
			if not PlayerDrawing then continue end
			-- 
			for _,Drawing in pairs(PlayerDrawing) do
				Drawing.Visible = false
			end
			-- 
			for _, Drawing in pairs(Visuals["Drawings"][Player]["Corners"]) do
				if Drawing then 
					Drawing.Visible = false 
				end 
			end 
		end 
	end  
end))
-- Bullet Tracers, Impacts, Shit Talk
task.spawn(LPH_JIT(function()
	while RunService.RenderStepped:Wait() do 
		utility.Rainbow = {Lynx:Rainbow(flags["Rainbow Speed"]), Lynx:Rainbow(flags["Rainbow Speed"]+1)}
		utility.Sine = Abs(Sin(tick())) + 0.4
		-- 
		Lynx:CharacterMaterial()
		-- 
		if flags["Auto Buy Armor"] then 
			if LocalPlayer.Character.BodyEffects.Armor.Value == 0 then 
				local Old_Ammo_Position = LocalPlayer.Character.HumanoidRootPart.CFrame
				-- 
				LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Ignored.Shop["[High-Medium Armor] - $2163"].Head.CFrame
				wait(0.1)
				fireclickdetector(workspace.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
				wait(0.1)
				if LocalPlayer.Character.BodyEffects.Armor.Value > 0 then 
					LocalPlayer.Character.HumanoidRootPart.CFrame = Old_Ammo_Position
				else 
					fireclickdetector(workspace.Ignored.Shop["[High-Medium Armor] - $2163"].ClickDetector)
				end 
			end  
		end  
		-- 
		Lynx:WorldVisuals()
		-- 
		Lynx:GunMaterial()   
		-- 
		if Lynx:GetPlayerStatus() then 
			if Lynx["Connections"].Loop ~= nil then 
				Lynx["Connections"].Loop:Disconnect()
			end 
		end 
		-- 
		if Lynx:GetTool() and Lynx:GetTool():FindFirstChild("Ammo") then 
			Lynx["Connections"].Loop = Lynx:GetTool().Ammo:GetPropertyChangedSignal("Value"):Connect(function()
				if Lynx:GetTool().Ammo.Value ~= Lynx:GetTool().MaxAmmo.Value then 
					pcall(function()
						if flags["On-Hit-Raycast"] then 
							Lynx["Connections"]["On-Hit-Raycast"] = Workspace.Ignored.Siren.Radius.DescendantAdded:Connect(function(Beam)
								--
								Lynx["Connections"]["On-Hit-Raycast"]:Disconnect()
								--
								delay(0.05, function()
									if Beam.Name == "BULLET_RAYS" then 
										local Ray = Ray.new(Beam.Position, Beam.CFrame.LookVector * 200)
										local IgnoreList = {LocalPlayer.Character}
										local Hit, HitPosition = workspace:FindPartOnRayWithIgnoreList(Ray, IgnoreList);
										-- 
										if Hit then
											local InstanceHit = Hit:FindFirstAncestorOfClass('Model')

											if not InstanceHit then return end 
											
											if InstanceHit:FindFirstChild("Humanoid") and InstanceHit:FindFirstChild("HumanoidRootPart") then 
												if flags["Hit Sound"] then 
													Lynx:HitSound(utility.sfx[flags["Hit Sound Effect"]], flags["Hit Sound Volume"], flags["Hit Sound Pitch"])
												end 
												-- 
												if flags["Hit Chams Enabled"] then 
													if not flags["Optimized Chams"] then 
														Lynx:CloneCharacter(Players[InstanceHit.Name], flags["Hit Chams Color"].Color, flags["Hit Chams Material"], flags["Hit Chams Color"].Alpha, Workspace.Terrain["HitChams"], flags["Hit Chams Time"])
													else 
														Lynx:CloneCharacter2(Players[InstanceHit.Name], flags["Hit Chams Color"].Color, true, flags["Hit Chams Time"], flags["Hit Chams Material"], flags["Hit Chams Color"].Alpha, Workspace.Terrain["HitChams"])
													end 	
												end
												-- 
												if flags["Hit Markers Enabled"] then 
													if flags["HitMarker Type"] == "2D" then 
														HitMarker(4, flags["Hit Markers Color"].Color, flags["Hit Markers Time"])
													else 
														HitMarker3D(4, flags["Hit Markers Color"].Color, flags["Hit Markers Time"], HitPosition) 
													end 
												end 
												-- 
												if flags["Hit Effects"] then 
													Lynx:HitEffect(flags["Hit Effect"], Players[InstanceHit.Name].Character)
												end 
											end 
										end 	
									end 
								end)
							end) 
						end 
					end)
					--
					if flags["Bullet Tracers Enabled"] and flags["Bullet Tracers Mode"] == "Local" then 
						Lynx:CreateBeam(Lynx:GetTool().Handle.Position, LocalPlayer.Character.BodyEffects.MousePos.Value, flags["Rainbow Bullet Tracers"] and utility.Rainbow[1] or flags["Bullet Tracers Color1"].Color, flags["Rainbow Bullet Tracers"] and utility.Rainbow[2] or flags["Bullet Tracers Color2"].Color, utility.TracerTextures[flags["Bullet Tracers Texture"]])
						--
						RunService.RenderStepped:Wait()
						--
						for _, Value in pairs(Workspace.Ignored.Siren.Radius:GetChildren()) do 
							if Value:IsA("Part") and Value.Name == "BULLET_RAYS" then 
								Value:Destroy()
							end 
						end
					end
					-- 
					if flags["Impact Points Enabled"] then 
						local Impact = NewInstance("Part")
						Impact.Anchored = true 
						Impact.CanCollide = false 
						Impact.Parent = game.Workspace
						Impact.Material = Enum.Material[tostring(flags["Impact Points Material"])]
						Impact.Shape = Enum.PartType.Block 
						Impact.Transparency = flags["Impact Points Color"].Alpha
						Impact.Color = flags["Impact Points Color"].Color
						Impact.Size = NewVector3(0.5, 0.5, 0.5)
						Impact.CFrame = CFrame.new(LocalPlayer.Character.BodyEffects.MousePos.Value)
						delay(3, function()
							Impact:Destroy()
						end)
					end					
					--
					Lynx["Connections"].Loop:Disconnect()
				end 
			end)
		end 
	end 
end))
-- 
local function Global_Beam(Beam)
	local Part = Beam
	if Part ~= nil then 
		local Attachments = Part:GetChildren()
		if Attachments ~= nil and Attachments[1] ~= nil and Attachments[2] ~= nil then 
			local Origin = Attachments[1].WorldCFrame
			local End = Attachments[2].WorldCFrame
			local Tool = Lynx:GetTool()
			Lynx:CreateBeam(Origin, End, flags["Rainbow Bullet Tracers"] and utility.Rainbow[1] or flags["Bullet Tracers Color1"].Color, flags["Rainbow Bullet Tracers"] and utility.Rainbow[2] or flags["Bullet Tracers Color2"].Color, utility.TracerTextures[flags["Bullet Tracers Texture"]])
			Part:Destroy()
		end 
	end 
end 
--
Workspace.Ignored.Siren.Radius.DescendantAdded:Connect(function(a)
	pcall(function()
		if flags["Bullet Tracers Enabled"] and flags["Bullet Tracers Mode"] == "Global" then 
			if Workspace.Ignored.Siren.Radius.BULLET_RAYS then 
				Global_Beam(Workspace.Ignored.Siren.Radius.BULLET_RAYS)
			end 
		end 
	end)
end)
-- 
task.spawn(LPH_JIT(function()
	while true do 
		if flags["Shit Talk"] then 
			local RandomChat = Random(1,#utility["ShitTalk"][tostring(flags["Shit Talk Mode"])])
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(utility["ShitTalk"][tostring(flags["Shit Talk Mode"])][RandomChat], "All")
		end 
		task.wait(flags["Shit Talk Delay"])
	end 
end))
--
Lynx:Connection(Players.PlayerAdded, LPH_JIT(function(Player)
    Lynx:Add(Player)
	-- 
	if flags["PlayerESP_Chams"] then 
		Lynx:Cham_Character(Player, flags["Highlight_Fill_Color"].Color, flags["Highlight_Outline_Color"].Color, flags["Highlight_Fill_Color"].Alpha, flags["Highlight_Outline_Color"].Alpha) 
	end  
end))
-- 
Lynx:Connection(Players.PlayerRemoving, LPH_JIT(function(Player)
    if Visuals["Drawings"][Player] or Visuals["Drawings"][Player]["Corners"] then
        for Index, Drawing in pairs(Visuals["Drawings"][Player]) do
            if Drawing and Index ~= "Corners" then 
                Drawing:Remove()
            end 
        end        
        --
        for Index = 1, 16 do
            Visuals["Drawings"][Player]["Corners"][Index]:Remove()
        end
        -- 
        Visuals["Drawings"][Player]["Corners"] = nil
        Visuals["Drawings"][Player] = nil
    end
	-- 
	if Find(flags["Silent Aim Notify"], "Left") and Lynx.Silent.Target ~= nil and Player == Lynx.Silent.Target then 
		ui:Notify{text = "Locked user has left: ".. Lynx.Silent.Target.Name.. " (".. Lynx.Silent.Target.DisplayName .. ")", time = 2, style = "loading"}
	end 
	-- 
	if flags["PlayerESP_Chams"] then 
		Lynx:Cham_Remove(Player)
	end 
end))
-- Cursor, FOVs
Lynx:Connection(InputService.InputChanged, LPH_JIT(function(input, typing)
    if flags["Cursor"] then 
        if not flags["Spin"] then 
            InputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            --
            if flags['Dot'] then 
                utility.Cursor.Dots[1].Position = NewVector2(Mouse.X - 1, Mouse.Y + 36 - 1)
                utility.Cursor.Dots[2].Position = NewVector2(Mouse.X - 2, Mouse.Y + 36 - 2)
                utility.Cursor.Dots[2].Color = NewRGB(0,0,0)
            end 
            -- 
            utility.Cursor.Lines[1].From = NewVector2(Mouse.X + flags["Cursor Gap"] * 5, Mouse.Y + 36)
            utility.Cursor.Lines[1].To = NewVector2(Mouse.X + flags["Cursor Radius"] * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[1].From = NewVector2(Mouse.X + flags["Cursor Gap"] * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[1].To = NewVector2(Mouse.X + flags["Cursor Radius"] * 5, Mouse.Y + 36)
            --
            utility.Cursor.Lines[2].From = NewVector2(Mouse.X - flags["Cursor Gap"] * 5, Mouse.Y + 36)
            utility.Cursor.Lines[2].To = NewVector2(Mouse.X - flags["Cursor Radius"] * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[2].From = NewVector2(Mouse.X - flags["Cursor Gap"] * 5, Mouse.Y + 36)
            utility.Cursor.Outlines[2].To = NewVector2(Mouse.X - flags["Cursor Radius"] * 5, Mouse.Y + 36)
            --
            utility.Cursor.Lines[3].From = NewVector2(Mouse.X, Mouse.Y - flags["Cursor Gap"] * 5 + 36)
            utility.Cursor.Lines[3].To = NewVector2(Mouse.X, Mouse.Y - flags["Cursor Radius"] * 5 + 36)
            utility.Cursor.Outlines[3].From = NewVector2(Mouse.X, Mouse.Y - flags["Cursor Gap"] * 5 + 36)
            utility.Cursor.Outlines[3].To = NewVector2(Mouse.X, Mouse.Y - flags["Cursor Radius"] * 5 + 36)
            --
            utility.Cursor.Lines[4].From = NewVector2(Mouse.X, Mouse.Y + flags["Cursor Gap"] * 5 + 36)
            utility.Cursor.Lines[4].To = NewVector2(Mouse.X, Mouse.Y + flags["Cursor Radius"] * 5 + 36)
            utility.Cursor.Outlines[4].From = NewVector2(Mouse.X, Mouse.Y + flags["Cursor Gap"] * 5 + 36)
            utility.Cursor.Outlines[4].To = NewVector2(Mouse.X, Mouse.Y + flags["Cursor Radius"] * 5 + 36)
        end 
    end
    -- 
    if utility.Renders[1].Visible then 
        utility.Renders[1].Position = NewVector2(Mouse.X, Mouse.Y + 36)
    end 
    --
    if utility.Renders[2].Visible then 
        utility.Renders[2].Position = NewVector2(Mouse.X, Mouse.Y + 36)
    end 
    -- 
    if utility.Renders[3].Visible then 
        utility.Renders[3].Position = NewVector2(Mouse.X, Mouse.Y + 36)
    end 	
end))
-- 
Wanted:GetPropertyChangedSignal("Value"):Connect(function()
	if flags["Custom Stomps"] then 
		if tonumber(Wanted.Value) == tonumber(OldWanted + 50) then
			task.spawn(function()
				if Stomping == true then
					local Info = {
						Character = nil,
						Humanoid  = nil 
					}
					-- 
					local function GetTouchingParts(part)
						local connection = part.Touched:Connect(function() end)
						local results = part:GetTouchingParts()
						connection:Disconnect()
						return results
					end
					-- 
					for i,v in pairs(GetTouchingParts(LocalPlayer.Character["LeftFoot"])) do 
						if Find(bodyParts, v.Name) then 
							if v.Parent ~= LocalPlayer.Character then 
								Info.Character = v.Parent
							end 
						end 
					end 
					-- 
					Info.Humanoid = Info.Character.Humanoid
					-- 
					if Info.Humanoid and Info.Character.BodyEffects["K.O"].Value == true then
						--
						local vCharacter = Info.Humanoid.Parent
						local vPlayer = Players:GetPlayerFromCharacter(vCharacter)
						-- 
						if flags["Stomp Effect"] == "Explosion" then
							Stomps:Explode(vCharacter)
						end 
						if flags["Stomp Effect"] == "Airstrike" then
							Stomps:AirStrike(vCharacter)
						end
						if flags["Stomp Effect"] == "Heart" then
							Stomps:Heart(vCharacter)
						end
						if flags["Stomp Effect"] == "UFO" then
							Stomps:UFO(vCharacter)
						end
						if flags["Stomp Effect"] == "Glitch" then
							Stomps:Glitch(vCharacter)
						end
						if flags["Stomp Effect"] == "Cosmic Slash" then
							Stomps:CosmicSlash(vCharacter)
						end
					end
					
				end
			end)
		end
		OldWanted = Wanted.Value
	end 
end)
--
for Index, Player in pairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        Lynx:Add(Player)
    end
end
-- 
local Old 
Old = hookmetamethod(game, "__namecall", LPH_JIT(function(self, ...)
	if tostring(self.Name) == "MainEvent" and getnamecallmethod() == "FireServer" and flags["Custom Stomps"] or (flags["Silent Aim Enabled"] and flags["Silent Aim Key"].Active) then 
		local args = {...}
		-- 
		if flags["Custom Stomps"] and tostring(args[1]) == "Stomp" then 
			Stomping = true
			delay(0.8,function()
				Stomping = false 
			end)
		end 
		--
		if flags["Silent Aim Enabled"] and flags["Silent Aim Key"].Active and args[1] == "UpdateMousePos" and not flags["Bypass Aim Viewer"] then 
			if Lynx.Silent.Target ~= nil and Lynx.Silent.Target.Character ~= nil and Lynx.Silent.Target.Character.HumanoidRootPart ~= nil and Lynx.Silent.Check == true and Lynx.Silent.HitPart and Lynx.Silent.Target.Character.Head then 
				local Offset = (flags["Air Prediction Method"] == "Offset" and Lynx.Silent.Target.Character.Humanoid.FloorMaterial == Enum.Material.Air) and NewVector3(0.0001, Lynx.Silent.Offset, 0.0001) or NewVector3(0.001, 0.001, 0.001)
				--
				if (flags["Resolver"] == true and flags["Resolver Key"].Active == true and Lynx.Silent.Resolver[1] ~= nil) then 
					args[2] = Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Resolver[1] * Lynx.Silent.Prediction) + Offset 
				else 
					args[2] = Lynx.Silent.Target.Character[Lynx.Silent.HitPart].Position + (Lynx.Silent.Target.Character.HumanoidRootPart.Velocity * Lynx.Silent.Prediction) + Offset 
				end 
				-- 
				Lynx.Silent.Position = args[2]
				-- 
				return Old(self, unpack(args))
			end 
		end 
	end 		
    return Old(self, ...)
end))
--
local old
old = hookmetamethod(game, "__index", LPH_JIT(function(Self, Key)
	if not checkcaller() then
		if Key == "CFrame" and flags["CFrame Desync"] and flags["CFrame Desync Key"].Active and Lynx:GetPlayerStatus(LocalPlayer) then
			if Self == LocalPlayer.Character.HumanoidRootPart then 
				return utility.Desyncs.OldCFrame
			end 
		end
	end 
	return old(Self, Key)
end))
-- 
ui:Notify{text = "osiris.cool has loaded in ".. Round(tostring(tick() - utility.LastTick)).. " seconds !", time = 5, style = "loading"}
]================]
local lynxSec=section('Lynx','Original Lynx / OSIRIS 2024','left')
note(lynxSec,'Original uploaded source included in this file. Runs separately from UNLEGIT and Azure. It may still need original external resources or game-specific compatibility.',105)
local lynxStatus=note(lynxSec,'Not launched',110)
local lynxBusy=false
button(lynxSec,'Launch original Lynx',function()
 if lynxBusy then lynxStatus.Text='Already started or starting. Rejoin before attempting another launch.';return end
 lynxBusy=true
 lynxStatus.Text='Compiling original Lynx...'
 task.spawn(function()
  local fn,err=loadstring(LYNX_ORIGINAL,'Lynx_Original')
  if not fn then lynxStatus.Text='Compile error: '..tostring(err):sub(1,500);warn('[Lynx] '..tostring(err));lynxBusy=false;return end
  lynxStatus.Text='Starting original Lynx systems...'
  local ok,result=xpcall(fn,function(e)return debug and debug.traceback and debug.traceback(tostring(e),2) or tostring(e)end)
  if not ok then
   lynxStatus.Text='Startup error: '..tostring(result):sub(1,600)
   warn('[Lynx startup] '..tostring(result))
   lynxBusy=false
  else
   lynxStatus.Text='Original Lynx source returned; check its own GUI.'
  end
 end)
end)
local lynxHelp=section('Lynx','Compatibility','right')
note(lynxHelp,'The uploaded Lynx source contains its own GUI framework and downloads dependencies from outside repositories. Current game updates may break it. Avoid starting several aim or anti-aim systems at once.',150)
button(lynxHelp,'Copy Lynx status',function()
 if type(setclipboard)=='function' then setclipboard(lynxStatus.Text);U.state='Lynx status copied' else U.state=lynxStatus.Text end
end)
local combat=section('Combat','Kill mode','left')
toggle(combat,'Kill Mode','KillMode');toggle(combat,'Void Spam','VoidSpam');toggle(combat,'Predict','Predict');number(combat,'Prediction (seconds)','Prediction')
toggle(combat,'Random Stomp','RandomStomp');toggle(combat,'Low HP Auto Stomp','LowHPStomp');number(combat,'Low HP threshold','StompHP')
local status=note(combat,'Ready',58)
local aim=section('Combat','Aim','right')
toggle(aim,'Camlock','Camlock');toggle(aim,'Silent Aim','SilentAim');toggle(aim,'Triggerbot','Triggerbot');toggle(aim,'Zoom Aim','ZoomAim')
cycle(aim,'Aim part','AimPart');number(aim,'FOV radius','FOV');number(aim,'Camlock smoothing','CamSmooth');number(aim,'Zoom FOV','ZoomFOV');number(aim,'Fire interval','FireDelay');toggle(aim,'Wall Check','WallCheck');toggle(aim,'Team Check','TeamCheck')
local newCombat=section('Combat','Force Hit & Knife','left')
toggle(newCombat,'Force Hit (normal tool firing)','ForceHit');number(newCombat,'Force Hit range','ForceHitRange');number(newCombat,'Force Hit delay','ForceHitDelay')
toggle(newCombat,'Knife Assist (nearby only)','KnifeAssist');number(newCombat,'Knife range','KnifeRange');toggle(newCombat,'Auto equip knife','CombatAutoEquip')
local targetSec=section('Targets','Targets','left');cycle(targetSec,'Target Selection','TargetMode')
local playerOptions={}
local function availablePlayers()
 local result={'None'};playerOptions={}
 for _,p in ipairs(Players:GetPlayers())do if p~=lp then local label=p.DisplayName..' (@'..p.Name..')';playerOptions[label]=p.UserId;table.insert(result,label)end end
 table.sort(result,function(a,b)if a=='None'then return b~='None'elseif b=='None'then return false end;return a:lower()<b:lower()end)
 return result
end
hcDropdown(targetSec,'Player Select',{
 get=function()
  local names={};for _,p in ipairs(Players:GetPlayers())do if U.selected[p.UserId]then table.insert(names,p.DisplayName..' (@'..p.Name..')')end end
  table.sort(names);return #names>1 and(#names..' players selected')or names[1]or 'None'
 end,
 set=function(label)availablePlayers();U.selected={};local id=playerOptions[label];if id then U.selected[id]=true end;return true end
},availablePlayers)
local function refreshTargets()U.refresh()end
U.connect(Players.PlayerAdded,refreshTargets)
U.connect(Players.PlayerRemoving,function(p)U.selected[p.UserId]=nil;task.defer(function()if U.alive then refreshTargets()end end)end)
button(targetSec,'Select all',function()for _,p in ipairs(Players:GetPlayers())do if p~=lp then U.selected[p.UserId]=true end end;refreshTargets()end)
button(targetSec,'Clear targets',function()U.selected={};refreshTargets()end)
local tp=section('Targets','Position & view','right')
cycle(tp,'Teleport Mode','TeleportMode');toggle(tp,'Orbit','Orbit');number(tp,'Orbit radius','OrbitRadius');number(tp,'Orbit speed','OrbitSpeed');number(tp,'Distance','TargetDistance');toggle(tp,'Return to Origin','ReturnOrigin');toggle(tp,'Spectate Target','Spectate')
button(tp,'TP Closest',function()if U.tpClosest then U.tpClosest()end end);button(tp,'Return now',function()if U.returnNow then U.returnNow()end end)
toggle(tp,'Bullet Visualizer','BulletVisualizer');toggle(tp,'Target Visualizer','TargetVisualizer')
local espSec=section('ESP','Player ESP • HC style','left')
for _,v in ipairs({{'Enable ESP','ESP'},{'Name','Name'},{'Distance','Distance'},{'Skeleton','Skeleton'},{'Engine Health','EngineHealth'},{'Box','Box'},{'Health Bar','HealthBar'}})do toggle(espSec,v[1],v[2])end
number(espSec,'Maximum distance','ESPRange')
local extra=section('ESP','Appearance','right')
for _,v in ipairs({{'3D Box','Box3D'},{'Gradient Fill','GradientFill'},{'Glow','Glow'},{'Edges','Edges'}})do toggle(extra,v[1],v[2])end
local colorField=field(extra,'ESP color (#RRGGBB)',S.ESPColor,function(v)if not U.set('ESPColor',v)then U.state='Use a color such as #F3A1D3.'end end)
table.insert(refreshers,function()if not colorField:IsFocused()then colorField.Text=S.ESPColor end end)
local move=section('Movement','Ground','left')
toggle(move,'CFrame Speed','CFrameSpeedEnabled');number(move,'Speed Multiplier','CFrameSpeed');toggle(move,'Speed Boost','SpeedBoost');number(move,'Speed Boost value','SpeedBoostValue');toggle(move,'Desync preview (visual only)','DesyncPreview')
toggle(move,'Walkspeed','WalkspeedEnabled');number(move,'Walkspeed value','Walkspeed');toggle(move,'Fake Macro','FakeMacro');number(move,'Macro speed','MacroSpeed');toggle(move,'Quick Stop','QuickStop');toggle(move,'Instant Fall','InstantFall');toggle(move,'Hip Height','HipEnabled');number(move,'Hip height value','HipHeight');toggle(move,'Spinbot','Spinbot');number(move,'Spin speed','SpinSpeed')
local air=section('Movement','Air & camera','right')
toggle(air,'Freecam','Freecam');number(air,'Freecam speed','FreecamSpeed');toggle(air,'Fly','Fly');number(air,'Fly speed','FlySpeed');toggle(air,'Jump Power','JumpEnabled');number(air,'Jump power value','JumpPower');toggle(air,'Gravity','GravityEnabled');number(air,'Gravity value','Gravity');toggle(air,'Infinite Jump','InfiniteJump')
local wp=section('Waypoints','Waypoints','left');toggle(wp,'Show Waypoint ESP','WaypointESP');toggle(wp,'Death Markers','DeathMarkers');toggle(wp,'Enable Icon','WaypointIcon');toggle(wp,'Show Text','WaypointText')
local waypointName=field(wp,'Waypoint name','Home',function()end)
local wpActions=section('Waypoints','Manage','right')
local configSec=section('Configs','Configs','left');local configName=field(configSec,'Config name','default',function()end)
local configList=note(configSec,'',68)
local general=section('Configs','Session','right')
button(general,'Stop all automation',function()for _,k in ipairs({'CFrameSpeedEnabled','KillMode','VoidSpam','Orbit','RandomStomp','LowHPStomp','Camlock','SilentAim','Triggerbot','ZoomAim','Spectate','Freecam','Fly','FakeMacro','Spinbot','ForceHit','KnifeAssist','CombatAutoEquip','SpeedBoost','DesyncPreview'})do U.set(k,false)end;U.set('TeleportMode','Off');if U.returnNow then U.returnNow()end;U.state='Stopped'end)
button(general,'Unload UNLEGIT',function()U:Destroy()end)
note(general,'Right Shift opens / closes.\nConfigs use Kimqetras_UNLEGIT only.\nLive-game verification required.',64)
showPage('Combat')

-- Targeting and movement controllers own only properties they change.
local function visible(part,char)
 local camera=workspace.CurrentCamera;if not camera then return false end
 if not S.WallCheck then return true end
 local rp=RaycastParams.new();rp.FilterType=Enum.RaycastFilterType.Exclude;rp.FilterDescendantsInstances={lp.Character,char,U.visualFolder};rp.IgnoreWater=true;rp.RespectCanCollide=true
 return workspace:Raycast(camera.CFrame.Position,part.Position-camera.CFrame.Position,rp)==nil
end
local function candidates(requireFov)
 local camera=workspace.CurrentCamera;local result={};local _,_,myRoot=U.character(lp);if not camera then return result end
 local m=UIS:GetMouseLocation()
 for _,p in ipairs(Players:GetPlayers())do if p~=lp and(not S.TeamCheck or not lp.Team or p.Team~=lp.Team)then
  local c,h,r=U.character(p)
  if c and h and h.Health>0 and r and (S.TargetMode~='Selected'or U.selected[p.UserId])then
   local part=c:FindFirstChild(S.AimPart)or c:FindFirstChild('Torso')or r
   local point,on=camera:WorldToScreenPoint(part.Position);local screen=(Vector2.new(point.X,point.Y)-m).Magnitude
   if not requireFov or(on and point.Z>0 and screen<=S.FOV and visible(part,c))then
    local distance=myRoot and(myRoot.Position-r.Position).Magnitude or math.huge
    local score=S.TargetMode=='Closest Distance'and distance or(S.TargetMode=='Lowest Health'and h.Health or screen)
    table.insert(result,{player=p,char=c,hum=h,root=r,part=part,score=score,distance=distance})
   end
  end
 end end
 table.sort(result,function(a,b)if a.score==b.score then return a.player.UserId<b.player.UserId end;return a.score<b.score end)
 return result
end
local function aimPoint(t)return t.part.Position+(S.Predict and t.root.AssemblyLinearVelocity*S.Prediction or Vector3.zero)end
local function localReady()local c,h,r=U.character(lp);return c and h and h.Health>0 and r and not U.knocked(c)end
local function gun()
 local c=lp.Character;if not c then return end
 for _,t in ipairs(c:GetChildren())do if t:IsA('Tool')then
  local n=t.Name:lower();if not n:find('knife')and not n:find('wallet')and not n:find('phone')and(t:FindFirstChild('Ammo',true)or n:find('shotgun')or n:find('revolver')or n:find('double')or n:find('smg')or n:find('rifle')or n:find('pistol'))then return t end
 end end
end
U.visualFolder=U.own(Instance.new('Folder'));U.visualFolder.Name='KimqetrasUNLEGIT_Visuals';U.visualFolder.Parent=workspace
local desyncGhost=Instance.new('Highlight');desyncGhost.Name='UNLEGIT_DesyncPreview';desyncGhost.FillColor=Color3.fromRGB(130,200,255);desyncGhost.OutlineColor=Color3.fromRGB(65,120,255);desyncGhost.FillTransparency=.88;desyncGhost.OutlineTransparency=.2;desyncGhost.Enabled=false;desyncGhost.Parent=U.visualFolder
local function beamTo(point)
 if not S.BulletVisualizer then return end
 local t=gun();local h=t and t:FindFirstChild('Handle',true);local origin=h and h:IsA('BasePart')and h.Position or(workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position)
 if not origin then return end
 local length=(point-origin).Magnitude;if length<.01 then return end
 local p=Instance.new('Part');p.Name='UNLEGITShotPreview';p.Size=Vector3.new(.035,.035,length);p.CFrame=CFrame.lookAt(origin,point)*CFrame.new(0,0,-length/2);p.Anchored=true;p.CanCollide=false;p.CanTouch=false;p.CanQuery=false;p.Material=Enum.Material.Neon;p.Color=U.color();p.Parent=U.visualFolder
 task.delay(.16,function()p:Destroy()end)
end
local function fire(t)
 if not localReady()or os.clock()-U.lastFire<S.FireDelay then return false end
 local tool=gun();if not tool then U.state='Equip a gun for shooting.';return false end
 if not tool.Enabled then U.state='The game has disabled this tool.';return false end
 local ammo=tool:FindFirstChild('Ammo',true);if ammo and tonumber(ammo.Value)and tonumber(ammo.Value)<=0 then U.state='Gun empty • reload using the game.';return false end
 U.lastFire=os.clock();tool:Activate();task.delay(.04,function()if tool.Parent then tool:Deactivate()end end)
 if t then beamTo(aimPoint(t))end;return true
end
local lastKnife=0
local function knifeAttack(t)
 if not t or not localReady() or os.clock()-lastKnife<.35 then return end
 local char,hum,root=U.character(lp)
 if not root or (root.Position-t.root.Position).Magnitude>S.KnifeRange then return end
 local tool
 for _,container in ipairs({char,lp:FindFirstChildOfClass('Backpack')}) do
  if container then for _,item in ipairs(container:GetChildren())do
   if item:IsA('Tool') and item.Name:lower():find('knife') then tool=item;break end
  end end
  if tool then break end
 end
 if not tool then return end
 if tool.Parent~=char then
  if not S.CombatAutoEquip then return end
  hum:EquipTool(tool)
 end
 if tool.Enabled then lastKnife=os.clock();tool:Activate();task.delay(.1,function()if tool.Parent then tool:Deactivate()end end) end
end
local function stomp(t)
 if not t or not localReady()or os.clock()-U.lastStomp<.65 then return end
 local _,_,r=U.character(lp);if(r.Position-t.root.Position).Magnitude>10 then U.state='Stomp target is too far away.';return end
 local ev=RS:FindFirstChild('MainEvent')
 if not ev or not ev:IsA('RemoteEvent')then U.state='This game has no supported MainEvent stomp action.';return end
 U.lastStomp=os.clock();ev:FireServer('Stomp')
end
local function captureOrigin(r)if not U.origin then U.origin=r.CFrame;U.originCharacter=lp.Character end end
function U.returnNow()
 local _,_,r=U.character(lp)
 if r and U.origin and U.originCharacter==lp.Character then r.CFrame=U.origin;r.AssemblyLinearVelocity=Vector3.zero end
 U.origin=nil;U.originCharacter=nil
end
function U.tpClosest()
 local _,_,r=U.character(lp);if not r then return end
 local list={};for _,p in ipairs(Players:GetPlayers())do if p~=lp then local c,h,root=U.character(p);if h and h.Health>0 and root then table.insert(list,{root=root,d=(r.Position-root.Position).Magnitude})end end end
 table.sort(list,function(a,b)return a.d<b.d end)
 if list[1]then captureOrigin(r);r.CFrame=list[1].root.CFrame*CFrame.new(0,0,S.TargetDistance);U.state='Teleported to closest player.'end
end
-- Standard Mouse-based Silent Aim only; games with other aiming pipelines need an adapter.
U.silentAvailable=false
if type(hookmetamethod)=='function'and type(checkcaller)=='function'then
 local ok=pcall(function()
  local old;old=hookmetamethod(game,'__index',function(self,key)
   if U.alive and (S.SilentAim or S.KillMode) and not checkcaller()and self==mouse and(key=='Hit'or key=='Target'or key=='UnitRay')then
    local t=S.KillMode and U.current or U.aimTarget
    if t and t.part.Parent and t.hum.Health>0 and not U.knocked(t.char)then
     local p=aimPoint(t)
     if key=='Target'then return t.part elseif key=='Hit'then return CFrame.new(p)else local camera=workspace.CurrentCamera;if camera then return Ray.new(camera.CFrame.Position,(p-camera.CFrame.Position).Unit)end end
    end
   end
   return old(self,key)
  end)
 end)
 U.silentAvailable=ok
end
local cameraOwner,cameraSaved,freePosition,freeYaw,freePitch
local properties={}
local function ownProperty(object,key,value)
 if not object then return end
 local record=properties[object];if not record then record={};properties[object]=record end
 if record[key]==nil then record[key]={value=object[key]}end
 object[key]=value
end
local function releaseProperty(object,key)
 local record=object and properties[object];if record and record[key]then local value=record[key].value;pcall(function()object[key]=value end);record[key]=nil end
end
local function releaseCamera()
 if cameraOwner and cameraSaved then
  local c=cameraOwner;pcall(function()c.CameraType=cameraSaved.kind;c.FieldOfView=cameraSaved.fov;c.CameraSubject=cameraSaved.subject;if cameraSaved.mode=='free'then c.CFrame=cameraSaved.cf end end)
 end
 cameraOwner=nil;cameraSaved=nil
end
local function ownCamera()
 local c=workspace.CurrentCamera;if not c then return end
 local mode=S.Freecam and 'free'or(S.Spectate and 'spectate'or 'aim')
 if cameraOwner~=c or(cameraSaved and cameraSaved.mode~=mode)then releaseCamera();cameraOwner=c;cameraSaved={mode=mode,kind=c.CameraType,subject=c.CameraSubject,fov=c.FieldOfView,cf=c.CFrame};freePosition=c.CFrame.Position;local x,y=c.CFrame:ToOrientation();freePitch=x;freeYaw=y end
 return c
end
local keys={}
U.connect(UIS.InputBegan,function(i,g)if not g and not UIS:GetFocusedTextBox()then keys[i.KeyCode]=true end end)
U.connect(UIS.InputEnded,function(i)keys[i.KeyCode]=nil end)
U.connect(UIS.WindowFocusReleased,function()keys={}end)
U.connect(UIS.JumpRequest,function()if U.alive and S.InfiniteJump and not UIS:GetFocusedTextBox()then local _,h=U.character(lp);if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)
local function inputMove()
 if UIS:GetFocusedTextBox()then return Vector3.zero end
 return Vector3.new((keys[Enum.KeyCode.D]and 1 or 0)-(keys[Enum.KeyCode.A]and 1 or 0),(keys[Enum.KeyCode.Space]and 1 or 0)-(keys[Enum.KeyCode.LeftControl]and 1 or 0),(keys[Enum.KeyCode.S]and 1 or 0)-(keys[Enum.KeyCode.W]and 1 or 0))
end
local flyAttachment,flyVelocity
local function stopFly()if flyVelocity then flyVelocity:Destroy();flyVelocity=nil end;if flyAttachment then flyAttachment:Destroy();flyAttachment=nil end end
local targetHighlight=U.own(Instance.new('Highlight'));targetHighlight.Name='UNLEGITTarget';targetHighlight.FillTransparency=.8;targetHighlight.OutlineColor=COL.accentStroke;targetHighlight.Enabled=false;targetHighlight.Parent=U.visualFolder
local elapsed,wasTeleport=0,false
U.connect(RunService.Heartbeat,function(dt)
 if not U.alive then return end
 local c,h,r=U.character(lp);local ready=h and h.Health>0 and r
 if ready then
  if S.Freecam then ownProperty(r,'Anchored',true)else releaseProperty(r,'Anchored')end
  if S.WalkspeedEnabled or S.FakeMacro or S.SpeedBoost then ownProperty(h,'WalkSpeed',S.SpeedBoost and S.SpeedBoostValue or (S.FakeMacro and S.MacroSpeed or S.Walkspeed))else releaseProperty(h,'WalkSpeed')end
  -- Source multiplier is studs/frame at 60 FPS; normalize to elapsed time.
  if S.CFrameSpeedEnabled and not S.Freecam and not S.Fly and not h.Sit and not U.knocked(c) and S.TeleportMode=='Off' and not S.Orbit and not S.VoidSpam then
   r.CFrame=r.CFrame+h.MoveDirection*(S.CFrameSpeed/10)*math.min(dt,.1)*60
  end
  if S.HipEnabled then ownProperty(h,'HipHeight',S.HipHeight)else releaseProperty(h,'HipHeight')end
  if S.JumpEnabled then ownProperty(h,'UseJumpPower',true);ownProperty(h,'JumpPower',S.JumpPower)else releaseProperty(h,'JumpPower');releaseProperty(h,'UseJumpPower')end
  if S.Spinbot then ownProperty(h,'AutoRotate',false);r.CFrame=r.CFrame*CFrame.Angles(0,math.rad(S.SpinSpeed)*dt,0)elseif not S.Fly then releaseProperty(h,'AutoRotate')end
  if S.QuickStop and h.MoveDirection.Magnitude<.01 then local v=r.AssemblyLinearVelocity;r.AssemblyLinearVelocity=Vector3.new(0,v.Y,0)end
  if S.InstantFall and h.FloorMaterial==Enum.Material.Air and r.AssemblyLinearVelocity.Y<0 then local v=r.AssemblyLinearVelocity;r.AssemblyLinearVelocity=Vector3.new(v.X,-110,v.Z)end
  if S.Fly and not S.Freecam then
   if not flyVelocity or flyVelocity.Parent~=r then stopFly();flyAttachment=Instance.new('Attachment');flyAttachment.Parent=r;flyVelocity=Instance.new('LinearVelocity');flyVelocity.Attachment0=flyAttachment;flyVelocity.RelativeTo=Enum.ActuatorRelativeTo.World;flyVelocity.ForceLimitsEnabled=false;flyVelocity.MaxForce=math.huge;flyVelocity.Parent=r end
   ownProperty(h,'AutoRotate',false);local v=inputMove();local camera=workspace.CurrentCamera;if camera then local dir=camera.CFrame:VectorToWorldSpace(v);flyVelocity.VectorVelocity=dir.Magnitude>0 and dir.Unit*S.FlySpeed or Vector3.zero end
  else stopFly();if not S.Spinbot then releaseProperty(h,'AutoRotate')end end
 else stopFly()end
 if S.GravityEnabled then ownProperty(workspace,'Gravity',S.Gravity)else releaseProperty(workspace,'Gravity')end
 elapsed=elapsed+dt;if elapsed<.08 then return end;elapsed=0
 local list=candidates(false);U.current=list[1]
 -- Keep an active selected target until it leaves/dies; choose next live selection afterwards.
 if S.TargetMode=='Selected'and U.locked then for _,t in ipairs(list)do if t.player==U.locked then U.current=t;break end end end
 local t=U.current;U.locked=t and t.player or nil
 local doTeleport=ready and not S.Freecam and t and (S.TeleportMode~='Off'or S.Orbit or S.VoidSpam)
 if doTeleport then
  captureOrigin(r);U.angle=U.angle+S.OrbitSpeed*.08
  local goal
  if S.VoidSpam and math.floor(os.clock()*6)%2==0 then goal=CFrame.new(t.root.Position.X,workspace.FallenPartsDestroyHeight+40,t.root.Position.Z)
  elseif S.Orbit or S.TeleportMode=='Orbit'then local p=t.root.Position+Vector3.new(math.cos(U.angle)*S.OrbitRadius,2,math.sin(U.angle)*S.OrbitRadius);goal=CFrame.lookAt(p,t.root.Position)
  elseif S.TeleportMode=='Above'then goal=CFrame.new(t.root.Position+Vector3.new(0,S.TargetDistance,0))*r.CFrame.Rotation
  else goal=t.root.CFrame*CFrame.new(0,0,S.TargetDistance)end
  r.CFrame=goal;r.AssemblyLinearVelocity=Vector3.zero
 elseif wasTeleport then if S.ReturnOrigin then U.returnNow()else U.origin=nil end end
 wasTeleport=doTeleport and true or false
 if not ready then U.state='Waiting for your character.';return end
 if S.KnifeAssist and t then knifeAttack(t) end
 if S.ForceHit and t and t.distance<=S.ForceHitRange and visible(t.part,t.char) then
  if os.clock()-U.lastFire>=S.ForceHitDelay then fire(t) end
 end
 if S.KillMode then
  if not t then U.state='Kill Mode: no available selected target.'
  elseif U.knocked(t.char)then stomp(t);U.state='Target knocked • stomp requires proximity.'
  elseif visible(t.part,t.char)then if fire(t)then U.state='Firing equipped tool at '..t.player.Name end
  else U.state='Target obstructed.'end
 elseif t then U.state=t.player.Name..' • '..math.floor(t.distance)..' studs • '..math.ceil(t.hum.Health)..' HP'
 else U.state='Ready • choose targets or change Target Selection.'end
 if S.RandomStomp then local down={};for _,item in ipairs(list)do if U.knocked(item.char)and item.distance<=10 then table.insert(down,item)end end;if #down>0 then stomp(down[math.random(#down)])end end
 if S.LowHPStomp and t and (t.hum.Health<=S.StompHP or U.knocked(t.char))then stomp(t)end
 desyncGhost.Adornee=lp.Character;desyncGhost.Enabled=S.DesyncPreview
 if S.DesyncPreview then U.state=U.state..' • desync preview is local only' end
 if S.SilentAim and not U.silentAvailable then U.state='Silent Aim hook unavailable in this runtime.'end
end)
U.connect(RunService.RenderStepped,function(dt)
 if not U.alive then return end
 U.aimTarget=candidates(true)[1];local t=U.aimTarget;local current=U.current
 local wantsCamera=S.Freecam or(S.Spectate and current)or(S.Camlock and t)or(S.ZoomAim and t)
 if wantsCamera then
  local c=ownCamera()
  if c then
   if S.Freecam then
    c.CameraType=Enum.CameraType.Scriptable
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)and not UIS:GetFocusedTextBox()then local d=UIS:GetMouseDelta();freeYaw=freeYaw-d.X*.003;freePitch=math.clamp(freePitch-d.Y*.003,-1.5,1.5)end
    local rotation=CFrame.fromOrientation(freePitch,freeYaw,0);local v=inputMove();if v.Magnitude>1 then v=v.Unit end;freePosition=freePosition+rotation:VectorToWorldSpace(v)*S.FreecamSpeed*dt;c.CFrame=CFrame.new(freePosition)*rotation
   else
    c.CameraType=cameraSaved.kind
    c.CameraSubject=S.Spectate and current and current.hum or cameraSaved.subject
    if S.Camlock and t then c.CFrame=c.CFrame:Lerp(CFrame.lookAt(c.CFrame.Position,aimPoint(t)),1-(1-S.CamSmooth)^(dt*60))end
    c.FieldOfView=S.ZoomAim and t and S.ZoomFOV or cameraSaved.fov
   end
  end
 elseif cameraOwner then releaseCamera()end
 targetHighlight.Enabled=S.TargetVisualizer and current~=nil;targetHighlight.Adornee=current and current.char or nil
 if S.Triggerbot and not gui.Enabled and not UIS:GetFocusedTextBox()then
  local hit=mouse.Target;local model=hit and hit:FindFirstAncestorOfClass('Model');local p=model and Players:GetPlayerFromCharacter(model)
  if p and p~=lp then for _,candidate in ipairs(candidates(true))do if candidate.player==p and not U.knocked(candidate.char)then fire(candidate);break end end end
 end
 status.Text=U.lastError and('Controller error: '..U.lastError:sub(1,120))or U.state;fit()
end)
U.connect(mouse.Button1Down,function()if S.BulletVisualizer and not gui.Enabled then local hit=mouse.Hit;if hit then beamTo(hit.Position)end end end)

-- Independent disk namespace; memory copies still work if executor file APIs are missing.
local disk=type(writefile)=='function'and type(readfile)=='function'and type(isfile)=='function'and type(makefolder)=='function'and type(isfolder)=='function'
local rootPath='Kimqetras_UNLEGIT';local memory={}
local function validName(n)n=tostring(n or ''):gsub('^%s+',''):gsub('%s+$','');assert(#n>0 and #n<=48 and n:match('^[%w_%-]+$'),'Use 1–48 letters, numbers, underscores or hyphens.');return n end
local function path(kind,n)return rootPath..'/'..kind..'_'..validName(n)..'.json'end
local function setupDisk()if disk and not isfolder(rootPath)then makefolder(rootPath)end end
local function readData(kind,n)
 local p=path(kind,n);if disk then setupDisk();assert(isfile(p),'File not found.');return Http:JSONDecode(readfile(p))end
 assert(memory[p],'Nothing saved with that name this session.');return Http:JSONDecode(memory[p])
end
local function saveData(kind,n,data,create)
 local p=path(kind,n);local encoded=Http:JSONEncode(data)
 if disk then setupDisk();if create then assert(not isfile(p),'Name already exists; use Save to overwrite.')end;writefile(p,encoded)
 else if create then assert(not memory[p],'Name already exists.')end;memory[p]=encoded end
 U.state=disk and 'Saved '..n or 'Saved in memory only; file APIs unavailable.'
end
local function deleteData(kind,n)
 local p=path(kind,n)
 if disk then assert(type(delfile)=='function','Delete file API unavailable.');assert(isfile(p),'File not found.');delfile(p)else memory[p]=nil end
 U.state='Deleted '..n
end
local function configContents()local selected={};for id,on in pairs(U.selected)do if on then table.insert(selected,id)end end;return {version=1,settings=S,selected=selected}end
local function showConfigs()
 local list={}
 if disk and type(listfiles)=='function'then setupDisk();for _,p in ipairs(listfiles(rootPath))do local name=p:gsub('\\','/'):match('/config_([%w_%-]+)%.json$');if name then table.insert(list,name)end end
 else for p in pairs(memory)do local name=p:match('/config_([%w_%-]+)%.json$');if name then table.insert(list,name)end end end
 table.sort(list);configList.Text=(disk and 'Saved: 'or 'Session only: ')..(#list>0 and table.concat(list,', ')or 'none')
end
button(configSec,'Create',function()saveData('config',configName.Text,configContents(),true);showConfigs()end)
button(configSec,'Save',function()saveData('config',configName.Text,configContents(),false);showConfigs()end)
button(configSec,'Load',function()
 local data=readData('config',configName.Text);assert(type(data)=='table'and data.version==1 and type(data.settings)=='table','Unsupported config.')
 for k in pairs(defaults)do if data.settings[k]~=nil then U.set(k,data.settings[k])end end
 U.selected={};if type(data.selected)=='table'then for _,id in ipairs(data.selected)do if type(id)=='number'and id>0 then U.selected[id]=true end end end
 refreshTargets();U.refresh();U.state='Loaded '..configName.Text
end)
button(configSec,'Delete',function()deleteData('config',configName.Text);showConfigs()end)
button(configSec,'Refresh list',showConfigs)
pcall(showConfigs)
local function serializedPoints()
 local out={};for _,w in ipairs(U.waypoints)do table.insert(out,{name=w.name,position={w.pos.X,w.pos.Y,w.pos.Z}})end;return {version=1,points=out}
end
button(wpActions,'Create',function()
 local _,_,r=U.character(lp);assert(r,'Character not ready.');assert(#U.waypoints<100,'Maximum 100 waypoints.');table.insert(U.waypoints,{name=waypointName.Text~=''and waypointName.Text:sub(1,40)or 'Waypoint',pos=r.Position});U.state='Waypoint created.'
end)
button(wpActions,'Save',function()saveData('waypoints','default',serializedPoints(),false)end)
button(wpActions,'Load',function()
 local data=readData('waypoints','default');assert(type(data)=='table'and data.version==1 and type(data.points)=='table','Invalid waypoints.')
 local result={};for _,w in ipairs(data.points)do
  local v=type(w)=='table'and w.position
  if type(v)=='table'and #v==3 and type(w.name)=='string'and #result<100 then
   local valid=true;for _,n in ipairs(v)do if type(n)~='number'or n~=n or math.abs(n)>1000000 then valid=false end end
   if valid then table.insert(result,{name=w.name:sub(1,40),pos=Vector3.new(v[1],v[2],v[3])})end
  end
 end
 U.waypoints=result;U.state='Waypoints loaded.'
end)
button(wpActions,'Delete named',function()for i=#U.waypoints,1,-1 do if U.waypoints[i].name==waypointName.Text then table.remove(U.waypoints,i)end end end)
button(wpActions,'Delete nearest',function()
 local _,_,r=U.character(lp);assert(r,'Character not ready.');local index,best
 for i,w in ipairs(U.waypoints)do local d=(r.Position-w.pos).Magnitude;if not best or d<best then best=d;index=i end end
 if index then table.remove(U.waypoints,index);U.state='Nearest waypoint removed.'end
end)
button(wpActions,'Clear death markers',function()U.deaths={}end)
local function characterAdded(char)
 stopFly();releaseCamera();U.origin=nil;U.originCharacter=nil;U.locked=nil
 local h=char:WaitForChild('Humanoid',10)
 if h and U.alive then U.connect(h.Died,function()
  local r=char:FindFirstChild('HumanoidRootPart');if r and S.DeathMarkers then table.insert(U.deaths,{name='Death '..os.date('%H:%M:%S'),pos=r.Position});if #U.deaths>25 then table.remove(U.deaths,1)end end
 end)end
end
U.connect(lp.CharacterAdded,characterAdded);if lp.Character then task.spawn(characterAdded,lp.Character)end
function U:Destroy()
 if not self.alive then return end;self.alive=false
 stopFly();releaseCamera()
 if S.ReturnOrigin then self.returnNow()end
 for object,record in pairs(properties)do for key,snapshot in pairs(record)do pcall(function()object[key]=snapshot.value end)end end
 properties={}
 for _,c in ipairs(self.connections)do c:Disconnect()end
 for _,d in ipairs(self.drawings)do pcall(function()d:Remove()end)end
 for _,o in ipairs(self.objects)do pcall(function()o:Destroy()end)end
 if self.gui then self.gui:Destroy()end
 if _G.KimqetrasUNLEGIT==self then _G.KimqetrasUNLEGIT=nil end
end

do
 local cam=workspace.CurrentCamera
 local actualDrawing=Drawing
 local Drawing=actualDrawing and {new=function(kind)local d=actualDrawing.new(kind);table.insert(U.drawings,d);return d end}or nil
 local ExtraESPEnabled,ExtraESPBoxes,ExtraESPNames,ExtraESPDistance,ExtraESPHealth,ExtraESPTracer,ExtraESPSkeleton=false,false,false,false,false,false,false
 local ExtraESPColor=U.color()
 U.connect(RunService.RenderStepped,function()
  ExtraESPEnabled=S.ESP;ExtraESPBoxes=S.Box;ExtraESPNames=S.Name;ExtraESPDistance=S.Distance;ExtraESPHealth=S.EngineHealth;ExtraESPSkeleton=S.Skeleton;ExtraESPColor=U.color()
 end)

local extraESPObjects = {}
local extraBoneConnections = {
    {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"},
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}

local function hideExtraESP(objs)
    if not objs then return end
    objs.Box.Visible = false
    objs.Name.Visible = false
    objs.Health.Visible = false
    objs.Distance.Visible = false
    objs.Tracer.Visible = false
    for _, line in pairs(objs.Skeleton) do line.Visible = false end
end

local function createExtraESP(plr)
    if extraESPObjects[plr] or not Drawing or not Drawing.new then return end
    local box = Drawing.new("Square") box.Thickness = 1 box.Filled = false box.Color = ExtraESPColor box.Visible = false
    local name = Drawing.new("Text") name.Size = 13 name.Center = true name.Outline = true name.Color = ExtraESPColor name.Visible = false
    local health = Drawing.new("Text") health.Size = 13 health.Center = false health.Outline = true health.Color = Color3.fromRGB(50,255,50) health.Visible = false
    local distance = Drawing.new("Text") distance.Size = 12 distance.Center = true distance.Outline = true distance.Color = ExtraESPColor distance.Visible = false
    local tracer = Drawing.new("Line") tracer.Thickness = 1 tracer.Color = ExtraESPColor tracer.Visible = false
    extraESPObjects[plr] = {Box=box, Name=name, Health=health, Distance=distance, Tracer=tracer, Skeleton={}}
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= lp then createExtraESP(p) end end
U.connect(Players.PlayerAdded,function(p) if p ~= lp then createExtraESP(p) end end)
U.connect(Players.PlayerRemoving,function(p)
    local objs = extraESPObjects[p]
    if objs then
        pcall(function() objs.Box:Remove() end) pcall(function() objs.Name:Remove() end)
        pcall(function() objs.Health:Remove() end) pcall(function() objs.Distance:Remove() end)
        pcall(function() objs.Tracer:Remove() end)
        for _, line in pairs(objs.Skeleton) do pcall(function() line:Remove() end) end
        extraESPObjects[p] = nil
    end
end)

local extraESPWasEnabled = false
U.connect(RunService.RenderStepped,function()
    cam=workspace.CurrentCamera
    if not cam then return end
    if not ExtraESPEnabled then
        if extraESPWasEnabled then
            for _, objs in pairs(extraESPObjects) do hideExtraESP(objs) end
            extraESPWasEnabled = false
        end
        return
    end
    extraESPWasEnabled = true
    for plr, objs in pairs(extraESPObjects) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if ExtraESPEnabled and not U.whitelist[plr.UserId] and hrp and hum and hum.Health > 0 and (not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") or (lp.Character.HumanoidRootPart.Position-hrp.Position).Magnitude<=S.ESPRange) then
            local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local head = char:FindFirstChild("Head") or hrp
                local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                local legPos = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))
                local boxHeight = math.abs(headPos.Y - legPos.Y)
                local topLeft = Vector2.new(rootPos.X - (boxHeight / 4), rootPos.Y - boxHeight / 2)

                if ExtraESPBoxes then
                    objs.Box.Size = Vector2.new(boxHeight / 2, boxHeight)
                    objs.Box.Position = topLeft objs.Box.Color = ExtraESPColor objs.Box.Visible = true
                else objs.Box.Visible = false end

                if ExtraESPNames then
                    objs.Name.Position = Vector2.new(rootPos.X, topLeft.Y - 16)
                    objs.Name.Text = plr.Name objs.Name.Color = ExtraESPColor objs.Name.Visible = true
                else objs.Name.Visible = false end

                if ExtraESPHealth then
                    local hp = hum.Health / math.max(hum.MaxHealth, 1)
                    objs.Health.Position = Vector2.new(topLeft.X - 26, topLeft.Y)
                    objs.Health.Text = tostring(math.floor(hp * 100)) .. "%"
                    objs.Health.Color = hp > 0.5 and Color3.fromRGB(50,255,50) or (hp > 0.25 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,50,50))
                    objs.Health.Visible = true
                else objs.Health.Visible = false end

                if ExtraESPDistance then
                    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    local dist = myRoot and math.floor((myRoot.Position - hrp.Position).Magnitude) or 0
                    objs.Distance.Position = Vector2.new(rootPos.X, topLeft.Y + boxHeight + 4)
                    objs.Distance.Text = tostring(dist) .. "m" objs.Distance.Color = ExtraESPColor objs.Distance.Visible = true
                else objs.Distance.Visible = false end

                if ExtraESPTracer then
                    objs.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                    objs.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    objs.Tracer.Color = ExtraESPColor objs.Tracer.Visible = true
                else objs.Tracer.Visible = false end

                if ExtraESPSkeleton then
                    for _, pair in ipairs(extraBoneConnections) do
                        local a, b = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2])
                        if a and b then
                            local p1, on1 = cam:WorldToViewportPoint(a.Position)
                            local p2, on2 = cam:WorldToViewportPoint(b.Position)
                            local key = pair[1] .. pair[2]
                            if on1 and on2 then
                                if not objs.Skeleton[key] then
                                    local line = Drawing.new("Line") line.Thickness = 1.5 line.Transparency = 0.6
                                    objs.Skeleton[key] = line
                                end
                                local line = objs.Skeleton[key]
                                line.From = Vector2.new(p1.X,p1.Y) line.To = Vector2.new(p2.X,p2.Y)
                                line.Color = ExtraESPColor line.Visible = true
                            elseif objs.Skeleton[key] then objs.Skeleton[key].Visible = false end
                        end
                    end
                else
                    for _, line in pairs(objs.Skeleton) do line.Visible = false end
                end
            else hideExtraESP(objs) end
        else hideExtraESP(objs) end
    end
end)


 -- HC's base box/text/skeleton rendering above is retained. Optional new layers below.
 local overlay=U.own(Instance.new('ScreenGui'));overlay.Name='KimqetrasUNLEGIT_ESP';overlay.IgnoreGuiInset=true;overlay.ResetOnSpawn=false;overlay.Parent=gui.Parent
 local layers={};local markerLabels={}
 local function drawLine()if not Drawing then return nil end;local d=Drawing.new('Line');d.Thickness=1;d.Visible=false;d.Color=U.color();return d end
 local function layer(p)
  if layers[p]then return layers[p]end
  local f=Instance.new('Frame');f.BorderSizePixel=0;f.BackgroundColor3=U.color();f.BackgroundTransparency=.85;f.Visible=false;f.Parent=overlay
  local gradient=Instance.new('UIGradient');gradient.Rotation=90;gradient.Transparency=NumberSequence.new(.6,0);gradient.Parent=f
  local bar=Instance.new('Frame');bar.BorderSizePixel=0;bar.BackgroundColor3=Color3.fromRGB(80,240,90);bar.Parent=overlay;bar.Visible=false
  local glow=Instance.new('Highlight');glow.FillTransparency=.85;glow.OutlineTransparency=.15;glow.Enabled=false;glow.Parent=U.visualFolder
  local v={fill=f,bar=bar,glow=glow,lines={},edges={}}
  if Drawing then for i=1,12 do v.lines[i]=drawLine()end;for i=1,8 do v.edges[i]=drawLine()end end
  layers[p]=v;return v
 end
 local function hide(v)v.fill.Visible=false;v.bar.Visible=false;v.glow.Enabled=false;for _,d in ipairs(v.lines)do d.Visible=false end;for _,d in ipairs(v.edges)do d.Visible=false end end
 U.connect(Players.PlayerRemoving,function(p)local v=layers[p];if v then hide(v);v.fill:Destroy();v.bar:Destroy();v.glow:Destroy();for _,d in ipairs(v.lines)do d:Remove()end;for _,d in ipairs(v.edges)do d:Remove()end;layers[p]=nil end end)
 local pairs3d={{1,2},{2,3},{3,4},{4,1},{5,6},{6,7},{7,8},{8,5},{1,5},{2,6},{3,7},{4,8}}
 local signs={Vector3.new(-1,-1,-1),Vector3.new(1,-1,-1),Vector3.new(1,1,-1),Vector3.new(-1,1,-1),Vector3.new(-1,-1,1),Vector3.new(1,-1,1),Vector3.new(1,1,1),Vector3.new(-1,1,1)}
 local function project(camera,pos)local p,on=camera:WorldToViewportPoint(pos);return Vector2.new(p.X,p.Y),on and p.Z>0 end
 U.connect(RunService.RenderStepped,function()
  local camera=workspace.CurrentCamera;if not camera then return end
  local _,_,myRoot=U.character(lp);local color=U.color()
  for _,p in ipairs(Players:GetPlayers())do if p~=lp then
   local v=layers[p];if not v and S.ESP then v=layer(p)end
   if v then
    hide(v);local c,h,r=U.character(p)
    if S.ESP and h and h.Health>0 and r and myRoot and(r.Position-myRoot.Position).Magnitude<=S.ESPRange then
     local point,on=project(camera,r.Position)
     if on then
      local head=c:FindFirstChild('Head')or r;local top= camera:WorldToViewportPoint(head.Position+Vector3.new(0,.5,0));local bottom=camera:WorldToViewportPoint(r.Position-Vector3.new(0,3,0))
      local height=math.abs(top.Y-bottom.Y);local width=height/2;local x,y=point.X-width/2,point.Y-height/2
      v.fill.Position=UDim2.fromOffset(x,y);v.fill.Size=UDim2.fromOffset(width,height);v.fill.BackgroundColor3=color;v.fill.Visible=S.GradientFill
      local ratio=math.clamp(h.Health/math.max(h.MaxHealth,1),0,1);v.bar.Position=UDim2.fromOffset(x-5,y+height*(1-ratio));v.bar.Size=UDim2.fromOffset(3,height*ratio);v.bar.BackgroundColor3=Color3.fromHSV(ratio/3,1,1);v.bar.Visible=S.HealthBar
      if S.Edges and Drawing then
       local l=width*.25;local k=height*.18;local endpoints={{{x,y},{x+l,y}},{{x,y},{x,y+k}},{{x+width,y},{x+width-l,y}},{{x+width,y},{x+width,y+k}},{{x,y+height},{x+l,y+height}},{{x,y+height},{x,y+height-k}},{{x+width,y+height},{x+width-l,y+height}},{{x+width,y+height},{x+width,y+height-k}}}
       for i,e in ipairs(endpoints)do local d=v.edges[i];d.From=Vector2.new(e[1][1],e[1][2]);d.To=Vector2.new(e[2][1],e[2][2]);d.Color=color;d.Visible=true end
      end
      if S.Box3D and Drawing then
       local cf,size=c:GetBoundingBox();local points,shown={},{}
       for i,sign in ipairs(signs)do points[i],shown[i]=project(camera,cf:PointToWorldSpace(size*.5*sign))end
       for i,pair in ipairs(pairs3d)do local d=v.lines[i];d.From=points[pair[1]];d.To=points[pair[2]];d.Color=color;d.Visible=shown[pair[1]]and shown[pair[2]]end
      end
     end
     v.glow.Adornee=c;v.glow.FillColor=color;v.glow.OutlineColor=color;v.glow.Enabled=S.Glow
    end
   end
  end end
  local markers={};if S.WaypointESP then for _,w in ipairs(U.waypoints)do table.insert(markers,w)end end;if S.DeathMarkers then for _,w in ipairs(U.deaths)do table.insert(markers,w)end end
  for i,w in ipairs(markers)do
   local t=markerLabels[i];if not t then t=text(overlay,'',UDim2.fromOffset(220,22),nil,13,color,Source,Enum.TextXAlignment.Center);t.AnchorPoint=Vector2.new(.5,.5);markerLabels[i]=t end
   local point,on=project(camera,w.pos);t.Position=UDim2.fromOffset(point.X,point.Y);t.Visible=on and(S.WaypointIcon or S.WaypointText);t.TextColor3=color
   local dist=myRoot and math.floor((myRoot.Position-w.pos).Magnitude)or 0;t.Text=(S.WaypointIcon and '♥ 'or '')..(S.WaypointText and(w.name..' • '..dist..' studs')or '')
  end
  for i=#markers+1,#markerLabels do markerLabels[i].Visible=false end
 end)
end
U.state='Ready • Right Shift toggles Kimqetras UNLEGIT.'

U.ready=true
gui.Enabled=true;main.Visible=true

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
