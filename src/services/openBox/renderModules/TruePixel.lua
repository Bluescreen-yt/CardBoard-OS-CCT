-- Craft-os exlusive

local TruePixel = {}

function TruePixel.Init()
    term.setGraphicsMode(true)
    term.clear()
end

function TruePixel.End()
    term.setGraphicsMode(false)
end

TruePixel.Colors = {
    ['0']=colors.white,
    ['1']=colors.orange,
    ['2']=colors.magenta,
    ['3']=colors.lightBlue,
    ['4']=colors.yellow,
    ['5']=colors.lime,
    ['6']=colors.pink,
    ['7']=colors.gray,
    ['8']=colors.lightGray,
    ['9']=colors.cyan,
    ['a']=colors.purple,
    ['b']=colors.blue,
    ['c']=colors.brown,
    ['d']=colors.green,
    ['e']=colors.red,
    ['f']=colors.black,
}

function TruePixel.ErrTexture(x, y)
    local sum = (x+y*2)%4
    if sum>-1 and sum<2 then
        return colors.blue
    end
    
    return colors.lightBlue
end

function TruePixel.Render(PixelBufer)
    for y=1, #PixelBufer do
        for x=1, #PixelBufer[y] do
            local color = TruePixel.Colors[PixelBufer[y][x]] or TruePixel.ErrTexture(x, y)
            term.setPixel(x-1, y-1, color)
        end
    end
end


return TruePixel
