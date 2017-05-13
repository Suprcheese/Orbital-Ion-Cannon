data:extend({
	{
		type = "technology",
		name = "orbital-ion-cannon",
		icon = "__Orbital Ion Cannon__/graphics/icon64.png",
		icon_size = 64,
		prerequisites = {"rocket-silo", "laser-turret-damage-7"},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "orbital-ion-cannon"
			},
			{
				type = "unlock-recipe",
				recipe = "ion-cannon-targeter"
			}
		},
		unit =
		{
			count = 2500,
			ingredients =
			{
			{"science-pack-1", 2},
			{"science-pack-2", 2},
			{"science-pack-3", 2},
			{"military-science-pack", 2},
			{"high-tech-science-pack", 2},
			{"production-science-pack", 2},
			{"space-science-pack", 1}
			},
			time = 60
		},
		order = "k-a"
	},
	{
		type = "technology",
		name = "auto-targeting",
		icon = "__Orbital Ion Cannon__/graphics/AutoTargetingTech.png",
		icon_size = 64,
		prerequisites = {"orbital-ion-cannon"},
		effects = {},
		unit =
		{
			count = 2000,
			ingredients =
			{
			{"science-pack-1", 2},
			{"science-pack-2", 2},
			{"science-pack-3", 2},
			{"military-science-pack", 2},
			{"high-tech-science-pack", 2},
			{"production-science-pack", 2},
			{"space-science-pack", 2}
			},
			time = 60
		},
		order = "k-b"
	},
})

if data.raw["item"]["bob-laser-turret-5"] and settings.startup["ion-cannon-bob-updates"].value then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-7", "bob-laser-turrets-5"}
end

if data.raw["item"]["fast-accumulator-3"] and data.raw["item"]["solar-panel-large-3"] and settings.startup["ion-cannon-bob-updates"].value then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-7",	"bob-solar-energy-4", "bob-electric-energy-accumulators-4"}
end

if data.raw["item"]["fast-accumulator-3"] and data.raw["item"]["solar-panel-large-3"] and data.raw["item"]["bob-laser-turret-5"] and settings.startup["ion-cannon-bob-updates"].value then
	data.raw["technology"]["orbital-ion-cannon"].prerequisites = {"rocket-silo", "laser-turret-damage-7", "bob-solar-energy-4", "bob-electric-energy-accumulators-4", "bob-laser-turrets-5"}
end
