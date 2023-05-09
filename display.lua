Display = Classe:extend()

function Display:new()
    score = 0
    diamonds = 0
    hp = 100
end

function Display:update(dt)
    if hp < 1 then
        hp = 0
        state = 3
    end
end

function Display:draw()

    -- Inicio do jogo
    if state == 0 then
        love.graphics.setFont(font)
        text = "Pressione <space> para iniciar o jogo"
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end

    -- Intervalo entre hordas
    if pauseTime < 15 then
        t = string.format("%.2f", pauseTime)
        text = "Intervalo: "..t
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end

    -- Display do HP e Diamonds (dinheiro)
    love.graphics.setFont(font)
    text = "HP: "..tostring(hp).."                    Diamonds: "..diamonds
    local x = love.graphics.getWidth()
    local fx = font.getWidth(font, text)/2
    love.graphics.print(text, x/2 - fx, 10, 0, 1,1,0)
end