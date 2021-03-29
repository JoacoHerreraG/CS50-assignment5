PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
    EntityIdleState.update(self, dt)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        for i, object in pairs(self.dungeon.currentRoom.objects) do
            if object.type == 'pot' and self.entity:potLiftRange(object) and object.carried == false then
                self.entity:changeState('lift-pot')
                object.carried = true
            end
        end
    end
end