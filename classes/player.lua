Player = Classe:extend()

function Player:new()
    self.anim = {}

    self.img = love.graphics.newImage("img/entities/player.png")
    self.wd = self.img:getWidth()

    self.anim.down = love.graphics.newQuad(0,0, 32, 32, self.wd, 32)
    self.anim.right = love.graphics.newQuad(32,0, 32, 32, self.wd, 32)
    self.anim.up = love.graphics.newQuad(64,0, 32, 32, self.wd, 32)
    self.anim.left = love.graphics.newQuad(96,0, 32, 32, self.wd, 32)

    self.pos = Vetor(2,2)
    self.pos_path = 1
    self.direction = Vetor()
    self.speed = 5
end

function Player:update(dt)

    -- Movimentação do player por cliques, usando A*
    if love.mouse.isDown(1) then
        path = nil
        self.pos_path = 1
        start = { x = self.pos.x, y = self.pos.y }
        goal = { x = mouse.x, y = mouse.y }
        requestPath()
    end

    -- Path finding (A*)
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


        -- Velocidade de movimento pelos tiles
        timer = timer + dt

        if timer >= 0.05 then
            self.pos = path_vet
            self.pos_path = self.pos_path + 1
            timer = 0
        end
    end
end

-- Carrega o frame de movimento de acordo com a direção do player
function Player:draw()
    if self.direction.x == 0 and self.direction.y < 0 then
        love.graphics.draw(self.img, self.anim.up, tile(self.pos.x-1), tile(self.pos.y-1))
    else if self.direction.x < 0 and self.direction.y == 0 then
        love.graphics.draw(self.img, self.anim.left, tile(self.pos.x-1), tile(self.pos.y-1))
    else if self.direction.x > 0 and self.direction.y == 0 then
        love.graphics.draw(self.img, self.anim.right, tile(self.pos.x-1), tile(self.pos.y-1))
    else
        love.graphics.draw(self.img, self.anim.down, tile(self.pos.x-1), tile(self.pos.y-1))
    end
    end
    end
end