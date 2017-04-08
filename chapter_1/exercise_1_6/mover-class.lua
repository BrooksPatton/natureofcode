local Circle = require('./circle-class')
local PVector = require('./pvector-class')

local Mover = {}
Mover.__index = Mover

function Mover.new()
    local m = {}
    setmetatable(m, Mover)

    local x = love.math.random(0, width)
    local y = love.math.random(0, height)
    local location = PVector.new(x, y)
    local r = 15
    local velocity = PVector.new(0, 0)
    
    m.speedLimit = 60
    m.circle = Circle.new(location, velocity, r)
    m.xoff = 0

    return m
end

function Mover:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', self.circle.location.x, self.circle.location.y, self.circle.r)
end

function Mover:update(dt)
    local acceleration = PVector.newRandom()
    acceleration:multi(self:nextNoise() * 5)

    self.circle.velocity:add(acceleration, dt)
    self.circle.velocity:limit(self.speedLimit)
    self.circle.location:add(self.circle.velocity, 1)
end

function Mover:nextNoise()
    local r = love.math.noise(self.xoff)
    self.xoff = self.xoff + 0.01
    return r
end

return Mover