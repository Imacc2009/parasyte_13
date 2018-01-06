GM.Name = "Parasyte 13"
GM.Author = "Hocka & josephfra"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:CreateTeams()

	team.SetUp( 1, "Citizens", Color(0,200,0))
	team.SetUp( 2, "Robot", Color(100,100,100))
	team.SetUp( 3, "Parasyte", Color(200,0,0))

end

function GM:KeyPress(ply, key)
	if ply:Team() == 3
		if ( key == IN_USE ) then
			ply:SetModel("models/player/charple.mdl")
			ply:SetWalkSpeed(400)
			sound.Play("npc/stalker/go_alert2.wav", ply:GetPos())
			print("ass")
		end
	end
end 