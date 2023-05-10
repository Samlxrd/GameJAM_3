Powerup = Classe:extend()
--312
function Powerup:new(d)
    self.poweruplist = {}
    self.type = nil
    self.costs = {2, 2, 5}
end

function Powerup:update(dt)

     -- Seleção do powerup lava
    if love.keyboard.isDown('q') and diamonds >= self.costs[1] then
        state = 2
        self.type = 1
    end

    -- Seleção do powerup gelo
    if love.keyboard.isDown('w') and diamonds >= self.costs[2] then
        state = 2
        self.type = 2
    end

    -- Seleção do powerup cacto
    if love.keyboard.isDown('e') and diamonds >= self.costs[3] then
        state = 2
        self.type = 3
    end


    -- Ativação do powerup
    if state == 2 then

        if love.mouse.isDown(1) and (map.area[mouse.x][mouse.y] == 3 or map.area[mouse.x][mouse.y] == 4) then
            table.insert(self.poweruplist, self:newPowerup(self.type, mouse))
            state = 1
        end

        -- Cancelar powerup
        if love.keyboard.isDown('escape') then
            state = 1
        end
    end

    -- Duração do powerup
    for i, p in ipairs(self.poweruplist) do
        p.counter = p.counter - dt
        if p.counter <= 0 then
            table.remove(self.poweruplist, i)
        end
    end

end

function Powerup:draw()
    if #self.poweruplist > 0 then
        print('entrou')
        for i, p in ipairs(self.poweruplist) do
            love.graphics.draw(p.texture[p.type], tile(p.pos.x-1), tile(p.pos.y-1))
        end
    end
end

function Powerup:newPowerup(type, pos)
    p = {}
    p.type = type
    p.pos = Vetor(pos.x, pos.y)

    p.texture = {}
    p.texture[1] = love.graphics.newImage("img/textures/lava.png")
    --p.texture[2] = love.graphics.newImage("img/textures/ice.png")
    --p.texture[3] = love.graphics.newImage("img/textures/cactus.png")

    p.duration = {10, 15, 60}
    p.counter = p.duration[type]

    diamonds = diamonds - self.costs[p.type]
    return p
end