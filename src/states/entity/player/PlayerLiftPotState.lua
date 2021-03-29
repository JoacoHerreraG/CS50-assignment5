
PlayerLiftPotState = Class{__includes = BaseState}

function PlayerLiftPotState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction

    if direction == 'left' then
    	self.player:changeAnimation('lift-left')
    elseif direction == 'right' then
    	self.player:changeAnimation('lift-right')
    elseif direction == 'up' then
    	self.player:changeAnimation('lift-up')
    else
    	self.player:changeAnimation('lift-down')
    end
end

function PlayerLiftPotState:enter(params)
    gSounds['lift-pot']:play()
    self.player.currentAnimation:refresh()
end

function PlayerLiftPotState:update(dt)
	if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('carry-idle')
    end
end

function PlayerLiftPotState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end