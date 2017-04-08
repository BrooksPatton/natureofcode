local Circle = require('./circle-class')
local PVector = require('./pvector-class')

local Mover = {}
Mover.__index = Mover

function Mover.new(numCircles)
    local m = {}
    setmetatable(m, Mover)

    m.circles = {}
    m.speedLimit = 60

    for i = 0, numCircles do
        local x = love.math.random(0, width)
        local y = love.math.random(0, height)
        local location = PVector.new(x, y)
        local r = 15
        local velocity = PVector.new(0, 0)
        local circle = Circle.new(location, velocity, r)
        circle.xoff = love.math.random(0, 1000000000)
        
        table.insert(m.circles, circle)
    end

    return m
end

function Mover:draw()
    for i, circle in ipairs(self.circles) do
        love.graphics.setColor(circle.red, circle.green, circle.blue)
        love.graphics.circle('fill', circle.location.x, circle.location.y, circle.r)
    end
end

function Mover:update(dt)
    for i, circle in ipairs(self.circles) do
        local acceleration = PVector.newRandom()
        acceleration:multi(self:nextNoise(circle) * circle.multiplier)

        circle.velocity:add(acceleration, dt)
        circle.velocity:limit(self.speedLimit)
        circle.location:add(circle.velocity, 1)
    end
end

function Mover:nextNoise(circle)
    local r = love.math.noise(circle.xoff)
    circle.xoff = circle.xoff + 0.01
    return r
end

return Mover