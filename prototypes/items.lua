data:extend({
	{
	type = "item",
	name = "orbital-ion-cannon",
	icon = "__Orbital Ion Cannon__/graphics/icon.png",
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
    type = "container",
    name = "ion-cannon-targeter",
    icon = "__Orbital Ion Cannon__/graphics/crosshairs.png",
    flags = {"placeable-neutral", "player-creation","placeable-off-grid"},
    max_health = 1,
    corpse = "small-remnants",
    inventory_size = 1,
    picture =
    {
      filename = "__Orbital Ion Cannon__/graphics/crosshairs64.png",
      width = 64,
      height = 64,
      shift = {0, 0}
    }
  },
})