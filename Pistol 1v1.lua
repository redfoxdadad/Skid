local DiscordLib =
    loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()
local win = DiscordLib:Window("Skid-Pistol 1v1")
local serv = win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
local btns = serv:Channel("Main")

btns:Button(
    "Chams",
    function()
        local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer 
local dwRunService = game:GetService("RunService")

local settings_tbl = {
    ESP_Enabled = true,
    ESP_TeamCheck = false,
    Chams = true,
    Chams_Color = Color3.fromRGB(228, 58, 55),
    Chams_Transparency = 0.1,
    Chams_Glow_Color = Color3.fromRGB(0, 58, 55)
}

function destroy_chams(char)

    for k,v in next, char:GetChildren() do 

        if v:IsA("BasePart") and v.Transparency ~= 1 then

            if v:FindFirstChild("Glow") and 
            v:FindFirstChild("Chams") then

                v.Glow:Destroy()
                v.Chams:Destroy() 

            end 

        end 

    end 

end

dwRunService.Heartbeat:Connect(function()

    if settings_tbl.ESP_Enabled then

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer then

                if v.Character and
                v.Character:FindFirstChild("HumanoidRootPart") and 
                v.Character:FindFirstChild("Humanoid") and 
                v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                    if settings_tbl.ESP_TeamCheck == false then

                        local char = v.Character 

                        for k,b in next, char:GetChildren() do 

                            if b:IsA("BasePart") and 
                            b.Transparency ~= 1 then
                                
                                if settings_tbl.Chams then

                                    if not b:FindFirstChild("Glow") and
                                    not b:FindFirstChild("Chams") then

                                        local chams_box = Instance.new("BoxHandleAdornment", b)
                                        chams_box.Name = "Chams"
                                        chams_box.AlwaysOnTop = true 
                                        chams_box.ZIndex = 4 
                                        chams_box.Adornee = b 
                                        chams_box.Color3 = settings_tbl.Chams_Color
                                        chams_box.Transparency = settings_tbl.Chams_Transparency
                                        chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                        local glow_box = Instance.new("BoxHandleAdornment", b)
                                        glow_box.Name = "Glow"
                                        glow_box.AlwaysOnTop = false 
                                        glow_box.ZIndex = 3 
                                        glow_box.Adornee = b 
                                        glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                        glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

                                    end

                                else

                                    destroy_chams(char)

                                end
                            
                            end

                        end

                    else

                        if v.Team == dwLocalPlayer.Team then
                            destroy_chams(v.Character)
                        end

                    end

                else

                    destroy_chams(v.Character)

                end

            end

        end

    else 

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer and 
            v.Character and 
            v.Character:FindFirstChild("HumanoidRootPart") and 
            v.Character:FindFirstChild("Humanoid") and 
            v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                
                destroy_chams(v.Character)

            end

        end

    end

end)
     DiscordLib:Notification("Notification", "Chams loaded", "Close")
    end
)

btns:Seperator()

btns:Button(
    "Aimbot",
    function()
        local dwCamera = workspace.CurrentCamera
        local dwRunService = game:GetService("RunService")
        local dwUIS = game:GetService("UserInputService")
        local dwEntities = game:GetService("Players")
        local dwLocalPlayer = dwEntities.LocalPlayer
        local dwMouse = dwLocalPlayer:GetMouse()
        
        local settings = {
            Aimbot = true,
            Aiming = false,
            Aimbot_AimPart = "Head",
            Aimbot_TeamCheck = true,
            Aimbot_Draw_FOV = true,
            Aimbot_FOV_Radius = 100,
            Aimbot_FOV_Color = Color3.fromRGB(0,255,255)
        }
        
        local fovcircle = Drawing.new("Circle")
        fovcircle.Visible = settings.Aimbot_Draw_FOV
        fovcircle.Radius = settings.Aimbot_FOV_Radius
        fovcircle.Color = settings.Aimbot_FOV_Color
        fovcircle.Thickness = 1
        fovcircle.Filled = false
        fovcircle.Transparency = 1
        
        fovcircle.Position = Vector2.new(dwCamera.ViewportSize.X / 2, dwCamera.ViewportSize.Y / 2)
        
        dwUIS.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton2 then
                settings.Aiming = true
            end
        end)
        
        dwUIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton2 then
                settings.Aiming = false
            end
        end)
        
        dwRunService.RenderStepped:Connect(function()
            
            local dist = math.huge
            local closest_char = nil
        
            if settings.Aiming then
        
                for i,v in next, dwEntities:GetChildren() do 
        
                    if v ~= dwLocalPlayer and
                    v.Character and
                    v.Character:FindFirstChild("HumanoidRootPart") and
                    v.Character:FindFirstChild("Humanoid") and
                    v.Character:FindFirstChild("Humanoid").Health > 0 then
        
                        if settings.Aimbot_TeamCheck == true and
                        v.Team ~= dwLocalPlayer.Team or
                        settings.Aimbot_TeamCheck == false then
        
                            local char = v.Character
                            local char_part_pos, is_onscreen = dwCamera:WorldToViewportPoint(char[settings.Aimbot_AimPart].Position)
        
                            if is_onscreen then
        
                                local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude
        
                                if mag < dist and mag < settings.Aimbot_FOV_Radius then
        
                                    dist = mag
                                    closest_char = char
        
                                end
                            end
                        end
                    end
                end
        
                if closest_char ~= nil and
                closest_char:FindFirstChild("HumanoidRootPart") and
                closest_char:FindFirstChild("Humanoid") and
                closest_char:FindFirstChild("Humanoid").Health > 0 then
        
                    dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, closest_char[settings.Aimbot_AimPart].Position)
                end
            end
        end)
        DiscordLib:Notification("Notification", "Aimbot loaded", "Close")
    end
)

