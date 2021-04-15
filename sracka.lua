local gui = game:GetObjects("rbxassetid://6583017704")[1]
syn.protect_gui(gui) gui.Parent = game.CoreGui
--local gui = script.Parent
local dropped = false
minvalue = minvalue or 0
maxvalue = maxvalue or 750
callback = callback or function() end
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")
local Value;
local TargetPart = "Head"



function open(dropper, x, y)
	dropper:TweenSize(UDim2.new(0, x,0, y ), "Out", "Quad", 0.2, false)
end
function close(dropper2, x)
	dropper2:TweenSize(UDim2.new(0, x,0, 0 ), "In", "Quad", 0.2, false)
end

gui.fr1.Ex.MouseButton1Down:Connect(function() gui:Destroy() end)

gui.fr1.aim.Folder.drop.MouseButton1Down:Connect(function()wait (0.2) if dropped == false then
		
		
		--[[]]
		gui.fr1.aim.Folder.drop.Active = false
		
		open(gui.fr1.aim.Folder.dr1, 65, 16)
		open(gui.fr1.aim.Folder.dr2, 65, 16)
		open(gui.fr1.aim.Folder.dr3, 65, 16)
		open(gui.fr1.aim.Folder.dr4, 65, 16)
		open(gui.fr1.aim.Folder.dr5, 65, 16)
		dropped = true
	else
		dropped = false
		gui.fr1.aim.Folder.drop.Active = false
		close(gui.fr1.aim.Folder.dr5, 65)
		close(gui.fr1.aim.Folder.dr4, 65)
		close(gui.fr1.aim.Folder.dr3, 65)
		close(gui.fr1.aim.Folder.dr2, 65)
		close(gui.fr1.aim.Folder.dr1, 65)
	end
	wait(3)
	gui.fr1.aim.Folder.drop.Active = true
end)
local dropped2 = false
gui.fr1.aim.kdrop.MouseButton1Down:Connect(function()
	if dropped2 == false then
		dropped2= true
		gui.fr1.aim.kdrop.Active = false

		open(gui.fr1.aim.m1, 59, 11)
		open(gui.fr1.aim.m2, 59, 11)
	else
		dropped2 = false
		close(gui.fr1.aim.m1, 59)
		close(gui.fr1.aim.m2, 59)

		wait(1.5)
		
	end	
end)
local Button = 2
gui.fr1.aim.m1.MouseButton1Down:Connect(function() 
	gui.fr1.aim.m1.Active = false
	Button = 1
	wait(2)
	gui.fr1.aim.m1.Active = true
end)
gui.fr1.aim.m2.MouseButton1Down:Connect(function() 
	gui.fr1.aim.m2.Active = false
	Button = 2
	wait(2)
	gui.fr1.aim.m2.Active = true
end)


gui.fr1.aim.Folder.dr1.MouseButton1Down:Connect(function() TargetPart = "Head" 
end)
gui.fr1.aim.Folder.dr2.MouseButton1Down:Connect(function() TargetPart = "RightHand" 
end)
gui.fr1.aim.Folder.dr3.MouseButton1Down:Connect(function() TargetPart = "LeftHand"  
end)
gui.fr1.aim.Folder.dr4.MouseButton1Down:Connect(function() TargetPart = "LowerTorso"  
end)
gui.fr1.aim.Folder.dr5.MouseButton1Down:Connect(function() TargetPart = "HumanoidRootPart"  end)

local FOVV = 150
gui.fr1.SliderButton.MouseButton1Down:Connect(function()
	Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 48) * gui.fr1.SliderFrame.AbsoluteSize.X) + tonumber(minvalue)) or 0
	pcall(function()
		callback(Value)
	end)
	gui.fr1.SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - gui.fr1.SliderFrame.AbsolutePosition.X, 0, 48), 0, 8)
	moveconnection = mouse.Move:Connect(function()
		
		gui.fr1.SliderButton.Text = Value
		
		Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 48) * gui.fr1.SliderFrame.AbsoluteSize.X) + tonumber(minvalue)) FOVV = Value
		pcall(function()
			callback(Value)
		end)
		gui.fr1.SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - gui.fr1.SliderFrame.AbsolutePosition.X, 0, 48), 0, 8)
	end)
	releaseconnection = uis.InputEnded:Connect(function(Mouse)
		if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
			Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 48) * gui.fr1.SliderFrame.AbsoluteSize.X) + tonumber(minvalue))
			pcall(function()
				callback(Value)
			end)
			gui.fr1.SliderFrame.Size = UDim2.new(0, math.clamp(mouse.X - gui.fr1.SliderFrame.AbsolutePosition.X, 0, 48), 0, 8)
			moveconnection:Disconnect()
			releaseconnection:Disconnect()
		end
	end)
end)

local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local UIS = game.UserInputService

mouse1down = false
mouse2down = false
UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		mouse2down = true
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		mouse1down = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		mouse1down = false
	end
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		mouse2down = false
	end
end)

local FOV = Drawing.new("Circle") -- Change these ESP Settings to anything at https://x.synapse.to/docs/reference/drawing_lib.html
FOV.Visible = true
FOV.Color = Color3.fromRGB(177, 0, 255)
FOV.Thickness = 11
FOV.NumSides = 88
FOV.Radius = FOVV --
FOV.Filled = true
FOV.Transparency = 0.05


local function inlos(p, ...) -- In line of site? p == player head, ... character 
	return #camera:GetPartsObscuringTarget({p}, {camera, plr.Character, ...}) == 0
end
local TeamCheck = true
local aimbotting = true
local old = nil
local baime = false
local tap = nil
local closestm = 0
game:GetService("RunService").RenderStepped:Connect(function(step) 
	local hume = nil
	local closest = nil
	if aimbotting == true then
		local min = math.huge
	FOV.Radius = FOVV
	FOV.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
	if mouse2down==true and Button == 2 or mouse1down == true and Button == 1 then
		for i, v in pairs(game.Players:GetChildren()) do	
				if TeamCheck == true and v.TeamColor == plr.TeamColor then else 
				if plr.Character and v.Character and v.Character ~= plr.Character then
				if v.Character:FindFirstChild(TargetPart,0) ~= nil and v.Character:FindFirstChild("Humanoid",0)  then
							local hum = plr.Character:WaitForChild("HumanoidRootPart",1555)
							local plrpos,OnScreen = camera:WorldToViewportPoint(v.Character[TargetPart].Position)
							if OnScreen==true and   inlos(v.Character[TargetPart].Position, v.Character) and v.Character.Humanoid.Health ~= 0   then
						local distance = math.sqrt(math.pow(mouse.X - plrpos.X, 2), math.pow(mouse.Y - plrpos.Y, 2))
								local fovdistance = math.sqrt(math.pow(FOV.Position.X - plrpos.X, 2) + math.pow(FOV.Position.Y - plrpos.Y, 2))
								local magnititude = (hum.Position - v.Character[TargetPart].Position).Magnitude
						if fovdistance <= FOV.Radius then
							if distance < min then
								min = distance
										closest = v
										hume = hum
										closestm = magnititude
							end
								end end
						else
							game:GetService("RunService").RenderStepped:Wait()
				end end
 end
		end
end
			if closest and baime == false then
			camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character[TargetPart].CFrame.Position)
			end
			
			--AimMethod-b
		if baime == true and closest and hume ~= nil then
			hume.CFrame = CFrame.new(hume.Position, Vector3.new(closest.Character[TargetPart].Position.X,hume.Position.Y,closest.Character[TargetPart].Position.Z))
			camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character[TargetPart].CFrame.Position)
		end			
			end		
end)
gui.fr1.Toggle.MouseButton1Down:Connect(function()
	gui.fr1.Toggle.Active = false

	if aimbotting == true then
		aimbotting = false	
		gui.fr1.Toggle.Image =  ""
	else
		aimbotting = true
		gui.fr1.Toggle.Image =  "rbxassetid://150902462"
	end
	
	wait(1.5)
	gui.fr1.Toggle.Active = true
	
end)

gui.fr1.Toggl2.MouseButton1Down:Connect(function()
	gui.fr1.Toggl2.Active = false

	if TeamCheck == true then
		TeamCheck = false	
		gui.fr1.Toggl2.Image =  ""
	else
		TeamCheck = true
		gui.fr1.Toggl2.Image =  "rbxassetid://150902462"
	end

	wait(1.5)
	gui.fr1.Toggl2.Active = true

end)

gui.fr1.Toggl3.MouseButton1Down:Connect(function()
	gui.fr1.Toggl3.Active = false

	if baime == true then
		baime = false	
		gui.fr1.Toggl3.Image =  ""
	else
		baime = true
		gui.fr1.Toggl3.Image =  "rbxassetid://150902462"
	end

	wait(1.5)
	gui.fr1.Toggl3.Active = true

end)

--game:GetService("RunService").RenderStepped:Wait()	
--
crosshairlength = 10
local cc = game.Workspace.CurrentCamera; 
local xl = Drawing.new("Line")
xl.Visible=true; 
local yl = Drawing.new("Line")
yl.Visible=true;
xl.Thickness=0.95;
yl.Thickness=0.95;
xl.Color=Color3.fromRGB(255,255,255); 
yl.Color=Color3.fromRGB(255,255,255);
xl.From=Vector2.new((cc.ViewportSize.X/2)+(crosshairlength/2+1),cc.ViewportSize.Y/2)
xl.To=Vector2.new(cc.ViewportSize.X/2-(crosshairlength/2),cc.ViewportSize.Y/2)
yl.From=Vector2.new(cc.ViewportSize.X/2,cc.ViewportSize.Y/2+(crosshairlength/2))
yl.To=Vector2.new(cc.ViewportSize.X/2,cc.ViewportSize.Y/2-(crosshairlength/2))
gui.fr1.aim.Draggable = true
gui.fr1.Draggable = true