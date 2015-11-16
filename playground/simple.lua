-- Simple Usage 2 --
-- local args = require('pl.lapp') [[
-- Various flags and option types
-- 	-p 		A simple optional flag, defaults to false
-- 	-q, --quiet	 A simple flag with long name
-- 	-o   (string) A required option with argument
-- 	<input> (default stdin)		Optional input file parameter
-- ]]

-- for k,v in pairs(args) do
-- 	print(k, v)
-- end

lapp = require ('pl.lapp')

local args = lapp [[
Print the first few lines of specified files
   -n         (default 10)    Number of lines to print
   <files...> (default stdin) Files to print
]]

-- by default, lapp converts file arguments to an actual Lua file object.
-- But the actual filename is always available as <file>_name.
-- In this case, 'files' is a varargs array, so that 'files_name' is
-- also an array.
local nline = args.n
local nfile = #args.files
for i = 1,nfile do
    local file = args.files[i]
    if nfile > 1 then
        print('==> '..args.files_name[i]..' <==')
    end
    local n = 0
    for line in file:lines() do
        print(line)
        n = n + 1
        if n == nline then break end
    end
end