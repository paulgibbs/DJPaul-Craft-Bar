GLOBAL.CHEATS_ENABLED = true
GLOBAL.require("debugkeys")
GLOBAL.require("debugtools")



AddClassPostConstruct("screens/playerhud", function(self)
	print("helllo world")
	for k, v in pairs(GLOBAL.AllRecipes) do
		if (v.name == 'pickaxe') then
			v.sortkey = 1
		end
	end

	print('DJPAUL')
end)
