data:extend({
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
			filename = "__Orbital Ion Cannon__/sound/" .. voiceStyle .. "/IonCannonReady.ogg",
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
			filename = "__Orbital Ion Cannon__/sound/" .. voiceStyle .. "/IonCannonCharging.ogg",
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
			filename = "__Orbital Ion Cannon__/sound/" .. voiceStyle .. "/SelectTarget.ogg",
			volume = 0.75
		},
		},
	},
})