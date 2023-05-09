Map = Classe:extend()

function Map:new()
    self.hover_color = { 1, 1, 1, 0.5 }

    self.width = math.floor(800/32)
    self.height = math.floor(608/32)

    self.blocos = {}
    self.blocos[1] = love.graphics.newImage("img/textures/grass.png")
    self.blocos[2] = love.graphics.newImage("img/textures/stone.png")
    self.blocos[3] = love.graphics.newImage("img/textures/sand.png")
    self.blocos[4] = love.graphics.newImage("img/textures/sand.png")
    self.blocos[5] = love.graphics.newImage("img/textures/lava.png")

    self.area = {}

    for i=1, self.width do
        self.area[i] = {}
        for j=1, self.height do
            if i==1 or i == self.width or j == 1 or j == self.height
             then
                self.area[i][j] = 2
            else
                self.area[i][j] = 1
            end

            if i == 23 and (j > 1 and j < 18) or
            j == 17 and (i > 2 and i < 24) or
            i == 3  and (j > 5 and j < 18) or
            j == 6  and (i > 2 and i < 20) or
            i == 19  and (j > 5 and j < 12) or
            j == 11 and (i > 6 and i < 19) then
                self.area[i][j] = 3
            end

            if i == 24 and (j > 1 and j < 19) or
            j == 18 and (i > 1 and i < 25) or
            i == 2  and (j > 4 and j < 18) or
            j == 5  and (i > 2 and i < 21) or
            i == 20  and (j > 5 and j < 13) or
            j == 12 and (i > 6 and i < 20) then
                self.area[i][j] = 4
            end
        end
    end

end

function Map:update(dt)
    if self.area[mouse.x][mouse.y] < 2 then
        self.hover_color = {0, 1, 0, 0.5}
    else
        self.hover_color = {1, 0, 0, 0.5}
    end
end

function Map:draw()
    for i=1, self.width do
        for j=1, self.height do
           love.graphics.draw(self.blocos[self.area[i][j]], tile(i-1), tile(j-1))
        end
    end

    love.graphics.setColor(self.hover_color)
    love.graphics.rectangle("fill", tile(mouse.x-1), tile(mouse.y - 1), 32, 32)
    love.graphics.setColor(1,1,1)
end

function tile(x)
    return x * 32
end