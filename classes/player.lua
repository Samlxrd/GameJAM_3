Player = Classe:extend()

function Player:new()
    self.pos = Vetor(2,2)
    self.pos_path = 1
    self.direction = Vetor()
    self.speed = 5
end

function Player:update(dt)
    if path then

        -- Chegou ao destino, reseta o path
        if #path == self.pos_path then
            path = nil
            self.pos_path = 1
            timer = 0
            return
        end

        -- Calcula a direção do path
        local path_vet = Vetor(path[self.pos_path+1 ].x, path[self.pos_path+1].y)
        self.direction = path_vet - self.pos

        -- Debugging
        print(path[self.pos_path].x)
        print(timer)
        timer = timer + dt

        -- Velocidade de movimento
        if timer >= 0.05 then
            self.pos = path_vet
            self.pos_path = self.pos_path + 1
            timer = 0
        end
    end
end

function Player:draw()
    love.graphics.rectangle("fill", tile(self.pos.x-1), tile(self.pos.y-1), 32,32)
end