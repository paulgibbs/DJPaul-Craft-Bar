GLOBAL.CHEATS_ENABLED = true
GLOBAL.require("debugkeys")
GLOBAL.require("debugtools")


local function sortRecipes()
	local sortedRecipes = {}
	local counter = 1

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

		-- Apply the sorted positions to the actual recipes list.
		for _, recipe in pairs(tabRecipes) do
			GLOBAL.AllRecipes[recipe.slug].sortkey = counter
			counter = counter + 1
		end
	end
end

AddClassPostConstruct("screens/playerhud", function(self)
	print('DJPAUL-DCB-BEFORE')
	sortRecipes()
end)


local function dumpvar(data)
    -- cache of tables already printed, to avoid infinite recursive loops
    local tablecache = {}
    local buffer = ""
    local padder = "    "
 
    local function _dumpvar(d, depth)
        local t = type(d)
        local str = tostring(d)
        if (t == "table") then
            if (tablecache[str]) then
                -- table already dumped before, so we dont
                -- dump it again, just mention it
                buffer = buffer.."<"..str..">\n"
            else
                tablecache[str] = (tablecache[str] or 0) + 1
                buffer = buffer.."("..str..") {\n"
                for k, v in pairs(d) do
                    buffer = buffer..string.rep(padder, depth+1).."["..k.."] => "
                    _dumpvar(v, depth+1)
                end
                buffer = buffer..string.rep(padder, depth).."}\n"
            end
        elseif (t == "number") then
            buffer = buffer.."("..t..") "..str.."\n"
        else
            buffer = buffer.."("..t..") \""..str.."\"\n"
        end
    end
    _dumpvar(data, 0)
    return buffer
end
