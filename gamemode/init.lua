AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

util.AddNetworkString("Parasyte_RoleNoti_P")
util.AddNetworkString("Parasyte_RoleNoti_R")
util.AddNetworkString("Parasyte_RoleNoti_S")

round = {}

round.Started = false
round.AcceptPlayers = false

local function RandomColor()

	r = math.random(255)
	g = math.random(255)
	b = math.random(255)

	return Vector(r/255, g/255, b/255)
end

local function RandomModel()

	local models = {
		"models/player/group01/male_01.mdl",
		"models/player/group01/female_01.mdl",
	}
	
	index = math.random(#models)
	local model = models[index]
	
	if index == 1 then
		model = string.Replace(model, "male_01", "male_0"..math.random(9))
	else
		model = string.Replace(model, "female_01", "female_0"..math.random(6))
	end
	
	return model

end

function GM:PreStartRound()

	local parasyteindex = math.random(#player.GetAll())
	local parasyte = player.GetAll()[parasyteindex]
	
	local robotindex = math.random(#player.GetAll())
	
	while parasyteindex == robotindex do
	
		robotindex = math.random(#player.GetAll())

	end
	
	local robot = player.GetAll()[robotindex]
	
	parasyte:SetTeam(3)
	robot:SetTeam(2)
	
	net.Start("Parasyte_RoleNoti_P")
	net.Send(parasyte)
	
	net.Start("Parasyte_RoleNoti_R")
	net.Send(robot)
	
	round.AcceptPlayers = true
	for k, v in pairs(player.GetAll()) do
		
		v:SetNWString("IsParasyte", false)
		v:StripWeapons()
		v:AllowFlashlight(true)
		v:Spectate(OBS_MODE_NONE)
		v:Spawn()
		v:SetWalkSpeed(100)
		
		if k == parasyteindex then
			v:SetModel(RandomModel())
			v:SetPlayerColor(RandomColor())
		elseif k == robotindex then
			v:SetModel("models/player/combine_super_soldier.mdl")
			v:SetPlayerColor(RandomColor())
			v:SetArmor(50)
		else
			v:SetTeam(1)
			v:SetModel(RandomModel())
			v:SetPlayerColor(RandomColor())
			net.Start("Parasyte_RoleNoti_S")
			net.Send(v)
		end
		
	end
	round.AcceptPlayers = false
	
end

function GM:PlayerSpawn(ply)
	if round.AcceptPlayers == false then
		ply:Spectate(OBS_MODE_ROAMING)
	end
	ply:SetupHands()
end

function GM:PlayerNoClip(ply)
	
	return ply:IsAdmin()

end

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function GM:Think()

	if round.Started == false  and player.GetCount() >= 5 then
		round.Started = true
		GAMEMODE:PreStartRound()
	end

end

function GM:KeyPress(ply, key)
	if ply:Team() == 3 and ( key == IN_USE ) then
		if !(ply:IsParasyte()) then
			ply.OldModel = ply:GetModel()
			ply:SetNWString("IsParasyte", true)
			ply:SetModel("models/player/charple.mdl")
			ply:SetWalkSpeed(400)
			sound.Play("npc/stalker/go_alert2.wav", ply:GetPos(), 170, 100, 1)
			ply:Give("weapon_parasyte", false)
		else
			ply:StripWeapon("weapon_parasyte")
			ply:SetModel(ply.OldModel)
			ply:SetWalkSpeed(100)
			ply:SetNWString("IsParasyte", false)
		end
	end
end

do
	local ply = FindMetaTable( "Player" )
	
	function ply:IsParasyte()
		return self:GetNWString("IsParasyte", false)
	end

end

function ply:Give(weapon, reserve)
	if ply:Team() == 2 then
		give("weapon_ar2", true)
	end
end