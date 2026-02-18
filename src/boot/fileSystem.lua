local FileSystem = {}
FileSystem.Files = {}


-- CONFIGS



function __scan(RootDir)
    local Virtal
    
    local Files = fs.list(RootDir)
    for _, file in ipairs(Files) do
        local FilePath = fs.combine(RootDir, file)
        if fs.isDir(FilePath) then
            __scan(FilePath)
        end
    end



end






return FileSystem