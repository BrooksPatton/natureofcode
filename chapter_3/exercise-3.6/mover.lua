-- GistID: 3f8a0d2a40325dc358cccab2aa124984
local Vector = require('./vector')

local Mover = {}
Mover.__index = Mover

function Mover.new(location, mass)
  local t = {}
  setmetatable(t, Mover)

  t.location = location
  t.mass = mass
  t.velocity = Vector.new(0, 0)
  t.acceleration = Vector.new(0, 0)
  t.size = mass
  t.color = {200, 200, 200}
  t.angle = 0
  t.aAcceleration = 0
  t.aVecolity = 0

  return t
end

function Mover:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.location.x, self.location.y, self.size)
end

function Mover:update()
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity
  self.acceleration = self.acceleration * 0

  self.angle = math.atan2(self.velocity.y, self.velocity.x)
end

function Mover:applyForce(force)
  local f = force / self.mass

  self.acceleration = self.acceleration + f
end

function Mover:checkEdges()
  if self.location.y > height then
    self.location.y = height
    self.velocity.y = self.velocity.y * -1
  end
end

function Mover:isInside(obj)
  if self.location.y > obj.y then
    return true
  end

  return false
end

function Mover:drag(obj, dt)
  --get the magnitude
  local speed = self.velocity:len()
  local dragMag = obj.c * speed * speed
  local drag = self.velocity * -1

  drag:normalizeInplace()
  drag = drag * dragMag

  self:applyForce(drag * dt)
end

return Mover
