local check = require("/services/checker/main")
local cbr = require("/services/openBox/renderModules/CharBased")

local Tests = {}

table.insert(Tests, { cbr.Render, {{
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'}
}}, nil})

-- check.RunTests(Tests)

cbr.Render({
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'},
    {'a','a','a','a'}
})
