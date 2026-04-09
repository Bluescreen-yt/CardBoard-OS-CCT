local AdvSandbox = {}
local __simpleSandbox = require('boot.objects.simpleSandbox')
local __objUtils = require('boot.objects.objUtil')

AdvSandbox.__index = AdvSandbox

function AdvSandbox.new()
    local self = setmetatable({}, AdvSandbox)
    self.SS = __simpleSandbox.Create()

    return self
end

function AdvSandbox:EmulateCraftOsGlobals()
    local FakeGlobals = {}
    
    -- FS
    FakeGlobals.fs = {}
    FakeGlobals.fs.complete = nil
    FakeGlobals.fs.find = nil
    FakeGlobals.fs.isDriveRoot = nil
    FakeGlobals.fs.list = nil
    FakeGlobals.fs.combine = nil
    FakeGlobals.fs.complete = nil
    FakeGlobals.fs.getName = nil
    FakeGlobals.fs.getDir = nil
    FakeGlobals.fs.exists = nil
    FakeGlobals.fs.isDir = nil
    FakeGlobals.fs.isReadOnly = nil
    FakeGlobals.fs.makeDir = nil
    FakeGlobals.fs.move = nil
    FakeGlobals.fs.copy = nil
    FakeGlobals.fs.delete = nil
    FakeGlobals.fs.open = nil
    FakeGlobals.fs.getDrive = nil
    FakeGlobals.fs.getFreeSpace = nil
    FakeGlobals.fs.getCapacity = nil
    FakeGlobals.fs.attributes = nil

    -- FS.open file
    function WrapSandboxedFile(filePath, content, mode)
        local WrapedFile = {}

        WrapedFile.readAll = nil
        WrapedFile.readLine = nil
        WrapedFile.close = nil
        WrapedFile.write = nil


        return WrapedFile
    end


    FakeGlobals._G = FakeGlobals
    
    self.SS:SetGlobals(FakeGlobals)
end








return AdvSandbox