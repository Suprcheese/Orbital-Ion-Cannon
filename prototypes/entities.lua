crosshairsPicture =	{
		filename = "__Orbital Ion Cannon__/graphics/crosshairsEntity.png",
		priority = "low",
		width = 64,
		height = 64,
		scale = 1,
		shift = {0, -1},
		frame_count = 1
}

local ion_cannon_targeter = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"])

ion_cannon_targeter.name = "ion-cannon-targeter"
ion_cannon_targeter.icon = "__Orbital Ion Cannon__/graphics/crosshairs.png"
ion_cannon_targeter.flags = {"placeable-neutral", "player-creation", "placeable-off-grid"}
ion_cannon_targeter.collision_mask = {}
ion_cannon_targeter.max_health = 0
ion_cannon_targeter.inventory_size = 0
ion_cannon_targeter.collision_box = {{0, 0}, {0, 0}}
ion_cannon_targeter.selection_box = {{0, 0}, {0, 0}}
ion_cannon_targeter.folded_animation =
{
	layers =
	{
		{
			filename = "__Orbital Ion Cannon__/graphics/null.png",
			priority = "medium",
			width = 32,
			height = 32,
			frame_count = 1,
			line_length = 1,
			run_mode = "forward",
			axially_symmetrical = false,
			direction_count = 1,
			shift = {0, 0}
		}
	}
}
ion_cannon_targeter.base_picture =
{
	layers =
	{
		{
			filename = "__Orbital Ion Cannon__/graphics/crosshairs64.png",
			line_length = 1,
			width = 64,
			height = 64,
			frame_count = 1,
			axially_symmetrical = false,
			direction_count = 1,
			shift = {0, 0}
		}
	}
}
ion_cannon_targeter.attack_parameters =
{
	type = "projectile",
	ammo_category = "melee",
	cooldown = 1,
	projectile_center = {0, 0},
	projectile_creation_distance = 1.4,
	range = ionCannonRadius,
	damage_modifier = 1,
	ammo_type =
	{
		type = "projectile",
		category = "melee",
		energy_consumption = "0J",
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					{
						type = "projectile",
						projectile = "dummy-crosshairs",
						starting_speed = 0.28
					}
				}
			}
		}
	}
}

data:extend({ion_cannon_targeter})

data:extend({
	{
		type = "projectile",
		name = "crosshairs",
		flags = {"not-on-map"},
		acceleration = .0009 / (HeatupTimeMultiplier * HeatupTimeMultiplier),
		action =
		{
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-entity",
							entity_name = "dead-tree",
							check_buildability = true
						},
						{
							type = "create-entity",
							entity_name = "dry-tree",
							check_buildability = true
						},
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
							entity_name = "ion-cannon-explosion"
						}
					}
				}
			},
			{
				type = "area",
				perimeter = ionCannonRadius * 0.8,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-fire",
							entity_name = "fire-flame"
						},
						{
							type = "create-fire",
							entity_name = "fire-flame-on-tree"
						}
					}
				}
			},
			{
				type = "area",
				perimeter = ionCannonRadius * 0.8,
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
				type = "area",
				perimeter = ionCannonRadius,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-sticker",
							sticker = "fire-sticker"
						},
						{
							type = "create-fire",
							entity_name = "fire-flame"
						},
						{
							type = "create-fire",
							entity_name = "fire-flame-on-tree"
						}
					}
				}
			}
		},
		light = {intensity = 0, size = 0},
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
		type = "projectile",
		name = "dummy-crosshairs",
		flags = {"not-on-map"},
		acceleration = .0009 / (HeatupTimeMultiplier * HeatupTimeMultiplier),
		action =
		{
			{
				type = "area",
				perimeter = ionCannonRadius * 0.8,
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
				type = "area",
				perimeter = ionCannonRadius,
				action_delivery =
				{
					type = "instant",
					target_effects =
					{
						{
							type = "create-fire",
							entity_name = "fire-flame"
						}
					}
				}
			}
		},
		light = {intensity = 0, size = 0},
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
		type = "train-stop",
		name = "ion-cannon-target",
		icon = "__Orbital Ion Cannon__/graphics/crosshairs.png",
		flags = {"placeable-off-grid", "placeable-neutral", "player-creation", "filter-directions"},
		order = "y",
		selectable_in_game = false,
		minable = {mining_time = 1, result = "train-stop"},
		max_health = 0,
		render_layer = "air-object",
		final_render_layer = "air-object",
		collision_box = {{0,0}, {0,0}},
		selection_box = {{0,0}, {0,0}},
		drawing_box = {{0,0}, {0,0}},
		tile_width = 1,
		tile_height = 1,
		animation_ticks_per_frame = 60,
		animations =
		{
			north = crosshairsPicture,
			east = crosshairsPicture,
			south = crosshairsPicture,
			west = crosshairsPicture,
		},
		vehicle_impact_sound =	{ filename = "__base__/sound/car-metal-impact.ogg", volume = 0 },
		working_sound =
		{
			sound = { filename = "__base__/sound/train-stop.ogg", volume = 0 }
		},
		circuit_wire_connection_points = {},
		circuit_connector_sprites =
		{
			get_circuit_connector_sprites({0.5625-1, 1.03125}, {0.5625-1, 1.03125}, 0), --N
			get_circuit_connector_sprites({-0.78125, 0.28125-1}, {-0.78125, 0.28125-1}, 6), --E
			get_circuit_connector_sprites({-0.28125+1, 0.28125}, {-0.28125+1, 0.28125}, 0), --S
			get_circuit_connector_sprites({0.03125, 0.28125+1}, {0.03125, 0.28125+1}, 6), --W
		},
	},

	{
		type = "smoke-with-trigger",
		name = "ion-cannon-explosion",
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		{
			filename = "__Orbital Ion Cannon__/graphics/explosion.png",
			priority = "low",
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
			priority = "low",
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
		light = {intensity = 2, size = ionCannonRadius * 3},
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
			scale = ionCannonRadius / 4,
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
			scale = ionCannonRadius / 4,
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
			scale = ionCannonRadius / 4,
			variation_count = 3
		}
		}
	}
})

local auto_targeter = util.table.deepcopy(data.raw["radar"]["radar"])

auto_targeter.name = "auto-targeter"
auto_targeter.icon = "__Orbital Ion Cannon__/graphics/AutoTargeter.png"
auto_targeter.minable = {hardness = 0.2, mining_time = 0.5, result = "auto-targeter"}
auto_targeter.pictures =
		{
			filename = "__Orbital Ion Cannon__/graphics/Auto-Target-Entity.png",
			priority = "low",
			width = 153,
			height = 131,
			apply_projection = false,
			direction_count = 64,
			line_length = 8,
			shift = {0.875, -0.34375}
		}
auto_targeter.energy_per_sector = "2MJ"
auto_targeter.max_distance_of_sector_revealed = autoTargetRange
auto_targeter.max_distance_of_nearby_sector_revealed = 1
auto_targeter.energy_usage = "500kW"

data:extend({auto_targeter})

if not ionCannonFlames then
	data.raw["projectile"]["crosshairs"].action =
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
						damage = {amount = ionCannonLaserDamage / 2, type = "laser"}
					},
					{
						type = "damage",
						damage = {amount = ionCannonExplosionDamage / 2, type = "explosion"}
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
						entity_name = "dead-tree",
						check_buildability = true
					},
					{
						type = "create-entity",
						entity_name = "dry-tree",
						check_buildability = true
					},
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
		},
		{
			type = "area",
			perimeter = ionCannonRadius,
			action_delivery =
			{
				type = "instant",
				target_effects =
				{
					{
						type = "create-fire",
						entity_name = "fire-flame-on-tree"
					},
					{
						type = "damage",
						damage = {amount = ionCannonLaserDamage / 2, type = "laser"}
					},
					{
						type = "damage",
						damage = {amount = ionCannonExplosionDamage / 2, type = "explosion"}
					}
				}
			}
		}
	}
end
