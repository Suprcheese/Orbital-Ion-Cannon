data:extend({
	{
		type = "item",
		name = "orbital-ion-cannon",
		icon = "__Orbital Ion Cannon__/graphics/icon64.png",
		icon_size = 64,
		flags = {"goes-to-main-inventory"},
		subgroup = "defensive-structure",
		order = "e[orbital-ion-cannon]",
		stack_size = 1
	},
	{
		type = "item",
		name = "ion-cannon-targeter",
		icon = "__Orbital Ion Cannon__/graphics/crosshairs64.png",
		icon_size = 64,
		flags = {"goes-to-quickbar"},
		place_result = "ion-cannon-targeter",
		subgroup = "capsule",
		order = "c[target]",
		stack_size = 1,
	}
})
