Display = Classe:extend()

function Display:new()
    score = 0
    diamonds = 0
    hp = 100
end

function Display:update(dt)

end

function Display:draw()
    love.graphics.setFont(font)
    text = "HP: "..tostring(hp).."                    Diamonds: "..diamonds
    local x = love.graphics.getWidth()
    local fx = font.getWidth(font, text)/2
    love.graphics.print(text, x/2 - fx, 10, 0, 1,1,0)
end