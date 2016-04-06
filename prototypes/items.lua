data:extend
(
{
	{
	type = "item",
	name = "orbital-ion-cannon",
	icon = "__Orbital Ion Cannon__/graphics/icon.png",
	flags = {"goes-to-main-inventory"},
	subgroup = "intermediate-product",
	order = "e[orbital-ion-cannon]",
	stack_size = 1
	},
	{
	type = "capsule",
	name = "ion-cannon-targeter",
	icon = "__Orbital Ion Cannon__/graphics/crosshairs.png",
	flags = {"goes-to-quickbar"},
    capsule_action =
    {
      type = "throw",
      attack_parameters =
      {
        type = "projectile",
        ammo_category = "capsule",
        cooldown = 90,
        projectile_creation_distance = 0.6,
        range = 100,
        ammo_type =
        {
          category = "capsule",
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "projectile",
              projectile = "crosshairs",
              starting_speed = 0.6
            }
          }
        }
      }
    },
	subgroup = "capsule",
	order = "b[target]",
	stack_size = 100
	},
}
)