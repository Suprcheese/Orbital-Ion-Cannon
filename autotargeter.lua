require "stdlib/area/position"

function findSpawnerNear(entity)
	local search = Position.expand_to_area(entity.position, autoTargetRange)
	local spawners = entity.surface.find_entities_filtered{area = search, type = "unit-spawner"}
	if spawners then
		return spawners[1]
	else
		return false
	end
end

script.on_event(defines.events.on_sector_scanned, function(event)
	local radar = event.radar
	if radar.name == "auto-targeter" then
		local spawner = findSpawnerNear(radar)
		if spawner then
			Game.print_force(radar.force, {"auto-target-designated", radar.backer_name, spawner.position.x, spawner.position.y})
			targetIonCannon(radar.force, spawner.position, radar.surface)
		end
	end
end)
