local Vector = require('./vector')

local Mover = {}
Mover.__index = Mover

function Mover.new(mass, location)
    local t = {}
    setmetatable(t, Mover)

    t.location = location
    t.red = love.math.random(0, 255)
    t.green = love.math.random(0, 255)
    t.blue = love.math.random(0, 255)
    t.mass = mass
    t.radius = mass * 16
    t.acceleration = Vector.new(0, 0)
    t.velocity = Vector.new(0, 0)

    return t
end

function Mover:draw()
    love.graphics.setColor(self.red, self.green, self.blue)
    love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
end

function Mover:applyForce(force)
    local f = force / self.mass
    self.acceleration = self.acceleration + f
end

function Mover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration = self.acceleration * 0
end

function Mover:checkEdges()
    if self.location.x <= 0 then
        self.location.x = 0
        self.velocity.x = self.velocity.x * -1
    elseif self.location.x >= width then
        self.location.x = width
        self.velocity.x = self.velocity.x * -1
    end

    if self.location.y > height then
        self.location.y = height
        self.velocity.y = self.velocity.y * -1
    end
end

return Mover