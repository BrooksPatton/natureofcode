local Circle = require('./circle')
local Pvector = require('./pvector')

local Mover = {}
Mover.__index = Mover

function Mover:new()
    local mover = {}
    setmetatable(mover, Mover)

    local location = Pvector.new(love.math.random(0, width), love.math.random(0, height))
    mover.circle = Circle.new(location, 5)
    mover.velocity = Pvector.new(love.math.random(-15, 15), love.math.random(-15, 15))
    mover.accelerationRate = 10

    return mover
end

function Mover:draw()
    self.circle:draw()
end

function Mover:update(dt)
    local acceleration = self.accelerationRate * dt

    if acceleration > 1000 then
        acceleration = 1000
    end

    self.velocity:addScalar(acceleration)
    -- sending in dt as I can't figure out how to multiply by dt here
    self.circle.location:add(self.velocity, dt)

    if self.circle.location.x > width then
        self.circle.location.x = 0
    elseif self.circle.location.x < 0 then
        self.circle.location.x = width
    end

    if self.circle.location.y > height then
        self.circle.location.y = 0
    elseif self.circle.location.y < 0 then
        self.circle.location.y = height
    end
end

return Mover