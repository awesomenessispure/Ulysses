local CATEGORY_NAME = "Truly Silent"

------------------------------ Sslay ------------------------------
function ulx.tslay( calling_ply, target_plys )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif not v:Alive() then
			ULib.tsayError( calling_ply, v:Nick() .. " is already dead!", true )
		elseif v:IsFrozen() then
			ULib.tsayError( calling_ply, v:Nick() .. " is frozen!", true )
		else
			if v:InVehicle() then
				v:ExitVehicle()
			end

			v:KillSilent()
			table.insert( affected_plys, v )
		end
	end

	ulx.fancyLogAdmin( calling_ply, "#T was slayed by (DEMOCRACY)", affected_plys )
end
local tslay = ulx.command( CATEGORY_NAME, "ulx tslay", ulx.tslay, "!tslay" )
tslay:addParam{ type=ULib.cmds.PlayersArg }
tslay:defaultAccess( ULib.ACCESS_ADMIN )
tslay:help( "Silently slays target(s)." )
