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


local TAB_NAMES={'Combat','Targets','ESP','Movement','Azure','Waypoints','Configs'}
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
