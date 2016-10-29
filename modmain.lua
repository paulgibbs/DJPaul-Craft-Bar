GLOBAL.CHEATS_ENABLED = true
GLOBAL.require("debugkeys")
GLOBAL.require("debugtools")


local function sortRecipesAlphabetically(rawRecipes)
	-- For each recipe tab...
	for tabName, tabRecipes in pairs(rawRecipes) do

		-- Sort the recipes.
		table.sort(tabRecipes, function(a, b)
			return a.value < b.value
		end)

		print('>> START')
		print(dumpvar(tabRecipes))
		print('>> END')
	end
end

local function sortRecipes()
	local sortedRecipes = {}

	-- Extract data for each recipe.
	for slug, recipe in pairs(GLOBAL.AllRecipes) do

		-- Not all recipes are craftable(!).
		if recipe.tab ~= nil then
			if sortedRecipes[recipe.tab.str] == nil then
				sortedRecipes[recipe.tab.str] = {}
			end

			local recipeData = {
				slug  = slug,
				value = recipe.name
			}

			table.insert(sortedRecipes[recipe.tab.str], recipeData)
		end
	end

	-- For each recipe tab...
	for tabName, tabRecipes in pairs(sortedRecipes) do

		-- Sort it!
		table.sort(tabRecipes, function(a, b)
			return a.value < b.value
		end)
	end

	-- Get sort offsets and apply back to AllRecipes.
end

AddClassPostConstruct("screens/playerhud", function(self)
	print('DJPAUL-DCB-INIT')
	sortRecipes()
end)











