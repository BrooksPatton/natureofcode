local vector = require('./vector')

local Mover = {}
Mover.__index = Mover

function Mover.new(location)
    local t = {}
    setmetatable(t, Mover)

    t.location = location
    t.velocity = vector.new(0, 0)
    t.acceleration = vector.new(0, 0)

    t.width = 15
    t.height = 25

    t.atTop = false

    return t
end

function Mover:draw()
  -- stroke(0, 0, 0)
  love.graphics.setColor(100, 100, 100)

  love.graphics.ellipse('fill', self.location.x, self.location.y, self.width, self.height)
end

function Mover:update()
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity
  self.acceleration = self.acceleration * 0
  self.velocity = self.velocity * 0

  if self.location.y - (self.height / 2) - 10 <= 0 then
    self.atTop = true
  else
    self.atTop = false
  end
end

function Mover:applyForce(force)
  self.acceleration = self.acceleration + force
end

return Mover
