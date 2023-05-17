Display = Classe:extend()

function Display:new()
    score = 0
    diamonds = 0
    hp = 0
end

function Display:update(dt)
    if hp <= 0 then
        hp = 0
        state = 3
    end
end

function Display:draw()

    -- Inicio do jogo
    if state == 0 then
        font = love.graphics.newFont("fonts/mine.ttf", 16)
        love.graphics.setFont(font)
        text = "Pressione <space> para iniciar o jogo"
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end

    -- Fim de jogo
    if state == 3 then
        font = love.graphics.newFont("fonts/mine.ttf", 16)
        love.graphics.setFont(font)
        text = "Voce perdeu o jogo! Horda alcancada: "..horde.current_horde
        text2 = "Pressione <space> para reiniciar o jogo"
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - 2*fy, 0, 1,1,0)
        love.graphics.print(text2, x/2 - fx, y/2 + 140, 0, 1,1,0)
    end

    -- Intervalo entre hordas
    if pauseTime < 13+2*horde.current_horde then
        t = string.format("%.1f", pauseTime)
        text = "Intervalo: "..t
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end

    -- Display do HP e Diamonds (dinheiro)
    love.graphics.setFont(font)
    text = "Horda atual: "..horde.current_horde.."\t\t\t\t\tVida: "..tostring(hp).."\t\t\t\t\tDiamantes: "..diamonds
    local x = love.graphics.getWidth()
    local fx = font.getWidth(font, text)/2
    love.graphics.print(text, x/2 - fx, 10, 0, 1,1,0)

    -- Display instruções
    text = "Powerups (Custo: 2 Diamantes): \t\t\tQ = Lava (Dano)\t\t\t W = Gelo (Lentidao)"
    fx = font.getWidth(font, text)/2
    love.graphics.print(text, x/2 - fx, love.graphics.getHeight() - 20, 0, 1,1,0)
end