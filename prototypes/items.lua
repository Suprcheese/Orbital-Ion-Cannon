data:extend({
	{
		type = "item",
		name = "orbital-ion-cannon",
		icon = "__Orbital Ion Cannon__/graphics/Icon.png",
		flags = {"goes-to-main-inventory"},
		subgroup = "defensive-structure",
		order = "e[orbital-ion-cannon]",
		stack_size = 1
	},
	{
		type = "item",
		name = "ion-cannon-targeter",
		icon = "__Orbital Ion Cannon__/graphics/crosshairs.png",
		flags = {"goes-to-quickbar"},
		place_result = "ion-cannon-targeter",
		subgroup = "capsule",
		order = "c[target]",
		stack_size = 1,
	},
	{
		type = "item",
		name = "auto-targeter",
		icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png",
		flags = {"goes-to-quickbar"},
		place_result = "auto-targeter",
		subgroup = "defensive-structure",
		order = "e[orbital-ion-cannon]-a[auto]",
		stack_size = 5
	},
})