-- every special character has 3x2 pixels

-- 12
-- 34
-- 56

-- ["123456"]=char id (/CharList.png)

local CharBasedRender = {}

CharBasedRender.CharList = {
    ["000000"]=128,
    ["100000"]=129,
    ["010000"]=130,
    ["110000"]=131,
    ["001000"]=132,
    ["101000"]=134,
    ["111000"]=135,

    ["000100"]=136,
    ["100100"]=137,
    ["010100"]=138,
    ["110100"]=139,
    ["001100"]=140,
    ["101100"]=141,
    ["011100"]=142,

    ["111100"]=143,
    ["000010"]=144,
    ["100010"]=145,
    ["010010"]=146,
    ["110010"]=147,
    ["001010"]=148,
    ["101010"]=149,
    ["011010"]=150,

    ["111010"]=151,
    ["000110"]=152,
    ["100110"]=153,
    ["010110"]=154,
    ["110110"]=155,
    ["001110"]=156,
    ["101110"]=157,

    ["011110"]=158,
    ["111110"]=159
}
function CharBasedRender.find(table, value)
    for i, v in ipairs(table) do
        if v == value then
            return i
        end
    end
    return nil
end

function CharBasedRender.GetPixelColor(PixelBufer, x, y)
    local Y = PixelBufer[y]
    if Y then
        return Y[x]
    end
    return nil
end

function CharBasedRender.FlipBinary(initial)
    local fliped = ''

    for charIDX =1, #initial do
        fliped = fliped .. tostring(1-tonumber(initial:sub(charIDX, charIDX)))
    end

    return fliped
end

function CharBasedRender.FindChar(CharCombination) -- 123456 yk (line 7)
    if not CharCombination then return nil end
    local char = CharBasedRender.CharList[CharCombination]
    local IsFliped = false
    if not char then
        
        IsFliped = true

        local flipedChar = CharBasedRender.FlipBinary(CharCombination)

        char = CharBasedRender.CharList[flipedChar]
    end
    if not char then
        char = "ERROR"
    end

    return {char, IsFliped}
end

CharBasedRender.colors = {
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
}

function CharBasedRender.FindNearestColorIDX(colorFrom, colorsList)
    local ColorOneIDX = CharBasedRender.find(CharBasedRender.colors, colorsList[1])
    local ColorTwoIDX = CharBasedRender.find(CharBasedRender.colors, colorsList[2])
    local ColorFromIDX = CharBasedRender.find(CharBasedRender.colors, colorFrom)

    local ColorTwoIDXDistance = math.abs(ColorTwoIDX-ColorFromIDX)
    local ColorOneIDXDistance = math.abs(ColorOneIDX-ColorFromIDX)

    if math.min(ColorTwoIDXDistance, ColorOneIDXDistance) == ColorOneIDXDistance then
        return 1
    else
        return 2
    end
    
end

function CharBasedRender.Render(PixelBufer)
    for y=1, #PixelBufer, 3 do
        for x=1, #PixelBufer[y], 2 do

            -- for every char 2x3 in pixels

            local colors = {} -- color1:1   color2:2
            local colorsReverse = {}
            local CharPixels = {}
            local MonochromePixelPatern = {} -- 6 digits binnary used to find character

            for y_height_char=1, 6 do  -- every pixel in character space 2x3 CharPixels
                for x_width_char=1, 2 do
                    table.insert(CharPixels, CharBasedRender.GetPixelColor(PixelBufer, x_width_char+x, y_height_char+y))
                end
            end

            local LastColor = '0' -- last checked color id
            for pxl in pairs(CharPixels) do
                local FinalChar = 1
                
                if colors[pxl] then -- if pixel is already in colors
                    FinalChar = colors[pxl] -- set FinalChar to id of color

                elseif #colors<2 then -- if not in colors and there is empty space (max 2) then add current color
                    colorsReverse[#colors+1] = pxl
                    colors[pxl] = #colors+1 -- set color in colors to id
                    FinalChar = colors[pxl] -- get id

                else
                    FinalChar = CharBasedRender.FindNearestColorIDX(pxl, colorsReverse) -- nearest color id
                end

                table.insert(MonochromePixelPatern, FinalChar) -- add final char to paterns
            end

            term.write(CharBasedRender.FindChar(table.concat(MonochromePixelPatern, '')))

        end
    end

end

return CharBasedRender