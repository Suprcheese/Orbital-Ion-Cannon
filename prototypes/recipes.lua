data:extend({
	{
		type = "recipe",
		name = "orbital-ion-cannon",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"low-density-structure", 100},
			{"solar-panel", 100},
			{"accumulator", 200},
			{"radar", 10},
			{"processing-unit", 200},
			{"electric-engine-unit", 25},
			{"laser-turret", 50},
			{"rocket-fuel", 50}
		},
		result = "orbital-ion-cannon"
	},
	{
		type = "recipe",
		name = "ion-cannon-targeter",
		energy_required = 0.5,
		enabled = false,
		category = "crafting",
		ingredients =
		{
			{"processing-unit", 1},
			{"plastic-bar", 2},
			{"battery", 1}
		},
		result= "ion-cannon-targeter"
	},
	{
		type = "recipe",
		name = "auto-targeter",
		energy_required = 5,
		enabled = false,
		category = "crafting",
		ingredients =
		{
			{"radar", 1},
			{"processing-unit", 20},
			{"ion-cannon-targeter", 1}
		},
		result= "auto-targeter"
	},
})

if data.raw["item"]["advanced-processing-unit"] and enableBobUpdates then
	data.raw["recipe"]["orbital-ion-cannon"].ingredients[5] = {"advanced-processing-unit", 200}
	data.raw["recipe"]["auto-targeter"].ingredients[2] = {"advanced-processing-unit", 20}
end

if data.raw["item"]["bob-laser-turret-5"] and enableBobUpdates then
	data.raw["recipe"]["orbital-ion-cannon"].ingredients[7] = {"bob-laser-turret-5", 50}
end

if data.raw["item"]["fast-accumulator-3"] and data.raw["item"]["solar-panel-large-3"] and enableBobUpdates then
	data.raw["recipe"]["orbital-ion-cannon"].ingredients[2] = {"solar-panel-large-3", 100}
	data.raw["recipe"]["orbital-ion-cannon"].ingredients[3] = {"fast-accumulator-3", 200}
end

-- If we have radar-2, assume we have bobs?
if data.raw["item"]["radar-2"] and enableBobUpdates then
  data:extend({
    {
      type = "recipe",
      name = "auto-targeter-2",
      energy_required = 5,
      enabled = false,
      category = "crafting",
      ingredients =
      {
        {"radar-2", 1},
        {"electronic-circuit", 20},
        {"auto-targeter", 1}
      },
      result= "auto-targeter-2"
    },
  })
end
if data.raw["item"]["radar-3"] and enableBobUpdates then
  data:extend({
    {
      type = "recipe",
      name = "auto-targeter-3",
      energy_required = 5,
      enabled = false,
      category = "crafting",
      ingredients =
      {
        {"radar-3", 1},
        {"advanced-circuit", 20},
        {"auto-targeter-2", 1}
      },
      result= "auto-targeter-3"
    },
  })
end
if data.raw["item"]["radar-4"] and enableBobUpdates then
  data:extend({
    {
      type = "recipe",
      name = "auto-targeter-4",
      energy_required = 5,
      enabled = false,
      category = "crafting",
      ingredients =
      {
        {"radar-4", 1},
        {"processing-unit", 20},
        {"auto-targeter-3", 1}
      },
      result= "auto-targeter-4"
    },
  })
end
if data.raw["item"]["radar-5"] and enableBobUpdates then
  data:extend({
    {
      type = "recipe",
      name = "auto-targeter-5",
      energy_required = 5,
      enabled = false,
      category = "crafting",
      ingredients =
      {
        {"radar-5", 1},
        {"advanced-processing-unit", 50},
        {"auto-targeter-4", 1}
      },
      result= "auto-targeter-5"
    },
  })
end
