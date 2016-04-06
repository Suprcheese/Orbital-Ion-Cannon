data:extend
(
{
 {
  type = "recipe",
  name = "orbital-ion-cannon",	
  energy_required = 60,
  enabled = false,
  ingredients =
  {
   {"low-density-structure", 100},
   {"solar-panel", 100},
   {"basic-accumulator", 200},
   {"radar", 10},
   {"processing-unit", 200},
   {"electric-engine-unit", 10},
   {"laser-turret", 25},
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
   {"advanced-circuit", 1}
  },
  result= "ion-cannon-targeter"
 }
}
)