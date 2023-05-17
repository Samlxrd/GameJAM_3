Powerup = Classe:extend()

function Powerup:new()
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


    -- Ativação do powerup
    if state == 2 then

        -- Posicionar powerup
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

    self:checkCollision(dt)
end

function Powerup:draw()
    if #self.poweruplist > 0 then
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
    p.texture[2] = love.graphics.newImage("img/textures/ice.png")

    p.duration = {10, 15}
    p.counter = p.duration[type]

    diamonds = diamonds - self.costs[p.type]
    return p
end

function Powerup:checkCollision(dt)
    if #self.poweruplist > 0 and #enemies.enemieslist > 0 then
        for i, p in ipairs(self.poweruplist) do
            for j, e in ipairs(enemies.enemieslist) do
                if self:isColliding(tile(e.pos), tile(p.pos)) then

                    -- Powerup Lava
                    if p.type == 1 then

                        e.life = e.life - dt * 80
                        if e.life <= 0 then
                            table.remove(enemies.enemieslist, j)
                        end

                    -- Powerup Gelo
                    else if p.type == 2 then
                        e.freezed = 1
                        e.freeze_time = 3.9
                        e.acceleration = 0.2
                    end
                    end
                else
                    if e.freeze_time < 4 and e.freezed == 1 then
                        e.freeze_time = e.freeze_time - dt
                    end

                    if e.freeze_time <= 0 then
                        e.acceleration = 1
                        e.freeze_time = 3
                        e.freezed = 0
                    end
                end

            end
        end
    end

end

function Powerup:isColliding(A,B)
    if A.x < B.x + 32 and A.x + 32 > B.x and
    A.y < B.y + 32 and A.y + 32 > B.y then
        return true
    end
end