if data.raw["tool"]["science-pack-4"] and enableBobUpdates then
	data.raw["technology"]["orbital-ion-cannon"].unit.ingredients[5] = {"science-pack-4", 2}
	data.raw["technology"]["auto-targeting"].unit.ingredients[5] = {"science-pack-4", 1}
  if data.raw["technology"]["auto-targeting-2"] then
    data.raw["technology"]["auto-targeting-2"].unit.ingredients[5] = {"science-pack-4", 1}
  end
  if data.raw["technology"]["auto-targeting-3"] then
    data.raw["technology"]["auto-targeting-3"].unit.ingredients[5] = {"science-pack-4", 1}
  end
  if data.raw["technology"]["auto-targeting-4"] then
    data.raw["technology"]["auto-targeting-4"].unit.ingredients[5] = {"science-pack-4", 1}
  end
  if data.raw["technology"]["auto-targeting-5"] then
    data.raw["technology"]["auto-targeting-5"].unit.ingredients[5] = {"science-pack-4", 1}
  end
end

if not data.raw["assembling-machine"]["assembling-machine-4"] then
	data.raw["assembling-machine"]["assembling-machine-3"].ingredient_count = 8
else
	data.raw["assembling-machine"]["assembling-machine-4"].ingredient_count = 8
end
