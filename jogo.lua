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
    requestPathL()
    requestPathR()
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
end
end

function Jogo:draw()
    map:draw()
    p1:draw()
    horde:draw()
    display:draw()

    if state == 0 then
        love.graphics.setFont(font)
        text = "Pressione <space> para iniciar o jogo"
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end

    if pauseTime < 15 then
        t = string.format("%.2f", pauseTime)
        text = "Intervalo: "..t
        local x,y = love.graphics.getDimensions()
        local fx, fy = font.getWidth(font, text)/2, font.getHeight(font)/2
        love.graphics.print(text, x/2 - fx, y/2 - fy, 0, 1,1,0)
    end
end

function positionIsOpenFunc(x, y)
    if map.area[x][y] == 1 then
        return true
    end
end

function positionIsOpenFuncEnemy(x, y)
    if map.area[x][y] == 3 then
        return true
    end
end

function requestPath ()
    path = LuaStar:find(map.width, map.height, start, goal, positionIsOpenFunc, false, true)
end

function requestPathL ()
    pathL = LuaStar:find(map.width, map.height, {x = 23, y = 2}, { x = 7, y = 11}, positionIsOpenFuncEnemy, false, true)
end

function requestPathR ()
    pathR = LuaStar:find(map.width, map.height, {x = 24, y = 2}, { x = 7, y = 12}, positionIsOpenFuncEnemy, false, true)
end

