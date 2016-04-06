data:extend
(
 {
  {
    type = "projectile",
    name = "crosshairs",
    flags = {"not-on-map"},
    acceleration = 0.005,
	action =
	{
		{
			type = "area",
			perimeter = 30,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "damage",
					damage = {amount = 1000, type = "laser"}
					},
					{
					type = "damage",
					damage = {amount = 500, type = "explosion"}
					}
				}
			}
		},
		{
			type = "direct",
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "create-entity",
					entity_name = "sb-t4-explosion"
					},
					{
					type = "create-entity",
					entity_name = "small-scorchmark",
					check_buildability = true
					},
					{
					type = "create-entity",
					entity_name = "sb-arty-explosion",
					}
				}
			}
		}
	},
    light = {intensity = 0.5, size = 6},
    animation =
    {
        filename = "__SupremeWarfare__/graphics/projectiles/he-shell-mk4.png",
        priority = "extra-high",
        width = 12,
        height = 30,
        frame_count = 1
    },
    shadow =
    {
        filename = "__SupremeWarfare__/graphics/projectiles/he-shell-mk4-shadow.png",
        priority = "extra-high",
        width = 12,
        height = 30,
        frame_count = 1
    }
  },

	  -- Explosion Smoke
	{
		type = "smoke-with-trigger",
		name = "sb-arty-explosion",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
		  filename = "__SupremeWarfare__/graphics/explosion.png",
		  priority = "high",
		  width = 192,
		  height = 192,
		  frame_count = 20,
		  animation_speed = 8,
		  line_length = 5,
		  scale = 12,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 60 * 3,

		spread_duration = 10,


	  },
	  -- BIG ARTY Explosion
	  {
		type = "explosion",
		name = "sb-t4-explosion",
		flags = {"not-on-map"},
		animations =
		{
		  {
			filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
			priority = "extra-high",
			width = 112,
			height = 94,
			scale = 0.8,
			frame_count = 54,
			line_length = 6,
			shift = {-0.56, -0.96},
			animation_speed = 0.5
		  }
		},
		light = {intensity = 1, size = 50},
		sound =
		{
		  {
			filename = "__base__/sound/fight/large-explosion-1.ogg",
			volume = 2.0
		  },
		  {
			filename = "__base__/sound/fight/large-explosion-2.ogg",
			volume = 2.0
		  }
		},
		created_effect =
		{
		  type = "direct",
		  action_delivery =
		  {
			type = "instant",
			target_effects =
			{
			  {
				type = "create-particle",
				repeat_count = 60,
				entity_name = "explosion-remnants-particle",
				initial_height = 0.5,
				speed_from_center = 0.08,
				speed_from_center_deviation = 0.15,
				initial_vertical_speed = 0.08,
				initial_vertical_speed_deviation = 0.15,
				offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
			  }
			}
		  }
		}
	  },
	}
)