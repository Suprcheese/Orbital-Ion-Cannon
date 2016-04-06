data:extend
(
{
 {
  type = "technology",
  name = "orbital-ion-cannon",
  icon = "__Orbital Ion Cannon__/graphics/icon64.png",
  prerequisites = {"rocket-silo"},
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
    {"alien-science-pack", 2},
    {"science-pack-1", 2},
    {"science-pack-2", 2},
    {"science-pack-3", 2}
   },
   time = 60
  },
  order = "k-a"
 }
}
)