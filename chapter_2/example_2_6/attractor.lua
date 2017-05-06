local Vector = require('./vector')

local Attractor = {}
Attractor.__index = Attractor

function Attractor.new(G, location)
  local t = {}
  setmetatable(t, Attractor)

  t.location = location
  t.mass = 100
  t.G = G

  return t
end

function Attractor:display()
  love.graphics.setColor(0, 255, 255)
  love.graphics.circle('fill', self.location.x, self.location.y, 5)
end

function Attractor:attract(mover)
  local force = self.location - mover.location
  local distance = self.location:dist(mover.location)
  distance = self:constrain(distance, 5, 25)
  force:normalizeInplace()
  local strength = (self.G * self.mass * mover.mass) / (distance * distance)
  force = force * strength

  return force
end

function Attractor:constrain(num, min, max)
  if num < min then
    num = min
  elseif num > max then
    num = max
  end

  return num
end

return Attractor
