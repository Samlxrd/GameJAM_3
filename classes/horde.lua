Horde = Classe:extend()

function Horde:new()
    counter = 0 -- contador usado no intervalo de spawn dos monstros da horda
    self.current_horde = 1
    self.spawning = 0
end

function Horde:update(dt)
    -- Estado em que pode ser gerada uma horda
    if state == 1 or state == 2 then

        counter = counter + dt
        -- Gera horda
        if self.spawning == 0 and pauseTime == 15 then
            enemies = Enemies(self:newHorde())
            self.spawning = 1
        else
            -- Intervalo entre hordas
            if enemies.monsters > 0 and #enemies.enemieslist == 0 then

                pauseTime = pauseTime - dt
                self.spawning = 0

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
    if (state == 1  or state == 2) and enemies ~= nil then
        enemies:draw()
    end
end

function Horde:newHorde()
    local horde_size = self.current_horde * 10
    local spawn_interval = 5 / self.current_horde

    if self.current_horde > 1 then
        horde_size  = horde_size + love.math.random(1,5)
    end

    if spawn_interval < 1.5 then
        spawn_interval = 1.5
    end

    return horde_size, spawn_interval
end