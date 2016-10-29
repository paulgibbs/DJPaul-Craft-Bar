GLOBAL.CHEATS_ENABLED = true
GLOBAL.require("debugkeys")
GLOBAL.require("debugtools")


local function sortRecipes()
	local sortedRecipes = {}

	-- Extract data for each recipe.
	for slug, recipe in pairs(GLOBAL.AllRecipes) do

		-- Not all recipes are craftable(!).
		if recipe.tab ~= nil then
			if sortedRecipes[recipe.tab.str] == nil then
				sortedRecipes[recipe.tab.str] = {}
			end

			table.insert(sortedRecipes[recipe.tab.str], {
				slug  = slug,
				value = recipe.name
			})
		end
	end

	-- For each tab, sort the recipies.
	for _, tabRecipes in pairs(sortedRecipes) do

		-- Sort the temporary table.
		table.sort(tabRecipes, function(a, b)
			return a.value < b.value
		end)

		local counter = 1

		-- Apply the sorted positions to the actual recipes list.
		for _, recipe in pairs(tabRecipes) do
			GLOBAL.AllRecipes[recipe.slug].sortkey = counter
			counter = counter + 1
		end
	end
end

AddClassPostConstruct("screens/playerhud", function(self)
	print('DJPAUL-DCB-BEFORE')
	print(dumpvar(GLOBAL.AllRecipes['pickaxe']))

	sortRecipes()

	print('DJPAUL-DCB-AFTER')
	print(dumpvar(GLOBAL.AllRecipes['pickaxe']))
end)











