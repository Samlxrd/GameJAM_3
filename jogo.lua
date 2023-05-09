Jogo = Classe:extend()

function Jogo:new()
    font = love.graphics.newFont("fonts/mine.ttf", 16)
    pauseTime = 15
    timer = 0
    map = Map()
    mouse = Vetor()
    p1 = Player()
    horde = Horde()
    display = Display()

    state = 0
    requestPathEnemy()
end

function Jogo:update(dt)
    if state == 0 then
       if love.keyboard.isDown('space') then
            state = 1
       end

    else if state == 1 then
        mouse.x = math.floor(love.mouse.getX()/32) + 1
        mouse.y = math.floor(love.mouse.getY()/32) + 1
        map:update(dt)

        if love.mouse.isDown(1) then
            path = nil
            p1.pos_path = 1
            start = { x = p1.pos.x, y = p1.pos.y }
            goal = { x = mouse.x, y = mouse.y }
            requestPath()
        end

        horde:update(dt)
        p1:update(dt)
    end
    display:update(dt)
end
end

function Jogo:draw()
    map:draw()
    p1:draw()
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
