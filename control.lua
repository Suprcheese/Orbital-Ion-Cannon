require "util"
require "defines"
require ("config")

script.on_init(function() On_Load() end)
script.on_load(function() On_Load() end)

function On_Load()
    if not global.ion_cannon_table then
	  global.ion_cannon_table = {}
	end
	SelectTarget = false
end

function init_GUI(player)
	if #global.ion_cannon_table == 0 then
		return
	end
	if (not player.gui.top["ion-cannon-button"]) then
		player.gui.top.add{type="button", name="ion-cannon-button", caption={"ion-cannons"}}
	end
end

function open_GUI(player)
	local frame = player.gui.top["ion-cannon-stats"]
	if (frame) then
		frame.destroy()
	else
		frame = player.gui.top.add{type="frame", name="ion-cannon-stats", direction="vertical"}
		frame.add{type="label", caption={"ion-cannon-details"}}
		frame.add{type="table", colspan=2, name="ion-cannon-table"}
		for i = 1, #global.ion_cannon_table do
			frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
			if global.ion_cannon_table[i][2] == 1 then
				frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
			else
				frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.ion_cannon_table[i][1]}}
			end
		end
	end
end

function update_GUI()
	for i, player in pairs(game.players) do
		local frame = player.gui.top["ion-cannon-stats"]
		if (frame) then
			if frame["ion-cannon-table"] then
				frame["ion-cannon-table"].destroy()
				frame.add{type="table", colspan=2, name="ion-cannon-table"}
				for i = 1, #global.ion_cannon_table do
					frame["ion-cannon-table"].add{type = "label", caption = {"ion-cannon-num", i}}
					if global.ion_cannon_table[i][2] == 1 then
						frame["ion-cannon-table"].add{type = "label", caption = {"ready"}}
					else
						frame["ion-cannon-table"].add{type = "label", caption = {"cooldown", global.ion_cannon_table[i][1]}}
					end
				end
			end
		end
	end
end

script.on_event(defines.events.on_gui_click, function(event)
	local player = game.players[event.element.player_index]
	local name = event.element.name
	if (name == "ion-cannon-button") then
		open_GUI(player)
	end
end)

script.on_event(defines.events.on_player_created, function(event)
	init_GUI(game.players[event.player_index])
end)

script.on_event(defines.events.on_tick, function(event)
    if game.tick % 60 == 37 then
		ReduceIonCannonCooldowns()
		update_GUI()
		if isIonCannonReady() and playVoices then
			playSoundForAllPlayers("ion-cannon-ready")
		end
		for i, player in ipairs(game.players) do
			if isHolding({name="ion-cannon-targeter", count=1}, player) and not SelectTarget and #global.ion_cannon_table > 0 and playVoices and not isAllIonCannonOnCooldown() then
				playSoundForPlayer("select-target", player)
				SelectTarget = true
			end
			if not isHolding({name="ion-cannon-targeter", count=1}, player) and SelectTarget then
				SelectTarget = false
			end
		end
	end
end)

function ReduceIonCannonCooldowns()
    for i, cooldown in ipairs(global.ion_cannon_table) do
		if cooldown[1] > 0 then
			global.ion_cannon_table[i][1] = global.ion_cannon_table[i][1] - 1
		end
	end
end

function isAllIonCannonOnCooldown()
    for i, cooldown in ipairs(global.ion_cannon_table) do
		if cooldown[2] == 1 then
			return false
		end
	end
	return true
end

function isIonCannonReady()
    for i, cooldown in ipairs(global.ion_cannon_table) do
		if cooldown[1] == 0 and cooldown[2] == 0 then
			cooldown[2] = 1
			return true
		end
	end
end

function message(mes)
  for i, player in ipairs(game.players) do
    player.print(mes)
  end
end

function anyPlayerCanReach(entity)
	for i, player in ipairs(game.players) do
		if player.can_reach_entity(entity) then
			return true
		end
	end
	return false
end

function playSoundForPlayer(sound, player)
	player.surface.create_entity({name = sound, position = player.position})
end

function playSoundForAllPlayers(sound)
	for i, player in ipairs(game.players) do
		player.surface.create_entity({name = sound, position = player.position})
	end
end

function isHolding(stack, player)
  local holding = player.cursor_stack
  if holding.valid_for_read and (holding.name == stack.name) and (holding.count >= stack.count) then
    return true
  end
  return false
end

script.on_event(defines.events.on_rocket_launched, function(event)
	local force = event.rocket.force
	if event.rocket.get_item_count("orbital-ion-cannon") > 0 then
	  table.insert(global.ion_cannon_table, {ionCannonCooldownSeconds, 0})
		if #global.ion_cannon_table == 1 then
			game.forces.player.recipes["ion-cannon-targeter"].enabled = true
			for i, player in pairs(game.players) do
				init_GUI(player)
			end
			message("Congratulation at sending up your first orbital ion cannon!")
			message("You may now create an ion cannon targeting device that will allow you to fire your ion cannons at the designated spot.")
			message("Each ion cannon has its own cooldown, and takes a bit of time to get set up when first sent into orbit.")
			message("Sending additional ion cannons into orbit will allow you to fire whenever one is available.")
			if playVoices then
				playSoundForAllPlayers("ion-cannon-charging")
			end
		else
			if #global.ion_cannon_table > 1 then
				message("Congratulation at sending up another orbital ion cannon!")
			end
			message("Number of ion cannons in orbit: " .. #global.ion_cannon_table)
			message("Ion cannon #" .. #global.ion_cannon_table  .. " will be ready to fire in " .. ionCannonCooldownSeconds .. " seconds.")
			if playVoices then
				playSoundForAllPlayers("ion-cannon-charging")
			end
			update_GUI()
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
	if global.tick ~= nil and global.tick > event.tick then return end
	global.tick = event.tick + 5
	local player = game.get_player(event.player_index)
	if isHolding({name="ion-cannon-targeter", count=1}, player) then
		local cannonNum = 0
		for i, cooldown in ipairs(global.ion_cannon_table) do
			if cooldown[2] == 1 then
				cannonNum = i
				break
			end
		end
		if cannonNum == 0 then
			message("Unable to fire, no ion cannon(s) ready.")
		else
			message("Targeting ion cannon #" .. cannonNum .. "...")
			local TargetPosition = event.position
			TargetPosition.y = TargetPosition.y + 1
			local IonTarget=player.surface.create_entity({name = "ion-cannon-target", position = TargetPosition, force = game.forces.enemy})
			if anyPlayerCanReach(IonTarget) then
				message("Error: Friendly character in critical proximity to target zone, firing sequence aborted.")
				IonTarget.destroy()
			else
				local CrosshairsPosition = event.position
				CrosshairsPosition.y = CrosshairsPosition.y - 20
				player.surface.create_entity({name = "crosshairs", target = IonTarget, force = game.forces.player, position = CrosshairsPosition, speed = 0.0001})
				message("Target acquired, beginning firing sequence...")
				playSoundForAllPlayers("klaxon")
				global.ion_cannon_table[cannonNum][1] = ionCannonCooldownSeconds
				global.ion_cannon_table[cannonNum][2] = 0
				message("Ion cannon #" .. cannonNum .. " will be ready to fire again in " .. ionCannonCooldownSeconds .. " seconds.")
			end
		end
	end
end)
