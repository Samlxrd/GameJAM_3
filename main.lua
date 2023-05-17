function love.load()
    Classe = require "libraries/classic"
    Vetor = require "libraries/vector"
    LuaStar = require "libraries/lua-star"

    require "classes/powerup"
    require "classes/enemies"
    require "classes/player"
    require "classes/horde"
    require "classes/map"
    require "display"
    require "jogo"

    jogo = Jogo()
end

function love.update(dt)
    jogo:update(dt)
end

function love.draw()
    jogo:draw()
end