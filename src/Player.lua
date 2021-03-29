Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.potLifted = nil
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:potLiftRange(target)
    local direction = self.direction
    
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.x - hitboxWidth
        hitboxY = self.y
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.x + self.width
        hitboxY = self.y
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.x
        hitboxY = self.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.x
        hitboxY = self.y + self.height
    end

    return not (hitboxX + hitboxWidth < target.x or hitboxX > target.x + target.width or
                hitboxY + hitboxHeight < target.y or hitboxY > target.y + target.height)
end

function Player:render()
    Entity.render(self)
end