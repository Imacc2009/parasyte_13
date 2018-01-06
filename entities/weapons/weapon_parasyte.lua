SWEP.PrintName		= "Parasyte"
SWEP.Author 		= "Hocka"
SWEP.Instructions 	= "Left mouse to attack."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.SetHoldType = "normal"
SWEP.DrawAmmo = false

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Slot = 0
SWEP.SlotPos = 1

 function SWEP:Initialize()
    self:SetHoldType("normal")
end


function SWEP:Deploy()
	self:GetOwner():DrawViewModel(false)
	self:GetOwner():DrawViewModel(false)
end

function SWEP:Holster()
	self:GetOwner():DrawViewModel(true)
	return true
end

local SwingSound = "npc/zombie/claw_miss1.wav"
local HitSound = "npc/zombie/claw_strike1.wav"

function SWEP:PrimaryAttack()
	if (CLIENT) then return end
	
	local ply = self:GetOwner()
	
	ply:LagCompensation(true)
	
	local shootpos = ply:GetShootPos()
	local endshootpos = shootpos + ply:GetAimVector() * 100
	local tmin = Vector(1, 1, 1) * -10
	local tmax = Vector(1, 1, 1) * 10
	
	local tr = util.TraceHull({start = shootpos,
		endpos = endshootpos,
		filter = ply,
		mask = MASK_SHOT_HULL,
		mins = tmin,
		maxs = tmax,})
		
	if (not IsValid(tr.Entity)) then
		tr = util.TraceLine({start = shootpos,
		endpos = endshootpos,
		filter = ply,
		mask = MASK_SHOT_HULL})
	end
	
	local ent = tr.Entity
	
	if (IsValid(ent) and ent:IsPlayer()) then
		sound.Play(HitSound, (ply:GetPos()))
		ent:SetHealth(ent:Health() - 50)
		if (ent:Health() < 1) then
			ent:Kill()
		end
		
	elseif (IsValid(ent) and ent:IsNPC()) then
		sound.Play(HitSound, (ply:GetPos()))
		ent:SetHealth(ent:Health() - 50)
		if (ent:Health() < 1) then
			ent:TakeDamage(50, ply, self)
		end
		
		self:SetNextPrimaryFire(CurTime() + 1)
		
	elseif (!IsValid(ent)) then
		sound.Play(SwingSound, (ply:GetPos()))
	
	self:SetNextPrimaryFire(CurTime() + 1)
	end

		
	
	ply:LagCompensation(false)
end

function SWEP:CanSecondaryAttack()
	return false
end