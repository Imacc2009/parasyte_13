AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

function GM:StartRound()

	local parasyteindex = math.random(#player.GetAll())
	local parasyte = player.GetAll()[parasyteindex]
	
	local robotindex = math.random(#player.GetAll())
	
	while parasyteindex == robotindex do
	
		local robotindex = math.random(#player.GetAll())

	end
	
	local robot = player.GetAll()[robotindex]
	
	parasyte:SetTeam(3)
	robot:SetTeam(2)
	
	for k, v in pairs(player.GetAll()) do
		if k == parasyteindex or k == robotindex then
			continue
		else
			v:SetTeam(1)
		end
	end
	
end
