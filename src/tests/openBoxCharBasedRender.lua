local check = require("/services/checker/main")
local cbr = require("/services/openBox/renderModules/CharBased")

local Tests = {}

table.insert(Tests, { cbr.Render, {{
    {'0','0','0','0'},
    {'0','0','0','0'},
    {'0','0','0','0'},
    {'0','0','0','0'},
    {'0','0','0','0'},
    {'0','0','0','0'}
}}, nil})

check.RunTests(Tests)
