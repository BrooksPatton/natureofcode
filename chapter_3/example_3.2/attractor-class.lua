local Vector = require('./vector')

local Attractor = {}
Attractor.__index = Attractor

function Attractor.new(location)
  local t = {}
  setmetatable(t, Attractor)

  t.location = location
  t.radius = 25
  t.color = {100, 100, 100}
  t.border = {0, 0, 0}
  t.mass = 50

  return t
end

function Attractor:display()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
  love.graphics.setColor(self.border)
  love.graphics.circle('line', self.location.x, self.location.y, self.radius)
end

function Attractor:attract(m)
  local force = self.location - m.location
  local distance = force:len()

  distance = constrain(distance, 5, 25)
  force = force:normalized()

  local strength = (gravity * self.mass * m.mass) / (distance * distance)

  return force * strength
end

return Attractor
