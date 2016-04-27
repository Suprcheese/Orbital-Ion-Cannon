Orbital Ion Cannon 1.1.0
========================

Version 1.1.0 was released April 26, 2016, was tested using Factorio v0.12.31, and was authored by Supercheese.

Do you have a large, late-game megabase and wish there were more cool things you could build? Do you wish you could do more with the rockets you launch than just increment a single number? Do you really hate biters? If so, then this mod is for you!
Build a giant ion cannon and launch it into orbit with a rocket, wait for it to charge up, and then you're ready to call down the thunder on those pesky aliens.
Simply click anywhere with your targeting device and watch the total annihilation ensue.
(If you've played the Command & Conquer series of games, you're bound to recognize many features similar to the GDI's Ion Cannons.)

You can click on the button added at the top of your screen to check on the status of your ion cannons in orbit.

This mod is aware of Bob's mods and will update its recipes and technology requirements if Bob's Electronics, Tech, Warfare, and/or Power mods are installed.

This mod also has configuration options available in config.lua. Here you may adjust parameters such as:

-The cooldown time for the ion cannons, their damage amounts and blast radii
-Select which announcer voice you want (Original C&C, Tiberian Sun EVA, or Tiberian Sun CABAL)
-Toggle the "Ion cannon ready" etc. voices and klaxon sounds on/off
-The time it takes between designating a target and the ion cannon firing
-Force off the friendly character proximity check or the recipe updates for Bob's mods
-The minimum time between targeting multiple ion cannons


Modding Details:
----------------
This mod implements a custom event, on_ion_cannon_fired, which can function just like other lua events (https://wiki.factorio.com/index.php?title=Lua/Events).
In order to use this event in another mod, you should use the following code:

script.on_event(remote.call("orbital_ion_cannon", "on_ion_cannon_fired"), function(event)
	...
end)

Where the ... can be any code of your choosing. The following variables are available when using this custom event:

	event.force				The force whose ion cannon is firing
	event.player_index		The player index of who fired the ion cannon
	event.position			The position the ion cannon is firing at


Credits:
--------

The klaxon sound was obtained from: https://freesound.org/people/jobro/sounds/244113/
It was uploaded by the user "jobro" under the CC-0 (Creative Commons 0) license. (See: http://creativecommons.org/publicdomain/zero/1.0/)

The explosion graphic was obtained from the Supreme Warfare mod, authored by SpeedyBrain (graphics by YuokiTani).

The "Ion Cannon Charging"/"Ion Cannon Deployed", "Ion Cannon Ready", and "Select Target" voices are from the "Command & Conquer" series of games by Westwood Studios, as are the Ion Cannon icons.
Command and Conquer: Tiberian Dawn was released as freeware in 2007.
Command and Conquer: Red Alert was released as freeware in 2008.
Command and Conquer: Tiberian Sun was released as freeware in 2010.

The ion beam that the ion cannon fires was obtained from: http://opengameart.org/content/top-down-sci-fi-shooter-pack
It was uploaded by the user Tatermand under the CC-BY-SA license.

Several portions of the control.lua code (et al.) were inspired by code from the following mods:

	-Supreme Warfare by SpeedyBrain
	-YARM by Narc
	-EvoGUI by Narc
	-Blueprint String by DaveMcW
	-Test Mode by rk84
	-Useful Space Industry and Solar Satellites by jorgenRe and CookieGamerTV, respectively.

My thanks to these talented modders for their great mods.

Thanks to the forum and #factorio IRC denizens for advice & bugtesting.


See also the associated forum thread to give feedback, view screenshots, etc.:

http://www.factorioforums.com/forum/viewtopic.php?f=93&t=17910
