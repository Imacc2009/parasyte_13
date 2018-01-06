include( "shared.lua" )

surface.CreateFont("PlayerInfo", {
	font = "DermaDefault",
	antialias = true,
	size = 20,
	weight = 800,
} )

surface.CreateFont("RoleInfo", {
	font = "DermaDefault",
	antialias = true,
	size = 70,
	weight = 800,
} )

surface.CreateFont("RoleName", {
	font = "DermaDefault",
	antialias = true,
	size = 100,
	weight = 800,
} )

function GM:HUDDrawTargetID()
	
	local ent = LocalPlayer():GetEyeTrace().Entity
	
	if ent:IsPlayer() then
		distance = ent:GetPos():Distance(LocalPlayer():GetPos())
		if distance < 400 then
			local color = team.GetColor(ent:Team())
			
			surface.SetFont("PlayerInfo")
			w, h = surface.GetTextSize(ent:Nick())
			draw.SimpleTextOutlined(ent:Nick(), "PlayerInfo", ScrW()/2 - w/2, ScrH()/2 + h, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0))
		end
	end

end

net.Receive("Parasyte_RoleNoti_P", function()

	local notification = vgui.Create("Parasyte_RoleNoti_P")
	
	timer.Simple(20, function()
		notification:Remove()
	end )

end )

net.Receive("Parasyte_RoleNoti_R", function()

	local notification = vgui.Create("Parasyte_RoleNoti_R")
	
	timer.Simple(20, function()
		notification:Remove()
	end )

end )

net.Receive("Parasyte_RoleNoti_S", function()

	local notification = vgui.Create("Parasyte_RoleNoti_S")
	
	timer.Simple(20, function()
		notification:Remove()
	end )

end )

--Parasyte Role Notification Panel
local PANEL = {}

function PANEL:Init()

	
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0,0)
	
	hook.Add("KeyPress", "closethatshit", function(ply, key)
	
		if key == IN_USE then
			self:Remove()
		end
	
	end )

end

function PANEL:Paint()
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("You are...")
	draw.SimpleTextOutlined("You are...", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*6, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleName")
	w, h = surface.GetTextSize("THE PARASYTE")
	draw.SimpleTextOutlined("THE PARASYTE", "RoleName", ScrW()/2 - w/2, ScrH()/2 - h*3.5, Color(200,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Press E to convert between survivor and parasyte.")
	draw.SimpleTextOutlined("Press E to convert between survivor and parasyte.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*3.25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Eliminate all players.")
	draw.SimpleTextOutlined("Eliminate all players.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)

end
vgui.Register( "Parasyte_RoleNoti_P", PANEL, "Panel" )

--Robot Role Notification Panel
local PANEL = {}

function PANEL:Init()

	
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0,0)
	
	hook.Add("KeyPress", "closethatshit", function(ply, key)
	
		if key == IN_USE then
			self:Remove()
		end
	
	end )

end

function PANEL:Paint()
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("You are...")
	draw.SimpleTextOutlined("You are...", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*6, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleName")
	w, h = surface.GetTextSize("THE ROBOT")
	draw.SimpleTextOutlined("THE ROBOT", "RoleName", ScrW()/2 - w/2, ScrH()/2 - h*3.5, Color(100,100,100), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Use your weapon to protect survivors.")
	draw.SimpleTextOutlined("Use your weapon to protect survivors.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*3.25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Eliminate the parasyte.")
	draw.SimpleTextOutlined("Eliminate the parasyte.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)

end
vgui.Register( "Parasyte_RoleNoti_R", PANEL, "Panel" )

--Survivor Role Notification Panel
local PANEL = {}

function PANEL:Init()

	
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0,0)
	
	hook.Add("KeyPress", "closethatshit", function(ply, key)
	
		if key == IN_USE then
			self:Remove()
		end
	
	end )

end

function PANEL:Paint()
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("You are...")
	draw.SimpleTextOutlined("You are...", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*6, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleName")
	w, h = surface.GetTextSize("A SURVIVOR")
	draw.SimpleTextOutlined("A SURVIVOR", "RoleName", ScrW()/2 - w/2, ScrH()/2 - h*3.5, Color(0,200,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Work with the robot to stay alive.")
	draw.SimpleTextOutlined("Work with the robot to stay alive.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*3.25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
	
	surface.SetFont("RoleInfo")
	w, h = surface.GetTextSize("Avoid the parasyte.")
	draw.SimpleTextOutlined("Avoid the parasyte.", "RoleInfo", ScrW()/2 - w/2, ScrH()/2 - h*2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)

end
vgui.Register( "Parasyte_RoleNoti_S", PANEL, "Panel" )