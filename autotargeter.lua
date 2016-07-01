require "stdlib/area/position"

function findNestNear(entity)
	local search = Position.expand_to_area(entity.position, autoTargetRange)
	local spawners = entity.surface.find_entities_filtered{area = search, type = "unit-spawner", limit = 1}
	if #spawners > 0 then
		return spawners[1]
	end
	if targetWorms then
		local worms = entity.surface.find_entities_filtered{area = search, type = "turret", limit = 1}
		if #worms > 0 then
			return worms[1]
		end
	end
	return false
end

script.on_event(defines.events.on_sector_scanned, function(event)
	local radar = event.radar
	if radar.name == "auto-targeter" then
		local target = findNestNear(radar)
		if target then
			local fired = targetIonCannon(radar.force, target.position, radar.surface)
			if fired and printMessages then
				Game.print_force(radar.force, {"auto-target-designated", radar.backer_name, target.position.x, target.position.y})
			end
		end
	end
end)
