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
		dark_background_icon = "__Orbital Ion Cannon__/graphics/crosshairs_darkBG.png",
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

if enableBobUpdates and data.raw["item"]["radar-2"] then
  data:extend({
    {
      type = "item",
      name = "auto-targeter-2",
      icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png",
      flags = {"goes-to-quickbar"},
      place_result = "auto-targeter-2",
      subgroup = "defensive-structure",
      order = "e[orbital-ion-cannon]-a[auto]",
      stack_size = 5
    },
  })
end
if enableBobUpdates and data.raw["item"]["radar-3"] then
  data:extend({
    {
      type = "item",
      name = "auto-targeter-3",
      icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png",
      flags = {"goes-to-quickbar"},
      place_result = "auto-targeter-3",
      subgroup = "defensive-structure",
      order = "e[orbital-ion-cannon]-a[auto]",
      stack_size = 5
    },
  })
end
if enableBobUpdates and data.raw["item"]["radar-4"] then
  data:extend({
    {
      type = "item",
      name = "auto-targeter-4",
      icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png",
      flags = {"goes-to-quickbar"},
      place_result = "auto-targeter-4",
      subgroup = "defensive-structure",
      order = "e[orbital-ion-cannon]-a[auto]",
      stack_size = 5
    },
  })
end
if enableBobUpdates and data.raw["item"]["radar-5"] then
  data:extend({
    {
      type = "item",
      name = "auto-targeter-5",
      icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png",
      flags = {"goes-to-quickbar"},
      place_result = "auto-targeter-5",
      subgroup = "defensive-structure",
      order = "e[orbital-ion-cannon]-a[auto]",
      stack_size = 5
    },
  })
end
