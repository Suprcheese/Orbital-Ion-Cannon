data:extend({
  {
    type = "projectile",
    name = "crosshairs",
    flags = {"not-on-map"},
    acceleration = 0.001,
	action =
	{
		{
			type = "area",
			perimeter = ionCannonRadius,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
					type = "damage",
					damage = {amount = ionCannonLaserDamage, type = "laser"}
					},
					{
					type = "damage",
					damage = {amount = ionCannonExplosionDamage, type = "explosion"}
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
					entity_name = "huge-explosion"
					},
					{
					type = "create-entity",
					entity_name = "ion-cannon-beam"
					},
					{
					type = "create-entity",
					entity_name = "enormous-scorchmark",
					check_buildability = true
					},
					{
					type = "create-entity",
					entity_name = "ion-cannon-explosion",
					}
				}
			}
		}
	},
    light = {intensity = 0.1, size = 1},
    animation =
	   {
        filename = "__Orbital Ion Cannon__/graphics/null.png",
        priority = "low",
        width = 32,
        height = 32,
        frame_count = 1
	   },
    shadow =
    {
        filename = "__Orbital Ion Cannon__/graphics/null.png",
        priority = "low",
        width = 32,
        height = 32,
        frame_count = 1
    }
  },

	  {
		type = "explosion",
		name = "ion-cannon-ready",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Orbital Ion Cannon__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		  {
			filename = "__Orbital Ion Cannon__/sound/IonCannonReady.ogg",
			volume = 0.75
		  },
		},
	  },
	  {
		type = "explosion",
		name = "ion-cannon-charging",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Orbital Ion Cannon__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		  {
			filename = "__Orbital Ion Cannon__/sound/IonCannonCharging.ogg",
			volume = 0.75
		  },
		},
	  },
	  {
		type = "explosion",
		name = "select-target",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Orbital Ion Cannon__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		  {
			filename = "__Orbital Ion Cannon__/sound/SelectTarget.ogg",
			volume = 0.75
		  },
		},
	  },

	  {
		type = "explosion",
		name = "klaxon",
		flags = {"not-on-map"},
		animations =
		{
			{
				filename = "__Orbital Ion Cannon__/graphics/null.png",
				priority = "low",
				width = 32,
				height = 32,
				frame_count = 1,
				line_length = 1,
				animation_speed = 1
			},
		},
		light = {intensity = 0, size = 0},
		sound =
		{
		  {
			filename = "__Orbital Ion Cannon__/sound/Klaxon.ogg",
			volume = 0.75
		  },
		},
	  },

   {
		type = "simple-entity",
		name = "ion-cannon-target",
		flags = {"placeable-off-grid", "not-on-map"},
		max_health = 1,
		render_layer = "air-object",
		final_render_layer = "air-object",
		resistances = {},
		pictures =
		{
		   {
				filename = "__Orbital Ion Cannon__/graphics/CrosshairsEntity.png",
				priority = "extra-high",
				width = 64,
				height = 64,
				scale = 1,
				shift = {0, -1},
				frame_count = 1
		   },
		}
   },

	{
		type = "smoke-with-trigger",
		name = "ion-cannon-explosion",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
		  filename = "__Orbital Ion Cannon__/graphics/explosion.png",
		  priority = "extra-high",
		  width = 192,
		  height = 192,
		  frame_count = 20,
		  animation_speed = 0.2,
		  line_length = 5,
		  scale = 5 * (ionCannonRadius / 15),
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 60 * 5,
		spread_duration = 10,
	  },

	{
		type = "smoke-with-trigger",
		name = "ion-cannon-beam",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
		  filename = "__Orbital Ion Cannon__/graphics/IonBeam.png",
		  priority = "extra-high",
		  width = 110,
		  height = 1871,
		  frame_count = 1,
		  animation_speed = 0.01,
		  line_length = 1,
		  shift = {-0.1, -27.5},
		  scale = 1,
		},
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = false,
		duration = 60 * 2,
		fade_away_duration = 60 * 1,
		spread_duration = 10,
	  },

	  {
		type = "explosion",
		name = "huge-explosion",
		flags = {"not-on-map"},
		animations =
		{
			{
			filename = "__base__/graphics/entity/medium-explosion/medium-explosion.png",
			priority = "high",
			width = 112,
			height = 94,
			scale = 0.8,
			frame_count = 54,
			line_length = 6,
			shift = {-0.56, -0.96},
			animation_speed = 0.5
			},
		},
		light = {intensity = 1, size = 50},
		sound =
		{
		  {
			filename = "__Orbital Ion Cannon__/sound/OrbitalIonCannon.ogg",
			volume = 2.0
		  },
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
				speed_from_center = 0.15,
				speed_from_center_deviation = 0.15,
				initial_vertical_speed = 0.1,
				initial_vertical_speed_deviation = 0.15,
				offset_deviation = {{-0.2, -0.2}, {0.2, 0.2}}
			  }
			}
		  }
		}
	  },
	  {
		type = "corpse",
		name = "enormous-scorchmark",
		icon = "__base__/graphics/icons/small-scorchmark.png",
		flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
		collision_box = {{-1.5, -1.5}, {1.5, 1.5}},
		collision_mask = {"doodad-layer", "not-colliding-with-itself"},
		selection_box = {{-1, -1}, {1, 1}},
		selectable_in_game = false,
		time_before_removed = 60 * 60 * 10, -- 10 minutes
		final_render_layer = "ground_patch_higher2",
		subgroup = "remnants",
		order="d[remnants]-b[scorchmark]-a[small]",
		animation =
		{
		  sheet=
		  {
			width = 110,
			height = 90,
			frame_count = 1,
			direction_count = 1,
			filename = "__base__/graphics/entity/scorchmark/small-scorchmark.png",
			scale = 5,
			variation_count = 3
		  }
		},
		ground_patch =
		{
		  sheet =
		  {
			width = 110,
			height = 90,
			frame_count = 1,
			direction_count = 1,
			x = 110 * 2,
			filename = "__base__/graphics/entity/scorchmark/small-scorchmark.png",
			scale = 5,
			variation_count = 3
		  }
		},
		ground_patch_higher =
		{
		  sheet =
		  {
			width = 110,
			height = 90,
			frame_count = 1,
			direction_count = 1,
			x = 110,
			filename = "__base__/graphics/entity/scorchmark/small-scorchmark.png",
			scale = 5,
			variation_count = 3
		  }
		}
	  }
	}
)