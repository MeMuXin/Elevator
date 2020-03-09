--[[
Author
Made by STR_Warrior(NiLSPACE)
]]




function Initialize(a_Plugin)
	a_Plugin:SetName("Elevator");
	a_Plugin:SetVersion(1);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, JugadorSalta);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_CROUCHING, JugadorAgacha);


	-- Load the InfoReg shared library:
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

	
	LOG("Initialized " .. a_Plugin:GetName() .. " v" .. a_Plugin:GetVersion())
	return true;
	--TODO New recipe
end


function JugadorSalta(Player, OldPosition, NewPosition, PreviousIsOnGround) -- player jumps
		a_Delta = OldPosition - NewPosition;
		if (a_Delta.y < 0) then
			if PreviousIsOnGround == true then
			--Player:SendMessage(Player:GetWorld():GetBlock(OldPosition.x, OldPosition.y-1, OldPosition.z) .. " META " .. Player:GetWorld():GetBlockMeta(OldPosition.x, OldPosition.y-1, OldPosition.z) .. " META " .. Player:GetWorld():GetHeight(OldPosition.x, OldPosition.z))
			--revisar desde donde estoy yo hasta el proximo bloque (hacia arriba) numero 35 meta 128 (Lana)
			for i = OldPosition.y, Player:GetWorld():GetHeight(OldPosition.x, OldPosition.z), 1 do
				if Player:GetWorld():GetBlock(OldPosition.x, i, OldPosition.z)	== 35 then
					Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
					return true
				end
			end
			end
		end
	return false
end

function JugadorAgacha(Player, IsCrouched) -- player crouches
	if IsCrouched then
			OldPosition = Player:GetPosition()
			--revisar desde donde estoy yo hasta el proximo (Hacia abajo) bloque numero 35 meta 128 (Lana)
			local i = OldPosition.y-2
			while i >= 3 do
				if Player:GetWorld():GetBlock(OldPosition.x, i, OldPosition.z)	== 35 then
					Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
					return true
				end
				i = i - 1
			end
	else
		return false
	end
end

