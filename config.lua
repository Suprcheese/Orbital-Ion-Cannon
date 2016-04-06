-- The Cooldown time for each orbital ion cannon, in seconds.
ionCannonCooldownSeconds = 180

-- Play the EVA voices from Command and Conquer - recommended for the GDI enthusiast.
playVoices = true

-- Play a klaxon sound for all players whenever a target for an ion cannon is designated.
playKlaxon = true

-- Radius of the ion cannon's blast.
ionCannonRadius = 20

-- If true, this mod will update its recipes and technologies to include new, high-tier items from Bob's Warfare and/or Power mods.
-- Note that this makes the ion cannon much more expensive to construct.
enableBobUpdates = true

-- These allow you to configure how much damage (of each type) is dealt in one ion cannon blast.
ionCannonLaserDamage = 2000
ionCannonExplosionDamage = 500

-- This multiplier affects how long it takes for an ion cannon to fire after a target has been designated.
-- The default value of 1 results in approximately 3.5 seconds between target designation and ion cannon blast.
-- This is a linear multiplier, so a value of 10 would result in about 35 seconds between targeting and blast.
-- It is not recommended to set this value too high (it was only tested out to a value of 10), or below 1.
HeatupTimeMultiplier = 1

-- When designating an ion cannon target, perform a check to see if any friendly character is too close to the target zone.
-- It is recommended to disable this check if you are using the "Long Reach" mod, since a side effect of that mod causes the radius of this check to excessively increase.
proximityCheck = true

-- The number of gameticks that must pass between designating consecutive ion cannon targets. There are 60 ticks per second, so the default 10 ticks would be 1/6th of a second.
-- For example, setting this value to 120 would mean that there is always a minimum of two seconds between ion cannon blasts; any attempt to target the ion cannon in the two seconds following a prior targeting would fail.
lockoutTicks = 10
