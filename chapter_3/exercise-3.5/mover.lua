-- GistID: 3f8a0d2a40325dc358cccab2aa124984
local Vector = require('./vector')

local Mover = {}
Mover.__index = Mover

function Mover.new(location, mass, size)
  local t = {}
  setmetatable(t, Mover)

  t.location = location
  t.mass = mass
  t.size = size
  t.velocity = Vector.new(0, 0)
  t.acceleration = Vector.new(0, 0)
  t.color = {200, 200, 200}
  t.engineColor = {100, 100, 100}
  t.thrustEngineColor = {255, 0, 0}
  t.angle = 0
  t.aAcceleration = 0
  t.aVecolity = 0
  t.turningSpeed = 4
  t.thrusting = false

  return t
end

function Mover:draw()
  local x1 = 0
  local y1 = 0 - (self.size/2)
  local x2 = 0 - (self.size/2)
  local y2 = 0 + (self.size/2)
  local x3 = 0 + (self.size/2)
  local y3 = 0 + (self.size/2)

  love.graphics.setColor(self.color)
  love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3)
  
  if self.thrusting then
    love.graphics.setColor(self.thrustEngineColor)
  else
    love.graphics.setColor(self.engineColor)
  end
  love.graphics.rectangle('fill', x2+5, y2, 5, 5)
  love.graphics.rectangle('fill', x3-10, y2, 5, 5)
end

function Mover:update(dt)
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity
  self.acceleration = self.acceleration * 0

  self.aVecolity = self.aVecolity + self.aAcceleration
  self:limitAngularVelocity()
  self.angle = self.angle + self.aVecolity 
  self.aAcceleration = self.aAcceleration * 0
end

function Mover:applyForce(force)
  local f = force / self.mass

  self.acceleration = self.acceleration + f
end

function Mover:applyAngularForce(force)
  self.aAcceleration = self.aAcceleration + force
end

function Mover:checkEdges()
  if self.location.y > height then
    self.location.y = 0
  elseif self.location.y < 0 then
    self.location.y = height
  end

  if self.location.x > width then
    self.location.x = 0
  elseif self.location.x < 0 then
    self.location.x = width
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

function Mover:limitAngularVelocity()
  local limit = 10
  if self.aVecolity > limit then
    self.aVecolity = limit
  end
end

return Mover
