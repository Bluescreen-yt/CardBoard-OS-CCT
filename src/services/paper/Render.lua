-- every special character has 3x2 pixels

-- 12
-- 34
-- 56

-- ["123456"]=char id (/CharList.png)

local Render = {}

Render.CharList = {
    ["010000"]=130,
}

function Render.FindChar(CharCombination) -- 123456 yk (line 7)
    local char = Render.CharList[CharCombination]
    if not char then
        local fliped = ''
        for i=1, #CharCombination do
            fliped = fliped .. tostring(1-tonumber(CharCombination[1]))
        end

        char = Render.CharList[fliped]
    end
    if not char then
        char = 88
    end

    return string.char(char)
end

function Render.GetPixelColor(PixelBufer, x, y)
    local Y = PixelBufer[y]
    if Y then
        return Y[x]
    end
    return nil
end

function Render.BlitRaw(PixelBufer)
    for y=1, #PixelBufer, 3 do
        for x=1, #PixelBufer[y], 2 do
            local colors = {}
            local CharPixels = {}
            local MonochromePixelPatern = {}

            for y_height_char=1, 6 do
                for x_width_char=1, 2 do
                    table.insert(CharPixels, Render.GetPixelColor(PixelBufer, x_width_char, y_height_char))
                end
            end

            local LastColor = '0'
            for pxl in pairs(CharPixels) do
                local FinalChar = 1
                
                if colors[pxl] then
                    FinalChar = colors[pxl]
                elseif #colors<2 then
                    colors[pxl] = #colors
                    FinalChar = colors[pxl]
                else
                    colors[pxl]
                end

                table.insert(MonochromePixelPatern, FinalChar)
            end

            colors['1'] = Render.GetPixelColor(PixelBufer, x, y)
        end
    end
end
