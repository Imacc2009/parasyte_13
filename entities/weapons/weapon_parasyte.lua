SWEP.PrintName		= "Parasyte"
SWEP.Author 		= "Hocka"
SWEP.Instructions 	= "Left mouse to attack."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.Clipsize  = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.ViewModel = ""
SWEP.WorldModel = ""

SWEP.Slot = 2
SWP.SlotPos = 1

 function SWEP:Initialize()
    self:SetHoldType("normal")
end


function SWEP:Deploy()
	self:GetOwner():DrawViewModel(false)
	self:GetOwner():DrawViewModel(false)

function SWEP:Holster()
	self:GetOwner():DrawViewModel(true)
	return true
end