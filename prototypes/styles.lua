data.raw["gui-style"].default["ion-cannon-button-style"] =
{
	type = "button_style",
	parent = "button",
	width = 32,
	height = 32,
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	font = "default-button",
	default_graphical_set =
	{
		type = "monolith",
		monolith_image =
		{
			filename = "__Orbital Ion Cannon__/graphics/Button.png",
			priority = "extra-high-no-scale",
			width = 64,
			height = 64,
			x = 0,
			y = 0,
		}
	},
	hovered_graphical_set =
	{
		type = "monolith",
		monolith_image =
		{
			filename = "__Orbital Ion Cannon__/graphics/Button.png",
			priority = "extra-high-no-scale",
			width = 64,
			height = 64,
			x = 64,
			y = 0,
		}
	},
	clicked_graphical_set =
	{
		type = "monolith",
		monolith_image =
		{
			filename = "__Orbital Ion Cannon__/graphics/Button.png",
			width = 64,
			height = 64,
			x = 0,
			y = 0,
		}
	},
	left_click_sound =
	{
		filename = "__core__/sound/gui-click.ogg",
		volume = 1
	}
}