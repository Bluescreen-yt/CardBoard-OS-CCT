local Sandbox = {}
Sandbox.__index = Sandbox

function Sandbox.Create()
    local self = setmetatable({}, Sandbox)

    self.SandboxGlobals = {}
    self.FileSandbox = {}
    self.FileBuffer = {}

    return self
end

function Sandbox:SetSandboxFiles(root)
    self.FileSandbox = __SCAN(root, nil)
end

function __MERGE(FileSandbox, Files)
    for file, content in Files do
        FileSandbox[file] = content
    end

    return FileSandbox
end

function __SCAN(hiddenDir, dir)
    local files = {}
    for _, file in ipairs( fs.list( fs.combine( hiddenDir, dir ) ) ) do
        local path = fs.combine(hiddenDir, dir, file)

        if fs.isDir(path) then
            files = __MERGE(files, __SCAN( hiddenDir, fs.combine(dir, file ) ) )
        
        else
            local File = fs.open(path, 'r')
            files[fs.combine(dir, file)]=File.readAll()
            File.close()
        end
    end

    return files
end

function Sandbox:SetGlobals(SGlobals)
    self.SandboxGlobals = SGlobals
end

function Sandbox:ClearFileBuffer()
    self.FileBuffer = {}
end

function Sandbox:GetFileSandbox(file)
    local FileBuffer = self.FileSandbox[file]
end

function Sandbox:WriteFileBuffer(file, content)
    self.FileBuffer[file] = content
end

function Sandbox:CloseFileBuffer(file)
    self.FileSandbox[file] = self.FileBuffer[file]
    self.FileBuffer[file] = nil
end

function Sandbox:SumChanges()
    local Changes = {
        FilesChanged = {},
        FilesBuffers = {}
    }
    
    for file, content in pairs(self.FileSandbox) do
        table.insert(Changes.FilesChanged, {file=file, content=content})
    end
    
    for file, content in pairs(self.FileBuffer) do
        table.insert(Changes.FilesBuffers, {file=file, content=content})
    end

end

function Sandbox:Run(code)
    local Exec = load(code, nil, 'bt', self.SandboxGlobals)

    return pcall(Exec)
end




return Sandbox