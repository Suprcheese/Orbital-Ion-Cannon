data:extend({
	{
		type = "technology",
		name = "orbital-ion-cannon",
		icon = "__Orbital Ion Cannon__/graphics/icon64.png",
		prerequisites = {"rocket-silo", "laser-turret-damage-6"},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "orbital-ion-cannon"
			},
		},
		unit =
		{
			count = 1000,
			ingredients =
			{
			{"science-pack-1", 2},
			{"science-pack-2", 2},
			{"science-pack-3", 2},
			{"alien-science-pack", 2},
			},
			time = 60
		},
		order = "k-a"
	},
	{
		type = "technology",
		name = "auto-targeting",
		icon = "__Orbital Ion Cannon__/graphics/AutoTargetingTech.png",
		prerequisites = {"orbital-ion-cannon"},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "auto-targeter"
			},
		},
		unit =
		{
			count = 1000,
			ingredients =
			{
			{"science-pack-1", 1},
			{"science-pack-2", 1},
			{"science-pack-3", 1},
			{"alien-science-pack", 1},
			},
			time = 60
		},
		order = "k-b"
	},
})

if data.raw["item"]["bob-laser-turret-5"] and enableBobUpdates then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-6", "bob-laser-turrets-5"}
end

if data.raw["item"]["fast-accumulator-3"] and data.raw["item"]["solar-panel-large-3"] and enableBobUpdates then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-6",	"bob-solar-energy-4", "bob-electric-energy-accumulators-4"}
end

if data.raw["item"]["fast-accumulator-3"] and data.raw["item"]["solar-panel-large-3"] and data.raw["item"]["bob-laser-turret-5"] and enableBobUpdates then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-6", "bob-solar-energy-4", "bob-electric-energy-accumulators-4", "bob-laser-turrets-5"}
end