
PlayerCarryPotState = Class{__includes = EntityWalkState}

function PlayerCarryPotState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerCarryPotState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('carry-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('carry-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('carry-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('carry-down')
    else
        self.entity:changeState('carry-idle')
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

    EntityWalkState.update(self, dt)

	for i, object in pairs(self.dungeon.currentRoom.objects) do
        if self.entity:collides(object) and object.solid then
            if self.entity.direction == 'left' then
                self.entity.x = object.x + object.width + 1
            elseif self.entity.direction == 'right' then
                self.entity.x = object.x - self.entity.width - 1
            elseif self.entity.direction == 'up' then
                self.entity.y = object.y + 6
            else
                self.entity.y = object.y - self.entity.height - 1
            end
        end
    end

    if self.bumped then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt            
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt            
        else
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end
end