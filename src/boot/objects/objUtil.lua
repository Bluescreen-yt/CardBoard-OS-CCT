local objutil = {}

function objutil.cloneObj(objutil)
    local Cloned = {}
    for key, value in pairs(objutil) do
        if type(value)=='table' then
            Cloned[key] = objutil.cloneObj(value)
        else
            Cloned[key] = value
        end
    end
end


return objutil