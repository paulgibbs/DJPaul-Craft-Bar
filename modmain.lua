GLOBAL.CHEATS_ENABLED = true
GLOBAL.require("debugkeys")
GLOBAL.require("debugtools")



AddClassPostConstruct("screens/playerhud", function(self)
	print("helllo world")
end)
