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
