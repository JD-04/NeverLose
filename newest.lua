do
	local Constant = 'L'..'P'..'H'..'_NO_VIRTUALIZE';
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end;

cloneref = cloneref or function(i) return i end;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset;
getgenv = getgenv or getfenv;

local LOAD_ENV = LPH_NO_VIRTUALIZE(function()
	if game:GetService('RunService'):IsStudio() then
		local BaseWorkspace = game:GetService("ReplicatedFirst"):FindFirstChild('PRI_WORKSPACE') or Instance.new('Folder',game:GetService("ReplicatedFirst"));

		BaseWorkspace.Name = 'PRI\0.'..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

		local __get_path_c = function(path)
			return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
		end;

		local __get_path = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				block = block[v];
			end;

			return block;
		end;

		getgenv().readfile = function(path)
			local path : StringValue = __get_path(path);

			return path.Value;
		end;

		getgenv().isfile = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and not message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().isfolder = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().writefile = function(path,content)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('StringValue',block);

					c.Name = tostring(v);
					c.Value = content;
				else
					if item:IsA('StringValue') and tostring(item) == v then
						item.Name = tostring(v);
						item.Value = content;
					end;

					block = item;
				end;
			end;
		end;

		getgenv().listfiles = function(path)
			local fold = __get_path(path);
			local pa = {};

			for i,v in next , fold:GetChildren() do
				if v:IsA('StringValue') then
					table.insert(pa,path..'/'..tostring(v));
				end;
			end;

			return pa;
		end;

		getgenv().makefolder = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('Folder',block);

					c.Name = tostring(v);
				else
					block = item;
				end;
			end;
		end;

		getgenv().delfile = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if item and item:IsA('StringValue') then
					item:Destroy();
				else
					block = item;
				end;
			end;
		end;
	end;
end)

LOAD_ENV();

writefile = writefile or getgenv().writefile;
makefolder = makefolder or getgenv().makefolder;
readfile = readfile or getgenv().readfile;
delfolder = delfolder or getgenv().delfolder;
delfile = delfile or getgenv().delfile;
listfiles = listfiles or getgenv().listfiles;
isfolder = isfolder or getgenv().isfolder;
isfile = isfile or getgenv().isfile;

local NeverLose = {};

NeverLose.BuiltInRegular = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal);
NeverLose.BuiltInBold = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal);
NeverLose.GlobalSignals = {};
NeverLose.UnloadEnabled = false;

local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local StatsService = cloneref(game:GetService('Stats'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui: PlayerGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse: Mouse = LocalPlayer:GetMouse();
local CurrentCamera: Camera = cloneref(workspace.CurrentCamera);
local ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end;
local GlobalWindow = Instance.new('ScreenGui');
local ManualTween = TweenInfo.new(0.1);
local SlowyTween = TweenInfo.new(0.175);
local FastTween = TweenInfo.new(0.05);
local VSlowTween = TweenInfo.new(0.5,Enum.EasingStyle.Quint);
local Encryption = {};

NeverLose.UserProfile = Players:GetUserThumbnailAsync(LocalPlayer.UserId , Enum.ThumbnailType.HeadShot , Enum.ThumbnailSize.Size150x150)
NeverLose.RandomString = LPH_NO_VIRTUALIZE(function()
	return string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4));
end);

ProtectGui(GlobalWindow);

GlobalWindow.Name = NeverLose.RandomString();
GlobalWindow.IgnoreGuiInset = true;
GlobalWindow.ZIndexBehavior = Enum.ZIndexBehavior.Global;
GlobalWindow.ResetOnSpawn = false;
GlobalWindow.Parent = CoreGui;

NeverLose.Scales = {
	Small = UDim2.fromOffset(560,420),
	Mobile = UDim2.fromOffset(600,400),
	Default = UDim2.fromOffset(640,480),
	Large = UDim2.fromOffset(800,600)
};

NeverLose.IconColor = Color3.fromRGB(255, 255, 255);
NeverLose.ScreenGui = GlobalWindow;
NeverLose.Flags = {};
NeverLose.AccentColor = Color3.fromRGB(78, 127, 252);

NeverLose.AccentTargets = {};
NeverLose.AccentHooks = {};
NeverLose.AccentPainted = Color3.fromRGB(78, 127, 252);
NeverLose.RiskColor = Color3.fromRGB(255, 62, 62);
NeverLose.SectionTransparency = 0.250;
NeverLose.SectionCards = {};
NeverLose.KeybindModes = {"Always" , "Hold" , "Toggle"};
NeverLose.Theme = {
 Window=Color3.fromRGB(17,19,24), Sidebar=Color3.fromRGB(21,23,28), Content=Color3.fromRGB(19,21,27), Section=Color3.fromRGB(28,31,38), Control=Color3.fromRGB(38,42,51), Hover=Color3.fromRGB(47,52,63), Selected=Color3.fromRGB(51,58,72), Border=Color3.fromRGB(67,73,87), Text=Color3.fromRGB(237,240,247), MutedText=Color3.fromRGB(187,194,208), Icon=Color3.fromRGB(183,193,211), Knob=Color3.fromRGB(242,246,255), ToggleOff=Color3.fromRGB(33,37,45), Accent=Color3.fromRGB(137,180,250), Risk=Color3.fromRGB(244,105,123)
};
NeverLose.ThemeName='Graphite';
NeverLose.ThemeTargets=setmetatable({},{__mode='k'});
NeverLose.ThemeHooks={};
NeverLose.FontObjects=setmetatable({},{__mode='k'});
NeverLose.ThemePresetOrder={'Graphite','Nightfall','Arctic','Orchid','Rose Quartz','Sakura','Evergreen','Amber','Crimson','Ocean','UBG'};
NeverLose.ThemePresetSeeds={
 ['Graphite']={'111318','15171c','13151b','1c1f26','262a33','89b4fa','edf0f7','bbc2d0'},
 ['Nightfall']={'0c1020','101527','10162a','18213a','242f49','91a7ff','e9edff','b9c2e2'},
 ['Arctic']={'10171d','131e26','111b24','1b2933','283944','88d4e3','e4f5f8','b0cdd5'},
 ['Orchid']={'17131d','1e1927','1b1625','282033','362d43','c4a4f4','f0e9fa','c9badb'},
 ['Rose Quartz']={'1b151b','211a22','1e1720','2d222e','3d2d3d','e9a6c3','f8edf4','d7bdcc'},
 ['Sakura']={'191719','201d20','1d1a1d','2b252a','3a3139','f2b8c6','f9f0f3','d4c4cb'},
 ['Evergreen']={'101914','152119','121e17','1d2d23','2b3e30','94d6a7','eaf5ed','bbd2c1'},
 ['Amber']={'1b1711','221d15','201b14','2d261c','3b3225','edc078','faf2e3','d6c8ac'},
 ['Crimson']={'1b1317','23191e','20151b','2e2028','402c35','ec8b9c','faedf1','dabdc7'},
 ['Ocean']={'0e171e','121e28','10202b','192d3b','263e4d','75bfee','e6f4fc','b1cddb'},
 ['UBG']={'0e1015','14171e','0e1015','14171e','1e232e','ff1414','ffffff','9aa0a6'}
};
NeverLose.ThemePresetOverrides = {
	UBG = {Border='282e3d',ToggleOff='1e232e'}
};
NeverLose.Motion = {Enabled=true,Style='Original',Direction='Original',FadeTime=0.175,PopupEffect='Scale'};
NeverLose.MotionStyles = {'Original','Linear','Sine','Quad','Cubic','Quart','Quint','Exponential','Circular','Back','Bounce','Elastic'};
NeverLose.MotionDirections = {'Original','In','Out','InOut'};
NeverLose.PopupEffects = {'Scale','Fade','Instant'};
NeverLose.MotionTweens = {};
NeverLose.AppearanceRoots = setmetatable({}, {__mode='k'});
function NeverLose:IsMotionTarget(object)
	return object:IsA('GuiObject') or object:IsA('UIComponent') or object:IsA('UIScale') or object:IsA('UIStroke') or object:IsA('UICorner') or object:IsA('UIShadow');
end;
function NeverLose:ResolveMotionInfo(object, info)
	info = info or TweenInfo.new(0.25);
	if not self:IsMotionTarget(object) then return info; end;
	local settings = self.Motion;
	local duration = (info.Time or 0.175) * settings.FadeTime / 0.175;
	if not settings.Enabled or self.MotionFlushing then duration = 0; end;
	if settings.PopupEffect == 'Instant' then
		local node = object;
		while node do
			if self.AppearanceRoots[node] then duration=0; break; end;
			node = node.Parent;
		end;
	end;
	local style = settings.Style == 'Original' and info.EasingStyle or Enum.EasingStyle[settings.Style];
	local direction = settings.Direction == 'Original' and info.EasingDirection or Enum.EasingDirection[settings.Direction];
	return TweenInfo.new(math.max(0,duration),style or Enum.EasingStyle.Quad,direction or Enum.EasingDirection.Out,info.RepeatCount or 0,info.Reverses or false,duration > 0 and (info.DelayTime or 0) or 0);
end;
function NeverLose:FinishMotion()
	self.MotionFlushing = true;
	local pending = self.MotionTweens; self.MotionTweens = {};
	for tween,record in pairs(pending) do
		if record.Connection then record.Connection:Disconnect(); end;
		pcall(function() tween:Cancel(); end);
		for property,value in pairs(record.Properties) do pcall(function() record.Object[property]=value; end); end;
	end;
	self.MotionFlushing = false;
end;
function NeverLose:SetMotionOption(name,value)
	if name == 'Enabled' then if type(value)~='boolean' then return false; end;
	elseif name == 'FadeTime' then value=tonumber(value); if not value or value~=value then return false; end; value=math.clamp(value,0,1);
	elseif name == 'Style' then if not table.find(self.MotionStyles,value) then return false; end;
	elseif name == 'Direction' then if not table.find(self.MotionDirections,value) then return false; end;
	elseif name == 'PopupEffect' then if not table.find(self.PopupEffects,value) then return false; end;
	else return false; end;
	self.Motion[name]=value;
	if not self.Motion.Enabled or self.Motion.FadeTime == 0 then self:FinishMotion(); end;
	if name=='PopupEffect' or name=='Enabled' or name=='FadeTime' then
		for _,entry in pairs(self.AppearanceRoots) do
			if entry.Tween then entry.Tween:Cancel(); entry.Tween=nil; end;
			entry.Scale.Scale=1;
		end;
	end;
	return true;
end;
function NeverLose:AnimatePopup(frame, scale)
	local entry=self.AppearanceRoots[frame];
	if not entry then
		if not scale then scale=Instance.new('UIScale'); scale.Name='PopupMotion'; scale.Scale=1; scale.Parent=frame; end;
		entry={Scale=scale}; self.AppearanceRoots[frame]=entry;
		self:AddSignal(frame.Destroying:Connect(function() if entry.Tween then entry.Tween:Cancel(); end; self.AppearanceRoots[frame]=nil; end));
	end;
	if entry.Tween then entry.Tween:Cancel(); entry.Tween=nil; end;
	if self.Motion.Enabled and self.Motion.FadeTime > 0 and self.Motion.PopupEffect=='Scale' then
		entry.Scale.Scale=0.97;
		entry.Tween=NeverLose.PlayAnimate(entry.Scale,TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1});
	else entry.Scale.Scale=1; end;
end;
function NeverLose:GetMotionAlpha(dt, speed)
	if not self.Motion.Enabled or self.Motion.FadeTime<=0 then return 1; end;
	return 1-math.exp(-(speed or 28)*math.min(math.max(dt,0),0.1)*0.175/self.Motion.FadeTime);
end;

NeverLose.Glow = {Enabled=true,Icons=true,Sliders=true,Toggles=true,Tabs=true,ColorMode='Element',Color=Color3.fromRGB(137,180,250),Intensity=0.28,BlurRadius=12,Spread=0,OffsetX=0,OffsetY=0,IconMode='On hover',HoverBoost=0.12,MaxVisible=64};
NeverLose.GlowTargets = setmetatable({}, {__mode='k'});
NeverLose.GlowHooks = {};
NeverLose.GlowCount = 0;
NeverLose.GlowSerial = 0;
NeverLose.GlowSupported = nil;
local function SetProp(object,property,value)
	return pcall(function() object[property]=value; end);
end;
local function MakeShadow(parent,props)
	props=props or {};
	local created,shadow=pcall(Instance.new,'UIShadow');
	if not created or not shadow then return nil; end;
	local values={Color=props.Color or NeverLose.AccentColor,BlurRadius=UDim.new(0,math.max(0,props.BlurRadius or 20)),Offset=UDim2.fromOffset(props.OffsetX or 0,props.OffsetY or 0),Spread=UDim2.fromOffset(props.SpreadX or 0,props.SpreadY or 0),Transparency=math.clamp(props.Transparency or 0,0,1),ZIndex=math.min(-1,props.ZIndex or -1)};
	for property,value in pairs(values) do
		if not SetProp(shadow,property,value) then shadow:Destroy(); return nil; end;
	end;
	SetProp(shadow,'Enabled',true);
	if not SetProp(shadow,'Parent',parent) then shadow:Destroy(); return nil; end;
	shadow.Name='ElementGlow'; return shadow;
end;
NeverLose.MakeShadow = MakeShadow;
function NeverLose:GetGlowStatus()
	if self.GlowSupported==false then return 'UIShadow unavailable; UI unchanged'; end;
	if not self.Glow.Enabled then return 'Glow disabled'; end;
	return 'Glow ready; awaiting visible elements';
end;
function NeverLose:NotifyGlow()
	for _,callback in ipairs(self.GlowHooks) do pcall(callback,self:GetGlowStatus()); end;
end;
function NeverLose:SetGlowOption(name,value)
	if name=='Enabled' or name=='Icons' or name=='Sliders' or name=='Toggles' or name=='Tabs' then
		if type(value)~='boolean' then return false; end;
	elseif name=='ColorMode' then
		if not table.find({'Element','Accent','Custom'},value) then return false; end;
	elseif name=='IconMode' then
		if not table.find({'On hover','Always'},value) then return false; end;
	elseif name=='Color' then
		if typeof(value)~='Color3' then return false; end;
	else
		local limits={Intensity={0,1},BlurRadius={0,30},Spread={-6,8},OffsetX={-12,12},OffsetY={-12,12},HoverBoost={0,0.5},MaxVisible={8,80}};
		local range=limits[name]; value=tonumber(value);
		if not range or not value or value~=value then return false; end;
		value=math.clamp(value,range[1],range[2]); if name=='MaxVisible' then value=math.floor(value); end;
	end;
	self.Glow[name]=value; self:UpdateGlows(0,true); self:NotifyGlow(); return true;
end;
function NeverLose:IsGlowVisible(object)
	if not self:IsGuiVisible(object) then return false; end;
	local root=self:GetGuiRoot(object); if not root then return false; end;
	local position,size=self:GetGuiRect(object,root); local canvas=self:GetCanvasSize(root);
	local left,top,right,bottom=math.max(0,position.X),math.max(0,position.Y),math.min(canvas.X,position.X+size.X),math.min(canvas.Y,position.Y+size.Y);
	if size.X<=0 or size.Y<=0 or right<=left or bottom<=top then return false; end;
	local node=object.Parent;
	while node and node~=root do
		if node:IsA('GuiObject') and (node.ClipsDescendants or node:IsA('ScrollingFrame')) then
			local p,z=self:GetGuiRect(node,root);
			left,top,right,bottom=math.max(left,p.X),math.max(top,p.Y),math.min(right,p.X+z.X),math.min(bottom,p.Y+z.Y);
			if right<=left or bottom<=top then return false; end;
		end;
		node=node.Parent;
	end;
	return true;
end;
function NeverLose:HideGlow(record)
	record.Opacity=0;
	if record.Shadow then
		SetProp(record.Shadow,'Transparency',1); SetProp(record.Shadow,'Enabled',false);
	end;
end;
function NeverLose:UpdateGlows(dt,instant)
	if self.GlowUpdating or self.GlowDestroyed then return; end;
	self.GlowUpdating=true;
	local settings=self.Glow; local candidates={};
	for object,record in pairs(self.GlowTargets) do
		local eligible=settings.Enabled and settings[record.Kind] and self.GlowSupported~=false and self:IsGlowVisible(object);
		if eligible then
			local alpha=object[record.AlphaProperty] or 0;
			local active=true;
			if record.Active then local ok,value=pcall(record.Active); active=ok and value; end;
			local hover=record.Hovered and self:CanUsePointer(object);
			if record.Kind=='Icons' and settings.IconMode=='On hover' then active=hover; end;
			local strength=math.clamp(settings.Intensity+(hover and settings.HoverBoost or 0),0,1);
			local weight=record.Kind=='Icons' and 0.7 or 1;
			record.TargetOpacity=active and math.clamp(1-alpha,0,1)*strength*weight or 0;
			if alpha<0.999 and (record.TargetOpacity>0.001 or record.Opacity>0.001) then table.insert(candidates,record); else self:HideGlow(record); end;
		else self:HideGlow(record); end;
	end;
	table.sort(candidates,function(a,b)
		local ranks={Toggles=4,Sliders=3,Tabs=2,Icons=1};
		local pa,pb=ranks[a.Kind],ranks[b.Kind]; if pa==pb then return a.Id<b.Id; end; return pa>pb;
	end);
	local drawn=0;
	for _,record in ipairs(candidates) do
		if drawn>=settings.MaxVisible then self:HideGlow(record);
		else
			if not record.Shadow then
				record.Shadow=MakeShadow(record.Object,{Color=settings.Color,BlurRadius=settings.BlurRadius,Transparency=1,ZIndex=-1});
				if not record.Shadow then
					self.GlowSupported=false; self:NotifyGlow(); break;
				elseif self.GlowSupported==nil then self.GlowSupported=true; self:NotifyGlow(); end;
			end;
			local shadow=record.Shadow;
			local color=settings.Color;
			if settings.ColorMode=='Accent' then color=self.Theme.Accent;
			elseif settings.ColorMode=='Element' then color=record.Object[record.ColorProperty] or self.Theme.Accent; end;
			local spread=settings.Spread;
			if record.Kind=='Icons' then spread=spread-math.min(4,record.Object.AbsoluteSize.X*0.2); end;
			local amount=instant and 1 or self:GetMotionAlpha(dt or 1/30,16);
			record.Opacity=record.Opacity+(record.TargetOpacity-record.Opacity)*amount;
			local ok=true;
			for property,value in pairs({Color=color,BlurRadius=UDim.new(0,settings.BlurRadius),Offset=UDim2.fromOffset(settings.OffsetX,settings.OffsetY),Spread=UDim2.fromOffset(spread,spread),Transparency=1-math.clamp(record.Opacity,0,1)}) do
				local assigned=SetProp(shadow,property,value); if not assigned then ok=false; break; end;
			end;
			if not ok then self.GlowSupported=false; self:NotifyGlow(); break; end;
			SetProp(shadow,'Enabled',record.Opacity>0.001);
			if record.Opacity>0.001 then drawn=drawn+1; end;
		end;
	end;
	if self.GlowSupported==false then for _,record in pairs(self.GlowTargets) do self:HideGlow(record); end; drawn=0; end;
	self.GlowCount=drawn; self.GlowUpdating=false;
end;
function NeverLose:BindGlow(object,kind,options)
	if not object or not object:IsA('GuiObject') then return; end;
	options=options or {};
	local record=self.GlowTargets[object];
	if record then
		if options.Active then record.Active=options.Active; end;
		return record;
	end;
	self.GlowSerial=self.GlowSerial+1;
	record={Object=object,Kind=kind,Id=self.GlowSerial,Opacity=0,TargetOpacity=0,Hovered=false,Active=options.Active,Connections={}};
	record.ColorProperty=options.ColorProperty or (object:IsA('TextLabel') and 'TextColor3' or object:IsA('ImageLabel') and 'ImageColor3' or 'BackgroundColor3');
	record.AlphaProperty=options.AlphaProperty or (object:IsA('TextLabel') and 'TextTransparency' or object:IsA('ImageLabel') and 'ImageTransparency' or 'BackgroundTransparency');
	self.GlowTargets[object]=record;
	local function connect(signal,callback)
		local connection=signal:Connect(callback); table.insert(record.Connections,connection); self:AddSignal(connection);
	end;
	connect(object.MouseEnter,function() record.Hovered=true; end);
	connect(object.MouseLeave,function() record.Hovered=false; end);
	connect(object:GetPropertyChangedSignal('Visible'),function() if not object.Visible then self:HideGlow(record); end; end);
	connect(object:GetPropertyChangedSignal(record.AlphaProperty),function() if object[record.AlphaProperty]>=0.999 then self:HideGlow(record); end; end);
	connect(object.Destroying,function()
		self.GlowTargets[object]=nil;
		for _,connection in ipairs(record.Connections) do connection:Disconnect(); end;
		if record.Shadow then pcall(function() record.Shadow:Destroy(); end); end;
	end);
	if not self.GlowTick then
		local elapsed=0;
		self.GlowTick=RunService.RenderStepped:Connect(function(dt)
			elapsed=elapsed+(tonumber(dt) or 1/60);
			if elapsed>=1/30 then self:UpdateGlows(elapsed); elapsed=0; end;
		end);
		self:AddSignal(self.GlowTick);
		self:AddSignal(self.ScreenGui.Destroying:Connect(function() self:DestroyGlows(); self:FinishMotion(); end));
	end;
	return record;
end;
function NeverLose:DestroyGlows()
	self.GlowDestroyed=true;
	if self.GlowTick then self.GlowTick:Disconnect(); self.GlowTick=nil; end;
	for object,record in pairs(self.GlowTargets) do
		for _,connection in ipairs(record.Connections) do connection:Disconnect(); end;
		if record.Shadow then pcall(function() record.Shadow:Destroy(); end); end;
		self.GlowTargets[object]=nil;
	end;
	self.GlowCount=0;
end;

function NeverLose:BindTheme(object,property,role)
 if property=='TextColor3' and (role=='Text' or role=='MutedText') and not self.FontObjects[object] then
  local face=object.FontFace;
  if face and tostring(face.Family):find('BuilderIcons',1,true) then role='Icon'; end;
 end;
 local bindings=self.ThemeTargets[object] or {};
 self.ThemeTargets[object]=bindings;
 bindings[property]=role;
 object[property]=self.Theme[role];
 if role=='Icon' and (property=='TextColor3' or property=='ImageColor3') then
  local isIcon=property=='ImageColor3' or object.FontFace and tostring(object.FontFace.Family):find('BuilderIcons',1,true);
  if isIcon then self:BindGlow(object,'Icons',{ColorProperty=property}); end;
 elseif role=='TabAccent' and property=='BackgroundColor3' then self:BindGlow(object,'Tabs'); end;
 return object;
end;
function NeverLose:BindThemeHook(callback) table.insert(self.ThemeHooks,callback); return callback; end;
function NeverLose:RefreshTheme()
 self.RiskColor=self.Theme.Risk; self.IconColor=self.Theme.Icon;
 for object,bindings in pairs(self.ThemeTargets) do
  for property,role in pairs(bindings) do pcall(function() object[property]=self.Theme[role]; end); end;
 end;
 self:SetAccentColor(self.Theme.Accent);
 for _,callback in ipairs(self.ThemeHooks) do pcall(callback); end;
end;
function NeverLose:ColorsEqual(a,b)
	if typeof(a)~='Color3' or typeof(b)~='Color3' then return a==b; end;
	return math.abs(a.R-b.R)<0.0005 and math.abs(a.G-b.G)<0.0005 and math.abs(a.B-b.B)<0.0005;
end;
function NeverLose:SetThemeColor(role,value)
 if not self.Theme[role] or typeof(value)~='Color3' then return false; end;
 self:RestoreElementPreset(); self.Theme[role]=value; self.ThemeName='Custom'; self:RefreshTheme(); return true;
end;
NeverLose.FontCatalog={
 'Bubblegum-Sans.ttf','Comfortaa-Regular.ttf','Figtree-Medium.ttf','Figtree-SemiBold.ttf','GoogleSansFlex_24pt-SemiBold.ttf','HankenGrotesk-SemiBold.ttf','Inter.ttf','InterBold.ttf','InterMedium.ttf','InterSemibold.ttf','Lato-Bold.ttf','Lexend-Medium.ttf','MinecraftStandard.ttf','Monaco.ttf','NDS12.ttf','Outfit-Medium.ttf','PIXEARG_.TTF','PixelOperator.ttf','Poppins-Medium.ttf','ProggyClean.fon','ProggyClean.ttf','Prompt-Medium.ttf','Prompt-Regular.ttf','Reactor7.ttf','RobotoMono-Regular.ttf','SGK075.ttf','TAHOMA-8PT-BOLD-WINDOWS-XP.TTF','basis33.ttf','cozette-vector.ttf','fs Tahoma 8px.ttf','lucida-console.ttf','minecraftia-regular.ttf','minecraftia.ttf','open-sans-px.ttf','proggy-clean.ttf','proggy-square.ttf','proggy-tiny.ttf','smallest_pixel-7.ttf','tahoma.ttf','tahomabd.ttf','teachers-pet.ttf','verdana-bold.ttf','verdana.ttf','windows-xp-tahoma.ttf'
};
NeverLose.FontName='Built-in'; NeverLose.FontScale=1.00; NeverLose.FontCache={}; NeverLose.FontRequest=0; NeverLose.TextMeasureCache={}; NeverLose.TextMeasureCount=0; NeverLose.TypographyHooks={};
function NeverLose:RegisterFont(object,fallback)
 local record=self.FontObjects[object] or {Size=object.TextSize}; self.FontObjects[object]=record; record.Fallback=fallback;
 if self.ActiveFont then object.FontFace=self.ActiveFont; else object.Font=fallback; end;
 return object;
end;
function NeverLose:SetTextSize(object,value)
 local record=self.FontObjects[object];
 if record then
  record.Size=value; object.TextSize=math.floor(value*self.FontScale+0.5);
  local size=object.Size;
  if size.Y.Scale==0 and size.Y.Offset>0 and size.Y.Offset<=28 then object.Size=UDim2.new(size.X.Scale,size.X.Offset,0,math.max(size.Y.Offset,object.TextSize+3)); end;
 else object.TextSize=value; end;
end;
function NeverLose:BindTypography(callback) table.insert(self.TypographyHooks,callback); return callback; end;
function NeverLose:RefreshTypography()
 table.clear(self.TextMeasureCache); self.TextMeasureCount=0;
 for object,record in pairs(self.FontObjects) do pcall(function()
  if self.ActiveFont then object.FontFace=self.ActiveFont; else object.Font=record.Fallback; end;
  self:SetTextSize(object,record.Size);
 end); end;
 for _,callback in ipairs(self.TypographyHooks) do task.defer(function() pcall(callback); end); end;
end;
function NeverLose:SetFontScale(value)
 self.FontScale=math.clamp(tonumber(value) or 1.00,0.85,1.30); self:RefreshTypography(); return self.FontScale;
end;
function NeverLose:MeasureText(text,size,font,bounds)
 text=tostring(text or ''); local width=bounds and bounds.X or 100000;
 if width==math.huge then width=100000; end;
 local face=font;
 if typeof(face)=='EnumItem' then face=self.ActiveFont or Font.fromEnum(face); end;
 if not face then face=self.ActiveFont or Font.fromEnum(Enum.Font.GothamMedium); end;
 local key=text..'\0'..tostring(size)..'\0'..tostring(face.Family)..':'..tostring(face.Weight)..':'..tostring(face.Style)..'\0'..tostring(width);
 if self.TextMeasureCache[key] then return self.TextMeasureCache[key]; end;
 local success,result=pcall(function()
  local params=Instance.new('GetTextBoundsParams'); params.Text=text; params.Size=size; params.Font=face; params.Width=width;
  return TextService:GetTextBoundsAsync(params);
 end);
 if not success then result=TextService:GetTextSize(text,size,Enum.Font.GothamMedium,Vector2.new(width,100000)); end;
 if self.TextMeasureCount>=2048 then table.clear(self.TextMeasureCache); self.TextMeasureCount=0; end;
 self.TextMeasureCache[key]=result; self.TextMeasureCount=self.TextMeasureCount+1; return result;
end;
function NeverLose:EnsureAssetFolder(path)
 if not isfolder or not makefolder or not writefile or not readfile then return false,'Local asset storage is unavailable'; end;
 return pcall(function() if not isfolder('NLAssets') then makefolder('NLAssets'); end; if not isfolder(path) then makefolder(path); end; end);
end;
function NeverLose:LoadFontAsset(name)
 if name=='Built-in' then return nil; end;
 if not table.find(self.FontCatalog,name) then error('Unknown font'); end;
 local file=name=='ProggyClean.fon' and 'ProggyClean.ttf' or name;
 if self.FontCache[file] then return self.FontCache[file]; end;
 if not getcustomasset then error('Custom fonts require custom asset support'); end;
 local ready,reason=self:EnsureAssetFolder('NLAssets/Fonts'); if not ready then error(reason); end;
 local path='NLAssets/Fonts/'..file;
 local function valid(data)
  if type(data)~='string' or #data<12 then return false; end;
  local h=data:sub(1,4); return h=='\0\1\0\0' or h=='OTTO' or h=='true' or h=='ttcf';
 end;
 local cached=false;
 if isfile and isfile(path) then local ok,data=pcall(readfile,path); cached=ok and valid(data); end;
 if not cached then
  local encoded=file:gsub('[^%w%-%._~]',function(c) return string.format('%%%02X',string.byte(c)); end);
  local data=game:HttpGet('https://raw.githubusercontent.com/sametexe001/luas/main/fonts/'..encoded);
  if not valid(data) then error('Invalid font download'); end; writefile(path,data);
 end;
 local familyPath=path..'.font.json';
 writefile(familyPath,HttpService:JSONEncode({name='NL '..file,faces={{name='Regular',weight=400,style='normal',assetId=getcustomasset(path)}}}));
 local face=Font.new(getcustomasset(familyPath),Enum.FontWeight.Regular,Enum.FontStyle.Normal);
 local probe=Instance.new('GetTextBoundsParams'); probe.Text='Aa 123'; probe.Font=face; probe.Size=14; probe.Width=1000;
 local measured=TextService:GetTextBoundsAsync(probe); if measured.X<=0 or measured.Y<=0 then error('Font could not be rendered'); end;
 self.FontCache[file]=face; return face;
end;
function NeverLose:SetUIFont(name)
 self.FontRequest=self.FontRequest+1; local request=self.FontRequest;
 local success,face=pcall(self.LoadFontAsset,self,name);
 if request~=self.FontRequest then return false,'Superseded'; end;
 if not success then return false,tostring(face); end;
 self.ActiveFont=face; self.FontName=name; self:RefreshTypography(); return true;
end;
function NeverLose:GetFontOptions()
 local options={'Built-in'}; for _,name in ipairs(self.FontCatalog) do table.insert(options,name); end; return options;
end;
function NeverLose:RefreshFontCatalog()
 return pcall(function()
  local data=HttpService:JSONDecode(game:HttpGet('https://api.github.com/repos/sametexe001/luas/contents/fonts?ref=main'));
  if type(data)~='table' then error('Invalid catalog'); end;
  for _,entry in ipairs(data) do
   local name=entry.name;
   if entry.type=='file' and type(name)=='string' and not name:find('[/\\]') then
    local lower=name:lower();
    if (lower:match('%.ttf$') or lower:match('%.otf$')) and not table.find(self.FontCatalog,name) then table.insert(self.FontCatalog,name); end;
   end;
  end;
  table.sort(self.FontCatalog,function(a,b) return a:lower()<b:lower(); end); return self:GetFontOptions();
 end);
end;
function NeverLose:FitWindowSize(size)
 local viewport=self.ScreenGui.AbsoluteSize; if viewport.X<=0 or viewport.Y<=0 then return size; end;
 local w=math.max(320,viewport.X-32); local h=math.max(240,viewport.Y-32);
 return UDim2.fromOffset(math.clamp(size.X.Scale*viewport.X+size.X.Offset,math.min(520,w),w),math.clamp(size.Y.Scale*viewport.Y+size.Y.Offset,math.min(360,h),h));
end;

NeverLose.CornerRadius = 8;
NeverLose.CornerTargets = setmetatable({}, {__mode = 'k'});
NeverLose.PopupTargets = setmetatable({}, {__mode = 'k'});
function NeverLose:BindCorner(corner, kind)
	self.CornerTargets[corner] = kind or 'Panel';
	local radius = self.CornerRadius;
	if kind == 'Control' then radius = math.max(0, radius - 3); elseif kind == 'Badge' then radius = math.max(0, math.min(3, radius - 4)); end;
	corner.CornerRadius = UDim.new(0, radius);
	return corner;
end;
function NeverLose:SetCornerRadius(value)
	self.CornerRadius = math.clamp(math.floor(tonumber(value) or 8), 0, 14);
	for corner,kind in pairs(self.CornerTargets) do pcall(function() self:BindCorner(corner, kind); end); end;
end;
function NeverLose:GetGuiRoot(object)
	if object and object:IsA('LayerCollector') then return object; end;
	return object and object:FindFirstAncestorWhichIsA('LayerCollector');
end;
function NeverLose:GetCanvasSize(root)
	if root and root:IsA('SurfaceGui') then return root.CanvasSize; end;
	return root and root.AbsoluteSize or self.ScreenGui.AbsoluteSize;
end;
function NeverLose:GetCanvasOrigin(root)
	return root and root:IsA('ScreenGui') and root.AbsolutePosition or Vector2.zero;
end;
function NeverLose:ProjectSurfaceRay(root, ray)
	local part = root.Adornee;
	if not part or not part:IsA('BasePart') then return nil; end;
	local origin = part.CFrame:PointToObjectSpace(ray.Origin);
	local direction = part.CFrame:VectorToObjectSpace(ray.Direction);
	local size = part.Size;
	local face = root.Face;
	local normal, right, down, width, height, depth;
	if face == Enum.NormalId.Front then
		normal, right, down = Vector3.new(0,0,-1), Vector3.new(-1,0,0), Vector3.new(0,-1,0);
		width, height, depth = size.X, size.Y, size.Z;
	elseif face == Enum.NormalId.Back then
		normal, right, down = Vector3.new(0,0,1), Vector3.new(1,0,0), Vector3.new(0,-1,0);
		width, height, depth = size.X, size.Y, size.Z;
	elseif face == Enum.NormalId.Left then
		normal, right, down = Vector3.new(-1,0,0), Vector3.new(0,0,1), Vector3.new(0,-1,0);
		width, height, depth = size.Z, size.Y, size.X;
	elseif face == Enum.NormalId.Right then
		normal, right, down = Vector3.new(1,0,0), Vector3.new(0,0,-1), Vector3.new(0,-1,0);
		width, height, depth = size.Z, size.Y, size.X;
	elseif face == Enum.NormalId.Top then
		normal, right, down = Vector3.new(0,1,0), Vector3.new(1,0,0), Vector3.new(0,0,1);
		width, height, depth = size.X, size.Z, size.Y;
	else
		normal, right, down = Vector3.new(0,-1,0), Vector3.new(1,0,0), Vector3.new(0,0,-1);
		width, height, depth = size.X, size.Z, size.Y;
	end;
	local divisor = direction:Dot(normal);
	if width <= 0 or height <= 0 or math.abs(divisor) < 0.00001 then return nil; end;
	local distance = (depth * 0.5 - origin:Dot(normal)) / divisor;
	if distance < 0 then return nil; end;
	local point = origin + direction * distance;
	local canvas = root.CanvasSize;
	return Vector2.new((0.5 + point:Dot(right) / width) * canvas.X, (0.5 + point:Dot(down) / height) * canvas.Y);
end;
function NeverLose:GetCanvasPoint(root, point)
	point = point or UserInputService:GetMouseLocation();
	if not root then return nil; end;
	if root:IsA('SurfaceGui') then
		local camera = workspace.CurrentCamera;
		if not camera then return nil; end;
		return self:ProjectSurfaceRay(root, camera:ViewportPointToRay(point.X, point.Y));
	end;
	local origin = self:GetCanvasOrigin(root);
	return Vector2.new(point.X - origin.X, point.Y - origin.Y);
end;
function NeverLose:GetGuiRect(object, root)
	root = root or self:GetGuiRoot(object);
	return object.AbsolutePosition - self:GetCanvasOrigin(root), object.AbsoluteSize;
end;
function NeverLose:PointInRect(point, position, size)
	return point ~= nil and point.X >= position.X and point.Y >= position.Y and point.X <= position.X + size.X and point.Y <= position.Y + size.Y;
end;
function NeverLose:IsGuiVisible(object)
	local node = object;
	while node do
		if node:IsA('GuiObject') and not node.Visible then return false; end;
		if node:IsA('LayerCollector') then return node.Enabled; end;
		node = node.Parent;
	end;
	return false;
end;
function NeverLose:IsMouseOverFrame(object)
	if not object or not self:IsGuiVisible(object) then return false; end;
	local root = self:GetGuiRoot(object);
	local point = self:GetCanvasPoint(root);
	if point then
		local position, size = self:GetGuiRect(object, root);
		if not self:PointInRect(point, position, size) then return false; end;
		local ancestor = object.Parent;
		while ancestor and ancestor ~= root do
			if ancestor:IsA('GuiObject') and (ancestor.ClipsDescendants or ancestor:IsA('ScrollingFrame')) then
				local ap, az = self:GetGuiRect(ancestor, root);
				if not self:PointInRect(point, ap, az) then return false; end;
			end;
			ancestor = ancestor.Parent;
		end;
		return true;
	end;
	if object.GuiState == Enum.GuiState.Hover or object.GuiState == Enum.GuiState.Press then return true; end;
	for _,child in ipairs(object:GetDescendants()) do
		if child:IsA('GuiObject') and child.Visible and (child.GuiState == Enum.GuiState.Hover or child.GuiState == Enum.GuiState.Press) then return true; end;
	end;
	return false;
end;
NeverLose.LocalLayers = setmetatable({}, {__mode='k'});
function NeverLose:GetLocalZIndex(object)
 local node = object;
 while node do
  local data = self.PopupTargets[node];
  if data and data.Raw[object] then return data.Raw[object]; end;
  node = node.Parent;
 end;
 return self.LocalLayers[object] or object.ZIndex;
end;
function NeverLose:ElevatePopup(frame, target)
	local data = self.PopupTargets[frame];
	if not data then
		data = {Anchor = frame.ZIndex, Target = target or 1000000, Raw = setmetatable({}, {__mode='k'}), Busy = false};
		self.PopupTargets[frame] = data;
		local function paint(object)
			if data.Busy then return; end;
			data.Busy = true;
			object.ZIndex = object == frame and data.Target or data.Target + math.clamp((data.Raw[object] or data.Anchor) - data.Anchor, 1, 9000);
			data.Busy = false;
		end;
		local function watch(object)
			if not object:IsA('GuiObject') or data.Raw[object] ~= nil then return; end;
			local raw = object.ZIndex;
			data.Raw[object] = raw >= 1000000 and raw - data.Target + data.Anchor or raw;
			NeverLose:AddSignal(object:GetPropertyChangedSignal('ZIndex'):Connect(function()
				if data.Busy then return; end;
				local value = object.ZIndex;
				data.Raw[object] = value >= 1000000 and value - data.Target + data.Anchor or value;
				if object == frame then data.Anchor = data.Raw[object]; end;
				paint(object);
			end));
			paint(object);
		end;
		data.Paint = paint;
		watch(frame);
		for _,object in ipairs(frame:GetDescendants()) do watch(object); end;
		NeverLose:AddSignal(frame.DescendantAdded:Connect(watch));
	end;
	if target then data.Target = target; end;
	for object in pairs(data.Raw) do if object == frame or object:IsDescendantOf(frame) then data.Paint(object); end; end;
end;
NeverLose.PopupRegistry = setmetatable({}, {__mode='k'});
NeverLose.PopupStack = {};
function NeverLose:HasOpenPopup()
	return #self.PopupStack > 0 or self.__CloseKeybindMenu ~= nil;
end;
function NeverLose:CanUsePointer(object)
	if self.__ModeMenuRoot and self.__ModeMenuRoot.Visible then
		return object == self.__ModeMenuRoot or object:IsDescendantOf(self.__ModeMenuRoot);
	end;
	local top = self.PopupStack[#self.PopupStack];
	return not top or object == top.Frame or object:IsDescendantOf(top.Frame);
end;
function NeverLose:ClosePopupsFrom(index)
	for i = #self.PopupStack, index, -1 do
		local entry = table.remove(self.PopupStack, i);
		entry.Open = false; entry.Pressed = nil; entry.Shield.Visible = false;
		pcall(entry.Close);
	end;
	self.IsMosueOverOtherFrame = #self.PopupStack > 0;
end;
function NeverLose:CloseAllPopups()
	if self.__CloseKeybindMenu then self.__CloseKeybindMenu(); end;
	self:ClosePopupsFrom(1);
end;
function NeverLose:RegisterPopup(frame, owner, close)
	local current = self.PopupRegistry[frame];
	if current then return current; end;
	local shield = Instance.new('TextButton');
	shield.Name = 'PopupOutsideClick'; shield.BackgroundTransparency = 1; shield.BorderSizePixel = 0; shield.Text = '';
	shield.Size = UDim2.fromScale(1,1); shield.Position = UDim2.fromOffset(0,0); shield.AutoButtonColor = false;
	shield.Active = true; shield.Selectable = false; shield.Visible = false;
	local scale = Instance.new('UIScale'); scale.Name = 'PopupMotion'; scale.Scale = 1; scale.Parent = frame;
	local entry = {Frame = frame, Owner = owner, Close = close, Shield = shield, Scale = scale, Open = false};
	self.PopupRegistry[frame] = entry;
	frame.Active = true;
	NeverLose:AddSignal(shield.InputBegan:Connect(function(input)
		if entry.Open and self.PopupStack[#self.PopupStack] == entry and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch) then entry.Pressed = input; end;
	end));
	local function dismiss()
		if not entry.Pressed or not entry.Open or self.PopupStack[#self.PopupStack] ~= entry then return; end;
		entry.Pressed = nil;
		self:ClosePopupsFrom(#self.PopupStack);
	end;
	NeverLose:AddSignal(shield.MouseButton1Click:Connect(dismiss));
	NeverLose:AddSignal(shield.MouseButton2Click:Connect(dismiss));
	NeverLose:AddSignal(frame.Destroying:Connect(function()
		local index = table.find(self.PopupStack, entry);
		if index then self:ClosePopupsFrom(index); end;
		self.PopupRegistry[frame] = nil; shield:Destroy();
	end));
	if owner then
		NeverLose:AddSignal(owner.Destroying:Connect(function()
			local index = table.find(self.PopupStack, entry); if index then self:ClosePopupsFrom(index); end;
		end));
	end;
	if not self.PopupInputReady then
		self.PopupInputReady = true;
		NeverLose:AddSignal(UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Escape and not self.__CloseKeybindMenu then
				local count = #self.PopupStack; if count > 0 then self:ClosePopupsFrom(count); end;
			end;
		end));
		NeverLose:AddSignal(UserInputService.WindowFocusReleased:Connect(function() self:CloseAllPopups(); end));
		NeverLose:AddSignal(RunService.RenderStepped:Connect(function()
			for i,record in ipairs(self.PopupStack) do
				local root = self:GetGuiRoot(record.Owner);
				if not root or not self:IsGuiVisible(record.Owner) then self:ClosePopupsFrom(i); break; end;
				if record.Shield.Parent ~= root then record.Shield.Parent = root; record.Frame.Parent = root; end;
			end;
		end));
	end;
	return entry;
end;
function NeverLose:SetPopupOpen(frame, value)
	local entry = self.PopupRegistry[frame]; if not entry then return; end;
	local index = table.find(self.PopupStack, entry);
	if not value then
		if index then
			self:ClosePopupsFrom(index + 1);
			table.remove(self.PopupStack, index);
		end;
		entry.Open = false; entry.Pressed = nil; entry.Shield.Visible = false;
		self.IsMosueOverOtherFrame = #self.PopupStack > 0;
		return;
	end;
	if index then return; end;
	local parentIndex = 0;
	for i,record in ipairs(self.PopupStack) do
		if entry.Owner == record.Frame or entry.Owner:IsDescendantOf(record.Frame) then parentIndex = i; end;
	end;
	if self.__CloseKeybindMenu then self.__CloseKeybindMenu(); end;
	self:ClosePopupsFrom(parentIndex + 1);
	local root = self:GetGuiRoot(entry.Owner);
	if not root then return; end;
	table.insert(self.PopupStack, entry);
	entry.Open = true; entry.Pressed = nil;
	frame.Parent = root; frame.Visible = true;
	local target = 1000000 + #self.PopupStack * 10000;
	self:ElevatePopup(frame, target);
	entry.Shield.Parent = root; entry.Shield.ZIndex = target - 1; entry.Shield.Visible = true;
	self:AnimatePopup(frame,entry.Scale);
	self.IsMosueOverOtherFrame = true;
end;
function NeverLose:PlacePopup(frame, owner)
	local root = self:GetGuiRoot(owner); if not root then return; end;
	local viewport = self:GetCanvasSize(root);
	local position,size = self:GetGuiRect(owner, root);
	local width,height = frame.Size.X.Offset,frame.Size.Y.Offset;
	local x,y = position.X,position.Y + size.Y + 6;
	if y + height > viewport.Y - 8 then y = position.Y - height - 6; end;
	frame.AnchorPoint = Vector2.zero;
	frame.Position = UDim2.fromOffset(math.clamp(x,8,math.max(8,viewport.X-width-8)), math.clamp(y,8,math.max(8,viewport.Y-height-8)));
end;
function NeverLose:CreateOuterSurface(panel, window, role, opacity)
	panel.BackgroundTransparency = 1;
	local clip = Instance.new('Frame'); clip.Name = role..'OuterClip'; clip.BackgroundTransparency = 1; clip.BorderSizePixel = 0;
	clip.Size = UDim2.fromScale(1,1); clip.ClipsDescendants = true; clip.Active = false; clip.ZIndex = panel.ZIndex; clip.Parent = panel;
	local surface = Instance.new('Frame'); surface.Name = role..'RoundedSurface'; surface.BorderSizePixel = 0; surface.BackgroundTransparency = opacity;
	surface.Active = false; surface.ZIndex = panel.ZIndex; surface.Parent = clip;
	self:BindTheme(surface,'BackgroundColor3',role);
	local corner = Instance.new('UICorner'); corner.Parent = surface; self:BindCorner(corner,'Panel');
	local function resize()
		local offset = window.AbsolutePosition - panel.AbsolutePosition;
		surface.Position = UDim2.fromOffset(offset.X,offset.Y); surface.Size = UDim2.fromOffset(window.AbsoluteSize.X,window.AbsoluteSize.Y);
	end;
	for _,object in ipairs({panel,window}) do
		self:AddSignal(object:GetPropertyChangedSignal('AbsoluteSize'):Connect(resize));
		self:AddSignal(object:GetPropertyChangedSignal('AbsolutePosition'):Connect(resize));
	end;
	resize(); return surface;
end;

NeverLose.ThemeScopes = {'Full UI', 'Surfaces only', 'Controls only', 'Text and icons', 'Accent only', 'Borders only'};
NeverLose.ThemeScope = 'Full UI';
NeverLose.ThemeScopeRoles = {
	['Surfaces only'] = {'Window','Sidebar','Content','Section'},
	['Controls only'] = {'Control','Hover','Selected','ToggleOff','ToggleOn','SliderFill','Knob'},
	['Text and icons'] = {'Text','MutedText','Icon'},
	['Accent only'] = {'Accent','TabAccent','SliderFill','ToggleOn'},
	['Borders only'] = {'Border'}
};
for name,seed in pairs({
	Blossom={'222224','1e1e20','242426','2b2d30','24262a','88b4e2','e0e1ec','a4a5b3'},
	Obsidian={'0b0c0f','101114','0e1014','181a1f','23262d','b1b7c4','f1f2f5','a9afb9'},
	Steel={'161b21','1b2129','181f27','232d37','2d3a46','9aafc8','e7edf5','b3c0cf'},
	Nord={'242933','292f3b','272e39','303948','3b4757','88c0d0','eceff4','b5bfce'},
	Dracula={'1c1b25','242230','211f2b','2b2839','393449','bd93f9','f8f8f2','bbb4cc'},
	Mocha={'181825','1e1e2e','1b1b2b','272739','34344a','cba6f7','cdd6f4','a6adc8'},
	Solarized={'001f27','002831','002b36','083540','154650','2aa198','e5e9d8','a9bcb8'},
	Carbon={'171716','1d1d1c','1b1b1a','272725','343432','d0bf95','efefdf','bebeb0'}
}) do
	NeverLose.ThemePresetSeeds[name] = seed;
end;
for _,name in ipairs({'Blossom','Obsidian','Steel','Nord','Dracula','Mocha','Solarized','Carbon'}) do table.insert(NeverLose.ThemePresetOrder, name); end;
NeverLose.Theme.SliderFill = NeverLose.Theme.Accent;
NeverLose.Theme.ToggleOn = NeverLose.Theme.Accent;
NeverLose.Theme.TabAccent = NeverLose.Theme.Accent;
NeverLose.ElementPresetOrder = {'None','Ice sliders','Mint switches','Lilac selection','Warm borders','High contrast text','Muted icons','Rose risk badges','Slate sidebar','Deep content','Soft cards','Dark controls','Pearl knobs'};
NeverLose.ElementPresets = {
	['Ice sliders'] = {SliderFill='91c9f7'},
	['Mint switches'] = {ToggleOn='87cfaa'},
	['Lilac selection'] = {TabAccent='bdabed',Selected='393147'},
	['Warm borders'] = {Border='786952'},
	['High contrast text'] = {Text='f5f6fa',MutedText='c9ceda'},
	['Muted icons'] = {Icon='969dab'},
	['Rose risk badges'] = {Risk='e88ca2'},
	['Slate sidebar'] = {Sidebar='242b36'},
	['Deep content'] = {Content='10141a'},
	['Soft cards'] = {Section='30333b'},
	['Dark controls'] = {Control='1d2027',ToggleOff='15181e'},
	['Pearl knobs'] = {Knob='f7f1e4'}
};
function NeverLose:BuildThemePalette(name)
	local seed = self.ThemePresetSeeds[name];
	if not seed then return nil; end;
	local t = {};
	for index,role in ipairs({'Window','Sidebar','Content','Section','Control','Accent','Text','MutedText'}) do t[role] = Color3.fromHex(seed[index]); end;
	t.Hover = t.Control:Lerp(t.Text, 0.07);
	t.Selected = t.Control:Lerp(t.Accent, 0.16);
	t.Border = t.Control:Lerp(t.Text, 0.17);
	t.Icon = t.MutedText;
	t.Knob = t.Text;
	t.ToggleOff = t.Control:Lerp(t.Window, 0.25);
	t.Risk = Color3.fromRGB(244,105,123);
	t.SliderFill, t.ToggleOn, t.TabAccent = t.Accent, t.Accent, t.Accent;
	local overrides = self.ThemePresetOverrides and self.ThemePresetOverrides[name];
	if overrides then
		for role,value in pairs(overrides) do
			t[role] = type(value) == 'string' and Color3.fromHex(value) or value;
		end;
	end;
	return t;
end;
function NeverLose:ApplyTheme(name, scope)
	local palette = self:BuildThemePalette(name);
	if not palette then return false; end;
	scope = scope or self.ThemeScope or 'Full UI';
	if scope ~= 'Full UI' and not self.ThemeScopeRoles[scope] then return false; end;
	self:RestoreElementPreset();
	if scope == 'Full UI' then
		for role,color in pairs(palette) do self.Theme[role] = color; end;
		self.ThemeName = name;
	else
		local roles = self.ThemeScopeRoles[scope];
		if not roles then return false; end;
		for _,role in ipairs(roles) do self.Theme[role] = palette[role]; end;
		self.ThemeName = 'Custom';
	end;
	self:RefreshTheme();
	return true;
end;
NeverLose.ElementPresetName = 'None';
function NeverLose:RestoreElementPreset()
	if self.ElementPresetBase then
		for role,color in pairs(self.ElementPresetBase) do self.Theme[role] = color; end;
		self.ThemeName = self.ElementPresetThemeName or self.ThemeName;
	end;
	self.ElementPresetBase = nil; self.ElementPresetThemeName = nil; self.ElementPresetName = 'None';
end;
function NeverLose:ApplyElementPreset(name)
	local preset = self.ElementPresets[name];
	if name ~= 'None' and not preset then return false; end;
	self:RestoreElementPreset();
	if preset then
		self.ElementPresetBase = {}; self.ElementPresetThemeName = self.ThemeName;
		for role,value in pairs(preset) do self.ElementPresetBase[role] = self.Theme[role]; self.Theme[role] = Color3.fromHex(value); end;
		self.ElementPresetName = name; self.ThemeName = 'Custom';
	end;
	self:RefreshTheme(); return true;
end;

function NeverLose:CreateSectionWorkspace(Window, WindowFrame)
	local manager = {Window = Window, Frame = WindowFrame, Records = {}, ByRoot = {}, Columns = {}, FloatOrder = {}, Gap = 12, Grid = 1, Locked = false};
	local layer = Instance.new('Frame');
	layer.Name = 'FloatingSections'; layer.BackgroundTransparency = 1; layer.BorderSizePixel = 0;
	layer.Size = UDim2.fromScale(1,1); layer.Position = UDim2.fromOffset(0,0); layer.Active = false; layer.ClipsDescendants = false; layer.ZIndex = 10000;
	manager.Layer = layer;
	local preview = Instance.new('Frame');
	preview.Name = 'SectionDropPreview'; preview.BackgroundTransparency = 0.9; preview.BorderSizePixel = 0; preview.Visible = false; preview.Active = false; preview.ZIndex = 80;
	NeverLose:BindAccent(preview, 'BackgroundColor3');
	local previewCorner = Instance.new('UICorner'); previewCorner.Parent = preview; NeverLose:BindCorner(previewCorner, 'Panel');
	local previewStroke = Instance.new('UIStroke'); previewStroke.Parent = preview; previewStroke.Thickness = 1; previewStroke.Transparency = 0.2; NeverLose:BindAccent(previewStroke, 'Color');
	manager.Preview = preview;
	function manager:GetRoot()
		return Window.__3DRender and Window.SurfaceGui or NeverLose.ScreenGui;
	end;
	function manager:RefreshRoot()
		local root = self:GetRoot();
		if not root then return; end;
		if layer.Parent ~= root then
			if self.Active then self:Finish(true); end;
			local oldSize = layer.Parent and NeverLose:GetCanvasSize(layer.Parent);
			layer.Parent = root;
			local size = NeverLose:GetCanvasSize(root);
			for _,record in ipairs(self.Records) do
				if record.Floating then
					local position = record.Root.Position;
					local x, y = position.X.Offset, position.Y.Offset;
					if oldSize and oldSize.X > 0 and oldSize.Y > 0 then x, y = x * size.X / oldSize.X, y * size.Y / oldSize.Y; end;
					record.Root.Position = UDim2.fromOffset(math.clamp(x, 4, math.max(4, size.X - record.Root.AbsoluteSize.X - 4)), math.clamp(y, 4, math.max(4, size.Y - record.HeaderHeight - 4)));
				end;
			end;
		end;
		layer.Visible = Window.Signal:GetValue();
	end;
	function manager:GetPoint(input)
		local screen;
		if input and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then screen = Vector2.new(input.Position.X, input.Position.Y); end;
		return NeverLose:GetCanvasPoint(self:GetRoot(), screen);
	end;
	function manager:SyncColumn(column)
		local info = self.Columns[column];
		if info then column.CanvasSize = UDim2.fromOffset(0, info.Layout.AbsoluteContentSize.Y + 25); end;
	end;
	function manager:RegisterColumn(tab, column, layout, name)
		if self.Columns[column] then return; end;
		self.Columns[column] = {Tab = tab, Layout = layout, Name = name};
		layout.Padding = UDim.new(0, self.Gap);
		NeverLose:AddSignal(layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function() self:SyncColumn(column); end));
		NeverLose:AddSignal(column:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
			for _,record in ipairs(self.Records) do if record.Root.Parent == column then record.Update(true); end; end;
		end));
	end;
	function manager:RegisterTab(tab, left, right, leftLayout, rightLayout)
		self:RegisterColumn(tab, left, leftLayout, 'left');
		if right ~= left then self:RegisterColumn(tab, right, rightLayout, 'right'); end;
		tab.Signal:Connect(function() self:RefreshVisibility(); end);
	end;
	function manager:SetGap(value)
		self.Gap = math.clamp(math.floor(tonumber(value) or 12), 8, 24);
		for column,info in pairs(self.Columns) do info.Layout.Padding = UDim.new(0, self.Gap); self:SyncColumn(column); end;
	end;
	function manager:GetColumnRecords(column, omit)
		local list = {};
		for _,record in ipairs(self.Records) do if record ~= omit and not record.Floating and record.Root.Parent == column then table.insert(list, record); end; end;
		table.sort(list, function(a,b) if a.Root.LayoutOrder == b.Root.LayoutOrder then return a.Id < b.Id; end; return a.Root.LayoutOrder < b.Root.LayoutOrder; end);
		return list;
	end;
	function manager:ClearPreview()
		preview.Visible = false; preview.Parent = nil; self.Target = nil;
	end;
	function manager:ShowPreview(column, index, record)
		if self.Target and self.Target.Column == column and self.Target.Index == index then return; end;
		local list = self:GetColumnRecords(column, record);
		index = math.clamp(index, 1, #list + 1);
		for i,other in ipairs(list) do other.Root.LayoutOrder = i * 2; end;
		preview.Parent = column; preview.LayoutOrder = index * 2 - 1;
		preview.Size = UDim2.new(1,-5,0,math.max(record.HeaderHeight + 20, record.Root.AbsoluteSize.Y));
		preview.BackgroundTransparency = 1; previewStroke.Transparency = 1;
		preview.Visible = true; self.Target = {Column = column, Index = index};
		local info = TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);
		NeverLose.PlayAnimate(preview,info,{BackgroundTransparency=0.9});
		NeverLose.PlayAnimate(previewStroke,info,{Transparency=0.25});
	end;
	function manager:GetTarget(point, record)
		if not point then return nil; end;
		for column,info in pairs(self.Columns) do
			if info.Tab.Signal:GetValue() and NeverLose:IsGuiVisible(column) then
				local position,size = NeverLose:GetGuiRect(column, self:GetRoot());
				if NeverLose:PointInRect(point, position, size) then
					if self.Target and self.Target.Column == column and preview.Parent == column then
						local pp, ps = NeverLose:GetGuiRect(preview, self:GetRoot());
						if NeverLose:PointInRect(point, pp, ps) then return column, self.Target.Index; end;
					end;
					local list = self:GetColumnRecords(column, record);
					for index,other in ipairs(list) do
						local op, os = NeverLose:GetGuiRect(other.Root, self:GetRoot());
						if point.Y < op.Y + os.Y * 0.5 then return column, index; end;
					end;
					return column, #list + 1;
				end;
			end;
		end;
		return nil;
	end;
	function manager:ApplyLayer(record, offset)
		record.ZOffset = offset;
		local function apply(object)
			if object:IsA('GuiObject') then
				local base = record.ZBase[object];
				if base == nil then base = object.ZIndex; if base >= 10000 and base < 1000000 then base = math.max(1, base - (record.PreviousOffset or offset)); end; record.ZBase[object] = base; end;
				NeverLose.LocalLayers[object] = base; object.ZIndex = base + offset;
			end;
		end;
		apply(record.Root);
		for _,object in ipairs(record.Root:GetDescendants()) do apply(object); end;
		record.PreviousOffset = offset;
	end;
	function manager:Raise(record)
		local index = table.find(self.FloatOrder, record); if index then table.remove(self.FloatOrder, index); end;
		if record.Floating then table.insert(self.FloatOrder, record); end;
		for i,other in ipairs(self.FloatOrder) do self:ApplyLayer(other, 10000 + i * 200); end;
	end;
	function manager:GetSize(root, natural, header)
		local record = self.ByRoot[root];
		if not record then return UDim2.new(1,-5,0,natural); end;
		record.NaturalHeight = natural;
		local opened = natural > header;
		local viewport = NeverLose:GetCanvasSize(self:GetRoot());
		local height = natural;
		if opened and (record.ManualHeight or record.Floating) then height = math.clamp(record.ManualHeight or natural, header + 24, math.max(header + 24, viewport.Y - 16)); end;
		if record.Grip then record.Grip.Visible = opened; end;
		if record.Floating then
			local width = math.clamp(record.ManualWidth or record.FloatWidth or 260, math.min(190, viewport.X - 16), math.max(190, viewport.X - 16));
			return UDim2.fromOffset(width, height);
		end;
		if record.ManualWidth then
			local available = math.max(120, (root.Parent and root.Parent.AbsoluteSize.X or 260) - 5);
			return UDim2.fromOffset(math.clamp(record.ManualWidth, math.min(190, available), available), height);
		end;
		return UDim2.new(1,-5,0,height);
	end;
	function manager:RefreshVisibility()
		local shown = Window.Signal:GetValue();
		layer.Visible = shown;
		if not shown then NeverLose:CloseAllPopups(); if self.Active then self:Finish(true); end; end;
		for _,record in ipairs(self.Records) do
			local visible = shown and (record.Floating or record.Tab.Signal:GetValue());
			record.Root.Visible = visible;
			if record.Signal:GetValue() ~= visible then record.Signal:SetValue(visible); end;
		end;
	end;
	function manager:Float(record, position)
		self:RefreshRoot();
		local oldPosition,oldSize = NeverLose:GetGuiRect(record.Root, self:GetRoot());
		local viewport = NeverLose:GetCanvasSize(self:GetRoot());
		record.Floating = true;
		record.FloatWidth = record.ManualWidth or oldSize.X;
		record.Root.Parent = layer; record.Root.AnchorPoint = Vector2.zero;
		record.Update(true);
		position = position or oldPosition;
		record.Root.Position = UDim2.fromOffset(math.clamp(position.X, 4, math.max(4, viewport.X - record.Root.AbsoluteSize.X - 4)), math.clamp(position.Y, 4, math.max(4, viewport.Y - record.HeaderHeight - 4)));
		self:Raise(record); self:RefreshVisibility();
	end;
	function manager:Dock(record, column, index)
		if not self.Columns[column] then column = record.HomeColumn; end;
		if not column or not self.Columns[column] then return; end;
		local list = self:GetColumnRecords(column, record);
		index = math.clamp(index or #list + 1, 1, #list + 1);
		self:ClearPreview(); record.Floating = false; record.Column = column; record.Tab = self.Columns[column].Tab;
		record.ManualWidth = nil;
		record.Root.Parent = column; record.Root.AnchorPoint = Vector2.zero; record.Root.Position = UDim2.fromOffset(0,0);
		self:ApplyLayer(record, 0); self:Raise(record);
		table.insert(list, index, record);
		for i,other in ipairs(list) do other.Root.LayoutOrder = i * 2; end;
		record.Update(true); self:SyncColumn(column); self:RefreshVisibility();
	end;
	function manager:Resize(record, width, height)
		local grid = self.Grid;
		record.ManualWidth = math.floor(width / grid + 0.5) * grid;
		record.ManualHeight = math.floor(height / grid + 0.5) * grid;
		record.Update(true);
	end;
	function manager:NewGrip(parent, name)
		local grip = Instance.new('ImageButton'); grip.Name = name; grip.Parent = parent;
		grip.Image = ''; grip.BackgroundTransparency = 1; grip.BorderSizePixel = 0; grip.AutoButtonColor = false;
		grip.AnchorPoint = Vector2.new(1,1); grip.Position = UDim2.new(1,-3,1,-3); grip.Size = UDim2.fromOffset(20,20); grip.ZIndex = 90;
		local lines = {};
		for _,shape in ipairs({{6,12,7,1},{12,6,1,7}}) do
			local line = Instance.new('Frame'); line.Name = 'CornerGripLine'; line.Parent = grip; line.BorderSizePixel = 0;
			line.Position = UDim2.fromOffset(shape[1],shape[2]); line.Size = UDim2.fromOffset(shape[3],shape[4]); line.ZIndex = 91; line.BackgroundTransparency = 0.6;
			NeverLose:BindTheme(line,'BackgroundColor3','Icon'); table.insert(lines,line);
		end;
		local function hover(value)
			for _,line in ipairs(lines) do NeverLose.PlayAnimate(line,TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = value}); end;
		end;
		NeverLose:AddSignal(grip.MouseEnter:Connect(function() hover(0.12); end));
		NeverLose:AddSignal(grip.MouseLeave:Connect(function() hover(0.6); end));
		return grip;
	end;
	function manager:Begin(record, input, kind, click)
		if self.Locked and kind ~= 'window' then return; end;
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return; end;
		if self.Active or NeverLose.__PointerCapture or NeverLose:HasOpenPopup() or not Window.Signal:GetValue() then return; end;
		if record and not record.Signal:GetValue() then return; end;
		local point = self:GetPoint(input); if not point then return; end;
		if record and record.MotionTween then record.MotionTween:Cancel(); record.MotionTween=nil; end;
		if NeverLose.__CloseKeybindMenu then NeverLose.__CloseKeybindMenu(); end;
		local object = record and record.Root or WindowFrame;
		local position,size = NeverLose:GetGuiRect(object, self:GetRoot());
		local index;
		if record then index = table.find(self:GetColumnRecords(record.Root.Parent), record); end;
		local screen = input.UserInputType == Enum.UserInputType.Touch and Vector2.new(input.Position.X,input.Position.Y) or UserInputService:GetMouseLocation();
		self.Active = {StartScreen = screen, Record = record, Kind = kind, Input = input, Start = point, LastPoint = point, Position = position, Size = size, Offset = point - position, Click = click,
			WasFloating = record and record.Floating, Column = record and record.Root.Parent, Index = index, Width = record and record.ManualWidth, Height = record and record.ManualHeight, Moved = false};
		NeverLose.__PointerCapture = self;
		if record and record.Floating then self:Raise(record); end;
	end;
	function manager:BindDrag(record, target, click)
		NeverLose:AddSignal(target.InputBegan:Connect(function(input) self:Begin(record, input, 'move', click); end));
	end;
	function manager:Step(input, dt)
		local action = self.Active; if not action then return; end;
		if action.Input.UserInputType == Enum.UserInputType.Touch and input and input ~= action.Input then return; end;
		local point = self:GetPoint(action.Input.UserInputType == Enum.UserInputType.Touch and action.Input or input);
		if not point then return; end;
		action.LastPoint = point;
		local delta = point - action.Start;
		local screen = action.Input.UserInputType == Enum.UserInputType.Touch and Vector2.new(action.Input.Position.X,action.Input.Position.Y) or UserInputService:GetMouseLocation();
		if not action.Moved and (screen-action.StartScreen).Magnitude < 5 then return; end;
		local record = action.Record;
		if not action.Moved then
			action.Moved = true;
			if action.Kind == 'move' then self:Float(record, action.Position); end;
		end;
		if action.Kind == 'move' then
			local viewport = NeverLose:GetCanvasSize(self:GetRoot());
			local position = point - action.Offset;
			if self.Grid > 1 then position = Vector2.new(math.floor(position.X/self.Grid+0.5)*self.Grid,math.floor(position.Y/self.Grid+0.5)*self.Grid); end;
			action.TargetPosition = Vector2.new(math.clamp(position.X,4,math.max(4,viewport.X-record.Root.AbsoluteSize.X-4)), math.clamp(position.Y,4,math.max(4,viewport.Y-record.HeaderHeight-4)));
			if dt then
				local current = Vector2.new(record.Root.Position.X.Offset,record.Root.Position.Y.Offset);
				local blended = current + (action.TargetPosition-current) * NeverLose:GetMotionAlpha(dt,28);
				record.Root.Position = UDim2.fromOffset(blended.X,blended.Y);
			end;
			local column,index = self:GetTarget(point, record);
			if column then
				self:ShowPreview(column,index,record);
				if dt and dt > 0 then
					local cp,cs = NeverLose:GetGuiRect(column,self:GetRoot());
					local edge = 28; local direction = point.Y < cp.Y + edge and -1 or (point.Y > cp.Y + cs.Y - edge and 1 or 0);
					if direction ~= 0 then
						local maximum = math.max(0,column.CanvasSize.Y.Offset-cs.Y);
						column.CanvasPosition = Vector2.new(0,math.clamp(column.CanvasPosition.Y+direction*220*dt,0,maximum));
					end;
				end;
			else self:ClearPreview(); end;
		elseif action.Kind == 'resize' then
			self:Resize(record, action.Size.X + delta.X, action.Size.Y + delta.Y);
		else
			local viewport = NeverLose:GetCanvasSize(self:GetRoot());
			local width = math.clamp(action.Size.X+delta.X, math.min(520,viewport.X-16), math.max(520,viewport.X-action.Position.X-8));
			local height = math.clamp(action.Size.Y+delta.Y, math.min(340,viewport.Y-16), math.max(340,viewport.Y-action.Position.Y-8));
			Window.Size = UDim2.fromOffset(math.floor(width+0.5),math.floor(height+0.5));
			WindowFrame.Size = Window.Size;
			WindowFrame.Position = UDim2.fromOffset(action.Position.X+width*WindowFrame.AnchorPoint.X,action.Position.Y+height*WindowFrame.AnchorPoint.Y);
		end;
	end;
	function manager:Finish(cancelled)
		local action = self.Active; if not action then return; end;
		local target = self.Target;
		self.Active = nil;
		if NeverLose.__PointerCapture == self then NeverLose.__PointerCapture = nil; end;
		self:ClearPreview();
		local record = action.Record;
		if cancelled then
			if record then
				record.ManualWidth, record.ManualHeight = action.Width, action.Height;
				if action.WasFloating then self:Float(record, action.Position);
				elseif action.Kind == 'move' and action.Moved then self:Dock(record, action.Column, action.Index); record.ManualWidth = action.Width; record.Update(true);
				else record.Update(true); end;
			elseif action.Moved then Window.Size = UDim2.fromOffset(action.Size.X,action.Size.Y); WindowFrame.Size=Window.Size; WindowFrame.Position=UDim2.fromOffset(action.Position.X+action.Size.X*WindowFrame.AnchorPoint.X,action.Position.Y+action.Size.Y*WindowFrame.AnchorPoint.Y); end;
		elseif action.Kind == 'move' and action.Moved then
			if target then
				self:Dock(record,target.Column,target.Index);
				record.Handler.Position = UDim2.new(0.5,0,0,5);
				NeverLose.PlayAnimate(record.Handler,TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0,0)});
			elseif action.TargetPosition then
				record.MotionTween = NeverLose.PlayAnimate(record.Root,TweenInfo.new(0.10,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.fromOffset(action.TargetPosition.X,action.TargetPosition.Y)});
			end;
		elseif not action.Moved and action.Click then action.Click(); end;
	end;
	function manager:Register(config)
		local record = config;
		record.Id = #self.Records + 1; record.Floating = false; record.ZOffset = 0; record.PreviousOffset = 0; record.ZBase = setmetatable({}, {__mode='k'});
		record.HomeColumn = record.Root.Parent; record.Column = record.HomeColumn;
		record.HomeIndex = #self:GetColumnRecords(record.Column) + 1;
		record.Root.LayoutOrder = record.HomeIndex * 2;
		self.ByRoot[record.Root] = record; table.insert(self.Records, record);
		if record.DragTarget then self:BindDrag(record,record.DragTarget,record.OnClick); end;
		NeverLose:AddSignal(record.Root.DescendantAdded:Connect(function(object)
			task.defer(function() if object.Parent and record.Floating then self:ApplyLayer(record,record.ZOffset); end; end);
		end));
		NeverLose:AddSignal(record.Root.InputBegan:Connect(function(input) if record.Floating and input.UserInputType == Enum.UserInputType.MouseButton1 and NeverLose:CanUsePointer(record.Root) then self:Raise(record); end; end));
		function record.API:Undock(x,y) manager:Float(record, x and Vector2.new(x,y or 24) or nil); return self; end;
		function record.API:Dock(side,index)
			local column = record.HomeColumn;
			for candidate,info in pairs(manager.Columns) do if info.Tab == record.Tab and info.Name == tostring(side or 'left'):lower() then column=candidate; break; end; end;
			manager:Dock(record,column,index); return self;
		end;
		function record.API:IsFloating() return record.Floating; end;
		function record.API:SetSize(width,height) manager:Resize(record,width or record.Root.AbsoluteSize.X,height or record.Root.AbsoluteSize.Y); return self; end;
		function record.API:ResetSize() record.ManualWidth=nil; record.ManualHeight=nil; record.Update(true); return self; end;
		record.API.WorkspaceRecord = record;
		record.Update(true); self:RefreshVisibility();
		return record;
	end;
	function manager:Reset()
		self:Finish(true);
		for _,record in ipairs(self.Records) do record.ManualWidth=nil; record.ManualHeight=nil; self:Dock(record,record.HomeColumn,record.HomeIndex); end;
	end;
	local windowGrip = manager:NewGrip(WindowFrame, 'WindowResizeGrip');
	manager.WindowGrip = windowGrip;
	NeverLose:AddSignal(windowGrip.InputBegan:Connect(function(input) manager:Begin(nil,input,'window'); end));
	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then manager:Step(input); end;
	end));
	NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
		local action=manager.Active;
		if action and (input==action.Input or action.Input.UserInputType~=Enum.UserInputType.Touch and input.UserInputType==Enum.UserInputType.MouseButton1) then manager:Step(input); manager:Finish(false); end;
	end));
	NeverLose:AddSignal(UserInputService.InputBegan:Connect(function(input) if input.KeyCode==Enum.KeyCode.Escape then manager:Finish(true); end; end));
	NeverLose:AddSignal(UserInputService.WindowFocusReleased:Connect(function() manager:Finish(true); end));
	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt) if manager.Active then manager:Step(nil,dt); end; end));
	Window.Signal:Connect(function() manager:RefreshRoot(); manager:RefreshVisibility(); end);
	NeverLose:AddSignal(WindowFrame.Destroying:Connect(function() manager:Finish(true); preview:Destroy(); layer:Destroy(); end));
	manager:RefreshRoot();
	return manager;
end;


local function AccentApply(Object , Property , Value)
	Object[Property] = Value;
end;

function NeverLose:BindAccent(Object , Property)
	if typeof(Object) ~= 'Instance' then
		return Object;
	end;

	Property = Property or 'BackgroundColor3';
	local bindings = NeverLose.ThemeTargets[Object]; if bindings then bindings[Property] = nil; end;

	table.insert(NeverLose.AccentTargets , {Object , Property});

	pcall(AccentApply , Object , Property , NeverLose.AccentColor);

	return Object;
end

function NeverLose:BindAccentHook(Callback)
	if type(Callback) ~= 'function' then
		return Callback;
	end;

	table.insert(NeverLose.AccentHooks , Callback);

	pcall(Callback , NeverLose.AccentColor);

	return Callback;
end

function NeverLose:PaintAccent(Value)
	local Targets = NeverLose.AccentTargets;
	local Index = 1;

	while Index <= #Targets do
		local Entry = Targets[Index];
		local Object = Entry[1];
		local Alive = false;

		if pcall(AccentApply , Object , Entry[2] , Value) then
			Alive = Object.Parent ~= nil;
		end;

		if Alive then
			Index = Index + 1;
		else
			table.remove(Targets , Index);
		end;
	end;

	local Hooks = NeverLose.AccentHooks;
	local Position = 1;

	while Position <= #Hooks do
		if pcall(Hooks[Position] , Value) then
			Position = Position + 1;
		else
			table.remove(Hooks , Position);
		end;
	end;

	NeverLose.AccentPainted = Value;
end

function NeverLose:ScanAccent()
	NeverLose:PaintAccent(NeverLose.AccentColor);

	return NeverLose.AccentTargets;
end

function NeverLose:SetAccentColor(Value)
	if type(Value) == 'string' then
		local Success , Parsed = pcall(Color3.fromHex , (Value:gsub('#' , '')));

		if Success then
			Value = Parsed;
		end;
	end;

	if typeof(Value) ~= 'Color3' then
		return NeverLose.AccentColor;
	end;

	local accentChanged = NeverLose.AccentColor ~= Value;
	NeverLose.AccentColor = Value;
	NeverLose.Theme.Accent = Value;
	if accentChanged then
		NeverLose.Theme.SliderFill, NeverLose.Theme.ToggleOn, NeverLose.Theme.TabAccent = Value, Value, Value;
		for object,bindings in pairs(NeverLose.ThemeTargets) do
			for property,role in pairs(bindings) do
				if role == 'SliderFill' or role == 'ToggleOn' or role == 'TabAccent' then pcall(function() object[property] = Value; end); end;
			end;
		end;
	end;

	if NeverLose.AccentPainted ~= Value then
		NeverLose:PaintAccent(Value);
	end;

	return Value;
end

function NeverLose:GetAccentColor()
	return NeverLose.AccentColor;
end;
NeverLose.MainColor = Color3.fromRGB(8, 8, 13);
NeverLose.RegisiteryColor = {};
NeverLose.NameRegisitry = {};
NeverLose.IsMosueOverOtherFrame = false;
NeverLose.GlobalLogo = "rbxassetid://120358385035996";
NeverLose.ImageColorMapping = "rbxassetid://4155801252";

if getcustomasset then
	local link = "https://github.com/4lpaca-pin/NeverLose/blob/main/assets/%s?raw=true";
	local dir = 'NLAssets';

	if not isfolder(dir) then
		makefolder(dir);
	end;

	pcall(function()
		if not isfile(dir..'/'..'logo.png') then
			local byte = game:HttpGet(string.format(link,'logo.png'));

			writefile(dir..'/'..'logo.png' , byte);
			task.wait();
		end;

		if isfile(dir..'/'..'logo.png') then
			NeverLose.GlobalLogo = getcustomasset(dir..'/'..'logo.png')
		end;
	end);

	pcall(function()
		if not isfile(dir..'/'..'saturation_value_gradient.png') then
			local byte = game:HttpGet(string.format(link,'saturation_value_gradient.png'));

			writefile(dir..'/'..'saturation_value_gradient.png' , byte);
			task.wait();
		end;

		if isfile(dir..'/'..'saturation_value_gradient.png') then
			NeverLose.ImageColorMapping = getcustomasset(dir..'/'..'saturation_value_gradient.png')
		end;
	end);
end;

function NeverLose:AddSignal(RBXSignal)
	if NeverLose.UnloadEnabled then
		table.insert(NeverLose.GlobalSignals,RBXSignal);
	end;

	return RBXSignal;
end;

function NeverLose:RegisterCard(Card , IsRendered)
	table.insert(NeverLose.SectionCards , {
		Card = Card,
		IsRendered = IsRendered
	});
end;

function NeverLose:SetSectionTransparency(Value)
	NeverLose.SectionTransparency = math.clamp(Value , 0 , 1);

	local Position = 1;

	while Position <= #NeverLose.SectionCards do
		local Entry = NeverLose.SectionCards[Position];

		if Entry.Card.Parent then
			local Success , Rendered = pcall(Entry.IsRendered);

			if Success and Rendered then
				Entry.Card.BackgroundTransparency = NeverLose.SectionTransparency;
			end;

			Position = Position + 1;
		else
			table.remove(NeverLose.SectionCards , Position);
		end;
	end;
end;

function NeverLose:GetSectionTransparency()
	return NeverLose.SectionTransparency;
end;

function NeverLose:AddQuery(ItemRoot: Frame , Name : string)
	table.insert(NeverLose.NameRegisitry , {
		Root = ItemRoot,
		Idx = Name,
	});
end;

function Encryption.new(data: string)
	local bytes = {};
	local encrypt_seed = ((#data + 3782) % 111) + 1;

	string.gsub(data , '.', LPH_NO_VIRTUALIZE(function(dt)
		table.insert(bytes , tostring(dt:byte() + encrypt_seed));
	end));

	local concatbyte = table.concat(bytes,'?');

	table.clear(bytes);

	return "{"..tostring(encrypt_seed + 72667).."}?"..concatbyte;
end;

function Encryption.reverse(data: string)
	local main_data = string.split(data,'?');
	local seed_str = main_data[1]:gsub('{',''):gsub('}','');
	local seed = tonumber(seed_str);

	local ks = {};
	local real_seed = seed - 72667;

	for i,v in next , main_data do
		if i > 1 then
			local fake_byte = tonumber(v);
			table.insert(ks , string.char(fake_byte - real_seed))	
		end;
	end;

	local data = table.concat(ks);

	table.clear(ks);

	return data;
end;

do
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

	NeverLose.Base64Encode = LPH_NO_VIRTUALIZE(function(data)
		return ((data:gsub('.', function(x) 
			local r,b='',x:byte()
			for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
			return r;
		end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return b:sub(c+1,c+1)
		end)..({ '', '==', '=' })[#data%3+1])
	end);

	NeverLose.Base64Decode = LPH_NO_VIRTUALIZE(function(data)
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r,f='',(b:find(x)-1)
			for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c=0
			for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
			return string.char(c)
		end))
	end);
end;

NeverLose.LoadIcon = LPH_NO_VIRTUALIZE(function()
	NeverLose.RobloxIcon = {
		["3d-cube-arrow-left"] = "3d-cube-arrow-left",
		["amazon"] = "amazon",
		["arm-left"] = "arm-left",
		["arm-right"] = "arm-right",
		["arrow-curl-to-left"] = "arrow-curl-to-left",
		["arrow-curl-to-right"] = "arrow-curl-to-right",
		["arrow-down-to-line"] = "arrow-down-to-line",
		["arrow-large-down"] = "arrow-large-down",
		["arrow-large-left"] = "arrow-large-left",
		["arrow-large-right"] = "arrow-large-right",
		["arrow-large-up"] = "arrow-large-up",
		["arrow-right-from-portrait-rectangle"] = "arrow-right-from-portrait-rectangle",
		["arrow-right-to-portrait-rectangle"] = "arrow-right-to-portrait-rectangle",
		["arrow-rotate-down-dashed"] = "arrow-rotate-down-dashed",
		["arrow-rotate-right"] = "arrow-rotate-right",
		["arrow-rotate-right-dashed"] = "arrow-rotate-right-dashed",
		["arrow-small-down"] = "arrow-small-down",
		["arrow-small-left"] = "arrow-small-left",
		["arrow-small-right"] = "arrow-small-right",
		["arrow-small-up"] = "arrow-small-up",
		["arrow-spin-clockwise"] = "arrow-spin-clockwise",
		["arrow-spin-clockwise-10"] = "arrow-spin-clockwise-10",
		["arrow-spin-clockwise-15"] = "arrow-spin-clockwise-15",
		["arrow-spin-clockwise-30"] = "arrow-spin-clockwise-30",
		["arrow-spin-counter-clockwise-10"] = "arrow-spin-counter-clockwise-10",
		["arrow-spin-counter-clockwise-15"] = "arrow-spin-counter-clockwise-15",
		["arrow-spin-counter-clockwise-30"] = "arrow-spin-counter-clockwise-30",
		["arrow-thick-to-left"] = "arrow-thick-to-left",
		["arrow-thick-to-right"] = "arrow-thick-to-right",
		["arrow-up-from-landscape-rectangle"] = "arrow-up-from-landscape-rectangle",
		["arrow-up-right-from-square"] = "arrow-up-right-from-square",
		["arrow-wide-short-down"] = "arrow-wide-short-down",
		["arrow-wide-short-left"] = "arrow-wide-short-left",
		["arrow-wide-short-right"] = "arrow-wide-short-right",
		["arrow-wide-short-up"] = "arrow-wide-short-up",
		["arrows-small-directional"] = "arrows-small-directional",
		["audio-wave-dotted-line"] = "audio-wave-dotted-line",
		["backpack"] = "backpack",
		["beard"] = "beard",
		["bell"] = "bell",
		["bell-clock"] = "bell-clock",
		["bell-plus"] = "bell-plus",
		["bell-slash"] = "bell-slash",
		["belt"] = "belt",
		["binoculars"] = "binoculars",
		["book-closed"] = "book-closed",
		["bookmark"] = "bookmark",
		["bow-tie"] = "bow-tie",
		["building-store"] = "building-store",
		["bullet-flying"] = "bullet-flying",
		["butterfly-wings"] = "butterfly-wings",
		["calendar"] = "calendar",
		["calendar-plus"] = "calendar-plus",
		["calendar-star"] = "calendar-star",
		["camera-small"] = "camera-small",
		["caret-small-down"] = "caret-small-down",
		["caret-small-left"] = "caret-small-left",
		["caret-small-right"] = "caret-small-right",
		["caret-small-up"] = "caret-small-up",
		["chain-link"] = "chain-link",
		["chart-four-vertical-bars"] = "chart-four-vertical-bars",
		["chart-line"] = "chart-line",
		["chart-pie"] = "chart-pie",
		["chart-scatter-plot"] = "chart-scatter-plot",
		["chart-three-vertical-bars"] = "chart-three-vertical-bars",
		["check"] = "check",
		["check-large"] = "check-large",
		["check-small"] = "check-small",
		["chevron-large-down"] = "chevron-large-down",
		["chevron-large-down-to-line"] = "chevron-large-down-to-line",
		["chevron-large-left"] = "chevron-large-left",
		["chevron-large-left-to-line"] = "chevron-large-left-to-line",
		["chevron-large-right"] = "chevron-large-right",
		["chevron-large-right-to-line"] = "chevron-large-right-to-line",
		["chevron-large-up"] = "chevron-large-up",
		["chevron-large-up-to-line"] = "chevron-large-up-to-line",
		["chevron-small-down"] = "chevron-small-down",
		["chevron-small-down-to-line"] = "chevron-small-down-to-line",
		["chevron-small-left"] = "chevron-small-left",
		["chevron-small-left-to-line"] = "chevron-small-left-to-line",
		["chevron-small-right"] = "chevron-small-right",
		["chevron-small-right-to-line"] = "chevron-small-right-to-line",
		["chevron-small-up"] = "chevron-small-up",
		["chevron-small-up-to-line"] = "chevron-small-up-to-line",
		["circle-check"] = "circle-check",
		["circle-i"] = "circle-i",
		["circle-minus"] = "circle-minus",
		["circle-person"] = "circle-person",
		["circle-person-three-horizontal-bars-wrapping-right"] = "circle-person-three-horizontal-bars-wrapping-right",
		["circle-play"] = "circle-play",
		["circle-plus"] = "circle-plus",
		["circle-question"] = "circle-question",
		["circle-slash"] = "circle-slash",
		["circle-star"] = "circle-star",
		["circle-three-dots-horizontal"] = "circle-three-dots-horizontal",
		["circle-three-dots-vertical"] = "circle-three-dots-vertical",
		["circle-x"] = "circle-x",
		["clock"] = "clock",
		["clock-dashed"] = "clock-dashed",
		["clock-spin-reverse"] = "clock-spin-reverse",
		["clock-spin-reverse-dashed"] = "clock-spin-reverse-dashed",
		["clothes-hanger"] = "clothes-hanger",
		["cloud"] = "cloud",
		["cloud-arrow-down"] = "cloud-arrow-down",
		["code"] = "code",
		["compact-makeup-brush"] = "compact-makeup-brush",
		["compass"] = "compass",
		["controller-with-cog"] = "controller-with-cog",
		["crop"] = "crop",
		["crosshairs"] = "crosshairs",
		["crosshairs-slash"] = "crosshairs-slash",
		["cube-vertexes"] = "cube-vertexes",
		["curved-rectangle-megaphone"] = "curved-rectangle-megaphone",
		["diagonal-line-pattern"] = "diagonal-line-pattern",
		["diagonal-line-pattern-sticker"] = "diagonal-line-pattern-sticker",
		["diamond-simplified"] = "diamond-simplified",
		["discord"] = "discord",
		["disguise-nose-glasses"] = "disguise-nose-glasses",
		["document-circle-slash"] = "document-circle-slash",
		["document-list-heart"] = "document-list-heart",
		["door-open-arrow-to-bottom-right"] = "door-open-arrow-to-bottom-right",
		["dress"] = "dress",
		["dual-arrows-horizontal"] = "dual-arrows-horizontal",
		["dual-arrows-to-corners"] = "dual-arrows-to-corners",
		["dual-arrows-vertical"] = "dual-arrows-vertical",
		["envelope"] = "envelope",
		["eraser"] = "eraser",
		["eye"] = "eye",
		["eye-slash"] = "eye-slash",
		["eye-with-eyeliner"] = "eye-with-eyeliner",
		["eyebrows"] = "eyebrows",
		["eyelashes"] = "eyelashes",
		["face-winking"] = "face-winking",
		["facebook"] = "facebook",
		["file-box"] = "file-box",
		["fingerprint"] = "fingerprint",
		["flag"] = "flag",
		["flame"] = "flame",
		["folder"] = "folder",
		["fountain-pen-nib"] = "fountain-pen-nib",
		["four-bars-horizontal-center-aligned"] = "four-bars-horizontal-center-aligned",
		["four-bars-horizontal-chevron-left"] = "four-bars-horizontal-chevron-left",
		["four-bars-horizontal-chevron-right"] = "four-bars-horizontal-chevron-right",
		["four-bars-horizontal-justified-aligned"] = "four-bars-horizontal-justified-aligned",
		["four-bars-horizontal-left-aligned"] = "four-bars-horizontal-left-aligned",
		["four-bars-horizontal-right-aligned"] = "four-bars-horizontal-right-aligned",
		["frame-bubble-slash"] = "frame-bubble-slash",
		["frame-bubble-soundwave"] = "frame-bubble-soundwave",
		["frame-camera"] = "frame-camera",
		["frame-camera-center"] = "frame-camera-center",
		["frame-collapsed"] = "frame-collapsed",
		["frame-corners"] = "frame-corners",
		["frame-expanded"] = "frame-expanded",
		["frame-face"] = "frame-face",
		["frame-person-torso"] = "frame-person-torso",
		["frame-record"] = "frame-record",
		["frame-single-bar-horizontal"] = "frame-single-bar-horizontal",
		["frame-soundwave"] = "frame-soundwave",
		["frame-video-camera"] = "frame-video-camera",
		["gear"] = "gear",
		["generic-dpad"] = "generic-dpad",
		["gift-box"] = "gift-box",
		["gift-card"] = "gift-card",
		["glasses"] = "glasses",
		["globe-detailed"] = "globe-detailed",
		["globe-simplified"] = "globe-simplified",
		["globe-simplipfied-speech-bubble"] = "globe-simplipfied-speech-bubble",
		["grid"] = "grid",
		["guilded"] = "guilded",
		["hack-week"] = "hack-week",
		["hammer-code"] = "hammer-code",
		["hand-curved-arrow-left"] = "hand-curved-arrow-left",
		["hand-dual-arrows"] = "hand-dual-arrows",
		["hand-ellipse"] = "hand-ellipse",
		["hand-half-ellipse"] = "hand-half-ellipse",
		["hand-two-arrows-horizontal"] = "hand-two-arrows-horizontal",
		["hashtag"] = "hashtag",
		["hat-fedora"] = "hat-fedora",
		["hat-toque"] = "hat-toque",
		["head-blank"] = "head-blank",
		["head-blush"] = "head-blush",
		["head-female"] = "head-female",
		["head-freckles"] = "head-freckles",
		["head-lips"] = "head-lips",
		["head-male"] = "head-male",
		["headphones"] = "headphones",
		["headphones-arrow-up"] = "headphones-arrow-up",
		["headphones-arrow-up-lock"] = "headphones-arrow-up-lock",
		["headphones-slash"] = "headphones-slash",
		["headphones-x"] = "headphones-x",
		["headphones-x-lock"] = "headphones-x-lock",
		["heart"] = "heart",
		["house"] = "house",
		["image"] = "image",
		["image-stacked"] = "image-stacked",
		["instagram"] = "instagram",
		["jacket"] = "jacket",
		["key"] = "key",
		["key-alt"] = "key-alt",
		["key-apostrophe"] = "key-apostrophe",
		["key-arrow-down"] = "key-arrow-down",
		["key-arrow-right"] = "key-arrow-right",
		["key-arrow-up"] = "key-arrow-up",
		["key-asterisk"] = "key-asterisk",
		["key-backspace"] = "key-backspace",
		["key-caps-lock"] = "key-caps-lock",
		["key-caret"] = "key-caret",
		["key-comma"] = "key-comma",
		["key-command"] = "key-command",
		["key-control"] = "key-control",
		["key-grave-accent"] = "key-grave-accent",
		["key-period"] = "key-period",
		["key-return"] = "key-return",
		["key-shift"] = "key-shift",
		["key-space"] = "key-space",
		["key-tab"] = "key-tab",
		["language-characters"] = "language-characters",
		["leg-left"] = "leg-left",
		["leg-right"] = "leg-right",
		["lightning-bolt"] = "lightning-bolt",
		["linkedin"] = "linkedin",
		["lips"] = "lips",
		["lipstick"] = "lipstick",
		["list-bulleted"] = "list-bulleted",
		["location-pin"] = "location-pin",
		["location-pin-map"] = "location-pin-map",
		["lock-closed"] = "lock-closed",
		["lollipop"] = "lollipop",
		["magnifying-glass"] = "magnifying-glass",
		["magnifying-glass-minus"] = "magnifying-glass-minus",
		["magnifying-glass-plus"] = "magnifying-glass-plus",
		["mascara"] = "mascara",
		["megaphone"] = "megaphone",
		["memory-card"] = "memory-card",
		["messenger"] = "messenger",
		["microphone"] = "microphone",
		["microphone-slash"] = "microphone-slash",
		["microphone-text-box"] = "microphone-text-box",
		["microphone-triangle-exclamation"] = "microphone-triangle-exclamation",
		["minus"] = "minus",
		["minus-small"] = "minus-small",
		["mirror-standing"] = "mirror-standing",
		["moments"] = "moments",
		["moon"] = "moon",
		["mouse-button-left"] = "mouse-button-left",
		["mouse-button-right"] = "mouse-button-right",
		["mouse-scrollwheel"] = "mouse-scrollwheel",
		["music-note"] = "music-note",
		["nebula"] = "nebula",
		["necklace"] = "necklace",
		["nine-dots-grid"] = "nine-dots-grid",
		["ninja"] = "ninja",
		["nose"] = "nose",
		["page"] = "page",
		["paint-brush"] = "paint-brush",
		["paint-bucket"] = "paint-bucket",
		["pants"] = "pants",
		["pants-2d-text"] = "pants-2d-text",
		["paper-airplane"] = "paper-airplane",
		["parrot"] = "parrot",
		["pause-large"] = "pause-large",
		["pause-small"] = "pause-small",
		["pencil"] = "pencil",
		["pencil-square"] = "pencil-square",
		["person"] = "person",
		["person-arrow-from-bottom-right"] = "person-arrow-from-bottom-right",
		["person-check"] = "person-check",
		["person-circle-slash"] = "person-circle-slash",
		["person-climbing"] = "person-climbing",
		["person-clock"] = "person-clock",
		["person-falling"] = "person-falling",
		["person-graduate"] = "person-graduate",
		["person-jumping"] = "person-jumping",
		["person-magnifying-glass"] = "person-magnifying-glass",
		["person-photo-camera"] = "person-photo-camera",
		["person-play"] = "person-play",
		["person-play-clock"] = "person-play-clock",
		["person-plus"] = "person-plus",
		["person-racing"] = "person-racing",
		["person-running"] = "person-running",
		["person-standing"] = "person-standing",
		["person-standing-arrow-reverse"] = "person-standing-arrow-reverse",
		["person-standing-dual-arrows-vertical"] = "person-standing-dual-arrows-vertical",
		["person-standing-gear"] = "person-standing-gear",
		["person-swimming"] = "person-swimming",
		["person-teleport"] = "person-teleport",
		["person-trash-can"] = "person-trash-can",
		["person-walking"] = "person-walking",
		["person-with-smaller-person"] = "person-with-smaller-person",
		["phone"] = "phone",
		["phone-down"] = "phone-down",
		["phone-plus"] = "phone-plus",
		["phone-volume"] = "phone-volume",
		["phone-x"] = "phone-x",
		["photo-camera"] = "photo-camera",
		["photo-camera-face"] = "photo-camera-face",
		["photo-camera-slash"] = "photo-camera-slash",
		["picture-in-picture"] = "picture-in-picture",
		["pig"] = "pig",
		["pin"] = "pin",
		["pin-slash"] = "pin-slash",
		["play-large"] = "play-large",
		["play-small"] = "play-small",
		["plus-large"] = "plus-large",
		["plus-small"] = "plus-small",
		["premium"] = "premium",
		["ps-circle"] = "ps-circle",
		["ps-dpad-down"] = "ps-dpad-down",
		["ps-dpad-left"] = "ps-dpad-left",
		["ps-dpad-right"] = "ps-dpad-right",
		["ps-dpad-up"] = "ps-dpad-up",
		["ps-l1"] = "ps-l1",
		["ps-l2"] = "ps-l2",
		["ps-l3"] = "ps-l3",
		["ps-r1"] = "ps-r1",
		["ps-r2"] = "ps-r2",
		["ps-r3"] = "ps-r3",
		["ps-square"] = "ps-square",
		["ps-stick-left"] = "ps-stick-left",
		["ps-stick-right"] = "ps-stick-right",
		["ps-triagle"] = "ps-triagle",
		["ps-x"] = "ps-x",
		["ps4-options"] = "ps4-options",
		["ps4-share"] = "ps4-share",
		["ps4-touchpad"] = "ps4-touchpad",
		["ps5-options"] = "ps5-options",
		["ps5-share"] = "ps5-share",
		["ps5-touchpad"] = "ps5-touchpad",
		["pumpkin"] = "pumpkin",
		["purse"] = "purse",
		["rectangle-list"] = "rectangle-list",
		["rectangle-numbers-counting"] = "rectangle-numbers-counting",
		["rectangle-person-with-three-horizontal-lines"] = "rectangle-person-with-three-horizontal-lines",
		["robux"] = "robux",
		["rosette-seven-point"] = "rosette-seven-point",
		["rosette-ten-point"] = "rosette-ten-point",
		["seven-point-rosette"] = "seven-point-rosette",
		["shield-check"] = "shield-check",
		["shield-lock"] = "shield-lock",
		["shirt"] = "shirt",
		["shirt-2d-text"] = "shirt-2d-text",
		["shirt-pants"] = "shirt-pants",
		["shoe-left"] = "shoe-left",
		["shoe-right"] = "shoe-right",
		["shopping-basket"] = "shopping-basket",
		["shopping-basket-check"] = "shopping-basket-check",
		["shopping-cart"] = "shopping-cart",
		["shorts"] = "shorts",
		["sidebar"] = "sidebar",
		["signal-exclamation"] = "signal-exclamation",
		["six-dots-two-column-grid"] = "six-dots-two-column-grid",
		["skip-end-large"] = "skip-end-large",
		["skip-end-small"] = "skip-end-small",
		["skip-next-large"] = "skip-next-large",
		["skip-next-small"] = "skip-next-small",
		["skip-previous-large"] = "skip-previous-large",
		["skip-previous-small"] = "skip-previous-small",
		["skip-start-large"] = "skip-start-large",
		["skip-start-small"] = "skip-start-small",
		["smartphone-portrait"] = "smartphone-portrait",
		["speaker"] = "speaker",
		["speaker-slash"] = "speaker-slash",
		["speaker-triangle-exclamation"] = "speaker-triangle-exclamation",
		["speaker-x"] = "speaker-x",
		["speech-bubble-align-center"] = "speech-bubble-align-center",
		["speech-bubble-align-left"] = "speech-bubble-align-left",
		["speech-bubble-exclamation"] = "speech-bubble-exclamation",
		["speech-bubble-round"] = "speech-bubble-round",
		["square-bone"] = "square-bone",
		["square-books"] = "square-books",
		["square-check"] = "square-check",
		["square-code"] = "square-code",
		["square-dashed-person-standing"] = "square-dashed-person-standing",
		["square-dual-arrows-horizontal"] = "square-dual-arrows-horizontal",
		["square-dual-arrows-to-corner"] = "square-dual-arrows-to-corner",
		["square-face-sound"] = "square-face-sound",
		["square-face-waving-hand"] = "square-face-waving-hand",
		["square-face-winking"] = "square-face-winking",
		["square-minus"] = "square-minus",
		["square-person"] = "square-person",
		["squares-grid-plus"] = "squares-grid-plus",
		["squares-grid-qr"] = "squares-grid-qr",
		["stacked-squares-arrow-down-left"] = "stacked-squares-arrow-down-left",
		["stacked-squares-arrow-up-right"] = "stacked-squares-arrow-up-right",
		["stacked-squares-plus"] = "stacked-squares-plus",
		["star"] = "star",
		["stop-large"] = "stop-large",
		["stop-small"] = "stop-small",
		["studio"] = "studio",
		["sun"] = "sun",
		["sweater"] = "sweater",
		["sword"] = "sword",
		["tag-sparkle"] = "tag-sparkle",
		["teletype"] = "teletype",
		["tencent-qq"] = "tencent-qq",
		["text-b-bold"] = "text-b-bold",
		["text-box-microphone"] = "text-box-microphone",
		["text-h-subscript-1"] = "text-h-subscript-1",
		["text-h-subscript-2"] = "text-h-subscript-2",
		["text-h-subscript-3"] = "text-h-subscript-3",
		["text-i-italic"] = "text-i-italic",
		["text-s-strikethrough"] = "text-s-strikethrough",
		["text-u-underline"] = "text-u-underline",
		["text-uppercase-a-lowercase-a"] = "text-uppercase-a-lowercase-a",
		["text-x-subscript-2"] = "text-x-subscript-2",
		["text-x-superscript-2"] = "text-x-superscript-2",
		["three-bars-horizontal"] = "three-bars-horizontal",
		["three-bars-horizontal-chevron-left"] = "three-bars-horizontal-chevron-left",
		["three-bars-horizontal-narrowing"] = "three-bars-horizontal-narrowing",
		["three-bars-horizontal-triangles-vertical"] = "three-bars-horizontal-triangles-vertical",
		["three-bars-vertical-triangles-horizontal"] = "three-bars-vertical-triangles-horizontal",
		["three-chevrons-enlarging-down"] = "three-chevrons-enlarging-down",
		["three-chevrons-enlarging-up"] = "three-chevrons-enlarging-up",
		["three-dots-horizontal"] = "three-dots-horizontal",
		["three-dots-vertical"] = "three-dots-vertical",
		["three-horizontal-bars-wrapping-right"] = "three-horizontal-bars-wrapping-right",
		["three-people"] = "three-people",
		["three-ring-note"] = "three-ring-note",
		["three-sliders-horizontal"] = "three-sliders-horizontal",
		["three-stacked-squares-tilted"] = "three-stacked-squares-tilted",
		["thumb-down"] = "thumb-down",
		["thumb-up"] = "thumb-up",
		["tik-tok"] = "tik-tok",
		["tilt"] = "tilt",
		["torso"] = "torso",
		["trash-can"] = "trash-can",
		["triangle-exclamation"] = "triangle-exclamation",
		["trophy"] = "trophy",
		["tshirt"] = "tshirt",
		["tshirt-2d-text"] = "tshirt-2d-text",
		["tshirt-dual-arrows"] = "tshirt-dual-arrows",
		["twitch"] = "twitch",
		["twitter"] = "twitter",
		["two-arrows-down-and-up"] = "two-arrows-down-and-up",
		["two-arrows-from-center"] = "two-arrows-from-center",
		["two-arrows-left-right"] = "two-arrows-left-right",
		["two-arrows-loop-clockwise"] = "two-arrows-loop-clockwise",
		["two-arrows-loop-clockwise-1"] = "two-arrows-loop-clockwise-1",
		["two-arrows-loop-clockwise-infinity"] = "two-arrows-loop-clockwise-infinity",
		["two-arrows-spin-clockwise"] = "two-arrows-spin-clockwise",
		["two-arrows-spin-clockwise-plus"] = "two-arrows-spin-clockwise-plus",
		["two-arrows-switch-right"] = "two-arrows-switch-right",
		["two-arrows-to-center"] = "two-arrows-to-center",
		["two-folders"] = "two-folders",
		["two-location-pins-connecting-arrow"] = "two-location-pins-connecting-arrow",
		["two-makeup-brushes"] = "two-makeup-brushes",
		["two-people"] = "two-people",
		["two-people-speech-bubble"] = "two-people-speech-bubble",
		["two-stacked-squares"] = "two-stacked-squares",
		["two-switches-horizontal"] = "two-switches-horizontal",
		["verified-backplate"] = "verified-backplate",
		["verified-check"] = "verified-check",
		["verified-mono"] = "verified-mono",
		["video-camera"] = "video-camera",
		["video-camera-arrow-to-bottom-left"] = "video-camera-arrow-to-bottom-left",
		["video-camera-arrow-to-top-right"] = "video-camera-arrow-to-top-right",
		["video-camera-slash"] = "video-camera-slash",
		["video-camera-triangle-exclamation"] = "video-camera-triangle-exclamation",
		["video-camera-x"] = "video-camera-x",
		["wallet"] = "wallet",
		["we-chat"] = "we-chat",
		["whatsapp"] = "whatsapp",
		["x"] = "x",
		["x-small"] = "x-small",
		["xbox-a"] = "xbox-a",
		["xbox-a-pressed"] = "xbox-a-pressed",
		["xbox-a-unpressed"] = "xbox-a-unpressed",
		["xbox-b"] = "xbox-b",
		["xbox-dpad"] = "xbox-dpad",
		["xbox-dpad-down"] = "xbox-dpad-down",
		["xbox-dpad-left"] = "xbox-dpad-left",
		["xbox-dpad-right"] = "xbox-dpad-right",
		["xbox-dpad-up"] = "xbox-dpad-up",
		["xbox-lb"] = "xbox-lb",
		["xbox-lt"] = "xbox-lt",
		["xbox-menu"] = "xbox-menu",
		["xbox-rb"] = "xbox-rb",
		["xbox-rt"] = "xbox-rt",
		["xbox-stick-left"] = "xbox-stick-left",
		["xbox-stick-left-directional"] = "xbox-stick-left-directional",
		["xbox-stick-left-horizontal"] = "xbox-stick-left-horizontal",
		["xbox-stick-left-vertical"] = "xbox-stick-left-vertical",
		["xbox-stick-right"] = "xbox-stick-right",
		["xbox-stick-right-directional"] = "xbox-stick-right-directional",
		["xbox-stick-right-horizontal"] = "xbox-stick-right-horizontal",
		["xbox-stick-right-vertical"] = "xbox-stick-right-vertical",
		["xbox-view"] = "xbox-view",
		["xbox-x"] = "xbox-x",
		["xbox-y"] = "xbox-y",
		["xr-headset"] = "xr-headset",
		["youtube"] = "youtube"
	};
end);

NeverLose.CreateSignal = LPH_NO_VIRTUALIZE(function(self , DefaultValue)
	local __cache = Instance.new('BindableEvent');
	local bind = {
		Value = DefaultValue,
		__event = __cache
	};

	function bind:GetValue()
		return bind.Value;
	end;

	function bind:SetValue(f)
		bind.Value = f;

		return __cache:Fire(f);
	end;

	function bind:Connect(f)
		local signal = __cache.Event:Connect(f);

		NeverLose:AddSignal(signal);

		return signal;
	end;

	return bind;
end);

NeverLose.SetIconMode = LPH_NO_VIRTUALIZE(function(self , Label: TextLabel , Icon: string)
	local useBold = string.lower(string.sub(Icon , -5)) == '-bold';

	if useBold then
		Label.Text = Icon:sub(1,-6);
		Label.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Label, 'TextColor3', 'Icon');
	else
		Label.Text = Icon;
		Label.FontFace = NeverLose.BuiltInRegular;
		NeverLose:BindTheme(Label, 'TextColor3', 'Icon');
	end;
end);

function NeverLose:GetIconFont(icon: string)
	local useBold = string.lower(string.sub(icon , -5)) == '-bold';

	if useBold then
		return NeverLose.BuiltInBold;
	end;

	return NeverLose.BuiltInRegular;
end;

function NeverLose:MoreThanHalfY(Value: number)
	return (NeverLose.ScreenGui.AbsoluteSize.Y / 2) < Value
end;

NeverLose.IsStudio = RunService:IsStudio();
NeverLose.IsMobile = UserInputService.TouchEnabled;

NeverLose.CreateInput = LPH_NO_VIRTUALIZE(function(self , Frame , Callback)
	local Button = Instance.new('ImageButton',Frame);

	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.ImageTransparency = 1;
	Button.Image = "rbxasset://textuers/translateIcon.png";

	if Callback then
		local bth_signal = Button.MouseButton1Click:Connect(function(...)
			if self:CanUsePointer(Button) and not self.__PointerCapture then return Callback(...); end;
		end);

		return Button , bth_signal;
	end;

	return Button;
end);

NeverLose.PlayAnimate = LPH_NO_VIRTUALIZE(function(Self , Info , Property)
	local resolved=NeverLose:ResolveMotionInfo(Self,Info);
	local tween=TweenService:Create(Self,resolved,Property);
	if resolved.Time>0 and NeverLose:IsMotionTarget(Self) then
		local record={Object=Self,Properties=Property}; NeverLose.MotionTweens[tween]=record;
		record.Connection=tween.Completed:Connect(function()
			NeverLose.MotionTweens[tween]=nil;
			if record.Connection then record.Connection:Disconnect(); record.Connection=nil; end;
		end);
	end;
	tween:Play();
	if resolved.Time==0 then for property,value in pairs(Property) do Self[property]=value; end; end;
	return tween;
end);

NeverLose.Drag = LPH_NO_VIRTUALIZE(function(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local Tween = TweenInfo.new(Speed);

	local updateInput = function(input)
		local delta = input.Position - dragStart;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		if NeverLose.Global3DRenderMode then
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = UDim2.fromScale(0.5,0.5)
			});
		else
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = position
			});
		end;
	end;

	NeverLose:AddSignal(InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			if NeverLose:HasOpenPopup() or NeverLose.__PointerCapture or not NeverLose:CanUsePointer(InputFrame) then return; end;
			dragToggle = true;
			dragStart = input.Position;
			startPos = MoveFrame.Position;

			local input_end;
			input_end = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false;

					input_end:Disconnect();
				end
			end)
		end
	end));

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle and not NeverLose:HasOpenPopup() and not NeverLose.__PointerCapture then
				updateInput(input)
			end
		end
	end));
end);

NeverLose.Rounding = LPH_NO_VIRTUALIZE(function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end);

NeverLose.ProcessParams = LPH_NO_VIRTUALIZE(function(self , Params , Fixed)
	Params = Params or {};

	local k = Params or {};

	for i,v in next , Fixed do
		k[i] = Params[i] or v;
	end;

	table.clear(Fixed);

	return k;
end);

NeverLose.EnabledBlur = true;
NeverLose.BlurModuleParent = workspace.CurrentCamera;

NeverLose.GetCalculatePosition = LPH_NO_VIRTUALIZE(function(planePos, planeNormal, rayOrigin, rayDirection)
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end);

NeverLose.CreateBlurModule = LPH_NO_VIRTUALIZE(function(self , Frame , Signal)
	if not NeverLose.EnabledBlur then
		return NeverLose:AddSignal(Instance.new('BindableEvent').Event:Connect(function() return "nl"; end));	
	end;

	local Part = Instance.new('Part',NeverLose.BlurModuleParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");

	BlockMesh.Parent = Part;

	Part.Material = Enum.Material.Glass;
	Part.Transparency = 1;
	Part.Reflectance = 1;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = NeverLose.RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);

	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = NeverLose.RandomString();

	Part.Name = NeverLose.RandomString();

	local disconnect;

	local UpdateFunction = function()
		local IsWindowActive = Signal:GetValue();

		if IsWindowActive and not NeverLose.Global3DRenderMode then

			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 1
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Transparency = 0.97,
				Size = Vector3.new(1, 1, 1) * 0.01;
			})

			Part.Parent = NeverLose.BlurModuleParent;
		else
			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 0
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Size = Vector3.zero,
				Transparency = 1.5,
			})

			Part.Parent = nil;

			return false;
		end;

		if IsWindowActive then
			local corner0 = Frame.AbsolutePosition;
			local corner1 = corner0 + Frame.AbsoluteSize;

			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);

			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

			local planeNormal = CurrentCamera.CFrame.LookVector;

			local pos0 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);

			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);

			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;

			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;

	local rbxsignal = NeverLose:AddSignal(CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction))
	local loopThread = NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end));

	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);

	disconnect = function()
		rbxsignal:Disconnect();
		loopThread:Disconnect();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end;

	Frame.Destroying:Connect(disconnect);

	return rbxsignal;
end);

local EmptyFunction = function() end;

function NeverLose:RollingEffect(parent)
	local UIGradient = Instance.new("UIGradient")

	UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.4), NumberSequenceKeypoint.new(1.00, 0.00)}
	UIGradient.Parent = parent

	return UIGradient;
end;

function NeverLose:CreateShadow(parent , RollingEffect)
	local Shadow = {};

	local UIShadowSafe85 = Instance.new("UIStroke")
	local UIShadowSafe65 = Instance.new("UIStroke")
	local UIShadowSafe50 = Instance.new("UIStroke")
	local UIShadowSafe45 = Instance.new("UIStroke")

	UIShadowSafe85.Thickness = 6.000
	UIShadowSafe85.Transparency = 1
	UIShadowSafe85.Parent = parent

	UIShadowSafe65.Thickness = 5.000
	UIShadowSafe65.Transparency = 1
	UIShadowSafe65.Parent = parent

	UIShadowSafe50.Thickness = 4.000
	UIShadowSafe50.Transparency = 1
	UIShadowSafe50.Parent = parent

	UIShadowSafe45.Thickness = 3.000
	UIShadowSafe45.Transparency = 1
	UIShadowSafe45.Parent = parent

	local RollingEffectThread;
	local r1,r2,r3,r4;

	if RollingEffect then
		r1 = NeverLose:RollingEffect(UIShadowSafe85);
		r2 = NeverLose:RollingEffect(UIShadowSafe65);
		r3 = NeverLose:RollingEffect(UIShadowSafe50);
		r4 = NeverLose:RollingEffect(UIShadowSafe45);
	end;

	Shadow.Render = LPH_NO_VIRTUALIZE(function(self , value)
		if RollingEffectThread then
			task.cancel(RollingEffectThread);
			RollingEffectThread = nil;
		end;

		if value then
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 0.900
			})

			if RollingEffect then
				RollingEffectThread = task.spawn(function()
					local level = 20;
					while true do task.wait(0.025)
						NeverLose.PlayAnimate(r1 , SlowyTween , {
							Rotation = r1.Rotation + level
						});

						NeverLose.PlayAnimate(r2 , SlowyTween , {
							Rotation = r2.Rotation + level
						});

						NeverLose.PlayAnimate(r3 , SlowyTween , {
							Rotation = r3.Rotation + level
						});

						NeverLose.PlayAnimate(r4 , SlowyTween , {
							Rotation = r4.Rotation + level
						});
					end;
				end);
			end;
		else
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 1
			})
		end;
	end);

	return Shadow;
end;

function NeverLose:CreateOptionWindow(Frame: Frame , Zindex)
	Zindex = Zindex or 9;

	local Window = {
		Signal = NeverLose:CreateSignal(false),
	};

	local OptionHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")
	local UIStroke = Instance.new("UIStroke")
	local shadow = NeverLose:CreateShadow(OptionHandler);

	OptionHandler.Name = NeverLose.RandomString();
	OptionHandler.Parent = NeverLose.ScreenGui;
	NeverLose:ElevatePopup(OptionHandler);
	OptionHandler.AnchorPoint = Vector2.new(0, 0)
	NeverLose:BindTheme(OptionHandler, 'BackgroundColor3', 'Section');
	OptionHandler.BackgroundTransparency = 0
	OptionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OptionHandler.BorderSizePixel = 0
	OptionHandler.ClipsDescendants = true
	OptionHandler.Position = UDim2.new(255,255,255,255)
	OptionHandler.Size = UDim2.new(0, 220, 0, 75)
	OptionHandler.ZIndex = Zindex + 9

	NeverLose:BindCorner(UICorner, 'Panel');
	UICorner.Parent = OptionHandler

	UIListLayout.Parent = OptionHandler
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIStroke.Transparency = 0.650
	NeverLose:BindTheme(UIStroke, 'Color', 'Border');
	UIStroke.Parent = OptionHandler

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
			Size = UDim2.new(0, 220, 0, UIListLayout.AbsoluteContentSize.Y - 1)
		})
	end)));

	NeverLose:AddSignal(OptionHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if OptionHandler.BackgroundTransparency > 0.9 then
			OptionHandler.Visible = false;
			UIListLayout.Parent = nil;
			OptionHandler.Parent = nil;
		else
			OptionHandler.Visible = true;
			UIListLayout.Parent = OptionHandler

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
				NeverLose:ElevatePopup(OptionHandler);
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
				NeverLose:ElevatePopup(OptionHandler);
			end;
		end
	end)));

	local FollowingThread;
	local SetPosition = LPH_NO_VIRTUALIZE(function() NeverLose:PlacePopup(OptionHandler,Frame); end);

	Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
		NeverLose:SetPopupOpen(OptionHandler,value);
		if FollowingThread then
			task.cancel(FollowingThread);
			FollowingThread = nil;
		end;

		if value then
			SetPosition();

			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			shadow:Render(true);

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
				NeverLose:ElevatePopup(OptionHandler);
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
				NeverLose:ElevatePopup(OptionHandler);
			end;

			FollowingThread = task.spawn(function()
				while true do task.wait()
					SetPosition();
				end
			end)
		else
			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			shadow:Render(false);
		end;
	end);

	NeverLose:RegisterPopup(OptionHandler,Frame,function() Window.Signal:SetValue(false); end);
	Window.SetRender(false);
	Window.Signal:Connect(Window.SetRender)

	local Payback = NeverLose:RegisiterItem(OptionHandler , Window.Signal);

	Payback.Winbdow = Window;
	Payback.Root = OptionHandler;
	Payback.Signal = Window.Signal;

	return Payback;
end;

function NeverLose:CreateColorPicker(HandleFrame: Frame)
	local ZIndex = NeverLose:GetLocalZIndex(HandleFrame);

	local ColorPickerLib = {};

	local ColorPickerHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local SaViMap = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local ColorZoneSelection = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorMap = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_4 = Instance.new("UICorner")
	local ColorMapSelection = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local RGBLabel = Instance.new("TextLabel")
	local UICorner_6 = Instance.new("UICorner")
	local Shadow = NeverLose:CreateShadow(ColorPickerHandler);

	ColorPickerHandler.Name = NeverLose.RandomString();
	ColorPickerHandler.Parent = NeverLose.ScreenGui;
	NeverLose:ElevatePopup(ColorPickerHandler);
	ColorPickerHandler.AnchorPoint = Vector2.new(0, 0)
	NeverLose:BindTheme(ColorPickerHandler, 'BackgroundColor3', 'Section');
	ColorPickerHandler.BackgroundTransparency = 0
	ColorPickerHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerHandler.BorderSizePixel = 0
	ColorPickerHandler.ClipsDescendants = true
	ColorPickerHandler.Position = UDim2.new(255, 0, 255, 20)
	ColorPickerHandler.Size = UDim2.new(0, 200, 0, 290)
	ColorPickerHandler.ZIndex = ZIndex + 125

	NeverLose:AddSignal(ColorPickerHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if ColorPickerHandler.BackgroundTransparency > 0.9 then
			ColorPickerHandler.Visible = false;
			ColorPickerHandler.Parent = nil
		else
			ColorPickerHandler.Visible = true;

			if NeverLose.Global3DRenderMode then
				ColorPickerHandler.Parent = NeverLose.GlobalSurfaceGui;
				NeverLose:ElevatePopup(ColorPickerHandler);
			else
				ColorPickerHandler.Parent = NeverLose.ScreenGui;
				NeverLose:ElevatePopup(ColorPickerHandler);
			end;
		end;
	end)));

	NeverLose:BindCorner(UICorner, 'Panel');
	UICorner.Parent = ColorPickerHandler

	UIStroke.Transparency = 0.650
	NeverLose:BindTheme(UIStroke, 'Color', 'Border');
	UIStroke.Parent = ColorPickerHandler

	SaViMap.Name = NeverLose.RandomString();
	SaViMap.Parent = ColorPickerHandler
	SaViMap.AnchorPoint = Vector2.new(0.5, 0)
	SaViMap.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	SaViMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SaViMap.BorderSizePixel = 0
	SaViMap.Position = UDim2.new(0.5, 0, 0, 5)
	SaViMap.Size = UDim2.new(0, 185, 0, 185)
	SaViMap.ZIndex = ZIndex + 126
	SaViMap.Image = NeverLose.ImageColorMapping

	NeverLose:BindCorner(UICorner_2, 'Control');
	UICorner_2.Parent = SaViMap

	ColorZoneSelection.Name = NeverLose.RandomString();
	ColorZoneSelection.Parent = SaViMap
	ColorZoneSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorZoneSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorZoneSelection.BackgroundTransparency = 1.000
	ColorZoneSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorZoneSelection.BorderSizePixel = 0
	ColorZoneSelection.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorZoneSelection.Size = UDim2.new(0, 10, 0, 10)
	ColorZoneSelection.ZIndex = ZIndex + 127

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorZoneSelection

	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.Parent = ColorZoneSelection

	ColorMap.Name = NeverLose.RandomString();
	ColorMap.Parent = ColorPickerHandler
	ColorMap.AnchorPoint = Vector2.new(0.5, 0)
	ColorMap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMap.BorderSizePixel = 0
	ColorMap.Position = UDim2.new(0.5, 0, 0, 200)
	ColorMap.Size = UDim2.new(1, -15, 0, 10)
	ColorMap.ZIndex = ZIndex + 126

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Parent = ColorMap

	NeverLose:BindCorner(UICorner_4, 'Control');
	UICorner_4.Parent = ColorMap

	ColorMapSelection.Name = NeverLose.RandomString();
	ColorMapSelection.Parent = ColorMap
	ColorMapSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorMapSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMapSelection.BackgroundTransparency = 1.000
	ColorMapSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMapSelection.BorderSizePixel = 0
	ColorMapSelection.Position = UDim2.new(0, 0, 0.5, 0)
	ColorMapSelection.Size = UDim2.new(0, 5, 1, 0)
	ColorMapSelection.ZIndex = ZIndex + 126

	UIStroke_3.Thickness = 2.000
	UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_3.Parent = ColorMapSelection

	NeverLose:BindCorner(UICorner_5, 'Control');
	UICorner_5.Parent = ColorMapSelection

	RGBLabel.Name = NeverLose.RandomString();
	RGBLabel.Parent = ColorPickerHandler
	NeverLose:BindTheme(RGBLabel, 'BackgroundColor3', 'Control');
	RGBLabel.BackgroundTransparency = 0.750
	RGBLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RGBLabel.BorderSizePixel = 0
	RGBLabel.Position = UDim2.new(0, 10, 0, 217)
	RGBLabel.Size = UDim2.new(1, -20, 0, 15)
	RGBLabel.ZIndex = ZIndex + 127
	NeverLose:RegisterFont(RGBLabel, Enum.Font.GothamBold);
	RGBLabel.Text = "#FFFFFF"
	NeverLose:BindTheme(RGBLabel, 'TextColor3', 'Text');
	NeverLose:SetTextSize(RGBLabel, 12.000);
	RGBLabel.TextTransparency = 0.400
	RGBLabel.TextXAlignment = Enum.TextXAlignment.Left

	NeverLose:BindCorner(UICorner_6, 'Control');
	UICorner_6.Parent = RGBLabel

	local AnimationValues = {"None" , "Rainbow" , "Fade" , "Fade Alpha"};
	local AnimationsBaseHeight = 290;
	local AnimationsRowHeight = 24;
	local AnimationsListHeight = #AnimationValues * AnimationsRowHeight;
	local AnimationsOpened = false;
	local AnimationsVisible = false;
	local AnimationsThread = nil;
	local AnimationsRows = {};

	ColorPickerLib.Animations = {};
	ColorPickerLib.Alpha = 1;
	ColorPickerLib.AnimationsCallback = EmptyFunction;

	local AnimationsTitle = Instance.new("TextLabel")
	local AnimationsBox = Instance.new("Frame")
	local AnimationsBoxCorner = Instance.new("UICorner")
	local AnimationsBoxStroke = Instance.new("UIStroke")
	local AnimationsLabel = Instance.new("TextLabel")
	local AnimationsIcon = Instance.new("TextLabel")
	local AnimationsList = Instance.new("Frame")
	local AnimationsListCorner = Instance.new("UICorner")
	local AnimationsListStroke = Instance.new("UIStroke")
	local AnimationsListLayout = Instance.new("UIListLayout")
	local AnimationsListPadding = Instance.new("UIPadding")

	AnimationsTitle.Name = NeverLose.RandomString();
	AnimationsTitle.Parent = ColorPickerHandler
	AnimationsTitle.BackgroundTransparency = 1.000
	AnimationsTitle.BorderSizePixel = 0
	AnimationsTitle.Position = UDim2.new(0, 10, 0, 238)
	AnimationsTitle.Size = UDim2.new(1, -20, 0, 14)
	AnimationsTitle.ZIndex = ZIndex + 127
	NeverLose:RegisterFont(AnimationsTitle, Enum.Font.GothamMedium);
	AnimationsTitle.Text = "Animations"
	NeverLose:BindTheme(AnimationsTitle, 'TextColor3', 'Text');
	NeverLose:SetTextSize(AnimationsTitle, 12.000);
	AnimationsTitle.TextTransparency = 0.500
	AnimationsTitle.TextXAlignment = Enum.TextXAlignment.Left

	AnimationsBox.Name = NeverLose.RandomString();
	AnimationsBox.Parent = ColorPickerHandler
	NeverLose:BindTheme(AnimationsBox, 'BackgroundColor3', 'Control');
	AnimationsBox.BackgroundTransparency = 0.350
	AnimationsBox.BorderSizePixel = 0
	AnimationsBox.Position = UDim2.new(0, 10, 0, 256)
	AnimationsBox.Size = UDim2.new(1, -20, 0, 26)
	AnimationsBox.ZIndex = ZIndex + 127

	NeverLose:BindCorner(AnimationsBoxCorner, 'Panel');
	AnimationsBoxCorner.Parent = AnimationsBox

	AnimationsBoxStroke.Transparency = 0.650
	NeverLose:BindTheme(AnimationsBoxStroke, 'Color', 'Border');
	AnimationsBoxStroke.Parent = AnimationsBox

	AnimationsLabel.Name = NeverLose.RandomString();
	AnimationsLabel.Parent = AnimationsBox
	AnimationsLabel.AnchorPoint = Vector2.new(0, 0.5)
	AnimationsLabel.BackgroundTransparency = 1.000
	AnimationsLabel.BorderSizePixel = 0
	AnimationsLabel.Position = UDim2.new(0, 9, 0.5, 0)
	AnimationsLabel.Size = UDim2.new(1, -34, 0, 15)
	AnimationsLabel.ZIndex = ZIndex + 128
	NeverLose:RegisterFont(AnimationsLabel, Enum.Font.GothamMedium);
	AnimationsLabel.Text = "None"
	NeverLose:BindTheme(AnimationsLabel, 'TextColor3', 'Text');
	NeverLose:SetTextSize(AnimationsLabel, 12.000);
	AnimationsLabel.TextTransparency = 0.400
	AnimationsLabel.TextTruncate = Enum.TextTruncate.AtEnd
	AnimationsLabel.TextXAlignment = Enum.TextXAlignment.Left

	AnimationsIcon.Name = NeverLose.RandomString();
	AnimationsIcon.Parent = AnimationsBox
	AnimationsIcon.AnchorPoint = Vector2.new(1, 0.5)
	AnimationsIcon.BackgroundTransparency = 1.000
	AnimationsIcon.BorderSizePixel = 0
	AnimationsIcon.Position = UDim2.new(1, -7, 0.5, 0)
	AnimationsIcon.Size = UDim2.new(0, 16, 0, 16)
	AnimationsIcon.ZIndex = ZIndex + 128
	AnimationsIcon.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(AnimationsIcon, 'TextColor3', 'Icon');
	AnimationsIcon.Text = "chevron-small-down"
	NeverLose:BindTheme(AnimationsIcon, 'TextColor3', 'MutedText');
	NeverLose:SetTextSize(AnimationsIcon, 14.000);
	AnimationsIcon.TextTransparency = 0.400
	AnimationsIcon.TextWrapped = true

	AnimationsList.Name = NeverLose.RandomString();
	AnimationsList.Parent = ColorPickerHandler
	AnimationsList.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
	AnimationsList.BackgroundTransparency = 0.050
	AnimationsList.BorderSizePixel = 0
	AnimationsList.ClipsDescendants = true
	AnimationsList.Position = UDim2.new(0, 10, 0, 286)
	AnimationsList.Size = UDim2.new(1, -20, 0, AnimationsListHeight)
	AnimationsList.ZIndex = ZIndex + 128
	AnimationsList.Visible = false

	NeverLose:BindCorner(AnimationsListCorner, 'Panel');
	AnimationsListCorner.Parent = AnimationsList

	AnimationsListStroke.Transparency = 0.650
	NeverLose:BindTheme(AnimationsListStroke, 'Color', 'Border');
	AnimationsListStroke.Parent = AnimationsList

	AnimationsListPadding.PaddingTop = UDim.new(0, 0)
	AnimationsListPadding.PaddingBottom = UDim.new(0, 0)
	AnimationsListPadding.Parent = AnimationsList

	AnimationsListLayout.Parent = AnimationsList
	AnimationsListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local IsAnimationSelected = LPH_NO_VIRTUALIZE(function(name)
		if name == "None" then
			return #ColorPickerLib.Animations == 0;
		end;

		return table.find(ColorPickerLib.Animations , name) ~= nil;
	end);

	local UpdateAnimationsLabel = LPH_NO_VIRTUALIZE(function()
		if #ColorPickerLib.Animations == 0 then
			AnimationsLabel.Text = "None";
		else
			AnimationsLabel.Text = table.concat(ColorPickerLib.Animations , ", ");
		end;

		for _,row in next , AnimationsRows do
			local selected = IsAnimationSelected(row.Name);

			NeverLose.PlayAnimate(row.Bar , SlowyTween , {
				BackgroundTransparency = (selected and 0) or 1
			});

			NeverLose.PlayAnimate(row.Label , SlowyTween , {
				TextTransparency = (selected and 0) or 0.550
			});
		end;
	end);

	local GetAnimationsContent = LPH_NO_VIRTUALIZE(function()
		local content = AnimationsListLayout.AbsoluteContentSize.Y;

		if content <= 1 then
			content = #AnimationValues * AnimationsRowHeight;
		end;

		return content;
	end);

	local UpdateAnimationsSize = LPH_NO_VIRTUALIZE(function(instant)
		local height = AnimationsBaseHeight;

		if AnimationsOpened then
			local content = GetAnimationsContent();

			AnimationsList.Size = UDim2.new(1, -20, 0, content);

			height = AnimationsBaseHeight + content;
		end;

		if instant then
			ColorPickerHandler.Size = UDim2.new(0, 200, 0, height);
		else
			NeverLose.PlayAnimate(ColorPickerHandler , SlowyTween , {
				Size = UDim2.new(0, 200, 0, height)
			});
		end;
	end);

	local SetAnimationsOpened = LPH_NO_VIRTUALIZE(function(value , instant)
		AnimationsOpened = (value and true) or false;
		AnimationsList.Visible = AnimationsOpened and AnimationsVisible;

		NeverLose.PlayAnimate(AnimationsIcon , SlowyTween , {
			Rotation = (AnimationsOpened and 180) or 0
		});

		UpdateAnimationsSize(instant);
	end);

	local StopAnimations = LPH_NO_VIRTUALIZE(function()
		if AnimationsThread then
			pcall(task.cancel , AnimationsThread);

			AnimationsThread = nil;
		end;
	end);

	local StartAnimations = LPH_NO_VIRTUALIZE(function()
		StopAnimations();

		if #ColorPickerLib.Animations == 0 then
			ColorPickerLib.Alpha = 1;
			ColorPickerLib.AnimationsCallback(Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V) , 1 , ColorPickerLib.Animations);

			return;
		end;

		AnimationsThread = task.spawn(function()
			while true do
				local clock = os.clock();
				local hue , sat , val = ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V;
				local alpha = 1;

				for _,name in next , ColorPickerLib.Animations do
					if name == "Rainbow" then
						hue = (clock * 0.25) % 1;

						if sat < 0.350 then
							sat = 1;
						end;

						if val < 0.350 then
							val = 1;
						end;
					elseif name == "Fade" then
						val = val * (0.350 + (0.650 * ((math.sin(clock * 2) + 1) / 2)));
					elseif name == "Fade Alpha" then
						alpha = 0.150 + (0.850 * ((math.sin(clock * 2) + 1) / 2));
					end;
				end;

				local animated = Color3.fromHSV(hue , sat , val);

				ColorPickerLib.Alpha = alpha;

				if AnimationsVisible and not ColorPickerLib.IsHold then
					RGBLabel.Text = "#"..animated:ToHex();

					SaViMap.BackgroundColor3 = Color3.fromHSV(hue , 1 , 1);
					ColorZoneSelection.Position = UDim2.fromScale(sat , 1 - val);
					ColorMapSelection.Position = UDim2.fromScale(hue , 0.5);
				end;

				ColorPickerLib.AnimationsCallback(animated , alpha , ColorPickerLib.Animations);

				task.wait();
			end;
		end);
	end);

	local ToggleAnimation = LPH_NO_VIRTUALIZE(function(name)
		if name == "None" then
			table.clear(ColorPickerLib.Animations);
		else
			local index = table.find(ColorPickerLib.Animations , name);

			if index then
				table.remove(ColorPickerLib.Animations , index);
			else
				table.insert(ColorPickerLib.Animations , name);
			end;
		end;

		UpdateAnimationsLabel();
		StartAnimations();
	end);

	for index,name in next , AnimationValues do
		local RowFrame = Instance.new("Frame")
		local RowCorner = Instance.new("UICorner")
		local RowBar = Instance.new("Frame")
		local RowBarCorner = Instance.new("UICorner")
		local RowLabel = Instance.new("TextLabel")

		RowFrame.Name = NeverLose.RandomString();
		RowFrame.Parent = AnimationsList
		RowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RowFrame.BackgroundTransparency = 1.000
		RowFrame.BorderSizePixel = 0
		RowFrame.Size = UDim2.new(1, 0, 0, AnimationsRowHeight)
		RowFrame.ZIndex = ZIndex + 129
		RowFrame.LayoutOrder = index

		NeverLose:BindCorner(RowCorner, 'Control');
		RowCorner.Parent = RowFrame

		RowBar.Name = NeverLose.RandomString();
		RowBar.Parent = RowFrame
		RowBar.AnchorPoint = Vector2.new(0, 0.5)
		NeverLose:BindAccent(RowBar , 'BackgroundColor3');
		RowBar.BackgroundTransparency = 1.000
		RowBar.BorderSizePixel = 0
		RowBar.Position = UDim2.new(0, 5, 0.5, 0)
		RowBar.Size = UDim2.new(0, 2, 0, 12)
		RowBar.ZIndex = ZIndex + 130

		RowBarCorner.CornerRadius = UDim.new(1, 0)
		RowBarCorner.Parent = RowBar

		RowLabel.Name = NeverLose.RandomString();
		RowLabel.Parent = RowFrame
		RowLabel.BackgroundTransparency = 1.000
		RowLabel.BorderSizePixel = 0
		RowLabel.Position = UDim2.new(0, 14, 0, 0)
		RowLabel.Size = UDim2.new(1, -20, 1, 0)
		RowLabel.ZIndex = ZIndex + 130
		NeverLose:RegisterFont(RowLabel, Enum.Font.GothamMedium);
		RowLabel.Text = name
		NeverLose:BindTheme(RowLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(RowLabel, 12.000);
		RowLabel.TextTransparency = 0.550
		RowLabel.TextTruncate = Enum.TextTruncate.AtEnd
		RowLabel.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(AnimationsRows , {
			Name = name,
			Frame = RowFrame,
			Bar = RowBar,
			Label = RowLabel
		});

		local RowButton = NeverLose:CreateInput(RowFrame , LPH_NO_VIRTUALIZE(function()
			ToggleAnimation(name);
		end));

		NeverLose:AddSignal(RowButton.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(RowFrame , SlowyTween , {
				BackgroundTransparency = 0.930
			});
		end)));

		NeverLose:AddSignal(RowButton.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(RowFrame , SlowyTween , {
				BackgroundTransparency = 1.000
			});
		end)));
	end;

	local AnimationsButton = NeverLose:CreateInput(AnimationsBox , LPH_NO_VIRTUALIZE(function()
		SetAnimationsOpened(not AnimationsOpened);
	end));

	NeverLose:AddSignal(AnimationsButton.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		if AnimationsVisible then
			NeverLose.PlayAnimate(AnimationsBox , SlowyTween , {
				BackgroundTransparency = 0.150
			});
		end;
	end)));

	NeverLose:AddSignal(AnimationsButton.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		if AnimationsVisible then
			NeverLose.PlayAnimate(AnimationsBox , SlowyTween , {
				BackgroundTransparency = 0.350
			});
		end;
	end)));

	local AnimationsRender = LPH_NO_VIRTUALIZE(function(value)
		AnimationsVisible = (value and true) or false;

		SetAnimationsOpened(false , true);

		NeverLose.PlayAnimate(AnimationsTitle , SlowyTween , {
			TextTransparency = (AnimationsVisible and 0.500) or 1
		});

		NeverLose.PlayAnimate(AnimationsBox , SlowyTween , {
			BackgroundTransparency = (AnimationsVisible and 0.350) or 1
		});

		NeverLose.PlayAnimate(AnimationsBoxStroke , SlowyTween , {
			Transparency = (AnimationsVisible and 0.650) or 1
		});

		NeverLose.PlayAnimate(AnimationsLabel , SlowyTween , {
			TextTransparency = (AnimationsVisible and 0.400) or 1
		});

		NeverLose.PlayAnimate(AnimationsIcon , SlowyTween , {
			TextTransparency = (AnimationsVisible and 0.400) or 1
		});
	end);

	function ColorPickerLib:GetAnimations()
		return ColorPickerLib.Animations;
	end;

	function ColorPickerLib:SetAnimations(values)
		table.clear(ColorPickerLib.Animations);

		if type(values) == "table" then
			for _,name in next , values do
				if name ~= "None" and table.find(AnimationValues , name) and not table.find(ColorPickerLib.Animations , name) then
					table.insert(ColorPickerLib.Animations , name);
				end;
			end;
		elseif type(values) == "string" and values ~= "None" and table.find(AnimationValues , values) then
			table.insert(ColorPickerLib.Animations , values);
		end;

		UpdateAnimationsLabel();
		StartAnimations();
	end;

	function ColorPickerLib:GetAlpha()
		return ColorPickerLib.Alpha;
	end;

	UpdateAnimationsLabel();

	ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
		NeverLose:SetPopupOpen(ColorPickerHandler,value);
		if value then
			NeverLose:PlacePopup(ColorPickerHandler,HandleFrame);

			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 0,
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 0.750,
				TextTransparency = 0.400
			})

			AnimationsRender(true);

			Shadow:Render(true)
		else
			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 1,
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 1,
				TextTransparency = 1
			})

			AnimationsRender(false);

			Shadow:Render(false)
		end;
	end);

	NeverLose:RegisterPopup(ColorPickerHandler,HandleFrame,function() ColorPickerLib.SetRender(false); end);
	ColorPickerLib.SetRender(false);
	ColorPickerLib.Root = ColorPickerHandler;
	ColorPickerLib.H = 1;
	ColorPickerLib.S = 1;
	ColorPickerLib.V = 1;
	ColorPickerLib.Callback = EmptyFunction;

	function ColorPickerLib:Update()
		local RealColor = Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V);

		NeverLose.PlayAnimate(ColorZoneSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.S , 1 - ColorPickerLib.V)
		});

		NeverLose.PlayAnimate(SaViMap,ManualTween,{
			BackgroundColor3 = Color3.fromHSV(ColorPickerLib.H , 1 , 1)
		});

		NeverLose.PlayAnimate(ColorMapSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.H,0.5)
		});

		RGBLabel.Text = "#"..RealColor:ToHex();

		ColorPickerLib.Callback(RealColor);
	end;

	function ColorPickerLib:GetColor()
		return Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V);
	end;

	function ColorPickerLib:SetValue(Color)
		if typeof(Color) == 'string' then
			Color = Color3.fromHex(Color);
		end;

		local H , S , V = Color:ToHSV();

		ColorPickerLib.H = H;
		ColorPickerLib.S = S;
		ColorPickerLib.V = V;

		ColorPickerLib:Update();
	end;

	ColorPickerLib.IsHold = false;
	local ColorDrag;
	local function stopColorDrag()
		ColorDrag = nil; ColorPickerLib.IsHold = false;
		if NeverLose.__PointerCapture == ColorPickerLib then NeverLose.__PointerCapture = nil; end;
	end;
	local function updateColorDrag(input)
		if not ColorDrag then return; end;
		if not NeverLose:CanUsePointer(ColorPickerHandler) or not NeverLose.PopupRegistry[ColorPickerHandler].Open then stopColorDrag(); return; end;
		local screen = input and input.Position and Vector2.new(input.Position.X,input.Position.Y) or nil;
		local root = NeverLose:GetGuiRoot(ColorPickerHandler);
		local point = NeverLose:GetCanvasPoint(root,screen); if not point then return; end;
		local position,size = NeverLose:GetGuiRect(ColorDrag.Target,root); if size.X <= 0 or size.Y <= 0 then return; end;
		local x = math.clamp((point.X-position.X)/size.X,0,1);
		if ColorDrag.Target == ColorMap then ColorPickerLib.H = x;
		else ColorPickerLib.S = x; ColorPickerLib.V = 1-math.clamp((point.Y-position.Y)/size.Y,0,1); end;
		ColorPickerLib:Update();
	end;
	for _,target in ipairs({ColorMap,SaViMap}) do
		NeverLose:AddSignal(target.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return; end;
			if NeverLose.__PointerCapture or not NeverLose:CanUsePointer(target) then return; end;
			ColorDrag = {Target=target,Input=input}; ColorPickerLib.IsHold = true; NeverLose.__PointerCapture = ColorPickerLib; updateColorDrag(input);
		end));
	end;
	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if ColorDrag and (input == ColorDrag.Input or ColorDrag.Input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.MouseMovement) then updateColorDrag(input); end;
	end));
	NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
		if ColorDrag and (input == ColorDrag.Input or ColorDrag.Input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.MouseButton1) then stopColorDrag(); end;
	end));
	NeverLose:AddSignal(UserInputService.WindowFocusReleased:Connect(stopColorDrag));
	NeverLose:AddSignal(ColorPickerHandler.Destroying:Connect(stopColorDrag));
	NeverLose:AddSignal(ColorPickerHandler:GetPropertyChangedSignal('Visible'):Connect(function() if not ColorPickerHandler.Visible then stopColorDrag(); end; end));

	return ColorPickerLib;
end;

NeverLose.KeyEnum = {
	One = '1',
	Two = '2',
	Three = '3',
	Four = '4',
	Five = '5',
	Six = '6',
	Seven = '7',
	Eight = '8',
	Nine = '9',
	Zero = '0',
	['Minus'] = "-",
	['Plus'] = "+",
	BackSlash = "\\",
	Slash = "/",
	Period = '.',
	Semicolon = ';',
	Colon = ":",
	LeftControl = "LCtrl",
	RightControl = "RCtrl",
	LeftShift = "LShift",
	RightShift = "RShift",
	Return = "Enter",
	LeftBracket = "[",
	RightBracket = "]",
	Quote = "'",
	Comma = ",",
	Equals = "=",
	LeftSuper = "Super",
	RightSuper = "Super",
	LeftAlt = "LAlt",
	RightAlt = "RAlt",
	Escape = "Esc",
};

NeverLose.EnumReverse = {};

for i,v in next , NeverLose.KeyEnum do
	NeverLose.EnumReverse[v] = i;
end;

function NeverLose:KeyCodeToStr(K: Enum.KeyCode)
	if typeof(K) == 'string' then
		if NeverLose.KeyEnum[K] then
			return NeverLose.KeyEnum[K];
		end;

		return K;
	end;

	return (NeverLose.KeyEnum[K.Name] or K.Name);
end;

function NeverLose:StrToKeyCode(str: string)
	if NeverLose.EnumReverse[str] then
		return Enum.KeyCode[NeverLose.EnumReverse[str]];
	end;

	return Enum.KeyCode[str];
end;

function NeverLose:CreateRowBadge(Label, Text, Color, Bind)
	if typeof(Label) ~= 'Instance' or not Label.Parent then return nil; end;
	local BadgeLib = {};
	local Badge = Instance.new('Frame');
	Badge.Name = NeverLose.RandomString();
	Badge.Parent = Label;
	Badge.AnchorPoint = Vector2.new(0, 0.5);
	Badge.BackgroundColor3 = Color;
	Badge.BackgroundTransparency = 0.88;
	Badge.BorderSizePixel = 0;
	Badge.ClipsDescendants = false;
	Badge.ZIndex = Label.ZIndex + 1;
	local corner = Instance.new('UICorner'); corner.Parent = Badge;
	NeverLose:BindCorner(corner, 'Badge');
	local text = Instance.new('TextLabel');
	text.Name = NeverLose.RandomString(); text.Parent = Badge;
	text.BackgroundTransparency = 1; text.BorderSizePixel = 0;
	text.AnchorPoint = Vector2.new(0, 0.5); text.Position = UDim2.fromScale(0, 0.5);
	text.Text = string.upper(tostring(Text)); text.TextColor3 = Color;
	text.TextXAlignment = Enum.TextXAlignment.Center;
	text.TextYAlignment = Enum.TextYAlignment.Center;
	text.TextWrapped = false; text.ZIndex = Label.ZIndex + 2;
	local busy = false;
	local function UpdateBadge()
		if busy or not Label.Parent then return; end;
		busy = true;
		text.FontFace = Label.FontFace;
		text.TextSize = Label.TextSize;
		local labelHeight = math.max(Label.AbsoluteSize.Y, Label.TextSize + 2);
		local height = math.max(16, math.floor(Label.TextSize + 4));
		local badgeBounds = NeverLose:MeasureText(text.Text, text.TextSize, text.FontFace);
		local labelBounds = NeverLose:MeasureText(Label.Text, Label.TextSize, Label.FontFace);
		local width = math.ceil(badgeBounds.X) + 8;
		local labelWidth = Label.AbsoluteSize.X;
		local textWidth = labelBounds.X;
		if Label.TextTruncate ~= Enum.TextTruncate.None and labelWidth > 0 then textWidth = math.min(textWidth, labelWidth); end;
		local x = 0;
		if Label.TextXAlignment == Enum.TextXAlignment.Center then x = (labelWidth - textWidth) * 0.5;
		elseif Label.TextXAlignment == Enum.TextXAlignment.Right then x = labelWidth - textWidth; end;
		local y = Label.AbsoluteSize.Y * 0.5;
		if Label.TextYAlignment == Enum.TextYAlignment.Top then y = labelHeight * 0.5;
		elseif Label.TextYAlignment == Enum.TextYAlignment.Bottom then y = Label.AbsoluteSize.Y - labelHeight * 0.5; end;
		Badge.Size = UDim2.fromOffset(width, height);
		Badge.Position = UDim2.fromOffset(math.floor(x + textWidth + 6 + 0.5), y);
		text.Size = UDim2.new(1, 0, 0, labelHeight);
		Label:SetAttribute('RowBadgeWidth', width + 6);
		busy = false;
	end;
	for _,property in ipairs({'Text','TextSize','FontFace','AbsoluteSize','TextXAlignment','TextYAlignment','TextTruncate'}) do NeverLose:AddSignal(Label:GetPropertyChangedSignal(property):Connect(UpdateBadge)); end;
	NeverLose:BindTypography(UpdateBadge);
	if Bind then
		NeverLose:BindAccent(Badge, 'BackgroundColor3'); NeverLose:BindAccent(text, 'TextColor3');
	elseif Color == NeverLose.RiskColor then
		NeverLose:BindTheme(Badge, 'BackgroundColor3', 'Risk'); NeverLose:BindTheme(text, 'TextColor3', 'Risk');
	end;
	BadgeLib.Root, BadgeLib.Label = Badge, text;
	BadgeLib.Update = UpdateBadge;
	BadgeLib.SetRender = function(value)
		Badge.Visible = value and true or false;
		Badge.BackgroundTransparency = 0.88; text.TextTransparency = 0;
	end;
	UpdateBadge();
	return BadgeLib;
end;

function NeverLose:RegisiterHandler(Handler: Frame , Signal)
	local handle = {};
	local ZINdex = NeverLose:GetLocalZIndex(Handler);

	function handle:AddToggle(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = false,
			Flag = nil,
			Callback = EmptyFunction,
			Risk = false,
			New = nil,
		});

		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Circle = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = NeverLose.RandomString();
		Toggle.Parent = Handler
		Toggle.BackgroundColor3 = NeverLose.Theme.ToggleOff
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.ClipsDescendants = true
		Toggle.Size = UDim2.new(0, 30, 0, 22)
		Toggle.ZIndex = ZINdex + 13
		Toggle.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Toggle

		Circle.Name = NeverLose.RandomString();
		Circle.Parent = Toggle
		Circle.AnchorPoint = Vector2.new(0.5, 0.5)
		NeverLose:BindTheme(Circle, 'BackgroundColor3', 'Knob');
		Circle.BackgroundTransparency = 0.500
		Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Circle.BorderSizePixel = 0
		Circle.Position = UDim2.new(0.300000012, 0, 0.5, 0)
		Circle.Size = UDim2.new(0, 18, 0, 18)
		Circle.ZIndex = ZINdex + 14

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Circle

		local ToggleLib = {
			Root = Toggle	
		};

		local ToggleColor = LPH_NO_VIRTUALIZE(function()
			if Config.Risk then
				return NeverLose.RiskColor;
			end;

			return NeverLose.Theme.ToggleOn;
		end);

		ToggleLib.SetUI = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = ToggleColor()
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = NeverLose.Theme.Knob,
					BackgroundTransparency = 0,
					Position = UDim2.new(0.7, 0, 0.5, 0)
				})
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = NeverLose.Theme.ToggleOff
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = NeverLose.Theme.Knob,
					BackgroundTransparency = 0.500,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		ToggleLib.SetVisible = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ToggleLib.SetUI(Config.Default);
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 1,
					BackgroundColor3 = NeverLose.Theme.ToggleOff
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = NeverLose.Theme.Knob,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		NeverLose:BindGlow(Toggle,'Toggles',{Active=function() return Config.Default and Signal:GetValue(); end});
		NeverLose:BindThemeHook(function() if Toggle.Parent then ToggleLib.SetVisible(Signal:GetValue()); end; end);
		ToggleLib.SetUI(Config.Default);
		ToggleLib.SetVisible(Signal:GetValue());

		if self and self.Label then
			if Config.Risk then
				NeverLose:BindTheme(self.Label, 'TextColor3', 'Risk');
			end;

			if Config.New then
				local BadgeText = 'NEW';

				if type(Config.New) == 'string' then
					BadgeText = Config.New;
				end;

				local Badge = NeverLose:CreateRowBadge(self.Label , BadgeText , (Config.Risk and NeverLose.RiskColor) or NeverLose.AccentColor , not Config.Risk);

				if Badge then
					Badge.SetRender(Signal:GetValue());

					Signal:Connect(Badge.SetRender);
				end;
			end;
		end;

		NeverLose:BindAccentHook(function(Value)
			if not Toggle.Parent then
				error('unbound');
			end;

			if Config.Default and Signal:GetValue() and not Config.Risk then
				Toggle.BackgroundColor3 = Value;
			end;
		end);

		NeverLose:CreateInput(Toggle , LPH_NO_VIRTUALIZE(function()
			Config.Default = not Config.Default;

			ToggleLib.SetUI(Config.Default);

			Config.Callback(Config.Default)
		end))

		ToggleLib.Signal = Signal:Connect(ToggleLib.SetVisible);

		function ToggleLib:GetValue()
			return Config.Default;
		end;

		function ToggleLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				ToggleLib.SetUI(Config.Default);
			end;

			Config.Callback(Config.Default)
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ToggleLib;
		end;

		return ToggleLib;
	end;

	function handle:AddSlider(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = 50,
			Min = 0,
			Max = 10,
			Type = "",
			Rounding = 0,
			Nums = {},
			Flag = nil,
			Size = 125,
			Callback = EmptyFunction,
		});

		local SliderLib = {};

		SliderLib.GetSize = LPH_NO_VIRTUALIZE(function()
			return (Config.Default - Config.Min) / (Config.Max - Config.Min);
		end);

		local FullNumSize = NeverLose:MeasureText(string.rep("0",(Config.Rounding + #tostring(Config.Max))+1)..tostring(Config.Type),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

		SliderLib.MaximumSize = FullNumSize.X;

		if Config.Nums then
			local nszie = 0;

			for i,ns in next , Config.Nums do
				local size = NeverLose:MeasureText(string.rep("m",string.len(tostring(ns))),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

				if nszie < size.X then
					nszie = size.X;
				end
			end;

			if SliderLib.MaximumSize < nszie then
				SliderLib.MaximumSize = nszie;
			end;
		end;

		local Slider = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ValueFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextBox")
		local SlideMain = Instance.new("Frame")
		local SlideFrame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local SlideMoving = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")
		local boxSize = 2;

		Slider.Name = NeverLose.RandomString();
		Slider.Parent = Handler
		NeverLose:BindTheme(Slider, 'BackgroundColor3', 'Control');
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.ClipsDescendants = false
		Slider.Size = UDim2.new(0, Config.Size, 0, 22)
		Slider.ZIndex = ZINdex + 13
		Slider.LayoutOrder = -(#Handler:GetChildren() + 5);

		Slider:SetAttribute('BaseWidth' , Config.Size);
		Slider:SetAttribute('MinWidth' , math.min(Config.Size , SliderLib.MaximumSize + 48));
		Slider:SetAttribute('Flexible' , true);

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = Slider

		ValueFrame.Name = NeverLose.RandomString();
		ValueFrame.Parent = Slider
		ValueFrame.AnchorPoint = Vector2.new(1, 0)
		NeverLose:BindTheme(ValueFrame, 'BackgroundColor3', 'Control');
		ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueFrame.BorderSizePixel = 0
		ValueFrame.ClipsDescendants = true
		ValueFrame.Position = UDim2.new(1, 0, 0, 0)
		ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 22)
		ValueFrame.ZIndex = ZINdex + 13

		NeverLose:BindCorner(UICorner_2, 'Control');
		UICorner_2.Parent = ValueFrame

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = ValueFrame

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = ValueFrame
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		NeverLose:RegisterFont(ValueLabel, Enum.Font.GothamMedium);
		ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);
		NeverLose:BindTheme(ValueLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(ValueLabel, 10.000);
		ValueLabel.ClearTextOnFocus = false;
		ValueLabel.TextTransparency = 0.350

		SlideMain.Name = NeverLose.RandomString();
		SlideMain.Parent = Slider
		SlideMain.AnchorPoint = Vector2.new(0, 0.5)
		SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SlideMain.BackgroundTransparency = 1.000
		SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMain.BorderSizePixel = 0
		SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
		SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
		SlideMain.ZIndex = ZINdex + 13

		SlideFrame.Name = NeverLose.RandomString();
		SlideFrame.Parent = SlideMain
		SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
		SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
		SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideFrame.BorderSizePixel = 0
		SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
		SlideFrame.Size = UDim2.new(1, 0, 0, 5)
		SlideFrame.ZIndex = ZINdex + 13

		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = SlideFrame

		SlideMoving.Name = NeverLose.RandomString();
		SlideMoving.Parent = SlideFrame
		NeverLose:BindTheme(SlideMoving, 'BackgroundColor3', 'SliderFill');
		SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMoving.BorderSizePixel = 0
		SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
		SlideMoving.ZIndex = ZINdex + 14

		UICorner_4.CornerRadius = UDim.new(1, 0)
		UICorner_4.Parent = SlideMoving

		Frame.Parent = SlideMoving
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Size = UDim2.new(0, 10, 0, 10)
		Frame.ZIndex = ZINdex + 15

		UICorner_5.CornerRadius = UDim.new(1, 0)
		UICorner_5.Parent = Frame

		NeverLose:BindTheme(Frame, 'BackgroundColor3', 'Knob');
		NeverLose:BindTheme(SlideFrame, 'BackgroundColor3', 'ToggleOff');
		local RefreshSliderMetrics = function()
			if not Slider.Parent then return; end;
			local maximum = 0;
			for _,value in ipairs({tostring(Config.Min)..tostring(Config.Type), tostring(Config.Max)..tostring(Config.Type), tostring(Config.Default)..tostring(Config.Type)}) do maximum = math.max(maximum, NeverLose:MeasureText(value, ValueLabel.TextSize, ValueLabel.FontFace).X); end;
			for _,value in pairs(Config.Nums) do maximum = math.max(maximum, NeverLose:MeasureText(value, ValueLabel.TextSize, ValueLabel.FontFace).X); end;
			SliderLib.MaximumSize = math.ceil(maximum) + 4;
			ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 22);
			SlideMain.Size = UDim2.new(1, -SliderLib.MaximumSize - 11, 0, 22);
			Slider:SetAttribute('MinWidth', math.min(Config.Size, SliderLib.MaximumSize + 48));
		end;
		NeverLose:BindTypography(RefreshSliderMetrics); RefreshSliderMetrics();
		local LoadText = LPH_NO_VIRTUALIZE(function()
			if Config.Nums[Config.Default] then
				ValueLabel.Text = Config.Nums[Config.Default]

			else
				ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);

			end;
		end);

		ValueLabel.FocusLost:Connect(LPH_NO_VIRTUALIZE(function()
			local OutVal = NeverLose:ParseInput(ValueLabel.Text , true);
			if OutVal then
				local rx = math.clamp(OutVal , Config.Min , Config.Max);
				local Value = NeverLose.Rounding(rx,Config.Rounding);

				if Value then
					Config.Default = Value;

					NeverLose.PlayAnimate(SlideMoving , ManualTween ,{
						Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
					});

					LoadText();

					Config.Callback(Config.Default)
				else
					LoadText();
				end;

			else
				LoadText()
			end;
		end));

		SliderLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 22)
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 0.350
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 0
				});
			else
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 1,
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 1
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 1
				});
			end;
		end);

		SliderLib.SetRender(Signal:GetValue());
		SliderLib.Signal = Signal:Connect(SliderLib.SetRender);
		NeverLose:BindGlow(SlideMoving,'Sliders',{Active=function() return Signal:GetValue() and Config.Default>Config.Min; end});

		local DragInput;
		local function Update(input)
			local screen = input and input.Position and Vector2.new(input.Position.X,input.Position.Y) or nil;
			local root = NeverLose:GetGuiRoot(SlideMain);
			local point = NeverLose:GetCanvasPoint(root,screen); if not point then return; end;
			local position,size = NeverLose:GetGuiRect(SlideMain,root); if size.X <= 0 then return; end;
			local scale = math.clamp((point.X-position.X)/size.X,0,1);
			local value = NeverLose.Rounding(Config.Min+(Config.Max-Config.Min)*scale,Config.Rounding);
			Config.Default = value;
			NeverLose.PlayAnimate(SlideMoving,ManualTween,{Size=UDim2.new(SliderLib.GetSize(),0,1,0)});
			LoadText(); Config.Callback(value);
		end;
		local function stop()
			DragInput = nil;
			if NeverLose.__PointerCapture == SliderLib then NeverLose.__PointerCapture = nil; end;
		end;
		NeverLose:AddSignal(SlideMain.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return; end;
			if not Signal:GetValue() or not NeverLose:CanUsePointer(SlideMain) or NeverLose.__PointerCapture then return; end;
			DragInput = input; NeverLose.__PointerCapture = SliderLib; Update(input);
		end));
		NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
			if not DragInput then return; end;
			if not Signal:GetValue() or not NeverLose:CanUsePointer(SlideMain) then stop(); return; end;
			if input == DragInput or DragInput.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.MouseMovement then Update(input); end;
		end));
		NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
			if DragInput and (input == DragInput or DragInput.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType == Enum.UserInputType.MouseButton1) then stop(); end;
		end));
		NeverLose:AddSignal(UserInputService.WindowFocusReleased:Connect(stop));
		NeverLose:AddSignal(SlideMain.Destroying:Connect(stop));
		Signal:Connect(function(value) if not value then stop(); end; end);

		function SliderLib:GetValue()
			return Config.Default;
		end;

		function SliderLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});
			end;

			LoadText()

			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = SliderLib;
		end;

		return SliderLib;
	end;

	function handle:AddOption(GearIcon)
		local Option = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")

		Option.Name = NeverLose.RandomString();
		Option.Parent = Handler
		NeverLose:BindTheme(Option, 'BackgroundColor3', 'Hover');
		Option.BackgroundTransparency = 1.000
		Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Option.BorderSizePixel = 0
		Option.ClipsDescendants = true
		Option.Size = UDim2.new(0, 20, 0, 18)
		Option.ZIndex = ZINdex + 13
		Option.LayoutOrder = -(#Handler:GetChildren() + 5);

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = Option
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = ZINdex + 14
		Icon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
		Icon.Text = (GearIcon == 1 and 'gear') or (GearIcon == 2 and 'chevron-large-right') or "three-dots-horizontal";
		NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Icon, 16.000);
		Icon.TextTransparency = 0.400
		Icon.TextWrapped = true

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = Option

		local Window = NeverLose:CreateOptionWindow(Option , ZINdex + 13);
		Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.400
				})
			else
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end);

		Window.SetRender(Signal:GetValue());
		Signal:Connect(Window.SetRender);
		Signal:Connect(function(value) if not value then Window.Signal:SetValue(false); end; end);

		local bthg = NeverLose:CreateInput(Option , LPH_NO_VIRTUALIZE(function() Window.Signal:SetValue(true); end));

		NeverLose:AddSignal(bthg.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 0.5
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)));

		NeverLose:AddSignal(bthg.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 1.000
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.400
			})
		end)));

		return Window;
	end;

	function handle:AddColorPicker(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = Color3.fromRGB(255, 255, 255),
			Callback  = EmptyFunction,
		});

		if typeof(Config.Default) == 'string' then
			Config.Default = Color3.fromHex(Config.Default:gsub('#',''));
		end;

		local ColorPickerLib = {};
		local ColorPicker = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ImageLabel = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")

		ColorPicker.Name = NeverLose.RandomString();
		ColorPicker.Parent = Handler
		ColorPicker.BackgroundColor3 = Config.Default;
		ColorPicker.BackgroundTransparency = 0
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.ClipsDescendants = true
		ColorPicker.Size = UDim2.new(0, 18, 0, 18)
		ColorPicker.ZIndex = ZINdex + 13
		ColorPicker.LayoutOrder = -(#Handler:GetChildren() + 5);

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = ColorPicker

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = ColorPicker

		ImageLabel.Parent = ColorPicker
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel.ZIndex = ZINdex + 11
		ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
		ImageLabel.ImageTransparency = 0.9
		ImageLabel.BackgroundTransparency = 1;
		ImageLabel.ScaleType = Enum.ScaleType.Crop

		NeverLose:BindCorner(UICorner_2, 'Control');
		UICorner_2.Parent = ImageLabel

		local BackendM = NeverLose:CreateColorPicker(ColorPicker);

		BackendM:SetValue(Config.Default)

		ColorPicker.BackgroundColor3 = Config.Default;

		BackendM.Callback = function(color)
			ColorPicker.BackgroundColor3 = color;
			Config.Default = color;
			Config.Callback(Config.Default , BackendM.Alpha , BackendM.Animations);
		end;

		BackendM.AnimationsCallback = LPH_NO_VIRTUALIZE(function(color , alpha , animations)
			ColorPicker.BackgroundColor3 = color;
			Config.Callback(color , alpha , animations);
		end);

		if Config.Animations then
			BackendM:SetAnimations(Config.Animations);
		end;

		NeverLose:CreateInput(ColorPicker , LPH_NO_VIRTUALIZE(function() BackendM.SetRender(true); end));

		ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if not value then BackendM.SetRender(false); end;
			if value then
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 0.9
				})
			else
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 1
				})
			end;
		end);

		ColorPickerLib.SetRender(Signal:GetValue());
		Signal:Connect(ColorPickerLib.SetRender);

		function ColorPickerLib:GetValue()
			return Config.Default;
		end;

		function ColorPickerLib:SetValue(v)
			Config.Default = v;

			BackendM:SetValue(Config.Default);

			ColorPicker.BackgroundColor3 = BackendM:GetColor();
		end;

		function ColorPickerLib:GetAnimations()
			return BackendM:GetAnimations();
		end;

		function ColorPickerLib:SetAnimations(v)
			BackendM:SetAnimations(v);
		end;

		function ColorPickerLib:GetAlpha()
			return BackendM.Alpha;
		end;

		if Config.AnimationFlag then
			NeverLose.Flags[Config.AnimationFlag] = {
				GetValue = function()
					return BackendM:GetAnimations();
				end,
				SetValue = function(_ , value)
					BackendM:SetAnimations(value);
				end
			};
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ColorPickerLib;
		end;

		return ColorPickerLib;
	end;

	function handle:AddKeybind(Config)
		Config = NeverLose:ProcessParams(Config,{
			Default = nil,
			Blacklist = {},
			Callback = EmptyFunction,
			Flag = nil,
			Mode = nil,
			Name = nil,
			List = false,
			Trigger = nil
		});

		local ListEntry = nil;
		local IsBinding = false;
		local BindingConnection;
		local CapturedMouseButton;
		local ModeMenu;
		local ModeShield;
		local ShieldPress = {};
		local ModeButtons = {};
		local FollowConnection;
		local KeybindLib = {};

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextLabel")

		Keybind.Name = NeverLose.RandomString();
		Keybind.Parent = Handler
		NeverLose:BindTheme(Keybind, 'BackgroundColor3', 'Control');
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.ClipsDescendants = true
		Keybind.Size = UDim2.new(0, 45, 0, 22)
		Keybind.ZIndex = ZINdex + 13
		Keybind.LayoutOrder = -(#Handler:GetChildren() + 5);

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = Keybind

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = Keybind

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = Keybind
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.ClipsDescendants = true
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		NeverLose:RegisterFont(ValueLabel, Enum.Font.GothamMedium);
		ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or "None")
		NeverLose:BindTheme(ValueLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(ValueLabel, 10.000);
		ValueLabel.TextTransparency = 0.500

		KeybindLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 1
				})
			end;
		end);

		function KeybindLib:Update()
			local size = NeverLose:MeasureText(ValueLabel.Text, ValueLabel.TextSize, ValueLabel.FontFace,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(Keybind , SlowyTween , {
				Size = UDim2.new(0, size.X + 7, 0, 22)
			})
		end;

		local IsBlacklist = LPH_NO_VIRTUALIZE(function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end);

		NeverLose:BindTypography(function() if Keybind.Parent then KeybindLib:Update(); end; end);
		KeybindLib:Update()

		KeybindLib.SetRender(Signal:GetValue());
		Signal:Connect(KeybindLib.SetRender);

		local ListName = Config.Name or (self.Label and self.Label.Text) or 'Keybind';

		local EnsureListEntry = LPH_NO_VIRTUALIZE(function()
			if not ListEntry then
				ListEntry = NeverLose:GetKeybindList():Register({
					Name = ListName,
					Mode = Config.Mode or 'Always',
					Key = Config.Default,
					Trigger = Config.Trigger
				});
			end;

			return ListEntry;
		end);

		if Config.List or Config.Mode then
			EnsureListEntry();
		end;

		local CanInteract = LPH_NO_VIRTUALIZE(function()
			if not Signal:GetValue() then
				return false;
			end;

			local ancestor = Keybind;
			while ancestor do
				if ancestor:IsA('GuiObject') and not ancestor.Visible then
					return false;
				end;
				if ancestor:IsA('LayerCollector') then
					return ancestor.Enabled;
				end;
				ancestor = ancestor.Parent;
			end;

			return false;
		end);

		local CloseModeMenu = LPH_NO_VIRTUALIZE(function()
			if FollowConnection then
				FollowConnection:Disconnect();
				FollowConnection = nil;
			end;

			if ModeMenu then ModeMenu.Visible = false; end;
			if ModeShield then ModeShield.Visible = false; end;
			table.clear(ShieldPress);

			if NeverLose.__CloseKeybindMenu == KeybindLib.CloseMenu then
				NeverLose.__CloseKeybindMenu = nil;
				NeverLose.__ModeMenuRoot = nil;
			end;
		end);

		KeybindLib.CloseMenu = CloseModeMenu;

		local RefreshModes = LPH_NO_VIRTUALIZE(function()
			local mode = ListEntry and ListEntry:GetMode() or Config.Mode or 'Always';

			for name,button in pairs(ModeButtons) do
				local selected = name == mode;
				button.BackgroundTransparency = selected and 0.850 or 1;
				button.BackgroundColor3 = NeverLose.AccentColor;
				button.TextColor3 = selected and NeverLose.AccentColor or NeverLose.Theme.MutedText;
			end;
		end);

		function KeybindLib:GetMode()
			return ListEntry and ListEntry:GetMode() or Config.Mode or 'Always';
		end;

		function KeybindLib:SetMode(mode)
			local normalized;
			for _,name in ipairs(NeverLose.KeybindModes) do
				if string.lower(tostring(mode)) == string.lower(name) then
					normalized = name;
					break;
				end;
			end;

			if not normalized then
				return KeybindLib;
			end;

			Config.Mode = normalized;
			EnsureListEntry():SetMode(normalized);
			RefreshModes();

			return KeybindLib;
		end;

		function KeybindLib:GetState()
			if KeybindLib:GetMode() == 'Always' then
				return Config.Default ~= nil and Config.Default ~= 'None';
			end;

			return ListEntry and ListEntry.Active or false;
		end;

		local CancelBinding = LPH_NO_VIRTUALIZE(function()
			if BindingConnection then
				BindingConnection:Disconnect();
				BindingConnection = nil;
			end;

			if IsBinding then
				IsBinding = false;
				ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or 'None');
				KeybindLib:Update();
			end;

			if NeverLose.__BindingKeybind == KeybindLib then
				NeverLose.__BindingKeybind = nil;
			end;
		end);

		KeybindLib.CancelBinding = CancelBinding;

		local PositionModeMenu = LPH_NO_VIRTUALIZE(function()
			if not ModeMenu or not ModeMenu.Parent or not CanInteract() then
				CloseModeMenu();
				return;
			end;

			local root = ModeMenu.Parent;
			local viewport = root:IsA('SurfaceGui') and root.CanvasSize or root.AbsoluteSize;
			local origin = root:IsA('ScreenGui') and root.AbsolutePosition or Vector2.zero;
			local position = Keybind.AbsolutePosition - origin;
			local width = ModeMenu.Size.X.Offset;
			local height = ModeMenu.Size.Y.Offset;
			local x = position.X + Keybind.AbsoluteSize.X - width;
			local y = position.Y + Keybind.AbsoluteSize.Y + 5;

			if y + height > viewport.Y - 4 then
				y = position.Y - height - 5;
			end;

			ModeMenu.Position = UDim2.fromOffset(
				math.clamp(x , 4 , math.max(4 , viewport.X - width - 4)),
				math.clamp(y , 4 , math.max(4 , viewport.Y - height - 4))
			);
		end);

		local OpenModeMenu = LPH_NO_VIRTUALIZE(function()
			if CapturedMouseButton == Enum.UserInputType.MouseButton2 then
				CapturedMouseButton = nil;
				return;
			end;

			if IsBinding or not CanInteract() then
				return;
			end;

			if ModeMenu and ModeMenu.Visible then
				CloseModeMenu();
				return;
			end;

			if NeverLose.__CloseKeybindMenu then
				NeverLose.__CloseKeybindMenu();
			end;

			local root = Keybind:FindFirstAncestorWhichIsA('LayerCollector');
			if not root then
				return;
			end;

			if not ModeMenu then
				ModeMenu = Instance.new('Frame');
				ModeMenu.Name = NeverLose.RandomString();
				NeverLose:BindTheme(ModeMenu, 'BackgroundColor3', 'Section');
				ModeMenu.BackgroundTransparency = 0.035;
				ModeMenu.BorderSizePixel = 0;
				ModeMenu.Size = UDim2.fromOffset(148 , #NeverLose.KeybindModes * 30 + 8);
				ModeMenu.ZIndex = 2000000;
				ModeMenu.Active = true;
				ModeMenu.Visible = false;
				ModeMenu.ClipsDescendants = true;

				local corner = Instance.new('UICorner');
				NeverLose:BindCorner(corner, 'Panel');
				corner.Parent = ModeMenu;

				local stroke = Instance.new('UIStroke');
				NeverLose:BindTheme(stroke, 'Color', 'Border');
				stroke.Transparency = 0.350;
				stroke.Parent = ModeMenu;

				for index,name in ipairs(NeverLose.KeybindModes) do
					local button = Instance.new('TextButton');
					button.Name = name;
					button.BackgroundTransparency = 1;
					button.BorderSizePixel = 0;
					button.AutoButtonColor = false;
					button.Position = UDim2.fromOffset(4 , 4 + (index - 1) * 30);
					button.Size = UDim2.new(1, -8, 0, 30);
					NeverLose:RegisterFont(button, Enum.Font.GothamMedium);
					NeverLose:SetTextSize(button, 13);
					button.Text = name;
					button.ZIndex = 2000001;
					button.Parent = ModeMenu;

					local buttonCorner = Instance.new('UICorner');
					NeverLose:BindCorner(buttonCorner, 'Control');
					buttonCorner.Parent = button;
					ModeButtons[name] = button;

					NeverLose:AddSignal(button.MouseButton1Click:Connect(LPH_NO_VIRTUALIZE(function()
						KeybindLib:SetMode(name);
						RefreshModes();
					end)));
				end;
			end;

			if not ModeShield then
				ModeShield = Instance.new('TextButton');
				ModeShield.Name = 'KeybindOutsideClick';
				ModeShield.Text = ''; ModeShield.BackgroundTransparency = 1; ModeShield.BorderSizePixel = 0;
				ModeShield.Size = UDim2.fromScale(1,1); ModeShield.Position = UDim2.fromOffset(0,0);
				ModeShield.ZIndex = 1999999; ModeShield.AutoButtonColor = false; ModeShield.Active = true;
				NeverLose:AddSignal(ModeShield.InputBegan:Connect(function(input)
					ShieldPress[input.UserInputType] = true;
				end));
				NeverLose:AddSignal(ModeShield.MouseButton1Click:Connect(function()
					if ShieldPress[Enum.UserInputType.MouseButton1] or ShieldPress[Enum.UserInputType.Touch] then CloseModeMenu(); end;
				end));
				NeverLose:AddSignal(ModeShield.MouseButton2Click:Connect(function()
					if ShieldPress[Enum.UserInputType.MouseButton2] then CloseModeMenu(); end;
				end));
			end;
			table.clear(ShieldPress);
			ModeShield.Parent = root; ModeShield.Visible = true;
			ModeMenu.Parent = root;
			ModeMenu.Visible = true;
			NeverLose:AnimatePopup(ModeMenu);
			NeverLose.__CloseKeybindMenu = CloseModeMenu;
			NeverLose.__ModeMenuRoot = ModeMenu;
			RefreshModes();
			PositionModeMenu();
			FollowConnection = RunService.RenderStepped:Connect(PositionModeMenu);
		end);

		local KeybindButton,ClickConnection = NeverLose:CreateInput(Keybind , LPH_NO_VIRTUALIZE(function()
			if CapturedMouseButton == Enum.UserInputType.MouseButton1 then
				CapturedMouseButton = nil;
				return;
			end;

			if IsBinding or not CanInteract() then
				return;
			end;

			CloseModeMenu();
			if NeverLose.__BindingKeybind then
				NeverLose.__BindingKeybind.CancelBinding();
			end;

			IsBinding = true;
			NeverLose.__BindingKeybind = KeybindLib;
			ValueLabel.Text = '...';
			KeybindLib:Update();

			BindingConnection = UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(input)
				if input.KeyCode == Enum.KeyCode.Escape then
					CancelBinding();
					return;
				end;

				local selected;
				if input.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(input.KeyCode) and not IsBlacklist(input.KeyCode.Name) then
					selected = input.KeyCode.Name;
				elseif input.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist('M1B') then
					selected = 'M1B';
				elseif input.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist('M2B') then
					selected = 'M2B';
				end;

				if not selected then
					return;
				end;

				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
					CapturedMouseButton = input.UserInputType;
				end;

				CancelBinding();
				Config.Default = selected;
				ValueLabel.Text = NeverLose:KeyCodeToStr(selected);
				KeybindLib:Update();

				if ListEntry then
					ListEntry:SetKey(selected);
				end;

				Config.Callback(selected);
			end));
		end));

		NeverLose:AddSignal(ClickConnection);
		NeverLose:AddSignal(KeybindButton.MouseButton2Click:Connect(OpenModeMenu));
		NeverLose:BindAccentHook(RefreshModes);
		NeverLose:BindThemeHook(RefreshModes);

		NeverLose:AddSignal(UserInputService.InputBegan:Connect(function(input)
			if not IsBinding then CapturedMouseButton = nil; end;
			if ModeMenu and ModeMenu.Visible and input.KeyCode == Enum.KeyCode.Escape then CloseModeMenu(); end;
		end));

		Signal:Connect(LPH_NO_VIRTUALIZE(function(value)
			if not value then
				CloseModeMenu();
				CancelBinding();
			end;
		end));

		NeverLose:AddSignal(Keybind.Destroying:Connect(LPH_NO_VIRTUALIZE(function()
			CloseModeMenu();
			CancelBinding();
			if ModeMenu then
				ModeMenu:Destroy();
				ModeMenu = nil;
			end;
			if ModeShield then ModeShield:Destroy(); ModeShield = nil; end;
		end)));

		function KeybindLib:GetValue()
			return Config.Default;
		end;

		function KeybindLib:SetValue(v)
			CancelBinding();
			Config.Default = typeof(v) == 'EnumItem' and v.Name or v;
			ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or 'None');
			KeybindLib:Update();
			Config.Callback(Config.Default);

			if ListEntry then
				ListEntry:SetKey(Config.Default);
			end;
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = KeybindLib;
		end;

		return KeybindLib;
	end;

	function handle:AddTextInput(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = "",
			Placeholder = "Placeholder",
			Callback = print,
			Flag = nil,
			Size = 100,
			Numeric = false,
		});

		local TextBoxLib = {};

		local TextInput = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = Handler
		NeverLose:BindTheme(TextInput, 'BackgroundColor3', 'Control');
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, Config.Size, 0, 22)
		TextInput.ZIndex = ZINdex + 13
		TextInput.LayoutOrder = -(#Handler:GetChildren() + 5);

		TextInput:SetAttribute('BaseWidth' , Config.Size);
		TextInput:SetAttribute('MinWidth' , math.min(Config.Size , 50));

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = TextInput

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = ZINdex + 14
		TextBox.ClearTextOnFocus = false
		NeverLose:RegisterFont(TextBox, Enum.Font.GothamMedium);
		TextBox.PlaceholderText = Config.Placeholder
		TextBox.Text = tostring(Config.Default)
		NeverLose:BindTheme(TextBox, 'TextColor3', 'Text');
		NeverLose:SetTextSize(TextBox, 11.000);
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		TextBoxLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 0
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 0.650
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 0.350
				})	
			else
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 1
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 1
				})
			end;
		end);

		NeverLose:AddSignal(TextBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			local valout = NeverLose:ParseInput(TextBox.Text , Config.Numeric);

			if Config.Numeric then
				TextBox.Text = string.gsub(TextBox.Text , '[^0-9.]','')
			end;

			if valout then
				Config.Default = valout;
				Config.Callback(valout);
			end
		end)));

		TextBoxLib.SetRender(Signal:GetValue());
		Signal:Connect(TextBoxLib.SetRender);

		function TextBoxLib:GetValue()
			return Config.Default;
		end;

		function TextBoxLib:SetValue(v)
			Config.Default = v;
			TextBox.Text = tostring(v);
			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = TextBoxLib;
		end;

		return TextBoxLib;
	end;

	function handle:AddDropdown(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = nil,
			Values = {},
			Multi = false,
			Callback = EmptyFunction,
			AutoUpdate = true,
			Flag = nil,
			Size = 100
		})

		Config.Default = NeverLose.ProcessDropdown(Config.Default);

		local Dropdown = Instance.new("Frame")
		local DropdownIcon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local BasedLabel = Instance.new("TextLabel")

		Dropdown.Name = NeverLose.RandomString();
		Dropdown.Parent = Handler
		NeverLose:BindTheme(Dropdown, 'BackgroundColor3', 'Control');
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.ClipsDescendants = true
		Dropdown.Size = UDim2.new(0, Config.Size, 0, 22)
		Dropdown.ZIndex = ZINdex + 13
		Dropdown.LayoutOrder = -(#Handler:GetChildren() + 5);

		Dropdown:SetAttribute('BaseWidth' , Config.Size);
		Dropdown:SetAttribute('MinWidth' , math.min(Config.Size , 58));

		DropdownIcon.Name = NeverLose.RandomString();
		DropdownIcon.Parent = Dropdown
		DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
		DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownIcon.BackgroundTransparency = 1.000
		DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownIcon.BorderSizePixel = 0
		DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
		DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
		DropdownIcon.ZIndex = ZINdex + 14
		DropdownIcon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(DropdownIcon, 'TextColor3', 'Icon');
		DropdownIcon.Text = "chevron-small-down"
		NeverLose:BindTheme(DropdownIcon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(DropdownIcon, 16.000);
		DropdownIcon.TextTransparency = 0.250
		DropdownIcon.TextWrapped = true

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = Dropdown

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = Dropdown

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = Dropdown
		BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.ClipsDescendants = true
		BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
		BasedLabel.Size = UDim2.new(1, -25, 0, 22)
		BasedLabel.ZIndex = ZINdex + 14
		NeverLose:RegisterFont(BasedLabel, Enum.Font.GothamMedium);
		BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);
		NeverLose:BindTheme(BasedLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(BasedLabel, 12.000);
		BasedLabel.TextTransparency = 0.5
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		do
			local UIGradient = Instance.new("UIGradient")

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.23), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = BasedLabel;
		end;

		NeverLose:AddSignal(Dropdown.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.200
			})
		end)));

		NeverLose:AddSignal(Dropdown.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.5
			})
		end)));

		local DropdownLib = {
			OpenSignal = NeverLose:CreateSignal(false),
			Signals = {},
			Refuse = {},
		};

		DropdownLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 0.250
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.5
				});
			else
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});
			end
		end);

		DropdownLib.SetRender(Signal:GetValue())
		Signal:Connect(DropdownLib.SetRender);
		DropdownLib.ExtentSize = 0;

		do
			local DropdownHandler = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local DropdownScrollFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Shadow = NeverLose:CreateShadow(DropdownHandler);

			DropdownHandler.Name = NeverLose.RandomString();
			DropdownHandler.Parent = NeverLose.ScreenGui;
			NeverLose:ElevatePopup(DropdownHandler);
			DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
			NeverLose:BindTheme(DropdownHandler, 'BackgroundColor3', 'Section');
			DropdownHandler.BackgroundTransparency = 0.5
			DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownHandler.BorderSizePixel = 0
			DropdownHandler.ClipsDescendants = true
			DropdownHandler.Position = UDim2.new(255,255,255,255)
			DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
			DropdownHandler.ZIndex = ZINdex + 125
			DropdownLib.BlockRoot = DropdownHandler;

			NeverLose:AddSignal(DropdownHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if DropdownHandler.BackgroundTransparency > 0.9 then
					DropdownHandler.Visible = false;
					DropdownHandler.Parent = nil;
				else
					DropdownHandler.Visible = true;

					if NeverLose.Global3DRenderMode then
						DropdownHandler.Parent = NeverLose.GlobalSurfaceGui;
						NeverLose:ElevatePopup(DropdownHandler);
					else
						DropdownHandler.Parent = NeverLose.ScreenGui;
						NeverLose:ElevatePopup(DropdownHandler);
					end;
				end;
			end));

			NeverLose:BindCorner(UICorner, 'Panel');
			UICorner.Parent = DropdownHandler

			UIStroke.Transparency = 0.650
			NeverLose:BindTheme(UIStroke, 'Color', 'Border');
			UIStroke.Parent = DropdownHandler

			DropdownScrollFrame.Name = NeverLose.RandomString();
			DropdownScrollFrame.Parent = DropdownHandler
			DropdownScrollFrame.Active = true
			DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownScrollFrame.BackgroundTransparency = 1.000
			DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownScrollFrame.BorderSizePixel = 0
			DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
			DropdownScrollFrame.ZIndex = ZINdex + 127
			DropdownScrollFrame.ScrollBarThickness = 0

			DropdownLib.RootItem = DropdownScrollFrame;

			UIListLayout.Parent = DropdownScrollFrame
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
				NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
					Size = UDim2.new(0, math.min(math.max(Dropdown.AbsoluteSize.X + 5, DropdownLib.ExtentSize + 40), NeverLose.ScreenGui.AbsoluteSize.X - 16), 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));
				})
			end)));

			local SetPosition = LPH_NO_VIRTUALIZE(function() NeverLose:PlacePopup(DropdownHandler,Dropdown); end);

			DropdownLib.SetFrameRender = LPH_NO_VIRTUALIZE(function(value)
				NeverLose:SetPopupOpen(DropdownHandler,value);
				DropdownLib.OpenSignal:SetValue(value);

				if value then
					Shadow:Render(true);

					DropdownHandler.Size = UDim2.new(0, math.min(math.max(Dropdown.AbsoluteSize.X + 5, DropdownLib.ExtentSize + 40), NeverLose.ScreenGui.AbsoluteSize.X - 16), 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));

					SetPosition();

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 0
					})

					if Config.AutoUpdate then
						DropdownLib:Generate();
					end;
				else

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 1
					})

					Shadow:Render(false);
				end;
			end);

			NeverLose:RegisterPopup(DropdownHandler,Dropdown,function() DropdownLib.SetFrameRender(false); end);
			DropdownLib.SetFrameRender(false);
		end;
		Signal:Connect(function(value) if not value then DropdownLib.SetFrameRender(false); end; end);

		NeverLose:CreateInput(Dropdown , LPH_NO_VIRTUALIZE(function() DropdownLib.SetFrameRender(true); end));

		DropdownLib.IsMatch = LPH_NO_VIRTUALIZE(function(v1)
			if typeof(Config.Default) =='table' then
				if Config.Default[v1] or table.find(Config.Default , v1) then
					return true;
				end
			end

			if Config.Default == v1 then
				return true;
			end;
		end);

		function DropdownLib:Generate()
			DropdownLib.ExtentSize = 0;
			for i,v in next , DropdownLib.RootItem:GetChildren() do
				if v:IsA('Frame') then
					v:Destroy();
				end;
			end;

			for i,v in next , DropdownLib.Signals do
				v:Disconnect();
			end;

			table.clear(DropdownLib.Signals);
			table.clear(DropdownLib.Refuse);

			local Lastone;
			for i,Value in next , Config.Values do
				local ItemFrame = Instance.new("Frame")
				local ItemLabel = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				ItemFrame.Name = NeverLose.RandomString();
				ItemFrame.Parent = DropdownLib.RootItem
				NeverLose:BindTheme(ItemFrame, 'BackgroundColor3', 'Hover');
				ItemFrame.BackgroundTransparency = 1.000
				ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 28)
				ItemFrame.ZIndex = ZINdex + 1258

				ItemLabel.Name = NeverLose.RandomString();
				ItemLabel.Parent = ItemFrame
				ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.BackgroundTransparency = 1.000
				ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemLabel.BorderSizePixel = 0
				ItemLabel.Position = UDim2.new(0, 15, 0, 4)
				ItemLabel.Size = UDim2.new(1, -30, 0, 22)
				ItemLabel.TextTruncate = Enum.TextTruncate.AtEnd
				ItemLabel.ZIndex = ZINdex + 1258
				NeverLose:RegisterFont(ItemLabel, Enum.Font.GothamMedium);
				ItemLabel.Text = tostring(Value);
				NeverLose:BindTheme(ItemLabel, 'TextColor3', 'Text');
				NeverLose:SetTextSize(ItemLabel, 13.000);
				ItemLabel.TextTransparency = 0.200
				ItemLabel.TextXAlignment = Enum.TextXAlignment.Left

				NeverLose:BindCorner(UICorner, 'Panel');
				UICorner.Parent = ItemFrame
				local sizetext = NeverLose:MeasureText(ItemLabel.Text, ItemLabel.TextSize, ItemLabel.FontFace,Vector2.new(math.huge,math.huge));

				DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize , sizetext.X);

				local MIcon , MarkItem , MBar = nil , nil , nil;

				if Config.Multi then
					local Icon = Instance.new("TextLabel")

					Icon.Parent = ItemFrame;
					Icon.AnchorPoint = Vector2.new(0, 0.5)
					Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Icon.BorderSizePixel = 0
					Icon.Position = UDim2.new(0, 5, 0.5, 0)
					Icon.Size = UDim2.new(0, 20, 0, 20)
					Icon.ZIndex = ZINdex + 1259
					Icon.FontFace = NeverLose.BuiltInBold;
					NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
					Icon.Text = "check"
					NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
					NeverLose:SetTextSize(Icon, 18.000);
					Icon.TextTransparency = 1
					Icon.TextWrapped = true;

					local VisiblewOfMult = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.200,
								Position = UDim2.new(0, 30, 0, 4)
							})

							NeverLose.PlayAnimate(Icon , vs , {
								TextTransparency = 0.250
							})

							Lastone = ItemLabel;
						else

							NeverLose.PlayAnimate(Icon , SlowyTween , {
								TextTransparency = 1
							})

							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.5,
								Position = UDim2.new(0, 15, 0, 4)
							})
						end;
					end);

					MIcon = Icon;
					MarkItem = VisiblewOfMult;
				else
					local Bar = Instance.new("Frame")
					local BarCorner = Instance.new("UICorner")

					Bar.Name = NeverLose.RandomString();
					Bar.Parent = ItemFrame;
					Bar.AnchorPoint = Vector2.new(0, 0.5)
					NeverLose:BindAccent(Bar , 'BackgroundColor3');
					Bar.BackgroundTransparency = 1.000
					Bar.BorderSizePixel = 0
					Bar.Position = UDim2.new(0, 6, 0.5, 0)
					Bar.Size = UDim2.new(0, 2, 0, 12)
					Bar.ZIndex = ZINdex + 1259

					BarCorner.CornerRadius = UDim.new(1, 0)
					BarCorner.Parent = Bar

					MBar = Bar;

					local DefaultVisible = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.200
							})

							NeverLose.PlayAnimate(Bar , SlowyTween , {
								BackgroundTransparency = 0
							})

							Lastone = ItemLabel;
						else
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.5
							})

							NeverLose.PlayAnimate(Bar , SlowyTween , {
								BackgroundTransparency = 1
							})
						end;
					end);

					MarkItem = DefaultVisible;
				end;

				MarkItem();

				table.insert(DropdownLib.Refuse , MarkItem)

				table.insert(DropdownLib.Signals,ItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 0.1
					})
				end)));

				table.insert(DropdownLib.Signals,ItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 1
					})
				end)));

				table.insert(DropdownLib.Signals , DropdownLib.OpenSignal:Connect(LPH_NO_VIRTUALIZE(function(val)
					if val then
						MarkItem();
					else
						NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
							TextTransparency = 1
						})

						if MIcon then
							NeverLose.PlayAnimate(MIcon , SlowyTween , {
								TextTransparency = 1
							})
						end;

						if MBar then
							NeverLose.PlayAnimate(MBar , SlowyTween , {
								BackgroundTransparency = 1
							})
						end;
					end;
				end)));

				if Config.Multi then
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default[Value] = not Config.Default[Value];

						MarkItem();

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				else
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default = Value;

						for i,v in next , DropdownLib.Refuse do
							task.spawn(v);
						end;

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				end;
			end;
		end;

		DropdownLib:Generate();

		function DropdownLib:GetValue()
			return Config.Default;
		end;

		function DropdownLib:SetValue(v)
			Config.Default = v;

			BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

			for i,v in next , DropdownLib.Refuse do
				task.spawn(v);
			end;

			Config.Callback(Config.Default);
		end;

		function DropdownLib:SetValues(a)
			Config.Values = a;

			if not Config.AutoUpdate then
				DropdownLib:Generate();
			end;
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = DropdownLib;
		end;

		return DropdownLib;
	end;

	return handle;
end;

NeverLose.ProcessDropdown = LPH_NO_VIRTUALIZE(function(value)
	if typeof(value) == 'table' then
		local data = {};

		for i,v in next , value do
			if typeof(v) == 'boolean' and typeof(i) ~= 'number' then
				data[i] = v;
			else
				data[v] = true;
			end;
		end;

		return data;
	else
		return value;
	end;
end);

NeverLose.ParseDropdown = LPH_NO_VIRTUALIZE(function(value)
	if not value then return 'Select'; end;

	local Out;

	if typeof(value) == 'table' then
		if #value > 0 then
			local x = {};

			for i,v in next , value do
				table.insert(x , tostring(v))
			end;

			Out = table.concat(x,' , ');

			table.clear(x);
		else
			local x = {};

			for i,v in next , value do
				if v == true then
					table.insert(x , tostring(i));
				end			
			end;

			Out = table.concat(x,' , ');

			table.clear(x)

			if not Out:byte() then
				Out = 'Select';
			end
		end;
	else
		Out = tostring(value or 'Select');
	end;

	return Out;
end);

function NeverLose:ParseInput(Value , Numeric)
	if not Value then
		return (Numeric and nil) or "";	
	end;

	if Numeric then
		local out = string.gsub(tostring(Value), '[^0-9.%-]', '')

		if tonumber(out) then
			return tonumber(out);
		end;

		return nil;
	end;

	return Value;
end;

function NeverLose:CreateToolTips(Container: Frame , Name: string , Content: string)
	local Tooltips = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local TooltipName = Instance.new("TextLabel")
	local TooltipContent = Instance.new("TextLabel")
	local Shadow = NeverLose:CreateShadow(Tooltips);

	Tooltips.Name = NeverLose.RandomString();
	NeverLose:BindTheme(Tooltips, 'BackgroundColor3', 'Section');
	Tooltips.BackgroundTransparency = 0.075
	Tooltips.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tooltips.BorderSizePixel = 0
	Tooltips.ClipsDescendants = true
	Tooltips.Position = UDim2.new(255,255,255,255)
	Tooltips.Size = UDim2.new(0,0,0,0)
	Tooltips.ZIndex = 130

	NeverLose:BindCorner(UICorner, 'Panel');
	UICorner.Parent = Tooltips

	UIStroke.Transparency = 0.650
	NeverLose:BindTheme(UIStroke, 'Color', 'Border');
	UIStroke.Parent = Tooltips

	TooltipName.Name = NeverLose.RandomString();
	TooltipName.Parent = Tooltips
	TooltipName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.BackgroundTransparency = 1.000
	TooltipName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipName.BorderSizePixel = 0
	TooltipName.Position = UDim2.new(0, 15, 0, 5)
	TooltipName.Size = UDim2.new(0, 1, 0, 20)
	TooltipName.ZIndex = 132
	NeverLose:RegisterFont(TooltipName, Enum.Font.GothamBold);
	TooltipName.Text = Name
	NeverLose:BindTheme(TooltipName, 'TextColor3', 'Text');
	NeverLose:SetTextSize(TooltipName, 15.000);
	TooltipName.TextXAlignment = Enum.TextXAlignment.Left

	TooltipContent.Name = NeverLose.RandomString();
	TooltipContent.Parent = Tooltips
	TooltipContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.BackgroundTransparency = 1.000
	TooltipContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipContent.BorderSizePixel = 0
	TooltipContent.Position = UDim2.new(0, 15, 0, 30)
	TooltipContent.Size = UDim2.new(0, 1, 0, 15)
	TooltipContent.ZIndex = 132
	NeverLose:RegisterFont(TooltipContent, Enum.Font.GothamBold);
	TooltipContent.Text = Content
	NeverLose:BindTheme(TooltipContent, 'TextColor3', 'Text');
	NeverLose:SetTextSize(TooltipContent, 12.000);
	TooltipContent.TextTransparency = 0.650
	TooltipContent.TextXAlignment = Enum.TextXAlignment.Left
	TooltipContent.TextYAlignment = Enum.TextYAlignment.Top

	local ToolTip = {};

	ToolTip.Update = LPH_NO_VIRTUALIZE(function()
		local SizeName = NeverLose:MeasureText(TooltipName.Text, TooltipName.TextSize, TooltipName.FontFace, Vector2.new(math.huge,math.huge));
		local SizeContent = NeverLose:MeasureText(TooltipContent.Text, TooltipContent.TextSize, TooltipContent.FontFace, Vector2.new(math.huge,math.huge));

		local MaxX = math.max(SizeName.X , SizeContent.X) + 65;
		local MaxY = SizeName.Y + SizeContent.Y + 30;

		NeverLose.PlayAnimate(Tooltips,SlowyTween , {
			Size = UDim2.new(0,MaxX,0,MaxY)
		})
	end)

	NeverLose:AddSignal(Tooltips:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if Tooltips.BackgroundTransparency > 0.9 then
			Tooltips.Visible = false;
			Tooltips.Parent = nil;
		else
			Tooltips.Visible = true;

			if NeverLose.Global3DRenderMode then
				Tooltips.Parent = NeverLose.GlobalSurfaceGui;
				NeverLose:ElevatePopup(Tooltips);
			else
				Tooltips.Parent = NeverLose.ScreenGui;
				NeverLose:ElevatePopup(Tooltips);
			end;
		end
	end)));

	ToolTip.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			Tooltips.Position = UDim2.fromOffset(Container.AbsolutePosition.X + Container.AbsoluteSize.X , Container.AbsolutePosition.Y + (Container.AbsoluteSize.Y + 25));

			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 0.075
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 0.650
			})

			ToolTip.Update();
			Shadow:Render(true);
		else
			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 1
			})

			Shadow:Render(false);
		end;
	end);

	ToolTip.SetRender(false);
	ToolTip.Update();

	local DelayThread;
	NeverLose:AddSignal(Container.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		DelayThread = task.delay(1,ToolTip.SetRender,true);
	end)));

	NeverLose:AddSignal(Container.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		ToolTip.SetRender(false);
		ToolTip.Update();
	end)))

	return ToolTip;
end;

function NeverLose:RegisiterItem(Frame: Frame , Signel)
	local idx = {};
	local LayerIndex = NeverLose:GetLocalZIndex(Frame);

	function idx:AddLabel(Name: string,Warp: boolean)
		local BasedFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local UICorner = Instance.new("UICorner")

		BasedFrame.Name = NeverLose.RandomString();
		BasedFrame.Parent = Frame
		NeverLose:BindTheme(BasedFrame, 'BackgroundColor3', 'Hover');
		BasedFrame.BackgroundTransparency = 1.000
		BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedFrame.BorderSizePixel = 0
		BasedFrame.Size = UDim2.new(1, 0, 0, 32)
		BasedFrame.ZIndex = LayerIndex + 8

		NeverLose:AddQuery(BasedFrame , Name);

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = BasedFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
		BasedLabel.Position = UDim2.new(0, 11, 0.5, 0)
		BasedLabel.Size = UDim2.new(0, 1, 0, 22)
		BasedLabel.ZIndex = LayerIndex + 9
		NeverLose:RegisterFont(BasedLabel, Enum.Font.GothamMedium);
		BasedLabel.Text = Name
		NeverLose:BindTheme(BasedLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(BasedLabel, 13.000);
		BasedLabel.TextTransparency = 0.15
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = BasedFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = BasedFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0.5)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0.5, 0)
		BasedHandler.Size = UDim2.new(1, -20, 0, 30)
		BasedHandler.ZIndex = LayerIndex + 12

		UIListLayout.Parent = BasedHandler
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 5)

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = BasedFrame

		local UpdateRowLine = LPH_NO_VIRTUALIZE(function()
			local Last = nil;

			for _,Child in next , Frame:GetChildren() do
				if Child:IsA('GuiObject') and Child.Visible then
					Last = Child;
				end;
			end;

			LineFrame.Visible = Last ~= BasedFrame;
		end);

		NeverLose:AddSignal(Frame.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		NeverLose:AddSignal(Frame.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		local RowLayout = Frame:FindFirstChildWhichIsA('UIListLayout');

		if RowLayout then
			NeverLose:AddSignal(RowLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				task.defer(UpdateRowLine);
			end)));
		end;

		task.defer(UpdateRowLine);

		BasedLabel.TextTruncate = Enum.TextTruncate.AtEnd;

		local Fitting = false;

		local FitRow = LPH_NO_VIRTUALIZE(function()
			if Warp or Fitting then
				return;
			end;

			Fitting = true;

			local Available = BasedHandler.AbsoluteSize.X;

			if Available <= 0 then
				Available = BasedFrame.AbsoluteSize.X - 22;
			end;

			if Available > 0 then
				local TextWidth = NeverLose:MeasureText(BasedLabel.Text, BasedLabel.TextSize, BasedLabel.FontFace, Vector2.new(math.huge , math.huge)).X;
				local Resizable = {};
				local Total = 0;
				local Count = 0;

				for _,child in next , BasedHandler:GetChildren() do
					if child:IsA('GuiObject') and child.Visible then
						local base = child:GetAttribute('BaseWidth') or child.Size.X.Offset;

						Total = Total + base;
						Count = Count + 1;

						if child:GetAttribute('MinWidth') then
							table.insert(Resizable , child);
						end;
					end;
				end;

				if Count > 1 then
					Total = Total + ((Count - 1) * 5);
				end;

				local BadgeWidth = BasedLabel:GetAttribute('RowBadgeWidth') or 0;
				local Overflow = Total - (Available - TextWidth - BadgeWidth - 10);
				local Slack = 0;

				if Overflow < 0 then
					local Growable = 0;

					for _,child in next , Resizable do
						if child:GetAttribute('Flexible') then
							Growable = Growable + 1;
						end;
					end;

					if Growable > 0 then
						Slack = math.floor(math.abs(Overflow) / Growable);
					end;
				end;

				for _,child in next , Resizable do
					local base = child:GetAttribute('BaseWidth') or child.Size.X.Offset;
					local minimal = child:GetAttribute('MinWidth') or base;
					local width = base;

					if Overflow > 0 then
						local shrink = math.min(Overflow , math.max(base - minimal , 0));

						if shrink > 0 then
							width = base - shrink;
							Overflow = Overflow - shrink;
							Total = Total - shrink;
						end;
					elseif Slack >= 2 and child:GetAttribute('Flexible') then
						width = base + Slack;
						Total = Total + Slack;
					end;

					if math.abs(child.Size.X.Offset - width) >= 1 then
						child.Size = UDim2.new(0 , width , child.Size.Y.Scale , child.Size.Y.Offset);
					end;
				end;

				local LabelWidth = math.max(Available - Total - BadgeWidth - 10 , 10);

				if TextWidth < LabelWidth then
					LabelWidth = TextWidth;
				end;

				if math.abs(BasedLabel.Size.X.Offset - LabelWidth) >= 1 then
					BasedLabel.Size = UDim2.new(0 , LabelWidth , 0 , 22);
				end;
			end;

			Fitting = false;
		end);

		NeverLose:AddSignal(BasedLabel:GetAttributeChangedSignal('RowBadgeWidth'):Connect(FitRow));
		NeverLose:AddSignal(BasedLabel:GetPropertyChangedSignal('Text'):Connect(FitRow));
		NeverLose:AddSignal(BasedLabel:GetPropertyChangedSignal('TextSize'):Connect(FitRow));
		NeverLose:AddSignal(BasedLabel:GetPropertyChangedSignal('FontFace'):Connect(FitRow));
		NeverLose:BindTypography(FitRow);
		NeverLose:AddSignal(BasedHandler:GetPropertyChangedSignal('AbsoluteSize'):Connect(FitRow));
		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(FitRow));

		NeverLose:AddSignal(BasedHandler.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(FitRow);
		end)));

		task.defer(FitRow);

		local UpdateWarp = LPH_NO_VIRTUALIZE(function()
			local size = NeverLose:MeasureText(BasedLabel.Text, BasedLabel.TextSize, BasedLabel.FontFace, Vector2.new(math.huge,math.huge));
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				Size = UDim2.new(1, 0, 0, size.Y + 13);
			})

			BasedLabel.Size = UDim2.new(1, -35, 1, 0)
			BasedLabel.TextYAlignment = Enum.TextYAlignment.Top;
		end);

		if Warp then
			UpdateWarp();
		end;

		local handle = NeverLose:RegisiterHandler(BasedHandler , Signel);

		handle.Root = BasedFrame;
		handle.Label = BasedLabel;

		handle.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.15
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})
			else
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end);

		function handle:SetVisible(val)
			BasedFrame.Visible = val;
		end;

		NeverLose:AddSignal(BasedFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.25
			})

		end)))

		NeverLose:AddSignal(BasedFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.15
			})
		end)))

		function handle:SetText(t)
			local oldtxt = BasedLabel.Text;

			BasedLabel.Text = t;

			if Warp and oldtxt ~= t then
				UpdateWarp();
			end;
		end;

		function handle:ToolTip(Content: string)
			handle.ToolTip = NeverLose:CreateToolTips(BasedFrame , Name , Content);

			return handle;
		end;

		handle.SetRender(Signel:GetValue());
		Signel:Connect(handle.SetRender);

		return handle;
	end;

	function idx:AddButton(Config)
		Config = NeverLose:ProcessParams(Config , {
			Icon = 'chevron-large-left',
			Name = "Button",
			Callback = EmptyFunction,
			ToolTip = nil,
		});

		local Button = {};
		local ButtonFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")

		NeverLose:AddQuery(ButtonFrame , Config.Name);

		ButtonFrame.Name = NeverLose.RandomString();
		ButtonFrame.Parent = Frame
		NeverLose:BindTheme(ButtonFrame, 'BackgroundColor3', 'Hover');
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
		ButtonFrame.ZIndex = LayerIndex + 8

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = ButtonFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 35, 0, 6)
		BasedLabel.Size = UDim2.new(0, 1, 0, 22)
		BasedLabel.ZIndex = LayerIndex + 9
		NeverLose:RegisterFont(BasedLabel, Enum.Font.GothamMedium);
		BasedLabel.Text = Config.Name;
		NeverLose:BindTheme(BasedLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(BasedLabel, 13.000);
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = ButtonFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = ButtonFrame

		local UpdateRowLine = LPH_NO_VIRTUALIZE(function()
			local Last = nil;

			for _,Child in next , Frame:GetChildren() do
				if Child:IsA('GuiObject') and Child.Visible then
					Last = Child;
				end;
			end;

			LineFrame.Visible = Last ~= ButtonFrame;
		end);

		NeverLose:AddSignal(Frame.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		NeverLose:AddSignal(Frame.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		local RowLayout = Frame:FindFirstChildWhichIsA('UIListLayout');

		if RowLayout then
			NeverLose:AddSignal(RowLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				task.defer(UpdateRowLine);
			end)));
		end;

		task.defer(UpdateRowLine);

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = ButtonFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 11, 0, 5)
		Icon.Size = UDim2.new(0, 18, 0, 18)
		Icon.ZIndex = LayerIndex + 9
		Icon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
		Icon.Text = Config.Icon
		NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Icon, 16.000);
		Icon.TextTransparency = 0.250
		Icon.TextWrapped = true

		function Button:SetText(t)
			BasedLabel.Text = t;
		end;

		function Button:SetIcon(t)
			Icon.Text = t
		end;

		local bth = NeverLose:CreateInput(ButtonFrame , LPH_NO_VIRTUALIZE(function()
			Config.Callback();
		end));

		NeverLose:AddSignal(bth.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});
		end)))

		NeverLose:AddSignal(bth.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 1
			});
		end)))

		Button.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.250
				});
			else
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				});
			end;
		end);

		if Config.ToolTip then
			Button.ToolTip = NeverLose:CreateToolTips(ButtonFrame , Config.Name , Config.ToolTip);
		end;

		Button.SetRender(Signel:GetValue())
		Signel:Connect(Button.SetRender);

		return Button;
	end;

	function idx:AddUserFrame(Name : string , Profile: string , Expires : string)
		local UserFrame = Instance.new("Frame")
		local UserLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local UserStatusLabel = Instance.new("TextLabel")

		UserFrame.Name = NeverLose.RandomString();
		UserFrame.Parent = Frame
		NeverLose:BindTheme(UserFrame, 'BackgroundColor3', 'Hover');
		UserFrame.BackgroundTransparency = 1.000
		UserFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserFrame.BorderSizePixel = 0
		UserFrame.Size = UDim2.new(1, 0, 0, 60)
		UserFrame.ZIndex = LayerIndex + 8

		UserLabel.Name = NeverLose.RandomString();
		UserLabel.Parent = UserFrame
		UserLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.BackgroundTransparency = 1.000
		UserLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserLabel.BorderSizePixel = 0
		UserLabel.Position = UDim2.new(0, 65, 0, 10)
		UserLabel.Size = UDim2.new(1, -35, 0, 15)
		UserLabel.ZIndex = LayerIndex + 9
		NeverLose:RegisterFont(UserLabel, Enum.Font.GothamMedium);
		UserLabel.Text = Name or 'User'
		NeverLose:BindTheme(UserLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(UserLabel, 13.000);
		UserLabel.TextTransparency = 0.200
		UserLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = UserFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = UserFrame

		local UpdateRowLine = LPH_NO_VIRTUALIZE(function()
			local Last = nil;

			for _,Child in next , Frame:GetChildren() do
				if Child:IsA('GuiObject') and Child.Visible then
					Last = Child;
				end;
			end;

			LineFrame.Visible = Last ~= UserFrame;
		end);

		NeverLose:AddSignal(Frame.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		NeverLose:AddSignal(Frame.ChildRemoved:Connect(LPH_NO_VIRTUALIZE(function()
			task.defer(UpdateRowLine);
		end)));

		local RowLayout = Frame:FindFirstChildWhichIsA('UIListLayout');

		if RowLayout then
			NeverLose:AddSignal(RowLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				task.defer(UpdateRowLine);
			end)));
		end;

		task.defer(UpdateRowLine);

		LogoImage.Name = NeverLose.RandomString();
		LogoImage.Parent = UserFrame
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0, 5)
		LogoImage.Size = UDim2.new(0, 45, 0, 45)
		LogoImage.ZIndex = LayerIndex + 9
		LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = LogoImage

		UserStatusLabel.Name = NeverLose.RandomString();
		UserStatusLabel.Parent = UserFrame
		UserStatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.BackgroundTransparency = 1.000
		UserStatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserStatusLabel.BorderSizePixel = 0
		UserStatusLabel.Position = UDim2.new(0, 65, 0, 25)
		UserStatusLabel.Size = UDim2.new(1, -35, 0, 15)
		UserStatusLabel.ZIndex = LayerIndex + 9
		NeverLose:RegisterFont(UserStatusLabel, Enum.Font.GothamMedium);
		UserStatusLabel.Text = Expires or 'Never'
		NeverLose:BindTheme(UserStatusLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(UserStatusLabel, 13.000);
		UserStatusLabel.TextTransparency = 0.200
		UserStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

		local UserFrameItem = {};

		UserFrameItem.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 0.200
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 0.650
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 0
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 0.200
				})
			else
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 1
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 1
				})
			end;
		end);

		UserFrameItem.SetRender(Signel:GetValue())
		Signel:Connect(UserFrameItem.SetRender);

		function UserFrameItem:SetUsername(name)
			UserLabel.Text = name or 'User'
		end;

		function UserFrameItem:SetProfile(Profile)
			LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";
		end;

		function UserFrameItem:SetExpires(Exp)
			UserStatusLabel.Text = Exp or 'Never';
		end;

		return UserFrameItem;
	end;

	return idx;
end;

function NeverLose:GetKeybindList()
	if NeverLose.__KeybindList then
		return NeverLose.__KeybindList;
	end;

	local ListLib = {};

	ListLib.Entries = {};
	ListLib.Enabled = true;
	ListLib.Expanded = false;
	ListLib.AllowExpand = true;

	local Panel = Instance.new("Frame")
	local PanelCorner = Instance.new("UICorner")
	local PanelStroke = Instance.new("UIStroke")
	local HeaderFrame = Instance.new("Frame")
	local HeaderIcon = Instance.new("TextLabel")
	local HeaderLabel = Instance.new("TextLabel")
	local HeaderLine = Instance.new("Frame")
	local ContentFrame = Instance.new("Frame")
	local ContentLayout = Instance.new("UIListLayout")

	Panel.Name = NeverLose.RandomString();
	Panel.Parent = NeverLose.ScreenGui
	Panel.Active = true
	NeverLose:BindTheme(Panel, 'BackgroundColor3', 'Window');
	Panel.BackgroundTransparency = 0.150
	Panel.BorderSizePixel = 0
	Panel.Position = UDim2.new(0, 25, 0, 150)
	Panel.Size = UDim2.new(0, 175, 0, 40)
	Panel.Visible = false
	Panel.ZIndex = 16

	NeverLose:BindCorner(PanelCorner, 'Panel');
	PanelCorner.Parent = Panel

	NeverLose:BindTheme(PanelStroke, 'Color', 'Border');
	PanelStroke.Transparency = 0.650
	PanelStroke.Parent = Panel

	HeaderFrame.Name = NeverLose.RandomString();
	HeaderFrame.Parent = Panel
	HeaderFrame.Active = true
	HeaderFrame.BackgroundTransparency = 1.000
	HeaderFrame.BorderSizePixel = 0
	HeaderFrame.Size = UDim2.new(1, 0, 0, 30)
	HeaderFrame.ZIndex = 17

	HeaderIcon.Name = NeverLose.RandomString();
	HeaderIcon.Parent = HeaderFrame
	HeaderIcon.AnchorPoint = Vector2.new(0, 0.5)
	HeaderIcon.BackgroundTransparency = 1.000
	HeaderIcon.BorderSizePixel = 0
	HeaderIcon.Position = UDim2.new(0, 11, 0.5, 0)
	HeaderIcon.Size = UDim2.new(0, 16, 0, 16)
	HeaderIcon.ZIndex = 18
	HeaderIcon.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(HeaderIcon, 'TextColor3', 'Icon');
	HeaderIcon.Text = "key"
	HeaderIcon.TextColor3 = NeverLose.AccentColor
	NeverLose:SetTextSize(HeaderIcon, 15.000);
	NeverLose:BindAccent(HeaderIcon , 'TextColor3');

	HeaderLabel.Name = NeverLose.RandomString();
	HeaderLabel.Parent = HeaderFrame
	HeaderLabel.AnchorPoint = Vector2.new(0, 0.5)
	HeaderLabel.BackgroundTransparency = 1.000
	HeaderLabel.BorderSizePixel = 0
	HeaderLabel.Position = UDim2.new(0, 33, 0.5, 0)
	HeaderLabel.Size = UDim2.new(1, -44, 0, 15)
	HeaderLabel.ZIndex = 18
	NeverLose:RegisterFont(HeaderLabel, Enum.Font.GothamBold);
	HeaderLabel.Text = "Keybinds"
	NeverLose:BindTheme(HeaderLabel, 'TextColor3', 'Text');
	NeverLose:SetTextSize(HeaderLabel, 13.000);
	HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left

	HeaderLine.Name = NeverLose.RandomString();
	HeaderLine.Parent = Panel
	HeaderLine.AnchorPoint = Vector2.new(0.5, 1)
	HeaderLine.BackgroundColor3 = NeverLose.AccentColor
	HeaderLine.BackgroundTransparency = 0.150
	HeaderLine.BorderSizePixel = 0
	HeaderLine.Position = UDim2.new(0.5, 0, 0, 30)
	HeaderLine.Size = UDim2.new(1, -20, 0, 1)
	HeaderLine.ZIndex = 18

	NeverLose:BindAccent(HeaderLine , 'BackgroundColor3');

	ContentFrame.Name = NeverLose.RandomString();
	ContentFrame.Parent = Panel
	ContentFrame.AnchorPoint = Vector2.new(0.5, 0)
	ContentFrame.BackgroundTransparency = 1.000
	ContentFrame.BorderSizePixel = 0
	ContentFrame.Position = UDim2.new(0.5, 0, 0, 35)
	ContentFrame.Size = UDim2.new(1, 0, 1, -35)
	ContentFrame.ZIndex = 17

	ContentLayout.Parent = ContentFrame
	ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	NeverLose.Drag(HeaderFrame , Panel , 0.150);

	local UpdatePanel = LPH_NO_VIRTUALIZE(function()
		local content = ContentLayout.AbsoluteContentSize.Y;
		local width = 130;

		for i,entry in next , ListLib.Entries do
			if entry.Row.Visible then
				local bounds = NeverLose:MeasureText(entry.Row.Text, entry.Row.TextSize, entry.Row.FontFace, Vector2.new(math.huge , math.huge));

				if width < bounds.X + 32 then
					width = bounds.X + 32;
				end;
			end;
		end;

		local visible = (ListLib.Enabled and content > 1) or false;

		Panel.Visible = visible;

		if visible then
			NeverLose.PlayAnimate(Panel , SlowyTween , {
				Size = UDim2.new(0, width, 0, 41 + content)
			});
		end;
	end);

	local KeyMatches = LPH_NO_VIRTUALIZE(function(Entry , input)
		if not Entry.Key then
			return false;
		end;

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			return Entry.Key == 'M1B';
		end;

		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			return Entry.Key == 'M2B';
		end;

		if input.KeyCode == Enum.KeyCode.Unknown then
			return false;
		end;

		return input.KeyCode.Name == tostring(Entry.Key);
	end);

	function ListLib:Register(Config)
		Config = Config or {};

		local Entry = {};

		Entry.Name = Config.Name or 'Keybind';
		Entry.Mode = Config.Mode or 'Always';
		Entry.Key = typeof(Config.Key) == 'EnumItem' and Config.Key.Name or Config.Key;
		Entry.Trigger = Config.Trigger;
		Entry.Active = Entry.Mode == 'Always' and Entry.Key ~= nil and Entry.Key ~= 'None';
		Entry.Toggled = false;

		local Row = Instance.new("TextLabel")

		Row.Name = NeverLose.RandomString();
		Row.Parent = ContentFrame
		Row.BackgroundTransparency = 1.000
		Row.BorderSizePixel = 0
		Row.Size = UDim2.new(1, -22, 0, 18)
		Row.ZIndex = 18
		NeverLose:RegisterFont(Row, Enum.Font.GothamBold);
		Row.Text = ""
		NeverLose:BindTheme(Row, 'TextColor3', 'Text');
		NeverLose:SetTextSize(Row, 12.000);
		Row.TextTransparency = 0.150
		Row.TextXAlignment = Enum.TextXAlignment.Left
		Row.Visible = false

		Entry.Row = Row;

		function Entry:Refresh()
			local active = Entry.Active;

			if Entry.Mode == 'Always' then
				active = Entry.Key ~= nil and Entry.Key ~= 'None';
			end;

			Row.Text = tostring(Entry.Name).." ("..tostring(Entry.Mode)..") - "..NeverLose:KeyCodeToStr(Entry.Key or "None");
			Row.Visible = (active or ListLib.Expanded) and true or false;
			Row.TextTransparency = (active and 0.150) or 0.550;

			UpdatePanel();
		end;

		function Entry:SetKey(key)
			Entry.Key = key;
			Entry.Toggled = false;
			Entry.Active = false;

			Entry:Refresh();
		end;

		function Entry:GetMode()
			return Entry.Mode;
		end;

		function Entry:SetMode(mode)
			local normalized;
			for _,name in ipairs(NeverLose.KeybindModes) do
				if string.lower(tostring(mode or 'Always')) == string.lower(name) then
					normalized = name;
					break;
				end;
			end;

			if not normalized then
				return;
			end;

			Entry.Mode = normalized;
			Entry.Toggled = false;
			Entry:SetActive(normalized == 'Always' and Entry.Key ~= nil and Entry.Key ~= 'None');
			Entry:Refresh();
		end;

		function Entry:NextMode()
			local index = table.find(NeverLose.KeybindModes , Entry.Mode) or 1;

			Entry:SetMode(NeverLose.KeybindModes[(index % #NeverLose.KeybindModes) + 1]);
		end;

		function Entry:SetActive(state)
			state = (state and true) or false;

			if Entry.Active == state then
				return;
			end;

			Entry.Active = state;

			Entry:Refresh();

			if Entry.Trigger then
				pcall(Entry.Trigger , state);
			end;
		end;

		function Entry:Remove()
			local index = table.find(ListLib.Entries , Entry);

			if index then
				table.remove(ListLib.Entries , index);
			end;

			Row:Destroy();

			UpdatePanel();
		end;

		table.insert(ListLib.Entries , Entry);

		Entry:Refresh();

		return Entry;
	end;

	function ListLib:Refresh()
		for i,entry in next , ListLib.Entries do
			entry:Refresh();
		end;

		UpdatePanel();
	end;

	function ListLib:SetEnabled(value)
		ListLib.Enabled = (value and true) or false;

		ListLib:Refresh();
	end;

	function ListLib:SetExpanded(value)
		ListLib.Expanded = (value and ListLib.AllowExpand and true) or false;

		ListLib:Refresh();
	end;

	function ListLib:SetPosition(position)
		Panel.Position = position;
	end;

	ListLib.Panel = Panel;

	NeverLose:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(input , typing)
		if typing or NeverLose.__PointerCapture or NeverLose.__BindingKeybind or NeverLose:HasOpenPopup() then
			return;
		end;

		for i,entry in next , ListLib.Entries do
			if KeyMatches(entry , input) then
				if entry.Mode == 'Hold' then
					entry:SetActive(true);
				elseif entry.Mode == 'Toggle' then
					entry.Toggled = not entry.Toggled;

					entry:SetActive(entry.Toggled);
				end;
			end;
		end;
	end)));

	NeverLose:AddSignal(UserInputService.InputEnded:Connect(LPH_NO_VIRTUALIZE(function(input)
		for i,entry in next , ListLib.Entries do
			if entry.Mode == 'Hold' and KeyMatches(entry , input) then
				entry:SetActive(false);
			end;
		end;
	end)));

	NeverLose.__KeybindList = ListLib;

	UpdatePanel();

	return ListLib;
end;

function NeverLose:CreateWindow(Config)
	Config = NeverLose:ProcessParams(Config , {
		Logo = NeverLose.GlobalLogo,
		Name = "Neverlose",
		Content = "Counter-Strike 2",
		Size = NeverLose.Scales.Default,
		ConfigFolder = "NeverLoseConfigs",
		Enable3DRenderer = false,
		Keybind = "Insert"
	});

	local Window = {
		Logo = Config.Logo,
		Name = Config.Name,
		Content = Config.Content,
		Size = NeverLose:FitWindowSize(Config.Size),
		ConfigFolder = Config.ConfigFolder,
		Signal = NeverLose:CreateSignal(true),
		Tabs = {},
		CurrentTab = 1,
		Keybind = Config.Keybind,
		Enable3DRenderer = Config.Enable3DRenderer
	};

	NeverLose.GlobalLogo = Window.Logo;

	local Logging = NeverLose:CreateLogger();
	if not isfolder(Window.ConfigFolder) then
		makefolder(Window.ConfigFolder);
	end;

	local WindowFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local LeftMenuFrame = Instance.new("Frame")
	local HeadFrame = Instance.new("Frame")
	local LogoImage = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local WindowName = Instance.new("TextLabel")
	local WindowContent = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local LeftScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local BottomFrame = Instance.new("Frame")
	local AccountProfile = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local AccountName = Instance.new("TextLabel")
	local ExpireLabel = Instance.new("TextLabel")
	local LineFrame_2 = Instance.new("Frame")
	local UserSettingButton = Instance.new("TextLabel")
	local RightMenuFrame = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner_4 = Instance.new("UICorner")
	local RightHeader = Instance.new("Frame")
	local LineFrame_3 = Instance.new("Frame")
	local ConfigFrame = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local ConfigIcon = Instance.new("TextLabel")
	local LineFrame_4 = Instance.new("Frame")
	local ConfigName = Instance.new("TextLabel")
	local ConfigBthIcon = Instance.new("TextLabel")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("TextLabel")
	local SearchBox = Instance.new("TextBox")
	local TabContainer = Instance.new("Frame")

	WindowFrame.Name = NeverLose.RandomString();
	WindowFrame.Parent = NeverLose.ScreenGui;
	WindowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	NeverLose:BindTheme(WindowFrame, 'BackgroundColor3', 'Window');
	WindowFrame.BackgroundTransparency = 0.055
	WindowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowFrame.BorderSizePixel = 0
	WindowFrame.ClipsDescendants = true
	WindowFrame.Position = UDim2.new(255, 0, 255, 0)
	WindowFrame.Size = Window.Size
	WindowFrame.Active = true;

	if not NeverLose.EnabledBlur then
		WindowFrame.BackgroundTransparency = 0.0255
	end;

	local renderParentWindow = LPH_NO_VIRTUALIZE(function()
		if Window.__3DRender then
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;

				NeverLose.PlayAnimate(WindowFrame,VSlowTween , {
					Position = UDim2.fromScale(0.5,0.5);
				});

				WindowFrame.Parent = Window.SurfaceGui;
			end;
		else
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;
				WindowFrame.Parent = NeverLose.ScreenGui


			end;
		end;
	end);

	NeverLose:AddSignal(WindowFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(renderParentWindow))

	Window.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
		if value then
			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = Window.__MenuTransparency or 0.055,
				Size = Window.Size
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 0.5
			})

			NeverLose.PlayAnimate(Window.RightSurface , SlowyTween , {
				BackgroundTransparency = Window.__ContentTransparency or 0.100
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 0.750
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 0.350
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 0.350
			})

			Window.Shadow:Render(true);
		else

			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = 1,
				Size = Window.Size + UDim2.fromOffset(-15,-15)
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(Window.RightSurface , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 1
			})

			Window.Shadow:Render(false);
		end;
	end);

	Window.Shadow = NeverLose:CreateShadow(WindowFrame);
	Window.Shadow:Render(false);

	task.delay(0.25,function()
		WindowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Window:SetRender(true);
		NeverLose:AddSignal(Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(...)
			Window:SetRender(...);
		end)))
	end)

	if NeverLose.EnabledBlur then
		NeverLose:CreateBlurModule(WindowFrame,Window.Signal);
	end;

	do
		local Frame = Instance.new("Frame")

		Frame.Parent = WindowFrame
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 50)
		Frame.ZIndex = 7
		Frame.BackgroundTransparency = 1;

		NeverLose.Drag(Frame , WindowFrame , 0.15)
	end

	NeverLose:BindCorner(UICorner, 'Panel');
	UICorner.Parent = WindowFrame

	LeftMenuFrame.Name = NeverLose.RandomString();
	LeftMenuFrame.Parent = WindowFrame
	NeverLose:BindTheme(LeftMenuFrame, 'BackgroundColor3', 'Sidebar');
	LeftMenuFrame.BackgroundTransparency = 0.08
	LeftMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftMenuFrame.BorderSizePixel = 0
	LeftMenuFrame.Size = UDim2.new(0, 128, 1, 0)
	Window.LeftSurface = NeverLose:CreateOuterSurface(LeftMenuFrame,WindowFrame,'Sidebar',0.08);

	HeadFrame.Name = NeverLose.RandomString();
	HeadFrame.Parent = LeftMenuFrame
	HeadFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeadFrame.BackgroundTransparency = 1.000
	HeadFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadFrame.BorderSizePixel = 0
	HeadFrame.Size = UDim2.new(1, 0, 0, 50)
	HeadFrame.ZIndex = 7

	LogoImage.Name = NeverLose.RandomString();
	LogoImage.Parent = HeadFrame
	LogoImage.AnchorPoint = Vector2.new(0, 0.5)
	LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.BackgroundTransparency = 1.000
	LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoImage.BorderSizePixel = 0
	LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
	LogoImage.Size = UDim2.new(0, 28, 0, 28)
	LogoImage.ZIndex = 7
	LogoImage.Image = Window.Logo
	NeverLose:BindTheme(LogoImage, 'ImageColor3', 'Icon');

	NeverLose:BindCorner(UICorner_2, 'Panel');
	UICorner_2.Parent = LogoImage

	WindowName.Name = NeverLose.RandomString();
	WindowName.Parent = HeadFrame
	WindowName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.BackgroundTransparency = 1.000
	WindowName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowName.BorderSizePixel = 0
	WindowName.Position = UDim2.new(0, 45, 0, 4)
	WindowName.Size = UDim2.new(1, -53, 0, 25)
	WindowName.TextTruncate = Enum.TextTruncate.AtEnd
	WindowName.ZIndex = 7
	NeverLose:RegisterFont(WindowName, Enum.Font.GothamBold);
	WindowName.Text = Window.Name
	NeverLose:BindTheme(WindowName, 'TextColor3', 'Text');
	NeverLose:SetTextSize(WindowName, 15.000);
	WindowName.TextXAlignment = Enum.TextXAlignment.Left

	WindowContent.Name = NeverLose.RandomString();
	WindowContent.Parent = HeadFrame
	WindowContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.BackgroundTransparency = 1.000
	WindowContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowContent.BorderSizePixel = 0
	WindowContent.Position = UDim2.new(0, 45, 0, 27)
	WindowContent.Size = UDim2.new(1, -53, 0, 17)
	WindowContent.TextTruncate = Enum.TextTruncate.AtEnd
	WindowContent.ZIndex = 7
	NeverLose:RegisterFont(WindowContent, Enum.Font.GothamBold);
	WindowContent.Text = Window.Content
	NeverLose:BindTheme(WindowContent, 'TextColor3', 'Text');
	NeverLose:SetTextSize(WindowContent, 10.000);
	WindowContent.TextTransparency = 0.650
	WindowContent.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame.Name = NeverLose.RandomString();
	LineFrame.Parent = HeadFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -10, 0, 1)
	LineFrame.ZIndex = 5

	LeftScrollingFrame.Name = NeverLose.RandomString();
	LeftScrollingFrame.Parent = LeftMenuFrame
	LeftScrollingFrame.Active = true
	LeftScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
	LeftScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftScrollingFrame.BackgroundTransparency = 1.000
	LeftScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftScrollingFrame.BorderSizePixel = 0
	LeftScrollingFrame.Position = UDim2.new(0.5, 0, 0, 60)
	LeftScrollingFrame.Size = UDim2.new(1, -10, 1, -115)
	LeftScrollingFrame.ZIndex = 7
	LeftScrollingFrame.ScrollBarThickness = 0

	UIListLayout.Parent = LeftScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		LeftScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
	end)))

	BottomFrame.Name = NeverLose.RandomString();
	BottomFrame.Parent = LeftMenuFrame
	BottomFrame.AnchorPoint = Vector2.new(0, 1)
	BottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomFrame.BackgroundTransparency = 1.000
	BottomFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BottomFrame.BorderSizePixel = 0
	BottomFrame.Position = UDim2.new(0, 0, 1, 0)
	BottomFrame.Size = UDim2.new(1, 0, 0, 50)
	BottomFrame.ZIndex = 7

	AccountProfile.Name = NeverLose.RandomString();
	AccountProfile.Parent = BottomFrame
	AccountProfile.AnchorPoint = Vector2.new(0, 0.5)
	AccountProfile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountProfile.BackgroundTransparency = 1.000
	AccountProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountProfile.BorderSizePixel = 0
	AccountProfile.Position = UDim2.new(0, 10, 0.5, 0)
	AccountProfile.Size = UDim2.new(0, 28, 0, 28)
	AccountProfile.ZIndex = 7
	AccountProfile.Image = NeverLose.UserProfile or ""

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = AccountProfile

	AccountName.Name = NeverLose.RandomString();
	AccountName.Parent = BottomFrame
	AccountName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.BackgroundTransparency = 1.000
	AccountName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountName.BorderSizePixel = 0
	AccountName.Position = UDim2.new(0, 45, 0, 5)
	AccountName.Size = UDim2.new(1, -70, 0, 25)
	AccountName.ZIndex = 7
	NeverLose:RegisterFont(AccountName, Enum.Font.GothamBold);
	AccountName.Text = ""
	NeverLose:BindTheme(AccountName, 'TextColor3', 'Text');
	NeverLose:SetTextSize(AccountName, 14.000);
	AccountName.TextXAlignment = Enum.TextXAlignment.Left
	AccountName.TextTruncate = Enum.TextTruncate.SplitWord;

	ExpireLabel.Name = NeverLose.RandomString();
	ExpireLabel.Parent = BottomFrame
	ExpireLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.BackgroundTransparency = 1.000
	ExpireLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireLabel.BorderSizePixel = 0
	ExpireLabel.Position = UDim2.new(0, 45, 0, 27)
	ExpireLabel.Size = UDim2.new(1, -70, 0, 17)
	ExpireLabel.TextTruncate = Enum.TextTruncate.AtEnd
	ExpireLabel.ZIndex = 7
	NeverLose:RegisterFont(ExpireLabel, Enum.Font.GothamBold);
	ExpireLabel.Text = "never"
	NeverLose:BindTheme(ExpireLabel, 'TextColor3', 'Text');
	NeverLose:SetTextSize(ExpireLabel, 10.000);
	ExpireLabel.TextTransparency = 0.650
	ExpireLabel.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame_2.Name = NeverLose.RandomString();
	LineFrame_2.Parent = BottomFrame
	LineFrame_2.AnchorPoint = Vector2.new(0.5, 0)
	NeverLose:BindTheme(LineFrame_2, 'BackgroundColor3', 'Border');
	LineFrame_2.BackgroundTransparency = 0.650
	LineFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_2.BorderSizePixel = 0
	LineFrame_2.Position = UDim2.new(0.5, 0, 0, 0)
	LineFrame_2.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_2.ZIndex = 5

	UserSettingButton.Name = NeverLose.RandomString();
	UserSettingButton.Parent = BottomFrame
	UserSettingButton.AnchorPoint = Vector2.new(1, 0.5)
	UserSettingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.BackgroundTransparency = 1.000
	UserSettingButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserSettingButton.BorderSizePixel = 0
	UserSettingButton.Position = UDim2.new(1, -7, 0.5, 0)
	UserSettingButton.Size = UDim2.new(0, 25, 0, 25)
	UserSettingButton.ZIndex = 7
	UserSettingButton.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(UserSettingButton, 'TextColor3', 'Icon');
	UserSettingButton.Text = "chevron-large-right"
	NeverLose:BindTheme(UserSettingButton, 'TextColor3', 'Text');
	NeverLose:SetTextSize(UserSettingButton, 13.000);
	UserSettingButton.TextTransparency = 0.5

	NeverLose:AddSignal(BottomFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.25
		})		
	end)))

	NeverLose:AddSignal(BottomFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.5
		})		
	end)))

	RightMenuFrame.Name = NeverLose.RandomString();
	local RightClip = Instance.new("Frame")
	local RightPadding = Instance.new("UIPadding")
	local RightEdge = Instance.new("Frame")

	RightClip.Name = NeverLose.RandomString();
	RightClip.Parent = WindowFrame
	RightClip.BackgroundTransparency = 1.000
	RightClip.BorderSizePixel = 0
	RightClip.ClipsDescendants = true
	RightClip.Position = UDim2.new(0, 129, 0, 0)
	RightClip.Size = UDim2.new(1, -129, 1, 0)
	RightClip.ZIndex = 8

	RightPadding.PaddingLeft = UDim.new(0, 0)
	RightPadding.Parent = RightMenuFrame

	RightEdge.Name = NeverLose.RandomString();
	RightEdge.Parent = RightClip
	NeverLose:BindTheme(RightEdge, 'BackgroundColor3', 'Border');
	RightEdge.BackgroundTransparency = 0.650
	RightEdge.BorderSizePixel = 0
	RightEdge.Position = UDim2.new(0, 0, 0, 0)
	RightEdge.Size = UDim2.new(0, 1, 1, 0)
	RightEdge.ZIndex = 9

	RightMenuFrame.Parent = RightClip
	NeverLose:BindTheme(RightMenuFrame, 'BackgroundColor3', 'Content');
	RightMenuFrame.BackgroundTransparency = 0.100
	RightMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightMenuFrame.BorderSizePixel = 0
	RightMenuFrame.ClipsDescendants = true
	RightMenuFrame.Position = UDim2.new(0, 0, 0, 0)
	RightMenuFrame.Size = UDim2.new(1, 0, 1, 0)
	RightMenuFrame.ZIndex = 8

	UIStroke.Transparency = 0.650
	NeverLose:BindTheme(UIStroke, 'Color', 'Border');
	UIStroke.Parent = RightMenuFrame

	NeverLose:BindCorner(UICorner_4,'Panel');
	Window.RightSurface = NeverLose:CreateOuterSurface(RightMenuFrame,WindowFrame,'Content',0.1);
	UIStroke.Parent = WindowFrame;
	UICorner_4.Parent = RightMenuFrame

	RightHeader.Name = NeverLose.RandomString();
	RightHeader.Parent = RightMenuFrame
	RightHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightHeader.BackgroundTransparency = 1.000
	RightHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightHeader.BorderSizePixel = 0
	RightHeader.Size = UDim2.new(1, 0, 0, 50)
	RightHeader.ZIndex = 9

	LineFrame_3.Name = NeverLose.RandomString();
	LineFrame_3.Parent = RightHeader
	LineFrame_3.AnchorPoint = Vector2.new(0.5, 1)
	NeverLose:BindTheme(LineFrame_3, 'BackgroundColor3', 'Border');
	LineFrame_3.BackgroundTransparency = 0.650
	LineFrame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_3.BorderSizePixel = 0
	LineFrame_3.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame_3.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_3.ZIndex = 9

	ConfigFrame.Name = NeverLose.RandomString();
	ConfigFrame.Parent = RightHeader
	ConfigFrame.AnchorPoint = Vector2.new(0, 0.5)
	NeverLose:BindTheme(ConfigFrame, 'BackgroundColor3', 'Control');
	ConfigFrame.BackgroundTransparency = 0.750
	ConfigFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigFrame.BorderSizePixel = 0
	ConfigFrame.Position = UDim2.new(0, 10, 0.5, 0)
	ConfigFrame.Size = UDim2.new(0, 140, 0, 30)
	ConfigFrame.ZIndex = 9

	UIStroke_2.Transparency = 0.650
	NeverLose:BindTheme(UIStroke_2, 'Color', 'Border');
	UIStroke_2.Parent = ConfigFrame

	NeverLose:BindCorner(UICorner_5, 'Control');
	UICorner_5.Parent = ConfigFrame

	ConfigIcon.Name = NeverLose.RandomString();
	ConfigIcon.Parent = ConfigFrame
	ConfigIcon.AnchorPoint = Vector2.new(0, 0.5)
	ConfigIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigIcon.BackgroundTransparency = 1.000
	ConfigIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigIcon.BorderSizePixel = 0
	ConfigIcon.Position = UDim2.new(0, 2, 0.5, 0)
	ConfigIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigIcon.ZIndex = 9
	ConfigIcon.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(ConfigIcon, 'TextColor3', 'Icon');
	ConfigIcon.Text = "floppy-disk"
	NeverLose:BindTheme(ConfigIcon, 'TextColor3', 'MutedText');
	NeverLose:SetTextSize(ConfigIcon, 16.000);
	ConfigIcon.TextTransparency = 0.250
	ConfigIcon.TextWrapped = true

	LineFrame_4.Name = NeverLose.RandomString();
	LineFrame_4.Parent = ConfigFrame
	NeverLose:BindTheme(LineFrame_4, 'BackgroundColor3', 'Border');
	LineFrame_4.BackgroundTransparency = 0.650
	LineFrame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_4.BorderSizePixel = 0
	LineFrame_4.Position = UDim2.new(0, 30, 0, 0)
	LineFrame_4.Size = UDim2.new(0, 1, 1, 0)

	ConfigName.Name = NeverLose.RandomString();
	ConfigName.Parent = ConfigFrame
	ConfigName.AnchorPoint = Vector2.new(0, 0.5)
	ConfigName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.BackgroundTransparency = 1.000
	ConfigName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigName.BorderSizePixel = 0
	ConfigName.Position = UDim2.new(0, 40, 0.5, 0)
	ConfigName.Size = UDim2.new(1, -65, 0, 22)
	ConfigName.TextTruncate = Enum.TextTruncate.AtEnd
	ConfigName.ZIndex = 9
	NeverLose:RegisterFont(ConfigName, Enum.Font.GothamMedium);
	ConfigName.Text = "Default"
	NeverLose:BindTheme(ConfigName, 'TextColor3', 'Text');
	NeverLose:SetTextSize(ConfigName, 12.000);
	ConfigName.TextTransparency = 0.350
	ConfigName.TextXAlignment = Enum.TextXAlignment.Left

	ConfigBthIcon.Name = NeverLose.RandomString();
	ConfigBthIcon.Parent = ConfigFrame
	ConfigBthIcon.AnchorPoint = Vector2.new(1, 0.5)
	ConfigBthIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigBthIcon.BackgroundTransparency = 1.000
	ConfigBthIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigBthIcon.BorderSizePixel = 0
	ConfigBthIcon.Position = UDim2.new(1, -2, 0.5, 0)
	ConfigBthIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigBthIcon.ZIndex = 9
	ConfigBthIcon.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(ConfigBthIcon, 'TextColor3', 'Icon');
	ConfigBthIcon.Text = "chevron-small-down"
	NeverLose:BindTheme(ConfigBthIcon, 'TextColor3', 'MutedText');
	NeverLose:SetTextSize(ConfigBthIcon, 16.000);
	ConfigBthIcon.TextTransparency = 0.250
	ConfigBthIcon.TextWrapped = true

	SearchFrame.Name = NeverLose.RandomString();
	SearchFrame.Parent = RightHeader
	SearchFrame.AnchorPoint = Vector2.new(1, 0.5)
	SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchFrame.BackgroundTransparency = 1.000
	SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchFrame.BorderSizePixel = 0
	SearchFrame.ClipsDescendants = true
	SearchFrame.Position = UDim2.new(1, -10, 0.5, 0)
	SearchFrame.Size = UDim2.new(0, 30, 0, 30)
	SearchFrame.ZIndex = 12

	SearchIcon.Name = NeverLose.RandomString();
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchIcon.BackgroundTransparency = 1.000
	SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchIcon.BorderSizePixel = 0
	SearchIcon.Position = UDim2.new(0, 2, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 25, 0, 25)
	SearchIcon.ZIndex = 12
	SearchIcon.FontFace = NeverLose.BuiltInBold;
	NeverLose:BindTheme(SearchIcon, 'TextColor3', 'Icon');
	SearchIcon.Text = "magnifying-glass"
	NeverLose:BindTheme(SearchIcon, 'TextColor3', 'MutedText');
	NeverLose:SetTextSize(SearchIcon, 14.000);
	SearchIcon.TextTransparency = 0.45
	SearchIcon.TextWrapped = true

	SearchBox.Name = NeverLose.RandomString();
	SearchBox.Parent = SearchFrame
	SearchBox.AnchorPoint = Vector2.new(0, 0.5)
	SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.BackgroundTransparency = 1.000
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0, 35, 0.5, 0)
	SearchBox.Size = UDim2.new(1, -35, 0, 25)
	SearchBox.ZIndex = 12
	SearchBox.ClearTextOnFocus = false
	NeverLose:RegisterFont(SearchBox, Enum.Font.GothamMedium);
	SearchBox.PlaceholderText = "Search"
	SearchBox.Text = ""
	NeverLose:BindTheme(SearchBox, 'TextColor3', 'Text');
	NeverLose:SetTextSize(SearchBox, 13.000);
	SearchBox.TextTransparency = 1
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	TabContainer.Name = NeverLose.RandomString();
	TabContainer.Parent = RightMenuFrame
	TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabContainer.BorderSizePixel = 0
	TabContainer.ClipsDescendants = true
	TabContainer.Position = UDim2.new(0, 0, 0, 50)
	TabContainer.Size = UDim2.new(1, 0, 1, -50)
	TabContainer.ZIndex = 5
	Window.SidebarWidth=128;
	Window.Background={Source='',Enabled=true,Opacity=1,Dim=0.35,Tint=Color3.new(1,1,1),Fit='Crop'};
	Window.BackgroundRequest=0;
	local BackgroundImage=Instance.new('ImageLabel');
	BackgroundImage.Name='ContentWallpaper'; BackgroundImage.BackgroundTransparency=1; BackgroundImage.BorderSizePixel=0;
	BackgroundImage.Position=UDim2.fromOffset(0,0); BackgroundImage.Size=UDim2.fromScale(1,1); BackgroundImage.ScaleType=Enum.ScaleType.Crop;
	BackgroundImage.ZIndex=8; BackgroundImage.Visible=false; BackgroundImage.Active=false; BackgroundImage.Parent=RightMenuFrame;
	local BackgroundDim=Instance.new('Frame');
	BackgroundDim.Name='WallpaperDim'; BackgroundDim.BackgroundColor3=Color3.new(0,0,0); BackgroundDim.BackgroundTransparency=0.65; BackgroundDim.BorderSizePixel=0;
	BackgroundDim.Position=UDim2.fromOffset(0,0); BackgroundDim.Size=UDim2.fromScale(1,1); BackgroundDim.ZIndex=8; BackgroundDim.Visible=false; BackgroundDim.Active=false; BackgroundDim.Parent=RightMenuFrame;
	local WallpaperCorner = Instance.new('UICorner'); WallpaperCorner.Parent=BackgroundImage; NeverLose:BindCorner(WallpaperCorner,'Panel');
	local DimCorner = Instance.new('UICorner'); DimCorner.Parent=BackgroundDim; NeverLose:BindCorner(DimCorner,'Panel');
	local function fitWallpaperCorners()
		local radius=NeverLose.CornerRadius;
		BackgroundImage.Position=UDim2.fromOffset(-radius,0); BackgroundImage.Size=UDim2.new(1,radius,1,0);
		BackgroundDim.Position=BackgroundImage.Position; BackgroundDim.Size=BackgroundImage.Size;
	end;
	NeverLose:AddSignal(WallpaperCorner:GetPropertyChangedSignal('CornerRadius'):Connect(fitWallpaperCorners)); fitWallpaperCorners();
	Window.BackgroundImage=BackgroundImage;
	function Window:UpdateBackground()
		local b=Window.Background; local visible=b.Enabled and BackgroundImage.Image~='' and Window.Signal:GetValue();
		BackgroundImage.Visible=visible; BackgroundDim.Visible=visible;
		BackgroundImage.ImageTransparency=1-b.Opacity; BackgroundImage.ImageColor3=b.Tint; BackgroundImage.ScaleType=Enum.ScaleType[b.Fit] or Enum.ScaleType.Crop; BackgroundDim.BackgroundTransparency=1-b.Dim;
	end;
	function Window:SetSidebarWidth(value)
		Window.SidebarWidth=math.clamp(math.floor(tonumber(value) or 128),112,176);
		LeftMenuFrame.Size=UDim2.new(0,Window.SidebarWidth,1,0);
		RightClip.Position=UDim2.new(0,Window.SidebarWidth+1,0,0); RightClip.Size=UDim2.new(1,-Window.SidebarWidth-1,1,0); return Window.SidebarWidth;
	end;
	function Window:SetBackgroundImage(source)
		source=tostring(source or ''):match('^%s*(.-)%s*$'); Window.BackgroundRequest=Window.BackgroundRequest+1; local request=Window.BackgroundRequest;
		if source=='' then BackgroundImage.Image=''; Window.Background.Source=''; Window:UpdateBackground(); return true; end;
		local success,asset=pcall(function()
			local id=source:match('^%d+$') or source:match('^rbxassetid://(%d+)$');
			if not id and source:match('^https?://[%w%.]*roblox%.com/') then id=source:match('[?&]id=(%d+)') or source:match('/library/(%d+)') or source:match('/store/asset/(%d+)'); end;
			if id then return 'rbxassetid://'..id; end;
			if source:match('^rbxasset://') then return source; end;
			if not getcustomasset then error('URL/local images require custom asset support; use a Roblox asset ID'); end;
			if not source:match('^https?://') then if isfile and isfile(source) then return getcustomasset(source); end; error('Image file not found'); end;
			local ready,reason=NeverLose:EnsureAssetFolder('NLAssets/Backgrounds'); if not ready then error(reason); end;
			local hash=5381; for i=1,#source do hash=(hash*33+source:byte(i))%4294967296; end;
			local base='NLAssets/Backgrounds/'..string.format('%08x',hash);
			for _,extension in ipairs({'.png','.jpg'}) do if isfile and isfile(base..extension) then return getcustomasset(base..extension); end; end;
			local data=game:HttpGet(source);
			if type(data)~='string' or #data<8 or #data>20971520 then error('Empty image or image larger than 20 MB'); end;
			local extension;
			if data:sub(1,8)=='\137PNG\r\n\26\n' then extension='.png'; elseif data:sub(1,3)=='\255\216\255' then extension='.jpg'; else error('Use a direct PNG/JPG link, not a web page'); end;
			writefile(base..extension,data); return getcustomasset(base..extension);
		end);
		if request~=Window.BackgroundRequest then return false,'Superseded'; end;
		if not success then return false,tostring(asset); end;
		local loaded,message=pcall(function()
			local failed=false;
			game:GetService('ContentProvider'):PreloadAsync({asset},function(_,status) if status~=Enum.AssetFetchStatus.Success then failed=true; end; end);
			if failed then error('Roblox could not load this image asset'); end;
		end);
		if request~=Window.BackgroundRequest then return false,'Superseded'; end;
		if not loaded then return false,tostring(message); end;
		BackgroundImage.Image=asset; Window.Background.Source=source; Window:UpdateBackground(); return true;
	end;
	Window.Signal:Connect(function() Window:UpdateBackground(); end);
	Window:SetSidebarWidth(128);

	do
		Window.Searching = false;
		local Input = NeverLose:CreateInput(SearchIcon , LPH_NO_VIRTUALIZE(function()
			Window.Searching = not Window.Searching;

			if Window.Searching then
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 220, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})

				NeverLose.PlayAnimate(SearchBox , VSlowTween , {
					TextTransparency = 0.350
				})
			else
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 30, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})

				NeverLose.PlayAnimate(SearchBox , SlowyTween , {
					TextTransparency = 1
				})

				SearchBox.Text = "";
			end;
		end));	

		local wati_for_finish = tick();
		local last_thread;
		local max_time = 0.2;

		NeverLose:AddSignal(SearchBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			if not SearchBox.Text:byte() then
				for i,v in next , NeverLose.NameRegisitry do
					v.Root.Visible = true;
				end;

				return;	
			end;

			wati_for_finish = tick();

			if last_thread then
				task.cancel(last_thread);
				last_thread = nil;
			end;

			last_thread = task.delay(max_time,function()
				if SearchBox.Text:byte() and (tick() - wati_for_finish) > max_time then
					for i,v in next , NeverLose.NameRegisitry do
						if string.find(string.lower(v.Idx) , string.lower(SearchBox.Text), 1, true) then
							v.Root.Visible = true;
						else
							v.Root.Visible = false;
						end;
					end;
				end;
			end);
		end)));

		NeverLose:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)))

		NeverLose:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Searching then
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})
			else
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})
			end;
		end)));
	end;

	if Window.Enable3DRenderer then
		local Part = Instance.new('Part');

		Part.Name = NeverLose.RandomString();
		Part.Anchored = true;
		Part.Transparency = 1;
		Part.CanCollide = false;
		Part.CanTouch = false;
		Part.CanQuery = true;
		Part.AudioCanCollide = false;
		Part.CollisionGroup = NeverLose.RandomString();
		Part.CFrame = CFrame.new(0,0,0);
		Part.Size = Vector3.zero;

		local SurfaceGui = Instance.new("SurfaceGui")

		SurfaceGui.Parent = NeverLose.ScreenGui;
		SurfaceGui.Adornee = Part;
		SurfaceGui.Face = Enum.NormalId.Front;
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		SurfaceGui.AlwaysOnTop = true
		SurfaceGui.LightInfluence = 1.000
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
		SurfaceGui.PixelsPerStud = 40;

		Window.SurfaceGui = SurfaceGui;
		NeverLose.GlobalSurfaceGui = SurfaceGui;

		Window.Load3DBlock = LPH_NO_VIRTUALIZE(function()
			if not Window.Signal:GetValue() then Part.Parent = nil; return; end;
			local camera = workspace.CurrentCamera;
			if not camera then return; end;
			local viewport = camera.ViewportSize;
			if viewport.X <= 0 or viewport.Y <= 0 then return; end;
			local distance = 25;
			local height = 2 * math.tan(math.rad(camera.FieldOfView) * 0.5) * distance;
			SurfaceGui.CanvasSize = Vector2.new(math.floor(viewport.X * 1.35), math.floor(viewport.Y * 1.35));
			Part.Size = Vector3.new(height * viewport.X / viewport.Y, height, 0.05);
			Part.Parent = NeverLose.BlurModuleParent or workspace;
			NeverLose.PlayAnimate(Part, VSlowTween, {CFrame = camera.CFrame * CFrame.new(0,0,-distance) * CFrame.Angles(0,math.rad(180),0)});
		end);
		NeverLose:AddSignal(CurrentCamera:GetPropertyChangedSignal('ViewportSize'):Connect(function()
			if Window.__3DRender then Window.Load3DBlock(); if Window.SectionWorkspace then Window.SectionWorkspace:RefreshRoot(); end; end;
		end));

		function Window:Set3DRender(val)
			NeverLose:CloseAllPopups();
			if NeverLose.__CloseKeybindMenu then NeverLose.__CloseKeybindMenu(); end;
			if Window.SectionWorkspace then Window.SectionWorkspace:Finish(true); end;
			Window.__3DRender = val;
			NeverLose.Global3DRenderMode = val;

			if val then
				Window.Load3DBlock();
			else


				Part.Parent = nil;
			end;

			renderParentWindow();
			if Window.SectionWorkspace then Window.SectionWorkspace:RefreshRoot(); end;
		end;
	end;

	if not Window.Set3DRender then
		function Window:Set3DRender()
			Window.__3DRender = false;

			return false;
		end;
	end;

	function Window:AddTabLabel(Name: string)
		local TabLabel = Instance.new("TextLabel")

		TabLabel.Name = NeverLose.RandomString()
		TabLabel.Parent = LeftScrollingFrame
		Window.__Order = (Window.__Order or 0) + 1;
		TabLabel.LayoutOrder = Window.__Order;
		TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.BackgroundTransparency = 1.000
		TabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabLabel.BorderSizePixel = 0
		TabLabel.Size = UDim2.new(1, -7, 0, 15)
		TabLabel.ZIndex = 8
		NeverLose:RegisterFont(TabLabel, Enum.Font.GothamMedium);
		TabLabel.Text = Name
		NeverLose:BindTheme(TabLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(TabLabel, 11.000);
		TabLabel.TextTransparency = 0.500
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left

		local SetRender = LPH_NO_VIRTUALIZE(function(val)
			if val then
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 1
				})
			end
		end)

		SetRender(Window.Signal:GetValue());

		return Window.Signal:Connect(SetRender);
	end;

	Window.SectionWorkspace = NeverLose:CreateSectionWorkspace(Window, WindowFrame);
	function Window:ResetSectionLayout() Window.SectionWorkspace:Reset(); end;
	function Window:SetSectionGap(value) Window.SectionWorkspace:SetGap(value); end;

	function Window:AddTab(Config)
		Config = NeverLose:ProcessParams(Config , {
			Icon = "crosshairs",
			Name = "Tab",
			Type = "Double"
		});

		local Tab = {
			Signal = NeverLose:CreateSignal(false);
		};

		local TabButton = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TabIcon = Instance.new("TextLabel")
		local TabContentLabel = Instance.new("TextLabel")

		Tab.Idx = TabButton;

		TabButton.Name = NeverLose.RandomString();
		TabButton.Parent = LeftScrollingFrame
		Window.__Order = (Window.__Order or 0) + 1;
		TabButton.LayoutOrder = Window.__Order;
		NeverLose:BindTheme(TabButton, 'BackgroundColor3', 'Selected');
		TabButton.BackgroundTransparency = 0.500
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, -1, 0, 30)
		TabButton.ZIndex = 8

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = TabButton

		TabIcon.Name = NeverLose.RandomString();
		TabIcon.Parent = TabButton
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabIcon.BorderSizePixel = 0
		TabIcon.Position = UDim2.new(0, 2, 0.5, 0)
		TabIcon.Size = UDim2.new(0, 25, 0, 25)
		TabIcon.ZIndex = 9
		TabIcon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(TabIcon, 'TextColor3', 'Icon');
		TabIcon.Text = Config.Icon;
		TabIcon.TextColor3 = NeverLose.Theme.TabAccent
		NeverLose:SetTextSize(TabIcon, 16.000);
		TabIcon.TextWrapped = true

		TabContentLabel.Name = NeverLose.RandomString();
		TabContentLabel.Parent = TabButton
		TabContentLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabContentLabel.BackgroundTransparency = 1.000
		TabContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabContentLabel.BorderSizePixel = 0
		TabContentLabel.Position = UDim2.new(0, 30, 0.5, 0)
		TabContentLabel.Size = UDim2.new(1, -36, 0, 22)
		TabContentLabel.TextTruncate = Enum.TextTruncate.AtEnd
		TabContentLabel.ZIndex = 9
		NeverLose:RegisterFont(TabContentLabel, Enum.Font.GothamBold);
		TabContentLabel.Text = Config.Name
		NeverLose:BindTheme(TabContentLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(TabContentLabel, 13.000);
		TabContentLabel.TextXAlignment = Enum.TextXAlignment.Left

		local TabFrame = Instance.new("Frame")
		local LeftScroll = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local RightScroll = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")

		TabFrame.Name = NeverLose.RandomString();
		TabFrame.Parent = TabContainer
		TabFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabFrame.BackgroundTransparency = 1.000
		TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabFrame.BorderSizePixel = 0
		TabFrame.ClipsDescendants = true
		TabFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.Visible = false;

		LeftScroll.Name = NeverLose.RandomString();
		LeftScroll.Parent = TabFrame
		LeftScroll.Active = true
		LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		LeftScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LeftScroll.BackgroundTransparency = 1.000
		LeftScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LeftScroll.BorderSizePixel = 0
		LeftScroll.ClipsDescendants = false
		LeftScroll.Position = UDim2.new(0.25, 0, 0.5, 0)
		LeftScroll.Size = UDim2.new(0.5, 0, 1, -5)
		LeftScroll.ScrollBarThickness = 0

		UIListLayout.Parent = LeftScroll
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)

		local LeftScrollPadding = Instance.new("UIPadding")

		LeftScrollPadding.PaddingTop = UDim.new(0, 12)
		LeftScrollPadding.PaddingBottom = UDim.new(0, 12)
		LeftScrollPadding.Parent = LeftScroll

		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			LeftScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 25)
		end)))

		RightScroll.Name = NeverLose.RandomString();
		RightScroll.Parent = TabFrame
		RightScroll.Active = true
		RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
		RightScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RightScroll.BackgroundTransparency = 1.000
		RightScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
		RightScroll.BorderSizePixel = 0
		RightScroll.ClipsDescendants = false
		RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
		RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
		RightScroll.ScrollBarThickness = 0

		UIListLayout_2.Parent = RightScroll
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)

		local RightScrollPadding = Instance.new("UIPadding")

		RightScrollPadding.PaddingTop = UDim.new(0, 12)
		RightScrollPadding.PaddingBottom = UDim.new(0, 12)
		RightScrollPadding.Parent = RightScroll

		if Config.Type == "Single" then
			UIListLayout_2:Destroy();
			RightScroll:Destroy();
			RightScroll = LeftScroll;
			UIListLayout_2 = UIListLayout;
			LeftScroll.Size = UDim2.new(1, 0, 1, -5);
			LeftScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
		else
			NeverLose:AddSignal(UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				RightScroll.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y + 25)
			end)))
		end;

		Window.SectionWorkspace:RegisterTab(Tab, LeftScroll, RightScroll, UIListLayout, UIListLayout_2);
		Tab.SetValue = LPH_NO_VIRTUALIZE(function(value)
			value = value and true or false;
			TabFrame.Visible = value;
			Tab.Signal:SetValue(value);

			if value then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0,
					TextColor3 = NeverLose.Theme.TabAccent
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 0.5,
					TextColor3 = NeverLose.Theme.MutedText
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 0.5
				})
			end;
		end);

		table.insert(Window.Tabs,Tab);

		if Window.Tabs[Window.CurrentTab] == Tab then
			for _,other in ipairs(Window.Tabs) do
				other.SetValue(other == Tab and Window.Signal:GetValue());
			end;
		else
			Tab.SetValue(false);
		end;

		NeverLose:BindAccentHook(function(Value)
			if not TabIcon.Parent then
				error('unbound');
			end;

			if Tab.Signal:GetValue() then
				TabIcon.TextColor3 = NeverLose.Theme.TabAccent;
			end;
		end);

		NeverLose:BindThemeHook(function() if TabIcon.Parent then TabIcon.TextColor3 = Tab.Signal:GetValue() and NeverLose.Theme.TabAccent or NeverLose.Theme.MutedText; end; end);
		local over = NeverLose:CreateInput(TabButton,LPH_NO_VIRTUALIZE(function()
			for i,v in next , Window.Tabs do
				if v.Idx == TabButton then
					v.SetValue(true);
					Window.CurrentTab = i;
				else
					v.SetValue(false);
				end;
			end;
		end));

		NeverLose:AddSignal(over.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.8
				})
			end;
		end)))

		NeverLose:AddSignal(over.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Tabs[Window.CurrentTab] == Tab then
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end)))

		Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(value)
			if value then
				if Window.Tabs[Window.CurrentTab] == Tab then
					Tab.SetValue(true)
				else
					Tab.SetValue(false);
				end;
			else
				Tab.SetValue(false);

				NeverLose.PlayAnimate(TabButton , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(TabIcon , SlowyTween , {
					TextTransparency = 1,
				})

				NeverLose.PlayAnimate(TabContentLabel , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end));

		function Tab:AddSection(Config)
			Config = Config or {};

			local WantCollapsible = Config.Collapsible;
			local WantOpen = Config.Open;
			local WantLine = Config.Line;

			if WantCollapsible == nil then
				WantCollapsible = true;
			end;

			if WantOpen == nil then
				WantOpen = true;
			end;

			if WantLine == nil then
				WantLine = true;
			end;

			Config = NeverLose:ProcessParams(Config , {
				Name = "SECTION",
				Position = 'left',
				Icon = ''
			});

			local HeaderHeight = 36;
			local Opened = (WantOpen and true) or false;
			local SectionSignal = NeverLose:CreateSignal(Tab.Signal:GetValue());
			local Rendered = SectionSignal:GetValue();

			local SectionFrame = Instance.new("Frame")
			local SectionHandler = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local HeaderFrame = Instance.new("Frame")
			local SectionIcon = Instance.new("TextLabel")
			local SectionLabel = Instance.new("TextLabel")
			local ArrowIcon = Instance.new("TextLabel")
			local LineFrame = Instance.new("Frame")
			local ContentFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			SectionFrame.Name = NeverLose.RandomString();
			SectionFrame.Parent = (string.lower(Config.Position) == 'left' and LeftScroll) or RightScroll
			SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionFrame.BackgroundTransparency = 1.000
			SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionFrame.BorderSizePixel = 0
			SectionFrame.ClipsDescendants = false
			SectionFrame.Size = UDim2.new(1, -5, 0, HeaderHeight)
			SectionFrame.ZIndex = 9

			SectionHandler.Name = NeverLose.RandomString();
			SectionHandler.Parent = SectionFrame
			SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
			NeverLose:BindTheme(SectionHandler, 'BackgroundColor3', 'Section');
			SectionHandler.BackgroundTransparency = NeverLose.SectionTransparency

			NeverLose:RegisterCard(SectionHandler , LPH_NO_VIRTUALIZE(function()
				return Rendered;
			end));
			SectionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionHandler.BorderSizePixel = 0
			SectionHandler.ClipsDescendants = true
			SectionHandler.Position = UDim2.new(0.5, 0, 0, 0)
			SectionHandler.Size = UDim2.new(1, -10, 1, 0)
			SectionHandler.ZIndex = 9

			UIStroke.Transparency = 0.650
			NeverLose:BindTheme(UIStroke, 'Color', 'Border');
			UIStroke.Parent = SectionHandler

			NeverLose:BindCorner(UICorner, 'Panel');
			UICorner.Parent = SectionHandler

			HeaderFrame.Name = NeverLose.RandomString();
			HeaderFrame.Parent = SectionHandler
			HeaderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HeaderFrame.BackgroundTransparency = 1.000
			HeaderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HeaderFrame.BorderSizePixel = 0
			HeaderFrame.Position = UDim2.new(0, 0, 0, 0)
			HeaderFrame.Size = UDim2.new(1, 0, 0, HeaderHeight)
			HeaderFrame.ZIndex = 10

			SectionIcon.Name = NeverLose.RandomString();
			SectionIcon.Parent = HeaderFrame
			SectionIcon.AnchorPoint = Vector2.new(0, 0.5)
			SectionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionIcon.BackgroundTransparency = 1.000
			SectionIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionIcon.BorderSizePixel = 0
			SectionIcon.Position = UDim2.new(0, 11, 0.5, 0)
			SectionIcon.Size = UDim2.new(0, 18, 0, 18)
			SectionIcon.ZIndex = 11
			SectionIcon.FontFace = NeverLose.BuiltInBold;
			NeverLose:BindTheme(SectionIcon, 'TextColor3', 'Icon');
			SectionIcon.Text = ""
			NeverLose:BindAccent(SectionIcon , 'TextColor3');
			NeverLose:SetTextSize(SectionIcon, 16.000);
			SectionIcon.TextWrapped = true

			SectionLabel.Name = NeverLose.RandomString();
			SectionLabel.Parent = HeaderFrame
			SectionLabel.AnchorPoint = Vector2.new(0, 0.5)
			SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionLabel.BackgroundTransparency = 1.000
			SectionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionLabel.BorderSizePixel = 0
			SectionLabel.Position = UDim2.new(0, 12, 0.5, 0)
			SectionLabel.Size = UDim2.new(1, -46, 0, 22)
			SectionLabel.ZIndex = 11
			NeverLose:RegisterFont(SectionLabel, Enum.Font.GothamMedium);
			SectionLabel.Text = Config.Name
			NeverLose:BindTheme(SectionLabel, 'TextColor3', 'Text');
			NeverLose:SetTextSize(SectionLabel, 12.000);
			SectionLabel.TextTransparency = 0.150
			SectionLabel.TextTruncate = Enum.TextTruncate.AtEnd
			SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

			ArrowIcon.Name = NeverLose.RandomString();
			ArrowIcon.Parent = HeaderFrame
			ArrowIcon.AnchorPoint = Vector2.new(1, 0.5)
			ArrowIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ArrowIcon.BackgroundTransparency = 1.000
			ArrowIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ArrowIcon.BorderSizePixel = 0
			ArrowIcon.Position = UDim2.new(1, -11, 0.5, 0)
			ArrowIcon.Size = UDim2.new(0, 18, 0, 18)
			ArrowIcon.ZIndex = 11
			ArrowIcon.FontFace = NeverLose.BuiltInBold;
			NeverLose:BindTheme(ArrowIcon, 'TextColor3', 'Icon');
			ArrowIcon.Text = "chevron-small-down"
			NeverLose:BindTheme(ArrowIcon, 'TextColor3', 'MutedText');
			NeverLose:SetTextSize(ArrowIcon, 16.000);
			ArrowIcon.TextTransparency = 0.250
			ArrowIcon.TextWrapped = true
			ArrowIcon.Rotation = (Opened and 0) or -90
			ArrowIcon.Visible = WantCollapsible

			LineFrame.Name = NeverLose.RandomString();
			LineFrame.Parent = SectionHandler
			LineFrame.AnchorPoint = Vector2.new(0.5, 1)
			NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
			LineFrame.BackgroundTransparency = 0.550
			LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LineFrame.BorderSizePixel = 0
			LineFrame.Position = UDim2.new(0.5, 0, 0, HeaderHeight)
			LineFrame.Size = UDim2.new(1, -20, 0, 1)
			LineFrame.ZIndex = 11
			LineFrame.Visible = (WantLine and Opened) or false;

			ContentFrame.Name = NeverLose.RandomString();
			ContentFrame.Parent = SectionHandler
			ContentFrame.AnchorPoint = Vector2.new(0.5, 0)
			ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ContentFrame.BackgroundTransparency = 1.000
			ContentFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentFrame.BorderSizePixel = 0
			ContentFrame.ClipsDescendants = true
			ContentFrame.Active = false
			ContentFrame.ScrollBarThickness = 0
			ContentFrame.CanvasSize = UDim2.fromOffset(0,0)
			ContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
			ContentFrame.Position = UDim2.new(0.5, 0, 0, HeaderHeight)
			ContentFrame.Size = UDim2.new(1, 0, 1, -HeaderHeight)
			ContentFrame.ZIndex = 9

			UIListLayout.Parent = ContentFrame
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			if Config.Icon and Config.Icon ~= '' then
				NeverLose:SetIconMode(SectionIcon , Config.Icon);

				SectionIcon.Visible = true;
				SectionLabel.Position = UDim2.new(0, 35, 0.5, 0);
				SectionLabel.Size = UDim2.new(1, -69, 0, 22);
			else
				SectionIcon.Visible = false;
			end;

			local Section = NeverLose:RegisiterItem(ContentFrame , SectionSignal);

			local GetTargetSize = LPH_NO_VIRTUALIZE(function()
				if not Opened then
					return HeaderHeight;
				end;

				local content = UIListLayout.AbsoluteContentSize.Y;

				if content <= 1 then
					return HeaderHeight;
				end;

				return HeaderHeight + content;
			end);

			local SizeTween;
			local UpdateSize = LPH_NO_VIRTUALIZE(function(instant)
				local target = Window.SectionWorkspace:GetSize(SectionFrame, GetTargetSize(), HeaderHeight);

				if SizeTween then
					SizeTween:Cancel();
					SizeTween = nil;
				end;

				if instant or not Rendered then
					SectionFrame.Size = target;
				else
					SizeTween = NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
						Size = target
					});
				end;
			end);

			local UpdateArrow = LPH_NO_VIRTUALIZE(function(instant)
				local rotation = (Opened and 0) or -90;

				if instant then
					ArrowIcon.Rotation = rotation;
				else
					NeverLose.PlayAnimate(ArrowIcon , VSlowTween , {
						Rotation = rotation
					});
				end;
			end);

			NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				ContentFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y);
				UpdateSize(true);
			end)));

			Section.Root = SectionFrame;
			Section.Handler = SectionHandler;
			Section.Content = ContentFrame;

			function Section:SetOpen(value , instant)
				Opened = (value and true) or false;

				LineFrame.Visible = (WantLine and Opened) or false;

				UpdateArrow(instant);
				UpdateSize(instant);

				return Section;
			end;

			function Section:Toggle()
				return Section:SetOpen(not Opened);
			end;

			function Section:IsOpen()
				return Opened;
			end;

			function Section:SetName(text)
				SectionLabel.Text = tostring(text);

				return Section;
			end;

			function Section:SetIcon(icon)
				if icon and icon ~= '' then
					NeverLose:SetIconMode(SectionIcon , icon);

					SectionIcon.Visible = true;
					SectionLabel.Position = UDim2.new(0, 35, 0.5, 0);
					SectionLabel.Size = UDim2.new(1, -69, 0, 22);
				else
					SectionIcon.Visible = false;
					SectionLabel.Position = UDim2.new(0, 12, 0.5, 0);
					SectionLabel.Size = UDim2.new(1, -46, 0, 22);
				end;

				return Section;
			end;

			Section.SetRender = LPH_NO_VIRTUALIZE(function(value)
				Rendered = (value and true) or false;
				UpdateSize(true);

				if Rendered then
					NeverLose.PlayAnimate(SectionLabel , SlowyTween , {
						TextTransparency = 0.150
					})

					NeverLose.PlayAnimate(SectionIcon , SlowyTween , {
						TextTransparency = 0
					})

					NeverLose.PlayAnimate(ArrowIcon , SlowyTween , {
						TextTransparency = 0.250
					})

					NeverLose.PlayAnimate(LineFrame , SlowyTween , {
						BackgroundTransparency = 0.550
					})

					NeverLose.PlayAnimate(SectionHandler , SlowyTween , {
						BackgroundTransparency = NeverLose.SectionTransparency
					})

					NeverLose.PlayAnimate(UIStroke , SlowyTween , {
						Transparency = 0.650
					})
				else
					NeverLose.PlayAnimate(SectionLabel , SlowyTween , {
						TextTransparency = 1
					})

					NeverLose.PlayAnimate(SectionIcon , SlowyTween , {
						TextTransparency = 1
					})

					NeverLose.PlayAnimate(ArrowIcon , SlowyTween , {
						TextTransparency = 1
					})

					NeverLose.PlayAnimate(LineFrame , SlowyTween , {
						BackgroundTransparency = 1
					})

					NeverLose.PlayAnimate(SectionHandler , SlowyTween , {
						BackgroundTransparency = 1
					})

					NeverLose.PlayAnimate(UIStroke , SlowyTween , {
						Transparency = 1
					})
				end;
			end);

			local HeaderInput = NeverLose:CreateInput(HeaderFrame);
			local DockRecord = Window.SectionWorkspace:Register({API = Section, Root = SectionFrame, Handler = SectionHandler, HeaderHeight = HeaderHeight, Tab = Tab, Signal = SectionSignal, Update = UpdateSize, DragTarget = HeaderInput,
				OnClick = function() if WantCollapsible and Rendered then Section:SetOpen(not Opened); end; end});
			NeverLose:AddSignal(HeaderInput.MouseEnter:Connect(function() if Rendered then ArrowIcon.TextTransparency = 0; SectionLabel.TextTransparency = 0; end; end));
			NeverLose:AddSignal(HeaderInput.MouseLeave:Connect(function() if Rendered then ArrowIcon.TextTransparency = 0.25; SectionLabel.TextTransparency = 0.15; end; end));

			UpdateArrow(true);
			UpdateSize(true);

			Section.SetRender(SectionSignal:GetValue());
			SectionSignal:Connect(Section.SetRender);

			return Section;
		end;

		function Tab:AddMultiSection(Config)
			Config = Config or {};

			local RawTabs = Config.Tabs or Config.Sections or Config.Values;
			local DefaultTab = Config.Default;

			Config = NeverLose:ProcessParams(Config , {
				Position = 'left'
			});

			if type(RawTabs) ~= 'table' or #RawTabs == 0 then
				RawTabs = {"Rage" , "Legit" , "Misc"};
			end;

			local BarHeight = 36;
			local SectionSignal = NeverLose:CreateSignal(Tab.Signal:GetValue());
			local Rendered = SectionSignal:GetValue();

			local MultiSection = {
				Sections = {},
				Order = {},
				Current = nil
			};

			local SectionFrame = Instance.new("Frame")
			local SectionHandler = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local TabBar = Instance.new("Frame")
			local BarLayout = Instance.new("UIListLayout")
			local LineFrame = Instance.new("Frame")

			SectionFrame.Name = NeverLose.RandomString();
			SectionFrame.Parent = (string.lower(Config.Position) == 'left' and LeftScroll) or RightScroll
			SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionFrame.BackgroundTransparency = 1.000
			SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionFrame.BorderSizePixel = 0
			SectionFrame.ClipsDescendants = false
			SectionFrame.Size = UDim2.new(1, -5, 0, BarHeight)
			SectionFrame.ZIndex = 9

			SectionHandler.Name = NeverLose.RandomString();
			SectionHandler.Parent = SectionFrame
			SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
			NeverLose:BindTheme(SectionHandler, 'BackgroundColor3', 'Section');
			SectionHandler.BackgroundTransparency = NeverLose.SectionTransparency

			NeverLose:RegisterCard(SectionHandler , LPH_NO_VIRTUALIZE(function()
				return Rendered;
			end));
			SectionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionHandler.BorderSizePixel = 0
			SectionHandler.ClipsDescendants = true
			SectionHandler.Position = UDim2.new(0.5, 0, 0, 0)
			SectionHandler.Size = UDim2.new(1, -10, 1, 0)
			SectionHandler.ZIndex = 9

			UIStroke.Transparency = 0.650
			NeverLose:BindTheme(UIStroke, 'Color', 'Border');
			UIStroke.Parent = SectionHandler

			NeverLose:BindCorner(UICorner, 'Panel');
			UICorner.Parent = SectionHandler

			TabBar.Name = NeverLose.RandomString();
			TabBar.Parent = SectionHandler
			TabBar.AnchorPoint = Vector2.new(0.5, 0)
			TabBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabBar.BackgroundTransparency = 1.000
			TabBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabBar.BorderSizePixel = 0
			TabBar.Position = UDim2.new(0.5, -12, 0, 0)
			TabBar.Size = UDim2.new(1, -44, 0, BarHeight)
			TabBar.ZIndex = 10

			BarLayout.Parent = TabBar
			BarLayout.FillDirection = Enum.FillDirection.Horizontal
			BarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			BarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			BarLayout.SortOrder = Enum.SortOrder.LayoutOrder
			BarLayout.Padding = UDim.new(0, 4)

			LineFrame.Name = NeverLose.RandomString();
			LineFrame.Parent = SectionHandler
			LineFrame.AnchorPoint = Vector2.new(0.5, 1)
			NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
			LineFrame.BackgroundTransparency = 0.550
			LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LineFrame.BorderSizePixel = 0
			LineFrame.Position = UDim2.new(0.5, 0, 0, BarHeight)
			LineFrame.Size = UDim2.new(1, -20, 0, 1)
			LineFrame.ZIndex = 10

			local GetTargetSize = LPH_NO_VIRTUALIZE(function()
				local data = MultiSection.Current and MultiSection.Sections[MultiSection.Current];

				if not data then
					return BarHeight;
				end;

				local content = data.Layout.AbsoluteContentSize.Y;

				if content <= 1 then
					content = data.Height or 0;
				end;

				if content <= 1 then
					return BarHeight;
				end;

				return BarHeight + content;
			end);

			local SizeTween;
			local UpdateSize = LPH_NO_VIRTUALIZE(function(instant)
				local target = Window.SectionWorkspace:GetSize(SectionFrame, GetTargetSize(), BarHeight);

				if SizeTween then
					SizeTween:Cancel();
					SizeTween = nil;
				end;

				if instant or not Rendered then
					SectionFrame.Size = target;
				else
					SizeTween = NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
						Size = target
					});
				end;
			end);

			local UpdateTabs = LPH_NO_VIRTUALIZE(function(instant)
				for i , key in ipairs(MultiSection.Order) do
					local data = MultiSection.Sections[key];
					local active = (key == MultiSection.Current);
					local textalpha = 1;
					local linealpha = 1;

					if Rendered then
						textalpha = (active and 0) or 0.550;
						linealpha = (active and 0) or 1;
					end;

					data.Underline.BackgroundColor3 = NeverLose.Theme.TabAccent;

					if instant then
						data.Label.TextTransparency = textalpha;
						data.Label.TextColor3 = (active and NeverLose.Theme.TabAccent) or NeverLose.Theme.Text;
						data.Underline.BackgroundTransparency = linealpha;
					else
						NeverLose.PlayAnimate(data.Label , SlowyTween , {
							TextTransparency = textalpha,
							TextColor3 = (active and NeverLose.Theme.TabAccent) or NeverLose.Theme.Text
						});

						NeverLose.PlayAnimate(data.Underline , SlowyTween , {
							BackgroundTransparency = linealpha
						});
					end;
				end;
			end);

			NeverLose:BindAccentHook(function(Value)
				if not TabBar.Parent then
					error('unbound');
				end;

				for _,key in ipairs(MultiSection.Order) do
					local data = MultiSection.Sections[key];

					if data then
						data.Underline.BackgroundColor3 = NeverLose.Theme.TabAccent;

						if key == MultiSection.Current then
							data.Label.TextColor3 = NeverLose.Theme.TabAccent;
						end;
					end;
				end;
			end);

			for i , rawname in ipairs(RawTabs) do
				local name = tostring(rawname);

				if not MultiSection.Sections[name] then
					local ButtonFrame = Instance.new("Frame")
					local ButtonLabel = Instance.new("TextLabel")
					local Underline = Instance.new("Frame")
					local UnderlineCorner = Instance.new("UICorner")
					local PageFrame = Instance.new("ScrollingFrame")
					local PageLayout = Instance.new("UIListLayout")
					local PageSignal = NeverLose:CreateSignal(false);
					local TextBounds = NeverLose:MeasureText(name , 12 , Enum.Font.GothamMedium , Vector2.new(math.huge , math.huge));

					ButtonFrame.Name = NeverLose.RandomString();
					ButtonFrame.Parent = TabBar
					ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonFrame.BackgroundTransparency = 1.000
					ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonFrame.BorderSizePixel = 0
					ButtonFrame.LayoutOrder = i
					ButtonFrame.Size = UDim2.new(0, TextBounds.X + 16, 1, -3)
					ButtonFrame.ZIndex = 11

					ButtonLabel.Name = NeverLose.RandomString();
					ButtonLabel.Parent = ButtonFrame
					ButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonLabel.BackgroundTransparency = 1.000
					ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					ButtonLabel.BorderSizePixel = 0
					ButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					ButtonLabel.Size = UDim2.new(1, 0, 0, 15)
					ButtonLabel.ZIndex = 12
					NeverLose:RegisterFont(ButtonLabel, Enum.Font.GothamMedium);
					ButtonLabel.Text = name
					NeverLose:BindTheme(ButtonLabel, 'TextColor3', 'Text');
					NeverLose:SetTextSize(ButtonLabel, 12.000);
					ButtonLabel.TextTransparency = 1.000
					local RefreshTabMetrics = function()
						if ButtonFrame.Parent then local bounds = NeverLose:MeasureText(ButtonLabel.Text, ButtonLabel.TextSize, ButtonLabel.FontFace); ButtonFrame.Size = UDim2.new(0, math.ceil(bounds.X) + 16, 1, -3); end;
					end;
					NeverLose:BindTypography(RefreshTabMetrics); RefreshTabMetrics();

					Underline.Name = NeverLose.RandomString();
					Underline.Parent = ButtonFrame
					Underline.AnchorPoint = Vector2.new(0.5, 1)
					NeverLose:BindTheme(Underline, 'BackgroundColor3', 'TabAccent');
					Underline.BackgroundTransparency = 1.000
					Underline.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Underline.BorderSizePixel = 0
					Underline.Position = UDim2.new(0.5, 0, 1, 0)
					Underline.Size = UDim2.new(1, -6, 0, 2)
					Underline.ZIndex = 12

					UnderlineCorner.CornerRadius = UDim.new(1, 0)
					UnderlineCorner.Parent = Underline

					PageFrame.Name = NeverLose.RandomString();
					PageFrame.Parent = SectionHandler
					PageFrame.AnchorPoint = Vector2.new(0.5, 0)
					PageFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					PageFrame.BackgroundTransparency = 1.000
					PageFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PageFrame.BorderSizePixel = 0
					PageFrame.ClipsDescendants = true
					PageFrame.Active = true
					PageFrame.ScrollBarThickness = 0
					PageFrame.CanvasSize = UDim2.fromOffset(0,0)
					PageFrame.ScrollingDirection = Enum.ScrollingDirection.Y
					PageFrame.Position = UDim2.new(0.5, 0, 0, BarHeight)
					PageFrame.Size = UDim2.new(1, 0, 1, -BarHeight)
					PageFrame.Visible = false
					PageFrame.ZIndex = 9

					PageLayout.Parent = PageFrame
					PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
					PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

					local Item = NeverLose:RegisiterItem(PageFrame , PageSignal);

					Item.Root = PageFrame;

					local data = {
						Name = name,
						Frame = PageFrame,
						Layout = PageLayout,
						Signal = PageSignal,
						Button = ButtonFrame,
						Label = ButtonLabel,
						Underline = Underline,
						Item = Item,
						Height = 0
					};

					MultiSection.Sections[name] = data;

					table.insert(MultiSection.Order , name);

					NeverLose:AddSignal(PageLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
						data.Height = PageLayout.AbsoluteContentSize.Y;
						PageFrame.CanvasSize = UDim2.fromOffset(0, data.Height + 6);

						if MultiSection.Current == name then
							UpdateSize(true);
						end;
					end)));

					local ButtonInput = NeverLose:CreateInput(ButtonFrame , LPH_NO_VIRTUALIZE(function()
						if not Rendered then
							return;
						end;

						MultiSection:SetSection(name);
					end));

					NeverLose:AddSignal(ButtonInput.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
						if not Rendered or MultiSection.Current == name then
							return;
						end;

						NeverLose.PlayAnimate(ButtonLabel , SlowyTween , {
							TextTransparency = 0.250
						});
					end)))

					NeverLose:AddSignal(ButtonInput.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
						if not Rendered or MultiSection.Current == name then
							return;
						end;

						NeverLose.PlayAnimate(ButtonLabel , SlowyTween , {
							TextTransparency = 0.550
						});
					end)))
				end;
			end;

			function MultiSection:SetSection(name , instant)
				name = tostring(name);

				if not MultiSection.Sections[name] then
					return MultiSection;
				end;

				MultiSection.Current = name;

				for i , key in ipairs(MultiSection.Order) do
					local data = MultiSection.Sections[key];
					local active = (key == name);

					data.Frame.Visible = active;
					data.Signal:SetValue((active and Rendered) or false);
				end;

				UpdateTabs(instant);
				UpdateSize(instant);

				return MultiSection;
			end;

			function MultiSection:GetSection(name)
				local data = MultiSection.Sections[tostring(name)];

				return data and data.Item;
			end;

			function MultiSection:GetCurrent()
				return MultiSection.Current;
			end;

			MultiSection.SetRender = LPH_NO_VIRTUALIZE(function(value)
				Rendered = (value and true) or false;
				UpdateSize(true);

				if Rendered then
					NeverLose.PlayAnimate(SectionHandler , SlowyTween , {
						BackgroundTransparency = NeverLose.SectionTransparency
					})

					NeverLose.PlayAnimate(UIStroke , SlowyTween , {
						Transparency = 0.650
					})

					NeverLose.PlayAnimate(LineFrame , SlowyTween , {
						BackgroundTransparency = 0.550
					})
				else
					NeverLose.PlayAnimate(SectionHandler , SlowyTween , {
						BackgroundTransparency = 1
					})

					NeverLose.PlayAnimate(UIStroke , SlowyTween , {
						Transparency = 1
					})

					NeverLose.PlayAnimate(LineFrame , SlowyTween , {
						BackgroundTransparency = 1
					})
				end;

				for i , key in ipairs(MultiSection.Order) do
					local data = MultiSection.Sections[key];

					data.Signal:SetValue((Rendered and key == MultiSection.Current) or false);
				end;

				UpdateTabs(false);
			end);

			MultiSection.Root = SectionFrame;
			MultiSection.Handler = SectionHandler;
			local DragHandle = Instance.new('ImageButton');
			DragHandle.Name = 'SectionDragHandle'; DragHandle.Parent = SectionHandler;
			DragHandle.Image = ''; DragHandle.BackgroundTransparency = 1; DragHandle.AutoButtonColor = false;
			DragHandle.AnchorPoint = Vector2.new(1,0); DragHandle.Position = UDim2.new(1,-4,0,0); DragHandle.Size = UDim2.fromOffset(22,BarHeight); DragHandle.ZIndex = 30;
			for x=0,1 do for y=0,2 do
				local dot=Instance.new('Frame'); dot.Parent=DragHandle; dot.BorderSizePixel=0; dot.BackgroundTransparency=0.3;
				dot.Size=UDim2.fromOffset(2,2); dot.Position=UDim2.fromOffset(7+x*5,BarHeight/2-6+y*5); dot.ZIndex=31; NeverLose:BindTheme(dot,'BackgroundColor3','Icon');
			end; end;
			Window.SectionWorkspace:Register({API=MultiSection,Root=SectionFrame,Handler=SectionHandler,HeaderHeight=BarHeight,Tab=Tab,Signal=SectionSignal,Update=UpdateSize,DragTarget=DragHandle});
			NeverLose:BindThemeHook(function() if SectionFrame.Parent then UpdateTabs(true); end; end);

			local StartTab = MultiSection.Order[1];

			if DefaultTab and MultiSection.Sections[tostring(DefaultTab)] then
				StartTab = tostring(DefaultTab);
			end;

			if StartTab then
				MultiSection:SetSection(StartTab , true);
			end;

			MultiSection.SetRender(SectionSignal:GetValue());
			SectionSignal:Connect(MultiSection.SetRender);

			return MultiSection;
		end;

		return Tab;
	end;

	function Window:_InitConfig()
		local ConfigSignal = NeverLose:CreateSignal(false);
		local ConfigLib = {
			Signals = {},
		};

		local ConfigMenu = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local UIStroke = Instance.new("UIStroke")
		local InputFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local TextInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		local LoadConfig = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner_3 = Instance.new("UICorner")
		local UICorner_4 = Instance.new("UICorner")

		local shadow = NeverLose:CreateShadow(ConfigMenu);

		ConfigLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			NeverLose:SetPopupOpen(ConfigMenu,value);
			if value then
				ConfigMenu.Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 0.035,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 95)
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 0.65
				})	

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 0
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 0.350
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.350
				})	

				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 180
				})	

				shadow:Render(true)
			else
				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 0
				})

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})	

				shadow:Render(false)
			end;
		end);

		NeverLose:AddSignal(ConfigMenu:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigMenu.BackgroundTransparency > 0.9 then
				ConfigMenu.Visible = false;
				UIListLayout.Parent = nil;
				ConfigMenu.Parent = nil;
			else

				ConfigMenu.Visible = true;
				UIListLayout.Parent = ConfigMenu

				if NeverLose.Global3DRenderMode then
					ConfigMenu.Parent = NeverLose.GlobalSurfaceGui;
					NeverLose:ElevatePopup(ConfigMenu);
				else
					ConfigMenu.Parent = NeverLose.ScreenGui;
					NeverLose:ElevatePopup(ConfigMenu);
				end;
			end
		end)))

		ConfigMenu.Name = NeverLose.RandomString();
		ConfigMenu.Parent = NeverLose.ScreenGui;
		NeverLose:ElevatePopup(ConfigMenu);
		ConfigMenu.AnchorPoint = Vector2.new(0.5, 0)
		NeverLose:BindTheme(ConfigMenu, 'BackgroundColor3', 'Section');
		ConfigMenu.BackgroundTransparency = 0.035
		ConfigMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigMenu.BorderSizePixel = 0
		ConfigMenu.ClipsDescendants = true
		ConfigMenu.Position = UDim2.new(255,255,255,255)
		ConfigMenu.Size = UDim2.new(0, 220,0, 110)
		ConfigMenu.ZIndex = 151

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = ConfigMenu

		UIListLayout.Parent = ConfigMenu
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = ConfigMenu

		InputFrame.Name = NeverLose.RandomString();
		InputFrame.Parent = ConfigMenu
		NeverLose:BindTheme(InputFrame, 'BackgroundColor3', 'Hover');
		InputFrame.BackgroundTransparency = 1.000
		InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputFrame.BorderSizePixel = 0
		InputFrame.Size = UDim2.new(1, 0, 0, 30)
		InputFrame.ZIndex = 154

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = InputFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = 154
		NeverLose:RegisterFont(BasedLabel, Enum.Font.GothamMedium);
		BasedLabel.Text = "Config"
		NeverLose:BindTheme(BasedLabel, 'TextColor3', 'Text');
		NeverLose:SetTextSize(BasedLabel, 13.000);
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = InputFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		NeverLose:BindTheme(LineFrame, 'BackgroundColor3', 'Border');
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = 154

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = InputFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = 154

		UIListLayout_2.Parent = BasedHandler
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout_2.Padding = UDim.new(0, 5)

		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			if #ConfigLib.Signals <= 0 then
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 0);
				})
			else
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 5);
				})
			end;

		end)));

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = BasedHandler
		NeverLose:BindTheme(TextInput, 'BackgroundColor3', 'Control');
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, 100, 0, 18)
		TextInput.ZIndex = 154

		NeverLose:BindCorner(UICorner_2, 'Control');
		UICorner_2.Parent = TextInput

		UIStroke_2.Transparency = 0.650
		NeverLose:BindTheme(UIStroke_2, 'Color', 'Border');
		UIStroke_2.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = 154
		TextBox.ClearTextOnFocus = false
		NeverLose:RegisterFont(TextBox, Enum.Font.GothamMedium);
		TextBox.PlaceholderText = "Config Name ..."
		TextBox.Text = ""
		NeverLose:BindTheme(TextBox, 'TextColor3', 'Text');
		NeverLose:SetTextSize(TextBox, 11.000);
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		LoadConfig.Name = NeverLose.RandomString();
		LoadConfig.Parent = BasedHandler
		NeverLose:BindTheme(LoadConfig, 'BackgroundColor3', 'Hover');
		LoadConfig.BackgroundTransparency = 1.000
		LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LoadConfig.BorderSizePixel = 0
		LoadConfig.ClipsDescendants = true
		LoadConfig.Size = UDim2.new(0, 20, 0, 18)
		LoadConfig.ZIndex = 153

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LoadConfig
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = 153
		Icon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
		Icon.Text = "plus-large"
		NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Icon, 16.000);
		Icon.TextTransparency = 0.350
		Icon.TextWrapped = true

		NeverLose:BindCorner(UICorner_3, 'Control');
		UICorner_3.Parent = LoadConfig

		NeverLose:BindCorner(UICorner_4, 'Panel');
		UICorner_4.Parent = InputFrame

		local OpenButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")

		OpenButton.Name = NeverLose.RandomString();
		OpenButton.Parent = ConfigFrame
		OpenButton.AnchorPoint = Vector2.new(0, 0.5)
		NeverLose:BindTheme(OpenButton, 'BackgroundColor3', 'Section');
		OpenButton.BackgroundTransparency = 1.000
		OpenButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.BorderSizePixel = 0
		OpenButton.Position = UDim2.new(0, 31, 0.5, 0)
		OpenButton.Size = UDim2.new(1, -31, 1, 0)
		OpenButton.ZIndex = 10
		NeverLose:RegisterFont(OpenButton, Enum.Font.SourceSans);
		OpenButton.Text = ""
		OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		NeverLose:SetTextSize(OpenButton, 14.000);
		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = OpenButton

		NeverLose:RegisterPopup(ConfigMenu,ConfigFrame,function() ConfigSignal:SetValue(false); end);
		ConfigLib.SetRender(false);
		Window.Signal:Connect(function(value) if not value then ConfigSignal:SetValue(false); end; end);
		ConfigSignal:Connect(ConfigLib.SetRender);
		ConfigLib.UnsafeThread = nil;
		ConfigLib.SelectedConfig = "Default";

		local UpdateSize = LPH_NO_VIRTUALIZE(function()
			local size = NeverLose:MeasureText(ConfigName.Text, ConfigName.TextSize, ConfigName.FontFace,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(ConfigFrame,SlowyTween , {
				Size = UDim2.fromOffset(size.X + 75, 30)
			});
		end);

		UpdateSize();

		function ConfigLib:GetData(performance)
			local ikc = {};
			
			local cd = 0;
			for Flag,v in next , NeverLose.Flags do
				if v and v.GetValue then
					local data = v:GetValue();

					if typeof(data) == 'Color3' then
						table.insert(ikc,{
							Idx = Flag,
							Value = data:ToHex(),
						});
					else
						table.insert(ikc,{
							Idx = Flag,
							Value = data
						});
					end;
				end;
				
				if performance then
					if cd % 35 == 1 then
						task.wait()
					end
				end;
				
				cd += 1;
			end;

			return NeverLose.Base64Encode(Encryption.new(HttpService:JSONEncode(ikc)));
		end;

		function ConfigLib:LoadData(data)
			local coded = HttpService:JSONDecode(Encryption.reverse(NeverLose.Base64Decode(data)));

			for i,v in next , coded do
				if v.Idx then
					if NeverLose.Flags[v.Idx] then
						task.spawn(function()
							NeverLose.Flags[v.Idx]:SetValue(v.Value)
						end)
					end;
				end;
			end;
		end;

		function ConfigLib:RefreshConfig()
			if not isfolder(Window.ConfigFolder) then
				makefolder(Window.ConfigFolder);
			end;
			
			if not isfile(Window.ConfigFolder..'/Default') then
				writefile(Window.ConfigFolder..'/Default',ConfigLib:GetData());
			end;
			
			for i,v in next,ConfigMenu:GetChildren() do
				if v:GetAttribute('ConfigItem') then
					v:Destroy();
				end;
			end;

			for i,v in next , ConfigLib.Signals do
				v:Disconnect();
			end

			table.clear(ConfigLib.Signals);

			local ConfigList = {};
			for i,v in next , listfiles(Window.ConfigFolder) do

				local name = string.sub(v , #Window.ConfigFolder + 2);

				table.insert(ConfigList , name)
			end;

			for i,ConfigNameStr in next , ConfigList do
				local ConfigItemFrame = Instance.new("Frame")
				local BasedHandler = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local DeleteConfig = Instance.new("Frame")
				local Icon = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local LoadConfig = Instance.new("Frame")
				local Icon_2 = Instance.new("TextLabel")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local BasedLabel = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")

				ConfigItemFrame.Name = NeverLose.RandomString();
				ConfigItemFrame.Parent = ConfigMenu
				ConfigItemFrame.BackgroundColor3 = Color3.fromRGB(21, 20, 27)
				ConfigItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ConfigItemFrame.BorderSizePixel = 0
				ConfigItemFrame.Size = UDim2.new(1, -10, 0, 30)
				ConfigItemFrame.ZIndex = 153
				ConfigItemFrame:SetAttribute('ConfigItem',true);

				BasedHandler.Name = NeverLose.RandomString();
				BasedHandler.Parent = ConfigItemFrame
				BasedHandler.AnchorPoint = Vector2.new(1, 0)
				BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedHandler.BackgroundTransparency = 1.000
				BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedHandler.BorderSizePixel = 0
				BasedHandler.Position = UDim2.new(1, -11, 0, 2)
				BasedHandler.Size = UDim2.new(1, -20, 0, 25)
				BasedHandler.ZIndex = 153

				UIListLayout.Parent = BasedHandler
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 5)

				DeleteConfig.Name = NeverLose.RandomString();
				DeleteConfig.Parent = BasedHandler
				NeverLose:BindTheme(DeleteConfig, 'BackgroundColor3', 'Hover');
				DeleteConfig.BackgroundTransparency = 1.000
				DeleteConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DeleteConfig.BorderSizePixel = 0
				DeleteConfig.ClipsDescendants = true
				DeleteConfig.Size = UDim2.new(0, 20, 0, 18)
				DeleteConfig.ZIndex = 153

				Icon.Name = NeverLose.RandomString();
				Icon.Parent = DeleteConfig
				Icon.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon.Size = UDim2.new(1, 0, 1, 0)
				Icon.ZIndex = 153
				Icon.FontFace = NeverLose.BuiltInBold;
				NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
				Icon.Text = "trash-can"
				NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
				NeverLose:SetTextSize(Icon, 16.000);
				Icon.TextTransparency = 0.400
				Icon.TextWrapped = true

				NeverLose:BindCorner(UICorner, 'Control');
				UICorner.Parent = DeleteConfig

				LoadConfig.Name = NeverLose.RandomString();
				LoadConfig.Parent = BasedHandler
				NeverLose:BindTheme(LoadConfig, 'BackgroundColor3', 'Hover');
				LoadConfig.BackgroundTransparency = 1.000
				LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LoadConfig.BorderSizePixel = 0
				LoadConfig.ClipsDescendants = true
				LoadConfig.Size = UDim2.new(0, 20, 0, 18)
				LoadConfig.ZIndex = 153

				Icon_2.Name = NeverLose.RandomString();
				Icon_2.Parent = LoadConfig
				Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_2.BackgroundTransparency = 1.000
				Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_2.BorderSizePixel = 0
				Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_2.Size = UDim2.new(1, 0, 1, 0)
				Icon_2.ZIndex = 153
				Icon_2.FontFace = NeverLose.BuiltInBold;
				NeverLose:BindTheme(Icon_2, 'TextColor3', 'Icon');
				Icon_2.Text = "arrow-right-from-portrait-rectangle"
				NeverLose:BindTheme(Icon_2, 'TextColor3', 'MutedText');
				NeverLose:SetTextSize(Icon_2, 16.000);
				Icon_2.TextTransparency = 0.400
				Icon_2.TextWrapped = true

				NeverLose:BindCorner(UICorner_2, 'Control');
				UICorner_2.Parent = LoadConfig

				NeverLose:BindCorner(UICorner_3, 'Control');
				UICorner_3.Parent = ConfigItemFrame

				BasedLabel.Name = NeverLose.RandomString();
				BasedLabel.Parent = ConfigItemFrame
				BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.BackgroundTransparency = 1.000
				BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedLabel.BorderSizePixel = 0
				BasedLabel.Position = UDim2.new(0, 11, 0, 7)
				BasedLabel.Size = UDim2.new(0, 1, 0, 15)
				BasedLabel.ZIndex = 153
				NeverLose:RegisterFont(BasedLabel, Enum.Font.GothamMedium);
				BasedLabel.Text = ConfigNameStr
				NeverLose:BindTheme(BasedLabel, 'TextColor3', 'Text');
				NeverLose:SetTextSize(BasedLabel, 13.000);
				BasedLabel.TextTransparency = 0.200
				BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

				UIStroke.Transparency = 0.500
				NeverLose:BindTheme(UIStroke, 'Color', 'Border');
				UIStroke.Parent = ConfigItemFrame

				local Render = LPH_NO_VIRTUALIZE(function(rst)
					if rst then
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 0
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 0.200
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 0.500
						})
					else
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 1
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 1
						})
					end;
				end)

				Render(ConfigSignal:GetValue());
				table.insert(ConfigLib.Signals , ConfigSignal:Connect(Render));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.25
					})
				end)));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.500
					})
				end)));

				local deleter,signal = NeverLose:CreateInput(DeleteConfig,function()
					if ConfigNameStr == "Default" then
						Logging.new("trash-can","You can't delete default config!",3.5)
						return;
					end;
					
					delfile(Window.ConfigFolder..'/'..ConfigNameStr);

					UpdateSize();

					ConfigLib:RefreshConfig();

					Logging.new("trash-can",'Deleted '..tostring(ConfigNameStr),3.5)
				end);


				local _,load_signal = NeverLose:CreateInput(LoadConfig,function()
					local path = Window.ConfigFolder..'/'..ConfigNameStr;

					if isfile(path) then
						local data = readfile(path);

						ConfigLib:LoadData(data);

						ConfigLib.SelectedConfig = ConfigNameStr;
						ConfigName.Text = ConfigNameStr;

						UpdateSize();

						ConfigLib:RefreshConfig();

						Logging.new("folder",'Loaded '..tostring(ConfigNameStr),3.5)
					end
				end);

				table.insert(ConfigLib.Signals , signal);
				table.insert(ConfigLib.Signals , load_signal);

				table.insert(ConfigLib.Signals , deleter.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = Color3.fromRGB(223, 125, 125)
					})
				end)))

				table.insert(ConfigLib.Signals , deleter.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = NeverLose.AccentColor
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
			end;

			table.clear(ConfigList);
		end;
		


		local hover_write = NeverLose:CreateInput(ConfigIcon,function()
			local path = Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default");

			if isfile(path) then
				writefile(Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default"),ConfigLib:GetData());

				Logging.new("folder",'Saved '..tostring(ConfigLib.SelectedConfig),3.5)
			end;
		end);

		NeverLose:AddSignal(hover_write.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.1
			})
		end)));

		NeverLose:AddSignal(hover_write.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.25
			})
		end)));


		local mv = NeverLose:CreateInput(LoadConfig , function()
			local cfg_name = TextBox.Text;

			if cfg_name and cfg_name:byte() and not cfg_name:find('/',1,true) and not cfg_name:find('\\',1,true) then
				cfg_name = string.sub(cfg_name , 1 , 24);

				writefile(Window.ConfigFolder..'/'..cfg_name,ConfigLib:GetData());
				ConfigLib.SelectedConfig = cfg_name;
				ConfigName.Text = cfg_name;

				Logging.new("folder",'Created '..tostring(cfg_name),3.5)

				TextBox.Text = "";

				UpdateSize();

				ConfigLib:RefreshConfig();
			end;
		end);

		NeverLose:AddSignal(mv.MouseEnter:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.1
			})
		end))

		NeverLose:AddSignal(mv.MouseLeave:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.35
			})
		end))

		ConfigLib:RefreshConfig();

		OpenButton.MouseButton1Click:Connect(LPH_NO_VIRTUALIZE(function()
			if NeverLose:CanUsePointer(OpenButton) then ConfigSignal:SetValue(true); end;
		end));

		return ConfigLib;
	end;

	Window:_InitConfig();

	local UserSettings = NeverLose:CreateOptionWindow(BottomFrame , BottomFrame.ZIndex + 13);
	NeverLose:CreateInput(BottomFrame , LPH_NO_VIRTUALIZE(function() UserSettings.Signal:SetValue(true); end));
	Window.Signal:Connect(function(value) if not value then UserSettings.Signal:SetValue(false); end; end);

	Window.UserSettings = UserSettings;

	function Window:SetAccount(Config)
		Config = NeverLose:ProcessParams(Config , {
			Profile = NeverLose.UserProfile,
			Username = LocalPlayer.DisplayName,
			Expires = "Never",
		});

		AccountName.Text = Config.Username;
		AccountProfile.Image = Config.Profile;
		ExpireLabel.Text = Config.Expires;

		Window.Username = Config.Username or Window.Username;
		Window.Profile = Config.Profile or Window.Profile;
		Window.Expires = Config.Expires or Window.Expires;

		if Window.UserSettings.UserFrame then
			Window.UserSettings.UserFrame:SetUsername(Window.Username);
			Window.UserSettings.UserFrame:SetProfile(Window.Profile);
			Window.UserSettings.UserFrame:SetExpires(Window.Expires);
		else
			Window.UserSettings.UserFrame = UserSettings:AddUserFrame(Window.Username , Window.Profile , Window.Expires);
		end;
	end;

	function Window:SetSize(newsize)
		Window.Size = NeverLose:FitWindowSize(newsize);

		if Window.Signal:GetValue() then
			NeverLose.PlayAnimate(WindowFrame , VSlowTween , {
				Size = Window.Size
			})
		end
	end;

	Window:SetAccount();

	NeverLose:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(value,ISTYPING)
		if value.KeyCode == Window.Keybind or value.KeyCode.Name == Window.Keybind then
			if not ISTYPING then
				Window:ToggleInterface()
			end
		end;
	end)));

	function Window:ToggleInterface()
		Window.Signal:SetValue(not Window.Signal:GetValue());

		if Window.__3DRender then
			Window.Load3DBlock();
		end;
	end;

	function Window:Watermark()
		if NeverLose.__WatermarkCache then
			return NeverLose.__WatermarkCache;
		end;

		local Watermark_lb = {Renders = {}, Status = true, __Order = 0};
		local Watermark = Instance.new('Frame');
		Watermark.Name = NeverLose.RandomString();
		Watermark.AnchorPoint = Vector2.new(1, 0);
		NeverLose:BindTheme(Watermark, 'BackgroundColor3', 'Window');
		Watermark.BackgroundTransparency = 0.200;
		Watermark.BorderSizePixel = 0;
		Watermark.ClipsDescendants = true;
		Watermark.Position = UDim2.new(1, -10, 0, 10);
		Watermark.Size = UDim2.fromOffset(20, 30);
		Watermark.ZIndex = 16;
		Watermark.Visible = false;
		Watermark.Parent = NeverLose.ScreenGui;

		local Corner = Instance.new('UICorner');
		NeverLose:BindCorner(Corner, 'Panel');
		Corner.Parent = Watermark;

		local Layout = Instance.new('UIListLayout');
		Layout.FillDirection = Enum.FillDirection.Horizontal;
		Layout.SortOrder = Enum.SortOrder.LayoutOrder;
		Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
		Layout.VerticalAlignment = Enum.VerticalAlignment.Center;
		Layout.Padding = UDim.new(0, 0);
		Layout.Parent = Watermark;

		for _,order in ipairs({-1, 2147483647}) do
			local Space = Instance.new('Frame');
			Space.Name = NeverLose.RandomString();
			Space.BackgroundTransparency = 1;
			Space.BorderSizePixel = 0;
			Space.Size = UDim2.fromOffset(10, 30);
			Space.LayoutOrder = order;
			Space.ZIndex = 16;
			Space.Parent = Watermark;
		end;

		local Shadow = NeverLose:CreateShadow(Watermark);
		local UpdateWidth = LPH_NO_VIRTUALIZE(function()
			local width = 0;
			for _,child in ipairs(Watermark:GetChildren()) do
				if child:IsA('GuiObject') and child.Visible then
					width = width + child.Size.X.Offset;
				end;
			end;

			Watermark.Size = UDim2.fromOffset(math.max(20, math.ceil(width)), 30);
			Watermark.Visible = Watermark_lb.Status and width > 20;
		end);

		Watermark_lb.Root = Watermark;
		NeverLose.__WatermarkCache = Watermark_lb;
		Shadow:Render(true);

		function Watermark_lb:SetRender(value)
			Watermark_lb.Status = value and true or false;
			UpdateWidth();
			NeverLose.PlayAnimate(Watermark, SlowyTween, {
				BackgroundTransparency = Watermark_lb.Status and 0.200 or 1
			});
			Shadow:Render(Watermark_lb.Status);

			for _,render in ipairs(Watermark_lb.Renders) do
				render(Watermark_lb.Status);
			end;
		end;

		function Watermark_lb:AddBlock(IconStr , Name)
			local InnerBlock = {Visible = true};
			local Frame = Instance.new('Frame');
			local Content = Instance.new('TextLabel');
			local Icon = Instance.new('TextLabel');
			Watermark_lb.__Order = Watermark_lb.__Order + 1;

			Frame.Name = NeverLose.RandomString();
			Frame.BackgroundTransparency = 1;
			Frame.BorderSizePixel = 0;
			Frame.Size = UDim2.fromOffset(26, 30);
			Frame.LayoutOrder = Watermark_lb.__Order;
			Frame.ZIndex = 16;
			Frame.Parent = Watermark;

			Content.Name = NeverLose.RandomString();
			Content.AnchorPoint = Vector2.new(0, 0.5);
			Content.BackgroundTransparency = 1;
			Content.BorderSizePixel = 0;
			Content.Position = UDim2.new(0, 26, 0.5, 0);
			Content.Size = UDim2.fromOffset(0, 20);
			Content.ZIndex = 17;
			NeverLose:RegisterFont(Content, Enum.Font.GothamBold);
			Content.Text = tostring(Name or '');
			NeverLose:BindTheme(Content, 'TextColor3', 'MutedText');
			NeverLose:SetTextSize(Content, 15);
			Content.TextTransparency = 0.200;
			Content.TextXAlignment = Enum.TextXAlignment.Left;
			Content.TextYAlignment = Enum.TextYAlignment.Center;
			Content.Parent = Frame;

			Icon.Name = NeverLose.RandomString();
			Icon.AnchorPoint = Vector2.new(0, 0.5);
			Icon.BackgroundTransparency = 1;
			Icon.BorderSizePixel = 0;
			Icon.Position = UDim2.new(0, 0, 0.5, 0);
			Icon.Size = UDim2.fromOffset(20, 20);
			Icon.ZIndex = 17;
			Icon.FontFace = NeverLose.BuiltInBold;
			NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
			Icon.Text = tostring(IconStr or '');
			NeverLose:SetTextSize(Icon, 18);
			Icon.TextTransparency = 0.250;
			Icon.TextYAlignment = Enum.TextYAlignment.Center;
			Icon.Parent = Frame;
			NeverLose:BindAccent(Icon, 'TextColor3');

			InnerBlock.Update = LPH_NO_VIRTUALIZE(function()
				local bounds = NeverLose:MeasureText(Content.Text, Content.TextSize, Content.FontFace, Vector2.new(math.huge, math.huge));
				local width = math.ceil(bounds.X);
				Content.Size = UDim2.fromOffset(width, 20);
				Frame.Size = UDim2.fromOffset(InnerBlock.Visible and width + 26 or 0, 30);
				Frame.Visible = InnerBlock.Visible;
				UpdateWidth();
			end);

			InnerBlock.SetRender = LPH_NO_VIRTUALIZE(function(value)
				local shown = value and InnerBlock.Visible;
				NeverLose.PlayAnimate(Content, SlowyTween, {TextTransparency = shown and 0.200 or 1});
				NeverLose.PlayAnimate(Icon, SlowyTween, {TextTransparency = shown and 0.250 or 1});
			end);

			function InnerBlock:SetVisible(value)
				InnerBlock.Visible = value and true or false;
				InnerBlock.Update();
				InnerBlock.SetRender(Watermark_lb.Status);
			end;

			function InnerBlock:SetText(text)
				Content.Text = tostring(text or '');
				InnerBlock.Update();
			end;

			function InnerBlock:Input(callback)
				local _,connection = NeverLose:CreateInput(Frame, callback);
				if connection then
					NeverLose:AddSignal(connection);
				end;
				return connection;
			end;

			NeverLose:BindTypography(function() if Frame.Parent then InnerBlock.Update(); end; end);
			table.insert(Watermark_lb.Renders, InnerBlock.SetRender);
			InnerBlock.Update();
			InnerBlock.SetRender(Watermark_lb.Status);
			return InnerBlock;
		end;

		function Watermark_lb:AddSeparator()
			local InnerBlock = {Visible = true};
			local Frame = Instance.new('Frame');
			local Content = Instance.new('TextLabel');
			Watermark_lb.__Order = Watermark_lb.__Order + 1;

			Frame.Name = NeverLose.RandomString();
			Frame.BackgroundTransparency = 1;
			Frame.BorderSizePixel = 0;
			Frame.Size = UDim2.fromOffset(18, 30);
			Frame.LayoutOrder = Watermark_lb.__Order;
			Frame.ZIndex = 16;
			Frame.Parent = Watermark;

			Content.Name = NeverLose.RandomString();
			Content.AnchorPoint = Vector2.new(0.5, 0.5);
			Content.BackgroundTransparency = 1;
			Content.BorderSizePixel = 0;
			Content.Position = UDim2.fromScale(0.5, 0.5);
			Content.Size = UDim2.new(1, 0, 0, 20);
			Content.ZIndex = 17;
			NeverLose:RegisterFont(Content, Enum.Font.GothamBold);
			Content.Text = '/';
			NeverLose:BindTheme(Content, 'TextColor3', 'MutedText');
			NeverLose:SetTextSize(Content, 15);
			Content.TextTransparency = 0.550;
			Content.TextXAlignment = Enum.TextXAlignment.Center;
			Content.TextYAlignment = Enum.TextYAlignment.Center;
			Content.Parent = Frame;

			InnerBlock.SetRender = LPH_NO_VIRTUALIZE(function(value)
				NeverLose.PlayAnimate(Content, SlowyTween, {
					TextTransparency = value and InnerBlock.Visible and 0.550 or 1
				});
			end);

			function InnerBlock:SetVisible(value)
				InnerBlock.Visible = value and true or false;
				Frame.Visible = InnerBlock.Visible;
				Frame.Size = UDim2.fromOffset(InnerBlock.Visible and 18 or 0, 30);
				InnerBlock.SetRender(Watermark_lb.Status);
				UpdateWidth();
			end;

			table.insert(Watermark_lb.Renders, InnerBlock.SetRender);
			InnerBlock.SetRender(Watermark_lb.Status);
			UpdateWidth();
			return InnerBlock;
		end;

		return Watermark_lb;
	end;

	function Window:SetMenuTransparency(Value)
		Window.__MenuTransparency = math.clamp(Value , 0 , 0.900);

		if Window.Signal:GetValue() then
			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = Window.__MenuTransparency
			});
		end;
	end;

	function Window:SetContentTransparency(Value)
		Window.__ContentTransparency = math.clamp(Value , 0 , 1);

		if Window.Signal:GetValue() then
			NeverLose.PlayAnimate(Window.RightSurface , SlowyTween , {
				BackgroundTransparency = Window.__ContentTransparency
			});
		end;
	end;

	function Window:SetupWatermark()
		if Window.WatermarkData then
			return Window.WatermarkData;
		end;

		local Lib = Window:Watermark();
		local Items = {};

		Items.Name = Lib:AddBlock('crosshairs' , tostring(WindowName.Text));
		Items.UsernameSep = Lib:AddSeparator();
		Items.Username = Lib:AddBlock('person' , tostring(AccountName.Text));
		Items.FPSSep = Lib:AddSeparator();
		Items.FPS = Lib:AddBlock('lightning-bolt' , '0 FPS');
		Items.PingSep = Lib:AddSeparator();
		Items.Ping = Lib:AddBlock('two-arrows-loop-clockwise' , '0 PING');
		Items.TimeSep = Lib:AddSeparator();
		Items.Time = Lib:AddBlock('clock' , '00:00:00');

		local Data = {};

		Data.Lib = Lib;
		Data.Items = Items;

		function Data.SetItem(key , state)
			local block = Items[key];

			if not block then
				return;
			end;

			block:SetVisible(state);

			local previous = false;
			for _,name in ipairs({'Name' , 'Username' , 'FPS' , 'Ping' , 'Time'}) do
				local item = Items[name];
				local separator = Items[name..'Sep'];

				if separator then
					separator:SetVisible(previous and item.Visible);
				end;

				previous = previous or item.Visible;
			end;
		end;

		Data.SetItem('Time' , false);

		local frames = 0;

		NeverLose:AddSignal(RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
			frames = frames + 1;
		end)));

		task.spawn(function()
			while task.wait(1) do
				if not NeverLose.ScreenGui or not NeverLose.ScreenGui.Parent then
					break;
				end;

				Items.FPS:SetText(tostring(frames)..' FPS');

				frames = 0;

				local success , ping = pcall(function()
					return math.floor(StatsService.Network.ServerStatsItem['Data Ping']:GetValue());
				end);

				Items.Ping:SetText(tostring((success and ping) or 0)..' PING');
				Items.Time:SetText(os.date('%H:%M:%S'));
				Items.Username:SetText(tostring(AccountName.Text));
			end;
		end);

		Window.WatermarkData = Data;

		return Data;
	end;

	function Window:BuildSettings()
		if Window.SettingsTab then
			return Window.SettingsTab;
		end;

		local SavedOrder = Window.__Order or 0;

		Window.__Order = 8999;

		Window:AddTabLabel('OTHER');

		local SettingsTab = Window:AddTab({
			Name = 'Settings',
			Icon = 'gear',
			Type = 'Double'
		});

		Window.__Order = SavedOrder;
		Window.SettingsTab = SettingsTab;
		Window.CurrentTab = #Window.Tabs + 1;
		SettingsTab.SetValue(false);

		local KeybindList = NeverLose:GetKeybindList();
		local WatermarkData = Window:SetupWatermark();

		WatermarkData.Lib:SetRender(true);

		Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(state)
			KeybindList:SetExpanded(state);
		end));

		local MenuSection = SettingsTab:AddSection({
			Name = 'Menu',
			Icon = 'gear',
			Position = 'left',
			Collapsible = true,
			Open = true,
			Line = true
		});

		MenuSection:AddLabel('Menu keybind'):AddKeybind({
			Default = Window.Keybind or 'Insert',
			Callback = function(value)
				Window.Keybind = value;
			end
		});

		MenuSection:AddLabel('Menu scale'):AddDropdown({
			Default = 'Default',
			Values = { 'Small' , 'Mobile' , 'Default' , 'Large' },
			Size = 95,
			Callback = function(value)
				Window:SetSize(NeverLose.Scales[value] or NeverLose.Scales.Default);
			end
		});

		MenuSection:AddLabel('3D menu'):AddToggle({
			Default = false,
			Callback = function(value)
				Window:Set3DRender(value);
			end
		});

		MenuSection:AddLabel('Watermark'):AddToggle({
			Default = true,
			Callback = function(value)
				WatermarkData.Lib:SetRender(value);
			end
		});

		MenuSection:AddLabel('Sidebar width'):AddSlider({Default=128,Min=112,Max=176,Type='px',Rounding=0,Size=125,Callback=function(v) Window:SetSidebarWidth(v); end});
		MenuSection:AddLabel('Hide username'):AddToggle({Default=false,Callback=function(v) Window:SetAccount({Username=v and 'MirageHub' or LocalPlayer.Name,Expires=Window.Expires}); end});
		local LayoutSection=SettingsTab:AddSection({Name='Layout',Icon='frame-corners',Position='left'});
		LayoutSection:AddLabel('Section spacing'):AddSlider({Default=12,Min=8,Max=24,Type='px',Size=125,Callback=function(v) Window:SetSectionGap(v); end});
		LayoutSection:AddLabel('Corner radius'):AddSlider({Default=8,Min=0,Max=14,Type='px',Size=125,Callback=function(v) NeverLose:SetCornerRadius(v); end});
		LayoutSection:AddLabel('Lock sections'):AddToggle({Default=false,Callback=function(v) Window.SectionWorkspace.Locked=v; if v then Window.SectionWorkspace:Finish(true); end; end});
		LayoutSection:AddLabel('Snap to 8px grid'):AddToggle({Default=false,Callback=function(v) Window.SectionWorkspace.Grid=v and 8 or 1; end});
		LayoutSection:AddButton({Name='Reset section layout',Icon='two-arrows-loop-clockwise',Callback=function() Window:ResetSectionLayout(); end});
		local AnimationSection=SettingsTab:AddSection({Name='Animations',Icon='play-large',Position='right',Open=false});
		local MotionControls={};
		MotionControls.Enabled=AnimationSection:AddLabel('Enable animations'):AddToggle({Default=NeverLose.Motion.Enabled,Flag='UI.Motion.Enabled',Callback=function(v) NeverLose:SetMotionOption('Enabled',v); end});
		MotionControls.Style=AnimationSection:AddLabel('Animation type'):AddDropdown({Default=NeverLose.Motion.Style,Values=NeverLose.MotionStyles,Size=130,Flag='UI.Motion.Style',Callback=function(v) NeverLose:SetMotionOption('Style',v); end});
		MotionControls.Direction=AnimationSection:AddLabel('Easing direction'):AddDropdown({Default=NeverLose.Motion.Direction,Values=NeverLose.MotionDirections,Size=130,Flag='UI.Motion.Direction',Callback=function(v) NeverLose:SetMotionOption('Direction',v); end});
		MotionControls.PopupEffect=AnimationSection:AddLabel('Popup animation'):AddDropdown({Default=NeverLose.Motion.PopupEffect,Values=NeverLose.PopupEffects,Size=130,Flag='UI.Motion.PopupEffect',Callback=function(v) NeverLose:SetMotionOption('PopupEffect',v); end});
		MotionControls.FadeTime=AnimationSection:AddLabel('Fade time'):AddSlider({Default=NeverLose.Motion.FadeTime,Min=0,Max=1,Type='s',Rounding=3,Size=125,Flag='UI.Motion.FadeTime',Callback=function(v) NeverLose:SetMotionOption('FadeTime',v); end});
		AnimationSection:AddLabel('0 = instant; default = 0.175s');
		AnimationSection:AddButton({Name='Reset animations',Icon='two-arrows-loop-clockwise',Callback=function()
			MotionControls.Style:SetValue('Original'); MotionControls.Direction:SetValue('Original'); MotionControls.PopupEffect:SetValue('Scale'); MotionControls.FadeTime:SetValue(0.175); MotionControls.Enabled:SetValue(true);
		end});
		local GlowSection=SettingsTab:AddSection({Name='Glow',Icon='star',Position='right',Open=false});
		local GlowStatus=GlowSection:AddLabel(NeverLose:GetGlowStatus());
		table.insert(NeverLose.GlowHooks,function(text) GlowStatus:SetText(text); end);
		local GlowControls={};
		for _,entry in ipairs({{'Enabled','Enable glow'},{'Icons','Icons'},{'Sliders','Slider fill'},{'Toggles','Enabled toggles'},{'Tabs','Active tab indicators'}}) do
			local key=entry[1]; GlowControls[key]=GlowSection:AddLabel(entry[2]):AddToggle({Default=NeverLose.Glow[key],Flag='UI.Glow.'..key,Callback=function(v) NeverLose:SetGlowOption(key,v); end});
		end;
		GlowControls.ColorMode=GlowSection:AddLabel('Glow color'):AddDropdown({Default=NeverLose.Glow.ColorMode,Values={'Element','Accent','Custom'},Size=130,Flag='UI.Glow.ColorMode',Callback=function(v) NeverLose:SetGlowOption('ColorMode',v); end});
		GlowControls.Color=GlowSection:AddLabel('Custom glow color'):AddColorPicker({Default=NeverLose.Glow.Color,Flag='UI.Glow.Color',Callback=function(v) NeverLose:SetGlowOption('Color',v); end});
		GlowControls.IconMode=GlowSection:AddLabel('Icon glow'):AddDropdown({Default=NeverLose.Glow.IconMode,Values={'On hover','Always'},Size=130,Flag='UI.Glow.IconMode',Callback=function(v) NeverLose:SetGlowOption('IconMode',v); end});
		for _,entry in ipairs({{'Intensity','Intensity',0,100,'%',100},{'BlurRadius','Blur radius',0,30,'px',1},{'Spread','Spread',-6,8,'px',1},{'HoverBoost','Hover boost',0,50,'%',100},{'OffsetX','Offset X',-12,12,'px',1},{'OffsetY','Offset Y',-12,12,'px',1},{'MaxVisible','Visible effect limit',8,80,'',1}}) do
			local key,scale=entry[1],entry[6]; GlowControls[key]=GlowSection:AddLabel(entry[2]):AddSlider({Default=NeverLose.Glow[key]*scale,Min=entry[3],Max=entry[4],Type=entry[5],Rounding=0,Size=125,Flag='UI.Glow.'..key,Callback=function(v) NeverLose:SetGlowOption(key,v/scale); end});
		end;
		GlowSection:AddButton({Name='Reset glow',Icon='two-arrows-loop-clockwise',Callback=function()
			for key,value in pairs({Enabled=true,Icons=true,Sliders=true,Toggles=true,Tabs=true,ColorMode='Element',IconMode='On hover',Intensity=28,BlurRadius=12,Spread=0,HoverBoost=12,OffsetX=0,OffsetY=0,MaxVisible=64}) do GlowControls[key]:SetValue(value); end;
			GlowControls.Color:SetValue(Color3.fromRGB(137,180,250));
		end});
		Window.MotionControls=MotionControls; Window.GlowControls=GlowControls;
		local FontSection=SettingsTab:AddSection({Name='Typography',Icon='fountain-pen-nib',Position='left'});
		local FontStatus=FontSection:AddLabel('Choose a font to preview');
		local FontPicker=FontSection:AddLabel('Font'):AddDropdown({Default='Built-in',Values=NeverLose:GetFontOptions(),Size=170,Callback=function(name)
			FontStatus:SetText('Loading '..name);
			task.spawn(function()
				local success,message=NeverLose:SetUIFont(name); if message=='Superseded' then return; end;
				if success then FontStatus:SetText(name=='ProggyClean.fon' and 'ProggyClean: TTF version loaded' or 'Active: '..name); else FontStatus:SetText('Unavailable; previous font kept'); warn(tostring(message)); end;
			end);
		end});
		FontSection:AddLabel('Text size'):AddSlider({Default=110,Min=85,Max=130,Type='%',Rounding=0,Size=125,Callback=function(v) NeverLose:SetFontScale(v/100); end});
		FontSection:AddLabel('Aa Bb Cc 0123456789');
		FontSection:AddButton({Name='Refresh font list',Icon='two-arrows-loop-clockwise',Callback=function()
			FontStatus:SetText('Refreshing font list...'); task.spawn(function()
				local success,result=NeverLose:RefreshFontCatalog(); if success then FontPicker:SetValues(result); end;
				FontStatus:SetText(success and (#NeverLose.FontCatalog..' fonts available') or 'Offline catalog retained');
			end);
		end});
		local PreloadingFonts=false;
		FontSection:AddButton({Name='Cache all fonts',Icon='arrow-down',Callback=function()
			if PreloadingFonts then return; end; PreloadingFonts=true;
			task.spawn(function()
				local loaded=0;
				for _,name in ipairs(NeverLose.FontCatalog) do
					if not NeverLose.ScreenGui.Parent then break; end;
					if pcall(NeverLose.LoadFontAsset,NeverLose,name) then loaded=loaded+1; end;
					FontStatus:SetText('Cached '..loaded..' / '..#NeverLose.FontCatalog); task.wait();
				end;
				PreloadingFonts=false;
			end);
		end});
		Window.FontPicker=FontPicker;
		task.defer(function() FontPicker:SetValue('InterMedium.ttf'); end);
		local ThemeSection=SettingsTab:AddSection({Name='Colors & themes',Icon='star',Position='left',Open=false});
		ThemeSection:AddLabel('Preset target'):AddDropdown({Default='Full UI',Values=NeverLose.ThemeScopes,Size=140,Callback=function(v) NeverLose.ThemeScope=v; end});
		local ElementPicker = ThemeSection:AddLabel('Element preset'):AddDropdown({Default='None',Values=NeverLose.ElementPresetOrder,Size=140,Callback=function(v) if v ~= NeverLose.ElementPresetName then NeverLose:ApplyElementPreset(v); end; end});
		NeverLose:BindThemeHook(function() if ElementPicker:GetValue() ~= NeverLose.ElementPresetName then ElementPicker:SetValue(NeverLose.ElementPresetName); end; end);
		ThemeSection:AddLabel('Theme preset'):AddDropdown({Default='Dracula',Values=NeverLose.ThemePresetOrder,Size=140,Callback=function(v) NeverLose:ApplyTheme(v); end});
		local ThemeEditors={};
		for _,entry in ipairs({{'Accent','Accent'},{'Slider fill','SliderFill'},{'Enabled switches','ToggleOn'},{'Active tabs','TabAccent'},{'Window','Window'},{'Sidebar','Sidebar'},{'Content','Content'},{'Sections','Section'},{'Controls','Control'},{'Hover','Hover'},{'Selection','Selected'},{'Borders','Border'},{'Text','Text'},{'Secondary text','MutedText'},{'Icons','Icon'},{'Slider / toggle knob','Knob'},{'Toggle off','ToggleOff'},{'Risk','Risk'}}) do
			local role=entry[2];
			ThemeEditors[role]=ThemeSection:AddLabel(entry[1]):AddColorPicker({Default=NeverLose.Theme[role],Callback=function(color) if not NeverLose:ColorsEqual(NeverLose.Theme[role],color) then NeverLose:SetThemeColor(role,color); end; end});
		end;
		NeverLose:BindThemeHook(function() for role,control in pairs(ThemeEditors) do if not NeverLose:ColorsEqual(control:GetValue(),NeverLose.Theme[role]) then control:SetValue(NeverLose.Theme[role]); end; end; end);
		ThemeSection:AddLabel('Window transparency'):AddSlider({Default=5,Min=0,Max=90,Type='%',Rounding=0,Size=125,Callback=function(v) Window:SetMenuTransparency(v/100); end});
		ThemeSection:AddLabel('Content transparency'):AddSlider({Default=10,Min=0,Max=100,Type='%',Rounding=0,Size=125,Callback=function(v) Window:SetContentTransparency(v/100); end});
		ThemeSection:AddLabel('Section transparency'):AddSlider({Default=25,Min=0,Max=95,Type='%',Rounding=0,Size=125,Callback=function(v) NeverLose:SetSectionTransparency(v/100); end});
		local BackgroundSection=SettingsTab:AddSection({Name='Background image',Icon='image',Position='right'});
		local PendingImage='';
		local BackgroundStatus=BackgroundSection:AddLabel('Roblox ID, PNG/JPG URL or local file');
		BackgroundSection:AddLabel('Image source'):AddTextInput({Default='',Placeholder='Paste ID / URL / path',Size=170,Callback=function(v) PendingImage=tostring(v); end});
		BackgroundSection:AddButton({Name='Apply image',Icon='image',Callback=function()
			BackgroundStatus:SetText('Loading background...'); task.spawn(function()
				local success,message=Window:SetBackgroundImage(PendingImage); if message=='Superseded' then return; end;
				BackgroundStatus:SetText(success and 'Background applied' or 'Image unavailable; previous image kept'); if not success then warn(tostring(message)); end;
			end);
		end});
		BackgroundSection:AddButton({Name='Remove image',Icon='trash-can',Callback=function() Window:SetBackgroundImage(''); BackgroundStatus:SetText('Background removed'); end});
		BackgroundSection:AddLabel('Show image'):AddToggle({Default=true,Callback=function(v) Window.Background.Enabled=v; Window:UpdateBackground(); end});
		BackgroundSection:AddLabel('Image opacity'):AddSlider({Default=100,Min=0,Max=100,Type='%',Rounding=0,Size=125,Callback=function(v) Window.Background.Opacity=v/100; Window:UpdateBackground(); end});
		BackgroundSection:AddLabel('Dark overlay'):AddSlider({Default=35,Min=0,Max=90,Type='%',Rounding=0,Size=125,Callback=function(v) Window.Background.Dim=v/100; Window:UpdateBackground(); end});
		BackgroundSection:AddLabel('Image tint'):AddColorPicker({Default=Color3.new(1,1,1),Callback=function(v) Window.Background.Tint=v; Window:UpdateBackground(); end});
		BackgroundSection:AddLabel('Image fit'):AddDropdown({Default='Crop',Values={'Crop','Stretch','Fit'},Size=110,Callback=function(v) Window.Background.Fit=v; Window:UpdateBackground(); end});

		local KeybindSection = SettingsTab:AddSection({
			Name = 'Keybinds',
			Icon = 'key',
			Position = 'right',
			Collapsible = true,
			Open = true,
			Line = true
		});

		KeybindSection:AddLabel('Show keybind list'):AddToggle({
			Default = true,
			Callback = function(value)
				KeybindList:SetEnabled(value);
			end
		});

		KeybindSection:AddLabel('Show all in menu'):AddToggle({
			Default = true,
			Callback = function(value)
				KeybindList.AllowExpand = value;

				KeybindList:SetExpanded(Window.Signal:GetValue());
			end
		});

		local WatermarkSection = SettingsTab:AddSection({
			Name = 'Watermark',
			Icon = 'crosshairs',
			Position = 'right',
			Collapsible = true,
			Open = true,
			Line = true
		});
		WatermarkSection:AddLabel('Username'):AddToggle({
			Default = true,
			Callback = function(value)
				WatermarkData.SetItem('Username' , value);
			end
		});

		WatermarkSection:AddLabel('FPS'):AddToggle({
			Default = true,
			Callback = function(value)
				WatermarkData.SetItem('FPS' , value);
			end
		});

		WatermarkSection:AddLabel('Ping'):AddToggle({
			Default = true,
			Callback = function(value)
				WatermarkData.SetItem('Ping' , value);
			end
		});

		WatermarkSection:AddLabel('Time'):AddToggle({
			Default = false,
			Callback = function(value)
				WatermarkData.SetItem('Time' , value);
			end
		});

		local UtilitySection = SettingsTab:AddSection({
			Name = 'Utility',
			Icon = 'trash-can',
			Position = 'right',
			Collapsible = true,
			Open = true,
			Line = true
		});

		local UnloadKey = nil;

		UtilitySection:AddLabel('Unload keybind'):AddKeybind({
			Default = nil,
			Callback = function(value)
				UnloadKey = value;
			end
		});

		NeverLose:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(input , typing)
			if typing or not UnloadKey then
				return;
			end;

			if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name == tostring(UnloadKey) then
				NeverLose:Unload();
			end;
		end)));

		UtilitySection:AddButton({
			Icon = 'trash-can',
			Name = 'Unload menu',
			Callback = function()
				NeverLose:Unload();
			end
		});

		return SettingsTab;
	end;

	Window:BuildSettings();

	Window:SetRender(false);

	return Window;
end;

function NeverLose:CreateNotification()
	if NeverLose.__Notification_Cache then
		return NeverLose.__Notification_Cache;
	end;

	local Notifier = {};
	local Notification = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notification.Name = NeverLose.RandomString();
	Notification.Parent = NeverLose.ScreenGui;
	Notification.AnchorPoint = Vector2.new(1, 0)
	Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Notification.BackgroundTransparency = 1.000
	Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, -25, 0, 25)
	Notification.Size = UDim2.new(0, 25, 0, 25)

	UIListLayout.Parent = Notification
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 0)

	NeverLose.__Notification_Cache = Notifier;

	function Notifier.new(Config)
		Config = NeverLose:ProcessParams(Config , {
			Title = "Notification",
			Content = "Hello World!",
			Logo = NeverLose.GlobalLogo or "rbxasset://textures/ui/VerifiedBadgeNameIcon.png",
			Duration = 5,
		});

		if NeverLose.__WatermarkCache then
			NeverLose.PlayAnimate(Notification,SlowyTween , {
				Position = UDim2.new(1, -25, 0, 55)
			});
		end;

		local ContainerFrame = Instance.new("Frame")
		local NotifyFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local NotifyName = Instance.new("TextLabel")
		local NotifyContent = Instance.new("TextLabel");
		local shadow = NeverLose:CreateShadow(NotifyFrame , true);

		ContainerFrame.Name = NeverLose.RandomString();
		ContainerFrame.Parent = Notification
		ContainerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ContainerFrame.BackgroundTransparency = 1.000
		ContainerFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerFrame.BorderSizePixel = 0
		ContainerFrame.Size = UDim2.new(0, 0, 0, 100)

		NotifyFrame.Name = NeverLose.RandomString();
		NotifyFrame.Parent = ContainerFrame
		NotifyFrame.AnchorPoint = Vector2.new(1, 0)
		NeverLose:BindTheme(NotifyFrame, 'BackgroundColor3', 'Section');
		NotifyFrame.BackgroundTransparency = 0.075
		NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyFrame.BorderSizePixel = 0
		NotifyFrame.ClipsDescendants = true
		NotifyFrame.Position = UDim2.new(0, 750, 0, 0)
		NotifyFrame.Size = UDim2.new(0, 220, 0, 55)
		NotifyFrame.ZIndex = 130

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = NotifyFrame

		UIStroke.Transparency = 0.650
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = NotifyFrame

		LogoImage.Name = NeverLose.RandomString();
		LogoImage.Parent = NotifyFrame
		LogoImage.AnchorPoint = Vector2.new(0, 0.5)
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
		LogoImage.Size = UDim2.new(0, 35, 0, 35)
		LogoImage.ZIndex = 131
		LogoImage.Image = Config.Logo
		NeverLose:BindTheme(LogoImage, 'ImageColor3', 'Icon');

		NeverLose:BindCorner(UICorner_2, 'Panel');
		UICorner_2.Parent = LogoImage

		NotifyName.Name = NeverLose.RandomString();
		NotifyName.Parent = NotifyFrame
		NotifyName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyName.BackgroundTransparency = 1.000
		NotifyName.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyName.BorderSizePixel = 0
		NotifyName.Position = UDim2.new(0, 50, 0, 7)
		NotifyName.Size = UDim2.new(0, 200, 0, 20)
		NotifyName.ZIndex = 132
		NeverLose:RegisterFont(NotifyName, Enum.Font.GothamBold);
		NotifyName.Text = Config.Title
		NeverLose:BindTheme(NotifyName, 'TextColor3', 'Text');
		NeverLose:SetTextSize(NotifyName, 17.000);
		NotifyName.TextXAlignment = Enum.TextXAlignment.Left

		NotifyContent.Name = NeverLose.RandomString();
		NotifyContent.Parent = NotifyFrame
		NotifyContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NotifyContent.BackgroundTransparency = 1.000
		NotifyContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyContent.BorderSizePixel = 0
		NotifyContent.Position = UDim2.new(0, 50, 0, 28)
		NotifyContent.Size = UDim2.new(0, 200, 0, 15)
		NotifyContent.ZIndex = 132
		NeverLose:RegisterFont(NotifyContent, Enum.Font.GothamBold);
		NotifyContent.Text = Config.Content
		NeverLose:BindTheme(NotifyContent, 'TextColor3', 'Text');
		NeverLose:SetTextSize(NotifyContent, 12.000);
		NotifyContent.TextTransparency = 0.650
		NotifyContent.TextXAlignment = Enum.TextXAlignment.Left

		local Size1 = NeverLose:MeasureText(NotifyName.Text, NotifyName.TextSize, NotifyName.FontFace,Vector2.new(math.huge,math.huge));
		local Size2 = NeverLose:MeasureText(NotifyContent.Text, NotifyContent.TextSize, NotifyContent.FontFace,Vector2.new(math.huge,math.huge));

		local MainSize = math.max(Size1.X , Size2.X);

		NotifyFrame.Size = UDim2.new(0, MainSize + 65, 0, 55);

		shadow:Render(true)
		NeverLose.PlayAnimate(NotifyFrame , VSlowTween , {
			Position = UDim2.new(1, 0, 0, 0)
		})

		ContainerFrame.Size = UDim2.new(0, 0, 0, 65)

		task.delay(Config.Duration or 5 , LPH_NO_VIRTUALIZE(function()

			if NeverLose.__WatermarkCache then
				NeverLose.PlayAnimate(Notification,SlowyTween , {
					Position = UDim2.new(1, -25, 0, 55)
				});
			end;

			shadow:Render(false)

			NeverLose.PlayAnimate(NotifyFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(NotifyName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(NotifyContent , SlowyTween , {
				TextTransparency = 1
			})

			task.wait(0.125);

			NeverLose.PlayAnimate(ContainerFrame , SlowyTween , {
				Size = UDim2.new(0, 0, 0, 0)
			})

			task.wait(0.125);

			ContainerFrame:Destroy();
		end))
	end;

	return Notifier;
end;

function NeverLose:CreateLogger()
	if NeverLose.__LogSystem then
		return 	NeverLose.__LogSystem;
	end;

	local Logging = {};
	local Log = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Log.Name = NeverLose.RandomString();
	Log.Parent = NeverLose.ScreenGui
	Log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Log.BackgroundTransparency = 1.000
	Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Log.BorderSizePixel = 0
	Log.Position = UDim2.new(0, 25, 0, 5 + math.abs(NeverLose.ScreenGui.AbsolutePosition.Y))
	Log.Size = UDim2.new(0, 25, 0, 25)

	UIListLayout.Parent = Log
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 12)

	NeverLose.__LogSystem = Logging;

	function Logging.new(IconStr: string , Message: string , Duration: number)
		Duration = Duration or 3;
		Message = Message or "Log";
		IconStr = IconStr or "crosshairs";

		local LogFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogContent = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(LogFrame , true);

		LogFrame.Name = NeverLose.RandomString();
		LogFrame.Parent = Log
		LogFrame.AnchorPoint = Vector2.new(0.5, 0)
		NeverLose:BindTheme(LogFrame, 'BackgroundColor3', 'Section');
		LogFrame.BackgroundTransparency =  1
		LogFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogFrame.BorderSizePixel = 0
		LogFrame.ClipsDescendants = true
		LogFrame.Position = UDim2.new(0,0,0,0)
		LogFrame.Size = UDim2.new(0, 0, 0, 20)
		LogFrame.ZIndex = 130

		NeverLose:BindCorner(UICorner, 'Control');
		UICorner.Parent = LogFrame

		UIStroke.Transparency = 1
		NeverLose:BindTheme(UIStroke, 'Color', 'Border');
		UIStroke.Parent = LogFrame

		LogContent.Name = NeverLose.RandomString();
		LogContent.Parent = LogFrame
		LogContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.BackgroundTransparency = 1.000
		LogContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogContent.BorderSizePixel = 0
		LogContent.Position = UDim2.new(0, 25, 0, 2)
		LogContent.Size = UDim2.new(0, 200, 0, 15)
		LogContent.ZIndex = 132
		NeverLose:RegisterFont(LogContent, Enum.Font.GothamBold);
		LogContent.Text = Message
		NeverLose:BindTheme(LogContent, 'TextColor3', 'Text');
		NeverLose:SetTextSize(LogContent, 12.000);
		LogContent.TextTransparency = 1
		LogContent.TextXAlignment = Enum.TextXAlignment.Left

		Line.Name = NeverLose.RandomString();
		Line.Parent = LogFrame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		NeverLose:BindAccent(Line , 'BackgroundColor3');
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BackgroundTransparency = 1
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, -2, 0.5, 0)
		Line.Size = UDim2.new(0, 5, 1, 0)
		Line.ZIndex = 131

		NeverLose:BindCorner(UICorner_2, 'Control');
		UICorner_2.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LogFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 7, 0, 3)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 133
		Icon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
		Icon.Text = IconStr
		NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Icon, 13.000);
		Icon.TextTransparency = 1
		Icon.TextWrapped = true

		local size = NeverLose:MeasureText(LogContent.Text, LogContent.TextSize, LogContent.FontFace,Vector2.new(math.huge,math.huge));

		NeverLose.PlayAnimate(LogFrame , SlowyTween , {
			Size = UDim2.new(0, size.X + 35, 0, 20),
			BackgroundTransparency =  0.075
		});

		task.delay(0.15,LPH_NO_VIRTUALIZE(function()
			Shadow:Render(true);

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 0.25
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 0
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			});

			task.wait(Duration + 0.1);

			Shadow:Render(false);

			NeverLose.PlayAnimate(LogFrame , SlowyTween , {
				BackgroundTransparency =  1
			});

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 1
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 1
			});

			task.wait(0.25);

			LogFrame:Destroy();
		end))
	end;

	return Logging
end;

function NeverLose:CreateIndicator()
	local IndicatorFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	IndicatorFrame.Name = NeverLose.RandomString();
	IndicatorFrame.Parent = NeverLose.ScreenGui;
	IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
	IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IndicatorFrame.BackgroundTransparency = 1.000
	IndicatorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IndicatorFrame.BorderSizePixel = 0
	IndicatorFrame.Position = UDim2.new(0, 15, 0.5, 0)
	IndicatorFrame.Size = UDim2.new(0, 100, 0, 100)
	IndicatorFrame.ZIndex = 15

	UIListLayout.Parent = IndicatorFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	local Indicators = {};

	Indicators.Color = {
		Red = Color3.fromRGB(255, 102, 105),
		Green = Color3.fromRGB(135, 255, 143),
		White = Color3.fromRGB(186, 186, 186),
	};

	Indicators.Root = IndicatorFrame;

	function Indicators.new(Config)
		Config = NeverLose:ProcessParams(Config , {
			Name = "Indicator",
			Icon = 'crosshairs',
			Color = 'Red',
		});

		local Indicator = {
			CurrentColor = Config.Color,	
			Visible = false,
		};

		local IndicatorItem = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local Icon = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(IndicatorItem);

		IndicatorItem.Name = NeverLose.RandomString();
		NeverLose:BindTheme(IndicatorItem, 'BackgroundColor3', 'Window');
		IndicatorItem.BackgroundTransparency = 1
		IndicatorItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IndicatorItem.BorderSizePixel = 0
		IndicatorItem.ClipsDescendants = true
		IndicatorItem.Size = UDim2.new(0, 85, 0, 40)
		IndicatorItem.ZIndex = 16
		IndicatorItem.Visible = false;

		IndicatorItem:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if IndicatorItem.BackgroundTransparency > 0.9 then
				IndicatorItem.Parent = nil;
				IndicatorItem.Visible = false;
			else
				IndicatorItem.Parent = IndicatorFrame;
				IndicatorItem.Visible = true;
			end;
		end))

		NeverLose:BindCorner(UICorner, 'Panel');
		UICorner.Parent = IndicatorItem

		Line.Name = NeverLose.RandomString();
		Line.Parent = IndicatorItem
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 2, 0.5, 0)
		Line.BackgroundTransparency = 1;
		Line.Size = UDim2.new(0, 3, 0.649999976, 0)
		Line.ZIndex = 17

		NeverLose:BindCorner(UICorner_2, 'Panel');
		UICorner_2.Parent = Line

		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = IndicatorItem
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 10, 0.5, 0)
		Icon.Size = UDim2.new(0, 25, 0, 25)
		Icon.ZIndex = 17
		Icon.FontFace = NeverLose.BuiltInBold;
		NeverLose:BindTheme(Icon, 'TextColor3', 'Icon');
		Icon.Text = Config.Icon
		NeverLose:BindTheme(Icon, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Icon, 21.000);
		Icon.TextTransparency = 1
		Icon.TextWrapped = true

		Content.Name = NeverLose.RandomString();
		Content.Parent = IndicatorItem
		Content.AnchorPoint = Vector2.new(0, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 40, 0.5, 0)
		Content.Size = UDim2.new(1, -40, 0, 25)
		Content.ZIndex = 17
		NeverLose:RegisterFont(Content, Enum.Font.GothamBold);
		Content.Text = Config.Name
		NeverLose:BindTheme(Content, 'TextColor3', 'MutedText');
		NeverLose:SetTextSize(Content, 20.000);
		Content.TextTransparency = 1
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Indicator.Update = LPH_NO_VIRTUALIZE(function()
			local text = NeverLose:MeasureText(Content.Text, Content.TextSize, Content.FontFace, Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
				Size = UDim2.new(0, text.X + 60, 0, 40);
			})
		end);

		Indicator.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
			Indicator.Visible = value;

			if value then
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 0.200
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 0,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 0.250,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 0.2,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(true);
			else
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 1,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(false);
			end;

			Indicator.Update();
		end);

		Indicator.Update();
		Indicator:SetRender(false);

		function Indicator:SetColor(new_color)
			Indicator.CurrentColor = new_color;

			if Indicator.Visible then
				Indicator:SetRender(true);
			end;
		end;

		function Indicator:SetText(name)
			Config.Name = name;

			Content.Text = Config.Name;

			Indicator.Update();
		end;

		return Indicator;
	end;

	return Indicators;
end;

function NeverLose:Unload()
	if not NeverLose.UnloadEnabled then
		return;	
	end;

	NeverLose:DestroyGlows(); NeverLose:FinishMotion();
	NeverLose.ScreenGui:Destroy();

	for i,v in next , NeverLose.GlobalSignals do
		pcall(v.Disconnect,v)
	end;
end;

return NeverLose
