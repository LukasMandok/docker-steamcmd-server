-----------------------------------------------------------------
-- @package     LuneraLITE
-- @author      Richard
-- @build       v1.4.0
-- @release     11.22.2015
-----------------------------------------------------------------

Lunera = Lunera or {}

-----------------------------------------------------------------
-- [ RESOURCES ]
-----------------------------------------------------------------

if Lunera.Settings.WorkshopEnabled then
	resource.AddWorkshop( "518104095" )
end

if Lunera.Settings.ResourcesEnable then

	resource.AddFile( "resource/fonts/adventpro_light.ttf" )
	resource.AddFile( "resource/fonts/oswald_light.ttf" )
	resource.AddFile( "resource/fonts/teko_light.ttf" )

	resource.AddFile( "materials/lunera/lunera_btn_donate.png" )
	resource.AddFile( "materials/lunera/lunera_btn_close.png" )
	resource.AddFile( "materials/lunera/lunera_btn_rules.png" )
	resource.AddFile( "materials/lunera/lunera_btn_roles.png" )
	resource.AddFile( "materials/lunera/lunera_btn_steam.png" )
	resource.AddFile( "materials/lunera/lunera_btn_website.png" )
	resource.AddFile( "materials/lunera/lunera_btn_workshop.png" )
	resource.AddFile( "materials/lunera/lunera_btn_server.png" )

end

-----------------------------------------------------------------
-- [ NETWORK STRINGS ]
-----------------------------------------------------------------

util.AddNetworkString( "LuneraInitMenu" )

-----------------------------------------------------------------
-- Lunera.PlayerJoinAnnounce
-----------------------------------------------------------------

function Lunera:PlayerJoin ( ply )
	if Lunera.Settings.InitOnJoin then
		timer.Create( "LuneraDelay", 4, 1, function()
			net.Start( "LuneraInitMenu" )
			net.Send( ply )
		end)
	end
end
hook.Add( "PlayerInitialSpawn", "Lunera:PlayerJoin", function( ply ) Lunera:PlayerJoin( ply ) end )

hook.Add("PlayerSay","Lunera.Request",function( ply, text )
	local text = string.lower(text)
	if text == Lunera.Settings.KeybindChat then
		ply:ConCommand("lunera_motd")
		return false
	end
end)