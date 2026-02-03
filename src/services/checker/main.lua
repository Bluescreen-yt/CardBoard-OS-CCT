local checker = {}

function checker.RunTest(func, arg, expectedResult)
    local RESU
    success, errorMessage = pcall(function() RESU = func(table.unpack(arg)) end)

    if success then
        if RESU==expectedResult then
            return true
        else
            return false, false, RESU
        end
    else 
        return false, errorMessage
    end
end

function checker.RunTests(info)
    local i = 0
    local results = {}

    for _, infoC in pairs(info) do
        i = i +1

        print('Running test '..tostring(i))


        succes, err, other = checker.RunTest(infoC[1], infoC[2], infoC[3] )

        results[i] = { {infoC[1], infoC[2], infoC[3]}, succes, err, other }

        if succes then
            print('succes!')
        else
            if err then
                print('ERROR: '..err)
            else
                print('fail. got < '..tostring(other)..' > instead')
            end
        
            print()
        end
    end
end

function checker.DisplayResults(Results, dent)
    if not dent then dent='' end

    for result, value in pairs(Results) do

        if type(value)=="table" then
            if results then
            print(dent..results..': {')
            else
            print(dent.."{")
            end

            checker.DisplayResults(value, dent..' ')
            print(dent..'},')
        else
            print(dent..result..':'..tostring(value)..',')
        end
    end

end

return checker