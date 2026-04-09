local SBL = {}
SBL.info = {}

SBL.info.version = '0.1 test'
SBL.info.vid = 0
SBL.BootFiles = {}
SBL.Bootables = {
}

function ScanRecursive(dir)
    local Files = fs.list(dir)
    local Found = {}
    print('Scaning: '..dir)

    for _, file in pairs(Files) do
        local FullPath = fs.combine(dir, file)
        print(FullPath)

        if fs.isDir(FullPath) then
            for _, obj in pairs(ScanRecursive(FullPath)) do
                
                table.insert(Found, obj)
            end
        else
            if file == 'SysBoot.json' then
                table.insert(Found, {file=file, dir=dir})
            end
        end
    
    end

    return Found
end

for _, obj in pairs(ScanRecursive('/')) do
    
    table.insert(SBL.BootFiles, obj)
end

print()
print('Found: ')


for _, file in pairs(SBL.BootFiles) do
    local path = file.dir..'/'..file.file
    print(path)
    local File = fs.open(path, 'r')

    local BootableData = textutils.unserialiseJSON(File.readAll())
    File.close()
    print(file.file, ' >>> ', BootableData.name)

    table.insert(SBL.Bootables, BootableData)
end


table.insert(SBL.Bootables, {file='CC', name='Craft-os'})

local Cursor = 1
local keyname

while true do
    term.clear()
    term.setCursorPos(1, 2)

    print('Welcome to Sticker Bootloader! version '.. SBL.info.version)
    print('Please select OS / file to boot to')
    print()

    if keyname == 'up' then
        Cursor = Cursor - 1
    elseif keyname == 'down' then
        Cursor = Cursor + 1
    elseif keyname == 'enter' then
        local File = SBL.Bootables[Cursor].file

        term.clear()
        if File == 'CC' then
            break
        else

            local FilePath = SBL.BootFiles[Cursor].dir .. File
            print('Running: ', FilePath)
            local FileFS = fs.open(FilePath, 'r')
            
            local Executable = load(FileFS.readAll())
            Executable()

            os.shutdown()
        end


        break
    end

    Cursor = (Cursor-1)%(#SBL.Bootables) +1

    for _, Option in pairs(SBL.Bootables) do
        local X, Y = term.getSize()
        local Dif = math.floor((Y/1.5)-4)

        if (Cursor<_+Dif) and (Cursor>_-Dif) then

            

            if Cursor==_ then
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.white)
            end
            local MSG = Option.name -- .. ' - ' .. tostring(SBL.BootFiles[Cursor-1])
            term.write(MSG .. string.rep(' ', math.max(0, X-#MSG)))
            print()
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.black)           
        end
    end

    local event, key, is_held = os.pullEvent("key")
    keyname = keys.getName(key)
end
