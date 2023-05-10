Jogo = Classe:extend()

--[[
States:
0 - Inicio do jogo pausado
1 - Jogo em progresso
2 - Selecionar local do powerup
3 - Fim de Jogo
]]

function Jogo:new()
    pauseTime = 15
    timer = 0
    map = Map()
    mouse = Vetor()
    p1 = Player()
    horde = Horde()
    display = Display()
    powerup = Powerup()

    state = 0
    requestPathEnemy()
end

function Jogo:update(dt)

    -- Pré-jogo
    if state == 0 then
       if love.keyboard.isDown('space') then
            state = 1
       end

    -- Jogo
    else if state == 1 then
        mouse.x = math.floor(love.mouse.getX()/32) + 1
        mouse.y = math.floor(love.mouse.getY()/32) + 1
        map:update(dt)

        -- Sistema de coleta do diamante
        if p1.pos == map.diamond then
            map.spawned = 0
            diamonds = diamonds + 1
            map.diamond = Vetor(1,1)
        end

        horde:update(dt)
        p1:update(dt)
        powerup:update(dt)

    -- Posicionar powerup
    else if state == 2 then

        mouse.x = math.floor(love.mouse.getX()/32) + 1
        mouse.y = math.floor(love.mouse.getY()/32) + 1

        map:update(dt)
        horde:update(dt)
        powerup:update(dt)
    end

    end

    -- Colisão da horda com os powerups

    display:update(dt)
end
end

function Jogo:draw()
    map:draw()
    p1:draw()
    powerup:draw()
    horde:draw()
    display:draw()
end

function positionIsOpenFunc(x, y)
    if map.area[x][y] == 1 then
        return true
    end
end

function positionIsOpenFunc1(x, y)
    if map.area[x][y] == 3 then
        return true
    end
end
function positionIsOpenFunc2(x, y)
    if map.area[x][y] == 4 then
        return true
    end
end

function requestPath ()
    path = LuaStar:find(map.width, map.height, start, goal, positionIsOpenFunc, false, true)
end

function requestPathEnemy()
    pathL = LuaStar:find(map.width, map.height, {x = 23, y = 2}, { x = 7, y = 11}, positionIsOpenFunc1, false, true)
    pathR = LuaStar:find(map.width, map.height, {x = 24, y = 2}, { x = 7, y = 12}, positionIsOpenFunc2, false, true)
end
