require("config")
require("prototypes.items")
require("prototypes.entities")
require("prototypes.recipes")
require("prototypes.technologies")

if not data.raw["assembling-machine"]["assembling-machine-4"] then
	data.raw["assembling-machine"]["assembling-machine-3"].ingredient_count = 8
end
