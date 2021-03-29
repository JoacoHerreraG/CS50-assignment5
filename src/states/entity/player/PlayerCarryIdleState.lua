
PlayerCarryIdleState = Class{__includes = EntityIdleState}

function PlayerCarryIdleState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.entity:changeAnimation('carry-idle-' .. self.entity.direction)
end

function PlayerCarryIdleState:enter(params)
    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerCarryIdleState:update(dt)
    EntityIdleState.update(self, dt)
end

function PlayerCarryIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('carry-pot')
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.entity:changeState('idle')
        for i, object in pairs (self.dungeon.currentRoom.objects) do
            if object.carried then 
                object.carried = false
                object:fire(self.entity)
                gSounds['throw-pot']:play()
            end
        end 
    end
end