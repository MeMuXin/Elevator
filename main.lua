--[[
Author
Made by TheMeMuX
]]




function Initialize(a_Plugin)
	a_Plugin:SetName("Elevator");
	a_Plugin:SetVersion(1);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, JugadorSalta);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_CROUCHED, JugadorAgacha);


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
				--Player:SendMessage("Bloque: " .. Player:GetWorld():GetBlock(OldPosition.x-1, Player:GetPosY()-1, OldPosition.z))
		if Player:GetWorld():GetBlock(OldPosition.x-1, OldPosition.y-1, OldPosition.z) == E_BLOCK_WOOL then

					for i = OldPosition.y, Player:GetWorld():GetHeight(OldPosition.x-1, OldPosition.z), 1 do
						if Player:GetWorld():GetBlock(OldPosition.x-1, i, OldPosition.z) == E_BLOCK_WOOL then

							Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
							return true
						end
					end
				end
			end
		end
	return false
end

function JugadorAgacha(Player) -- player crouches
OldPosition = Player:GetPosition()
	if Player:GetWorld():GetBlock(OldPosition.x-1, OldPosition.y-1, OldPosition.z) == E_BLOCK_WOOL then
	--revisar desde donde estoy yo hasta el proximo (Hacia abajo) bloque numero 35 meta 128 (Lana)
		local i = OldPosition.y-2
		while i >= 3 do
			if Player:GetWorld():GetBlock(OldPosition.x-1, i, OldPosition.z)	== E_BLOCK_WOOL then
				Player:TeleportToCoords(OldPosition.x, i+1, OldPosition.z)
				Player:SetInvulnerableTicks(14)
				return true
			end
			i = i - 1
		end
	end
end

