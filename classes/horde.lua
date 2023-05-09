Horde = Classe:extend()

function Horde:new()
    counter = 0 -- contador usado no intervalo de spawn dos monstros da horda
    self.current_horde = 1
    self.spawning = 0
end

function Horde:update(dt)
    if state == 1 then
        counter = counter + dt
        if self.spawning == 0 and pauseTime == 15 then
            enemies = Enemies(self:newHorde())
            self.spawning = 1
        else
            if enemies.monsters > 0 and #enemies.enemieslist == 0 then
                pauseTime = pauseTime - dt
                self.spawning = 0
                print('entrou')
                if pauseTime <= 0 then
                    self.current_horde = self.current_horde + 1
                    pauseTime = 15
                end
            end
            enemies:update(dt)
        end

    end
end

function Horde:draw()
    if state == 1 and enemies ~= nil then
        enemies:draw()

    end
end

function Horde:newHorde()
    return self.current_horde * 15 + love.math.random(1,5), 2
end