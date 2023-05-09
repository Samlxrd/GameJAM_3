Enemies = Classe:extend()

function Enemies:new(n, i)
    mov = 0
    self.monsters = 0
    self.enemieslist = {}
    self.pop = n
    self.interval = 1
end

function Enemies:update(dt)

    -- Intervalo de spawn dos monstros
    if counter > self.interval then
        if self.monsters < self.pop then
            table.insert(self.enemieslist, newEnemy(love.math.random(1,3)))
            self.monsters = self.monsters + 1
        end
    counter = 0
    end

    -- Controle do movimento dos monstros
    for i, e in ipairs(self.enemieslist) do
        if e.P == 1 then
            if pathL then
                if #pathL == e.pos_path then
                    table.remove(self.enemieslist, i)
                    hp = hp - e.life/5
                else
                    local pathL_vet = Vetor(pathL[e.pos_path+1].x, pathL[e.pos_path+1].y)
                    e.direction = pathL_vet - e.pos
                    e.pos = e.pos + e.direction:norm()*dt * e.speed

                    if e.pos:dist(pathL_vet) < 2/32 then
                        e.pos = pathL_vet
                        e.pos_path = e.pos_path + 1
                    end
                end
            end

        else
            if pathR then
                if #pathR == e.pos_path then
                    table.remove(self.enemieslist, i)
                    hp = hp - e.life/5
                else
                    local pathR_vet = Vetor(pathR[e.pos_path+1].x, pathR[e.pos_path+1].y)
                    e.direction = pathR_vet - e.pos
                    e.pos = e.pos + e.direction:norm()*dt * e.speed

                    if e.pos:dist(pathR_vet) < 2/32 then
                        e.pos = pathR_vet
                        e.pos_path = e.pos_path + 1
                    end
                end
            end
        end
    end
    --print(self.monsters.."/"..self.pop.. "   "..#self.enemieslist)
end

function Enemies:draw()
    if #self.enemieslist > 0 then
        for i, e in ipairs(self.enemieslist) do
            if e.direction.x == 0 and e.direction.y > 0 then
                love.graphics.draw(e.img, e.anim.down, tile(e.pos.x-1), tile(e.pos.y-1))
            else if e.direction.x < 0 and e.direction.y == 0 then
                love.graphics.draw(e.img, e.anim.left, tile(e.pos.x-1), tile(e.pos.y-1))
            else if e.direction.x == 0 and e.direction.y < 0 then
                love.graphics.draw(e.img, e.anim.up, tile(e.pos.x-1), tile(e.pos.y-1))
            else
                love.graphics.draw(e.img, e.anim.up, tile(e.pos.x-1), tile(e.pos.y-1))
            end
            end
            end
        end
    end
end

function newEnemy(type)
    e = {}
    e.pos_path = 1
    e.direction = Vetor()
    e.dir = 1
    e.types = {"img/mobs/zombie.png", "img/mobs/skeleton.png", "img/mobs/creeper.png"}
    e.speeds = {4, 6, 3}
    e.lifes = {20, 10, 80}
    e.life = e.lifes[type]
    e.speed = e.speeds[type]

    e.pos = Vetor(love.math.random(23,24),2)
    if e.pos.x == 23 then
        e.P = 1
    else
        e.P = 2
    end

    e.img = love.graphics.newImage(e.types[type])
    local wd = e.img:getWidth()
    e.anim = {}
    e.anim.down = love.graphics.newQuad(0,0, 32, 32, wd, 32)
    e.anim.right = love.graphics.newQuad(32,0, 32, 32, wd, 32)
    e.anim.up = love.graphics.newQuad(64,0, 32, 32, wd, 32)
    e.anim.left = love.graphics.newQuad(96,0, 32, 32, wd, 32)

    return e
end