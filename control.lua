require "util"
require "defines"

script.on_init(function() On_Load() end)
script.on_load(function() On_Load() end)

function message(mes)
  for i, player in ipairs(game.players) do
    player.print(mes)
  end
end

function On_Load()
    if not global.ion_cannons_sent then
	  global.ion_cannons_sent = 0
	end
end

script.on_event(defines.events.on_rocket_launched, function(event)
  local force = event.rocket.force
    if event.rocket.get_item_count("orbital-ion-cannon") > 0 then
	  global.ion_cannons_sent = global.ion_cannons_sent + 1
	  if global.ion_cannons_sent = 1
	    recipelist["ion-cannon-targeter"].enable()
		message("Congratulation at sending up your first orbital ion cannon!")
		message("You may now create ion cannon targeters that will allow you to fire the ion cannon at the designated spot.")
		message("Sending additional ion cannons into orbit will reduce the cooldown on the targeting devices.")
	  else
  	  message("Congratulation at sending up another orbital ion cannon!")
	  end
	  data.raw["capsule"]["ion-cannon-targeter"].capsule_action[1].attack_parameters[1].cooldown = 90/global.ion_cannons_sent
	  message("Number of ion cannons in orbit: "..global.ion_cannons_sent)
	  message("Current ion cannon cooldown: ".. 90/global.ion_cannons_sent)
	end
end)

