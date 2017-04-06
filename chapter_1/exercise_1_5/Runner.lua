local Runner = {}
Runner.__index = Runner

function Runner.new(location)
    local r = {}
    setmetatable(r, Runner)

    r.location = location
    r.size = 5
    r.speed = 0
    r.accelerationRate = 15
    r.maxSpeed = 200
    r.maxJumpHeight = 100
    r.jumpHeight = 0
    r.jumping = false
    r.jumpRate = 5

    return r
end

function Runner:draw()
    love.graphics.circle('fill', self.location.x, self.location.y - self.jumpHeight, self.size)
end

function Runner:update()
    if love.keyboard.isScancodeDown('up') then
        self.speed = self.speed + self.accelerationRate
    elseif love.keyboard.isScancodeDown('down') then
        self.speed = self.speed - self.accelerationRate
    end

    if love.keyboard.isScancodeDown('space') and self.jumpHeight == 0 and self.jumping == false then
        self.jumping = true
    end

    if self.jumping then
        self.jumpHeight = self.jumpHeight + self.jumpRate
    end

    if not self.jumping and self.jumpHeight > 0 then
        self.jumpHeight = self.jumpHeight - self.jumpRate
    end

    if self.jumpHeight > self.maxJumpHeight then
        self.jumping = false
    end

    if self.speed > self.maxSpeed then
        self.speed = self.maxSpeed
    elseif self.speed < 0 then
        self.speed = 0
    end

    if self.jumpHeight < 0 then
        self.jumpHeight = 0
    end
end

return Runner