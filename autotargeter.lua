function findNestNear(entity, chunk_position)
	local search = Chunk.to_area(chunk_position)
	local spawners = entity.surface.find_entities_filtered{area = search, type = "unit-spawner"}
	if #spawners > 0 then
		return spawners[math.random(#spawners)]
	end
	if settings.global["ion-cannon-target-worms"].value then
		local worms = entity.surface.find_entities_filtered{area = search, type = "turret"}
		if #worms > 0 then
			return worms[math.random(#worms)]
		end
	end
	return false
end

script.on_event(defines.events.on_sector_scanned, function(event)
	if settings.global["ion-cannon-auto-targeting"].value then
		local radar = event.radar
		if radar.force.technologies["auto-targeting"].researched == true then
			local target = findNestNear(radar, event.chunk_position)
			if target then
				local fired = targetIonCannon(radar.force, target.position, radar.surface)
				if fired then
					for i, player in pairs(radar.force.connected_players) do
						if settings.get_player_settings(player)["ion-cannon-verbose-print"].value then
							player.print({"auto-target-designated", target.position.x, target.position.y})
						end
					end
				end
			end
		end
	end
end)

script.on_event(defines.events.on_biter_base_built, function(event)
	if settings.global["ion-cannon-auto-target-visible"].value then
		local base = event.entity
		for i, force in pairs(game.forces) do
			if force.technologies["auto-targeting"].researched == true then
				if force.is_chunk_visible(base.surface, Chunk.from_position(base.position)) then
					local current_tick = game.tick
					if global.auto_tick < current_tick then
						global.auto_tick = current_tick + settings.startup["ion-cannon-heatup-multiplier"].value * 210
						local fired = targetIonCannon(force, base.position, base.surface)
						if fired then
							for i, player in pairs(force.connected_players) do
								if settings.get_player_settings(player)["ion-cannon-verbose-print"].value then
									player.print({"auto-target-designated", base.position.x, base.position.y})
								end
							end
							break
						end
					end
				end
			end
		end
	end
end)
