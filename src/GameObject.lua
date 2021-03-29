GameObject = Class{}

function GameObject:init(def, x, y)
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.onCollide = function() end

    self.carried = def.carried
    self.thrown = def.thrown
    self.dx = 0
    self.dy = 0

    self.onFireX = x
    self.onFireY = y
    self.broken = def.broken
end

function GameObject:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.dx == -80 and self.x <= self.onFireX - TILE_SIZE * 4 then
        self.broken = true
    elseif self.dx == 80 and self.x >= self.onFireX + TILE_SIZE * 4 then
        self.broken = true
    elseif self.dy == -80 and self.x <= self.onFireY - TILE_SIZE * 4 then
        self.broken = true
    elseif self.dy == 80 and self.x >= self.onFireY + TILE_SIZE * 4 then
        self.broken = true
    end
end

function GameObject:fire(player)
    self.thrown = true
    if player.direction == 'left' then
        self.x = player.x - self.width - 1
        self.y = player.y
        self.dx = -80
        self.dy = 0
        self.onFireX = self.x
        self.onFireY = self.y
    elseif player.direction == 'right' then
        self.x = player.x + player.width + 1
        self.y = player.y
        self.dx = 80
        self.dy = 0
        self.onFireX = self.x
        self.onFireY = self.y
    elseif player.direction == 'up' then
        self.x = player.x
        self.y = player.y - 12 
        self.dx = 0
        self.dy = -80
        self.onFireX = self.x
        self.onFireY = self.y
    else
        self.x = player.x
        self.y = player.y + player.height + 1
        self.dx = 0
        self.dy = 80
        self.onFireX = self.x
        self.onFireY = self.y
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end