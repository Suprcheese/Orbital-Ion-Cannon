require "util"
require "defines"
require "stdlib/game"
require ("config")

script.on_init(function() On_Init() end)
script.on_configuration_changed(function() On_Init() end)
script.on_load(function() On_Load() end)

remote.add_interface("orbital_ion_cannon",
	{
		on_ion_cannon_fired = function() return getIonCannonFiredEventID() end
	}
)

function On_Init()
	getIonCannonFiredEventID()
	if not global.IonCannonLaunched then
		global.IonCannonLaunched = false
	end
	if not global.forces_ion_cannon_table then
		global.forces_ion_cannon_table = {"player"}
		global.forces_ion_cannon_table["player"] = {}
	end
	if not global.SelectTarget then
		global.SelectTarget = {}
	end
	if not global.goToFull then
		global.goToFull = {}
	end
	if global.ion_cannon_table then
		global.forces_ion_cannon_table["player"] = global.ion_cannon_table 	-- Migrate ion cannon tables from version 1.0.5 and lower
		global.ion_cannon_table = nil 										-- Remove old ion cannon table
	end
	for i, player in ipairs(game.players) do
		if not global.forces_ion_cannon_table[player.force.name] then
			table.insert(global.forces_ion_cannon_table, player.force.name)
			global.forces_ion_cannon_table[player.force.name] = {}
		end
		global.SelectTarget[player.index] = false
		if global.goToFull[player.index] == nil then
			global.goToFull[player.index] = true
		end
	end
	for i, force in pairs(game.forces) do
		if global.forces_ion_cannon_table[force.name] and #global.forces_ion_cannon_table[force.name] > 0 then
			global.IonCannonLaunched = true
			script.on_event(defines.events.on_tick, process_tick)
			break
		end
	end
end

function On_Load()
	getIonCannonFiredEventID()
	if global.IonCannonLaunched then
		script.on_event(defines.events.on_tick, process_tick)
	end
end

function getIonCannonFiredEventID()
	if not when_ion_cannon_fired then
		when_ion_cannon_fired = script.generate_event_name()
	end
	return when_ion_cannon_fired
end

script.on_event(defines.events.on_force_created, function(event)
	if not global.forces_ion_cannon_table then
		On_Init()
	end
	table.insert(global.forces_ion_cannon_table, event.force.name)
	global.forces_ion_cannon_table[event.force.name] = {}
end)

script.on_event(defines.events.on_forces_merging, function(event)
	global.forces_ion_cannon_table[event.source.name] = nil
	for i, player in ipairs(game.players) do
		init_GUI(player)
	end
end)

function init_GUI(player)
	if not player.connected then
		return
	end
	if #global.forces_ion_cannon_table[player.force.name] == 0 then
		local frame = player.gui.top["ion-cannon-stats"]
		if (frame) then
			frame.destroy()
		end
		if player.gui.top["ion-cannon-button"] then
			player.gui.top["ion-cannon-button"].destroy()
		end
		return
	end
	if (not player.gui.top["ion-cannon-button"]) then
		player.gui.top.add{type="button", name="ion-cannon-button", caption={"ion-cannons"}}
	end
end

function open_GUI(player)
	local frame = player.gui.top["ion-cannon-stats"]
	if (frame) and global.goToFull[player.index] then
		frame.destroy()
	else
		if global.goToFull[player.index] then
			global.goToFull[player.index] = false
			if (frame) then
				frame.destroy()
			end
			frame = player.gui.top.add{type="frame", name="ion-cannon-stats", direction="vertical"}
			frame.add{type="label", caption={"ion-cannon-details-full"}}
			frame.add{type="table", colspan=2, name="ion-cannon-table"}
			for i = 1, #global.forces_ion_cannon_table[player.force.name] do
				frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
				if global.forces_ion_cannon_table[player.force.name][i][2] == 1 then
					frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
				else
					frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.forces_ion_cannon_table[player.force.name][i][1]}}
				end
			end
		else
			global.goToFull[player.index] = true
			if (frame) then
				frame.destroy()
			end
			frame = player.gui.top.add{type="frame", name="ion-cannon-stats", direction="vertical"}
			frame.add{type="label", caption={"ion-cannon-details-compact"}}
			frame.add{type="table", colspan=1, name="ion-cannon-table"}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-in-orbit", #global.forces_ion_cannon_table[player.force.name]}}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-ready", countIonCannonsReady(player)}}
			if countIonCannonsReady(player) < #global.forces_ion_cannon_table[player.force.name] then
				frame["ion-cannon-table"].add{type = "label", caption = {"time-until-next-ready", timeUntilNextReady(player)}}
			end
		end
	end
end

function update_GUI(player)
	if not player.connected then
		return
	end
	init_GUI(player)
	local frame = player.gui.top["ion-cannon-stats"]
	if (frame) then
		if frame["ion-cannon-table"] and not global.goToFull[player.index] then
			frame["ion-cannon-table"].destroy()
			frame.add{type="table", colspan=2, name="ion-cannon-table"}
			for i = 1, #global.forces_ion_cannon_table[player.force.name] do
				frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
				if global.forces_ion_cannon_table[player.force.name][i][2] == 1 then
					frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
				else
					frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.forces_ion_cannon_table[player.force.name][i][1]}}
				end
			end
		end
		if frame["ion-cannon-table"] and global.goToFull[player.index] then
			frame["ion-cannon-table"].destroy()
			frame.add{type="table", colspan=1, name="ion-cannon-table"}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-in-orbit", #global.forces_ion_cannon_table[player.force.name]}}
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannons-ready", countIonCannonsReady(player)}}
			if countIonCannonsReady(player) < #global.forces_ion_cannon_table[player.force.name] then
				frame["ion-cannon-table"].add{type = "label", caption = {"time-until-next-ready", timeUntilNextReady(player)}}
			end
		end
	end
end

function countIonCannonsReady(player)
    local ionCannonsReady = 0
	for i, cooldown in ipairs(global.forces_ion_cannon_table[player.force.name]) do
		if cooldown[2] == 1 then
			ionCannonsReady = ionCannonsReady + 1
		end
	end
	return ionCannonsReady
end

function timeUntilNextReady(player)
	local shortestCooldown = ionCannonCooldownSeconds
	for i, cooldown in ipairs(global.forces_ion_cannon_table[player.force.name]) do
		if cooldown[1] < shortestCooldown and cooldown[2] == 0 then
			shortestCooldown = cooldown[1]
		end
	end
	return shortestCooldown
end

script.on_event(defines.events.on_gui_click, function(event)
	local player = game.players[event.element.player_index]
	local name = event.element.name
	if (name == "ion-cannon-button") then
		open_GUI(player)
		return
	end
end)

script.on_event(defines.events.on_player_created, function(event)
	init_GUI(game.players[event.player_index])
end)

function process_tick()
    if game.tick % 60 == 47 then
		ReduceIonCannonCooldowns()
		for i, force in pairs(game.forces) do
			if global.forces_ion_cannon_table[force.name] then
				if isIonCannonReady(force) then
					if playVoices then
						playSoundForForce("ion-cannon-ready", force)
					end
				end
			end
		end
		for i, player in ipairs(game.players) do
			update_GUI(player)
			if player.connected and playVoices and #global.forces_ion_cannon_table[player.force.name] > 0 and isHolding({name="ion-cannon-targeter", count=1}, player) and not global.SelectTarget[player.index] and not isAllIonCannonOnCooldown(player) then
				playSoundForPlayer("select-target", player)
				global.SelectTarget[player.index] = true
			end
			if not isHolding({name="ion-cannon-targeter", count=1}, player) and global.SelectTarget[player.index] then
				global.SelectTarget[player.index] = false
			end
		end
	end
end

function ReduceIonCannonCooldowns()
	for i, force in pairs(game.forces) do
		if global.forces_ion_cannon_table[force.name] then
			for i, cooldown in ipairs(global.forces_ion_cannon_table[force.name]) do
				if cooldown[1] > 0 then
					global.forces_ion_cannon_table[force.name][i][1] = global.forces_ion_cannon_table[force.name][i][1] - 1
				end
			end
		end
	end
end

function isAllIonCannonOnCooldown(player)
    for i, cooldown in ipairs(global.forces_ion_cannon_table[player.force.name]) do
		if cooldown[2] == 1 then
			return false
		end
	end
	return true
end

function isIonCannonReady(force)
    for i, cooldown in ipairs(global.forces_ion_cannon_table[force.name]) do
		if cooldown[1] == 0 and cooldown[2] == 0 then
			cooldown[2] = 1
			return true
		end
	end
	return false
end

function anyFriendlyCanReach(entity, force)
	for i, player in ipairs(force.players) do
		if player.connected and player.can_reach_entity(entity) then
			return true
		end
	end
	return false
end

function playSoundForPlayer(sound, player)
	player.surface.create_entity({name = sound, position = player.position})
end

function playSoundForForce(sound, force)
	for i, player in ipairs(force.players) do
		if player.connected then
			player.surface.create_entity({name = sound, position = player.position})
		end
	end
end

function playSoundForAllPlayers(sound)
	for i, player in ipairs(game.players) do
		if player.connected then
			player.surface.create_entity({name = sound, position = player.position})
		end
	end
end

function isHolding(stack, player)
	local holding = player.cursor_stack
	if holding and holding.valid_for_read and (holding.name == stack.name) and (holding.count >= stack.count) then
		return true
	end
	return false
end

script.on_event(defines.events.on_rocket_launched, function(event)
	local force = event.rocket.force
	if event.rocket.get_item_count("orbital-ion-cannon") > 0 then
	  table.insert(global.forces_ion_cannon_table[force.name], {ionCannonCooldownSeconds, 0})
	  if not global.IonCannonLaunched then
		global.IonCannonLaunched = true
	  end
	  script.on_event(defines.events.on_tick, process_tick)
		if #global.forces_ion_cannon_table[force.name] == 1 then
			force.recipes["ion-cannon-targeter"].enabled = true
			for i, player in pairs(force.players) do
				init_GUI(player)
			end
			Game.print_force(force, {"congratulations-first"})
			Game.print_force(force, {"first-help"})
			Game.print_force(force, {"second-help"})
			Game.print_force(force, {"third-help"})
			if playVoices then
				playSoundForForce("ion-cannon-charging", force)
			end
		else
			if #global.forces_ion_cannon_table[force.name] > 1 then
				Game.print_force(force, {"congratulations-additional"})
			end
			Game.print_force(force, {"ion-cannons-in-orbit" , #global.forces_ion_cannon_table[force.name]})
			Game.print_force(force, {"time-to-ready" , #global.forces_ion_cannon_table[force.name] , ionCannonCooldownSeconds})
			if playVoices then
				playSoundForForce("ion-cannon-charging", force)
			end
		end
	end
end)

script.on_event(defines.events.on_built_entity, function(event)
	local player = game.get_player(event.player_index)
	if event.created_entity.name == "ion-cannon-targeter" then
		player.insert({name="ion-cannon-targeter", count=1})
		return event.created_entity.destroy()
	end
end)

script.on_event(defines.events.on_put_item, function(event)
	if global.tick ~= nil and global.tick > event.tick then
		return
	end
	global.tick = event.tick + lockoutTicks
	local player = game.get_player(event.player_index)
	if isHolding({name="ion-cannon-targeter", count=1}, player) then
		local cannonNum = 0
		for i, cooldown in ipairs(global.forces_ion_cannon_table[player.force.name]) do
			if cooldown[2] == 1 then
				cannonNum = i
				break
			end
		end
		if cannonNum == 0 then
			player.print({"unable-to-fire"})
		else
			player.print({"targeting-ion-cannon" , cannonNum})
			local TargetPosition = event.position
			TargetPosition.y = TargetPosition.y + 1
			local IonTarget=player.surface.create_entity({name = "ion-cannon-target", position = TargetPosition, force = game.forces.enemy})
			if anyFriendlyCanReach(IonTarget, player.force) and proximityCheck then
				player.print({"proximity-alert"})
				IonTarget.destroy()
			else
				local CrosshairsPosition = event.position
				CrosshairsPosition.y = CrosshairsPosition.y - 20
				player.surface.create_entity({name = "crosshairs", target = IonTarget, force = player.force, position = CrosshairsPosition, speed = 0})
				Game.print_force(player.force, {"target-acquired"})
				if playKlaxon then
					playSoundForAllPlayers("klaxon")
				end
				global.forces_ion_cannon_table[player.force.name][cannonNum][1] = ionCannonCooldownSeconds
				global.forces_ion_cannon_table[player.force.name][cannonNum][2] = 0
				Game.print_force(player.force, {"time-to-ready-again" , cannonNum , ionCannonCooldownSeconds})
				game.raise_event(when_ion_cannon_fired, {force = player.force, player_index = event.player_index, position = TargetPosition})		-- Passes event.force, event.player_index, and event.position
			end
		end
	end
end)
