lapp = require 'pl.lapp'
-- Simple Usage 1 ----------------------

-- local args = lapp [[
-- Does some calculations
-- 	-o, --offset (default 0.0)	Offset to add to scaled number
-- 	-s, --scale (number) Scaling factor
-- 	<number> (number) Number to be scaled
-- ]]

-- print(args.offset + args.scale*args.number)

-- Simple Usage 2 --
local args = require('pl.lapp') [[
Various flags and option types
	-p 		A simple optional flag, defaults to false
	-q, --quiet	 A simple flag with long name
	-o   (string) A required option with argument
	<input> (default stdin)		Optional input file parameter
]]

for k,v in pairs(args) do
	print(k, v)
end