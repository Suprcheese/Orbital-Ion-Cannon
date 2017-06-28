require "util"
require "stdlib/area/chunk"
require "stdlib/area/position"
require "autotargeter"

script.on_init(function() On_Init() end)
script.on_configuration_changed(function() On_Init() end)
script.on_load(function() On_Load() end)

remote.add_interface("orbital_ion_cannon",
	{
		on_ion_cannon_targeted = function() return getIonCannonTargetedEventID() end,

		on_ion_cannon_fired = function() return getIonCannonFiredEventID() end,

		target_ion_cannon = function(force, position, surface, player) return targetIonCannon(force, position, surface, player) end -- Player is optional
	}
)

function generateEvents()
	getIonCannonTargetedEventID()
	getIonCannonFiredEventID()
end

function getIonCannonTargetedEventID()
	if not when_ion_cannon_targeted then
		when_ion_cannon_targeted = script.generate_event_name()
	end
	return when_ion_cannon_targeted
end

function getIonCannonFiredEventID()
	if not when_ion_cannon_fired then
		when_ion_cannon_fired = script.generate_event_name()
	end
	return when_ion_cannon_fired
end

function On_Init()
	generateEvents()
	if not global.forces_ion_cannon_table then
		global.forces_ion_cannon_table = {}
		global.forces_ion_cannon_table["player"] = {}
	end
	global.goToFull = global.goToFull or {}
	global.markers = global.markers or {}
	global.klaxonTick = global.klaxonTick or 0
	global.auto_tick = global.auto_tick or 0
	global.readyTick = {}
	if global.ion_cannon_table then
		global.forces_ion_cannon_table["player"] = global.ion_cannon_table 	-- Migrate ion cannon tables from version 1.0.5 and lower
		global.ion_cannon_table = nil 										-- Remove old ion cannon table
	end
	if remote.interfaces["silo_script"] then
		remote.call("silo_script", "set_show_launched_without_satellite", false) -- FINALLY!
		remote.call("silo_script", "add_tracked_item", "orbital-ion-cannon")
		remote.call("silo_script", "update_gui")
	end
	for i, player in pairs(game.players) do
		global.readyTick[player.index] = 0
		if not global.forces_ion_cannon_table[player.force.name] then
			table.insert(global.forces_ion_cannon_table, player.force.name)
			global.forces_ion_cannon_table[player.force.name] = {}
		end
		if global.goToFull[player.index] == nil then
			global.goToFull[player.index] = true
		end
		if player.gui.top["ion-cannon-button"] then
			player.gui.top["ion-cannon-button"].destroy()
		end
		if player.gui.top["ion-cannon-stats"] then
			player.gui.top["ion-cannon-stats"].destroy()
		end
	end
	for i, force in pairs(game.forces) do
		force.reset_recipes()
		if global.forces_ion_cannon_table[force.name] and #global.forces_ion_cannon_table[force.name] > 0 then
			global.IonCannonLaunched = true
			script.on_event(defines.events.on_tick, process_tick)
			break
		end
	end
end

function On_Load()
	generateEvents()
	if global.IonCannonLaunched then
		script.on_event(defines.events.on_tick, process_tick)
	end
end

script.on_event(defines.events.on_force_created, function(event)
	if not global.forces_ion_cannon_table then
		On_Init()
	end
	global.forces_ion_cannon_table[event.force.name] = {}
end)

script.on_event(defines.events.on_forces_merging, function(event)
	global.forces_ion_cannon_table[event.source.name] = nil
	for i, player in pairs(game.players) do
		init_GUI(player)
	end
end)

function init_GUI(player)
	if #global.forces_ion_cannon_table[player.force.name] == 0 then
		local frame = player.gui.left["ion-cannon-stats"]
		if (frame) then
			frame.destroy()
		end
		if player.gui.top["ion-cannon-button"] then
			player.gui.top["ion-cannon-button"].destroy()
		end
		return
	end
	if not player.gui.top["ion-cannon-button"] then
		player.gui.top.add{type="button", name="ion-cannon-button", style="ion-cannon-button-style"}
	end
end

function open_GUI(player)
	local frame = player.gui.left["ion-cannon-stats"]
	local force = player.force
	local forceName = force.name
	local player_index = player.index
	if frame and global.goToFull[player_index] then
		frame.destroy()
	else
		if global.goToFull[player_index] and #global.forces_ion_cannon_table[forceName] < 40 then
			global.goToFull[player_index] = false
			if frame then
				frame.destroy()
			end
			frame = player.gui.left.add{type="frame", name="ion-cannon-stats", direction="vertical"}
			frame.add{type="label", caption={"ion-cannon-details-full"}}
			frame.add{type="table", colspan=2, name="ion-cannon-table"}
			for i = 1, #global.forces_ion_cannon_table[forceName] do
				frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
				if global.forces_ion_cannon_table[forceName][i][2] == 1 then
					frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
				else
					frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.forces_ion_cannon_table[forceName][i][1]}}
				end
			end
		else
			global.goToFull[player_index] = true
			if frame then
				frame.destroy()
			end
			frame = player.gui.left.add{type="frame", name="ion-cannon-stats", direction="vertical"}
			frame.add{type="label", caption={"ion-cannon-details-compact"}}
			frame.add{type="table", colspan=1, name="ion-cannon-table"}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-in-orbit", #global.forces_ion_cannon_table[forceName]}}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-ready", countIonCannonsReady(force)}}
			if countIonCannonsReady(force) < #global.forces_ion_cannon_table[forceName] then
				frame["ion-cannon-table"].add{type = "label", caption = {"time-until-next-ready", timeUntilNextReady(force)}}
			end
		end
	end
end

function update_GUI(player)
	init_GUI(player)
	local frame = player.gui.left["ion-cannon-stats"]
	local force = player.force
	local forceName = force.name
	local player_index = player.index
	if frame then
		if frame["ion-cannon-table"] and not global.goToFull[player_index] then
			frame["ion-cannon-table"].destroy()
			frame.add{type="table", colspan=2, name="ion-cannon-table"}
			for i = 1, #global.forces_ion_cannon_table[forceName] do
				frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
				if global.forces_ion_cannon_table[forceName][i][2] == 1 then
					frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
				else
					frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.forces_ion_cannon_table[forceName][i][1]}}
				end
			end
		end
		if frame["ion-cannon-table"] and global.goToFull[player_index] then
			frame["ion-cannon-table"].destroy()
			frame.add{type="table", colspan=1, name="ion-cannon-table"}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-in-orbit", #global.forces_ion_cannon_table[forceName]}}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-ready", countIonCannonsReady(force)}}
			if countIonCannonsReady(force) < #global.forces_ion_cannon_table[forceName] then
				frame["ion-cannon-table"].add{type = "label", caption = {"time-until-next-ready", timeUntilNextReady(force)}}
			end
		end
	end
end

function countIonCannonsReady(force)
	local ionCannonsReady = 0
	for i, cooldown in pairs(global.forces_ion_cannon_table[force.name]) do
		if cooldown[2] == 1 then
			ionCannonsReady = ionCannonsReady + 1
		end
	end
	return ionCannonsReady
end

function timeUntilNextReady(force)
	local shortestCooldown = settings.global["ion-cannon-cooldown-seconds"].value
	for i, cooldown in pairs(global.forces_ion_cannon_table[force.name]) do
		if cooldown[1] < shortestCooldown and cooldown[2] == 0 then
			shortestCooldown = cooldown[1]
		end
	end
	return shortestCooldown
end

script.on_event(defines.events.on_gui_click, function(event)
	local player = game.players[event.element.player_index]
	local name = event.element.name
	if name == "ion-cannon-button" then
		open_GUI(player)
		return
	end
end)

script.on_event("ion-cannon-hotkey", function(event)
	local player = game.players[event.player_index]
	if global.IonCannonLaunched then
		open_GUI(player)
	end
end)

script.on_event(defines.events.on_player_created, function(event)
	init_GUI(game.players[event.player_index])
	global.readyTick[event.player_index] = 0
end)

script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
	local player = game.players[event.player_index]
	if settings.get_player_settings(player)["ion-cannon-play-voices"].value and #global.forces_ion_cannon_table[player.force.name] > 0 and isHolding({name="ion-cannon-targeter", count=1}, player) and not isAllIonCannonOnCooldown(player) then
		playSoundForPlayer("select-target", player)
	end
end)

function process_tick()
	local current_tick = game.tick
	for i = #global.markers, 1, -1 do -- Loop over table backwards because some entries get removed within the loop
		local marker = global.markers[i]
		if marker[2] == current_tick then
			marker[1].destroy()
			table.remove(global.markers, i)
		end
	end
	if current_tick % 60 == 47 then
		ReduceIonCannonCooldowns()
		for i, force in pairs(game.forces) do
			if global.forces_ion_cannon_table[force.name] and isIonCannonReady(force) then
				for i, player in pairs(force.connected_players) do
					if settings.get_player_settings(player)["ion-cannon-play-voices"].value and global.readyTick[player.index] < current_tick then
						global.readyTick[player.index] = current_tick + settings.get_player_settings(player)["ion-cannon-ready-ticks"].value
						playSoundForPlayer("ion-cannon-ready", player)
					end
				end
			end
		end
		for i, player in pairs(game.connected_players) do
			update_GUI(player)
		end
	end
end

function ReduceIonCannonCooldowns()
	for i, force in pairs(game.forces) do
		local name = force.name
		if global.forces_ion_cannon_table[name] then
			for i, cooldown in pairs(global.forces_ion_cannon_table[name]) do
				if cooldown[1] > 0 then
					global.forces_ion_cannon_table[name][i][1] = global.forces_ion_cannon_table[name][i][1] - 1
				end
			end
		end
	end
end

function isAllIonCannonOnCooldown(player)
	for i, cooldown in pairs(global.forces_ion_cannon_table[player.force.name]) do
		if cooldown[2] == 1 then
			return false
		end
	end
	return true
end

function isIonCannonReady(force)
	local found = false
	for i, cooldown in pairs(global.forces_ion_cannon_table[force.name]) do
		if cooldown[1] == 0 and cooldown[2] == 0 then
			cooldown[2] = 1
			found = true
		end
	end
	return found
end

function playSoundForPlayer(sound, player)
	local voice = settings.get_player_settings(player)["ion-cannon-voice-style"].value
	player.surface.create_entity({name = sound .. "-" .. voice, position = player.position})
end

function isHolding(stack, player)
	local holding = player.cursor_stack
	if holding and holding.valid_for_read and (holding.name == stack.name) and (holding.count >= stack.count) then
		return true
	end
	return false
end

function targetIonCannon(force, position, surface, player)
	local cannonNum = 0
	for i, cooldown in pairs(global.forces_ion_cannon_table[force.name]) do
		if cooldown[2] == 1 then
			cannonNum = i
			break
		end
	end
	if cannonNum == 0 then
		if player then
			player.print({"unable-to-fire"})
		end
		return false
	else
		local current_tick = game.tick
		local TargetPosition = position
		TargetPosition.y = TargetPosition.y + 1
		local IonTarget = surface.create_entity({name = "ion-cannon-target", position = TargetPosition, force = game.forces.neutral})
		local marker = force.add_chart_tag(surface, {icon = {type = "item", name = "orbital-ion-cannon"}, text = "Ion cannon #" .. cannonNum .. " target location", position = TargetPosition})
		table.insert(global.markers, {marker, current_tick + settings.global["ion-cannon-chart-tag-duration"].value})
		if player then
			player.print({"targeting-ion-cannon" , cannonNum})
		end
		local CrosshairsPosition = position
		CrosshairsPosition.y = CrosshairsPosition.y - 20
		surface.create_entity({name = "crosshairs", target = IonTarget, force = force, position = CrosshairsPosition, speed = 0})
		for i, player in pairs(game.connected_players) do
			if settings.get_player_settings(player)["ion-cannon-play-klaxon"].value and global.klaxonTick < current_tick then
				global.klaxonTick = current_tick + 60
				player.surface.create_entity({name = "klaxon", position = player.position})
			end
		end
		global.forces_ion_cannon_table[force.name][cannonNum][1] = settings.global["ion-cannon-cooldown-seconds"].value
		global.forces_ion_cannon_table[force.name][cannonNum][2] = 0
		if player then
			script.raise_event(when_ion_cannon_targeted, {surface = surface, force = force, position = position, radius = settings.startup["ion-cannon-radius"].value, player_index = player.index,})		-- Passes event.surface, event.force, event.position, event.radius, and event.player_index
		else
			script.raise_event(when_ion_cannon_targeted, {surface = surface, force = force, position = position, radius = settings.startup["ion-cannon-radius"].value})		-- Passes event.surface, event.force, event.position, and event.radius
		end
		return cannonNum
	end
end

script.on_event(defines.events.on_rocket_launched, function(event)
	local force = event.rocket.force
	if event.rocket.get_item_count("orbital-ion-cannon") > 0 then
		table.insert(global.forces_ion_cannon_table[force.name], {settings.global["ion-cannon-cooldown-seconds"].value, 0})
		global.IonCannonLaunched = true
		script.on_event(defines.events.on_tick, process_tick)
		for i, player in pairs(force.connected_players) do
			init_GUI(player)
			if settings.get_player_settings(player)["ion-cannon-play-voices"].value then
				playSoundForPlayer("ion-cannon-charging", player)
			end
		end
		if #global.forces_ion_cannon_table[force.name] == 1 then
			force.print({"congratulations-first"})
			force.print({"first-help"})
			force.print({"second-help"})
			force.print({"third-help"})
		else
			force.print({"congratulations-additional"})
			force.print({"ion-cannons-in-orbit" , #global.forces_ion_cannon_table[force.name]})
		end
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
	local player = game.players[event.player_index]
	if event.created_entity.name == "ion-cannon-targeter" then
		player.cursor_stack.set_stack({name="ion-cannon-targeter", count=1})
		return event.created_entity.destroy()
	end
	if event.created_entity.name == "entity-ghost" then
		if event.created_entity.ghost_name == "ion-cannon-targeter" then
			return event.created_entity.destroy()
		end
	end
end)

script.on_event(defines.events.on_trigger_created_entity, function(event)
	local created_entity = event.entity
	if created_entity.name == "ion-cannon-explosion" then
		script.raise_event(when_ion_cannon_fired, {surface = created_entity.surface, position = created_entity.position, radius = settings.startup["ion-cannon-radius"].value})		-- Passes event.surface, event.position, and event.radius
		for i, force in pairs(game.forces) do
			force.chart(created_entity.surface, Position.expand_to_area(created_entity.position, 1))
		end
	end
end)

script.on_event(defines.events.on_put_item, function(event)
	local current_tick = event.tick
	if global.tick and global.tick > current_tick then
		return
	end
	global.tick = current_tick + 10
	local player = game.players[event.player_index]
	if isHolding({name="ion-cannon-targeter", count=1}, player) then
		local fired = targetIonCannon(player.force, event.position, player.surface, player)
		if fired then
			local TargetPosition = event.position
			TargetPosition.y = TargetPosition.y + 1
			for i, p in pairs(player.force.connected_players) do
				if settings.get_player_settings(p)["ion-cannon-custom-alerts"].value then
					p.add_custom_alert(p.character, {type = "item", name = "orbital-ion-cannon"}, {"ion-cannon-target-location", fired, TargetPosition.x, TargetPosition.y}, true)
				end
			end
		end
	end
end)
