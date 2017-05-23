local Vector = require('./vector')

local Mover = {}
Mover.__index = Mover

function Mover.new(location, mass)
  local t = {}
  setmetatable(t, Mover)

  local initX = love.math.random(-2, 2)
  local initY = love.math.random(-2, 2)

  t.location = location
  t.mass = mass
  t.size = mass * 1.5
  t.bgColor = {200, 200, 200}
  t.lineColor = {0, 0, 0}
  t.acceleration = Vector.new(initX, initY)
  t.velocity = Vector.new(0, 0)
  t.angle = 0
  t.aAcceleration = 0
  t.aVelocity = 0

  t.location.x = t.location.x + (t.size/2)
  t.location.y = t.location.y + (t.size/2)

  return t
end

function Mover:display()
  love.graphics.setColor(self.bgColor)
  love.graphics.rectangle('fill', 0 - (self.size/2), 0 - (self.size/2), self.size, self.size)
  love.graphics.setColor(self.lineColor)
  love.graphics.rectangle('line', 0 - (self.size/2), 0 - (self.size/2), self.size, self.size)
end

function Mover:applyForce(force)
  local f = force / self.mass

  self.acceleration = self.acceleration + f
end

function Mover:update()
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity

  self.aAcceleration = self.acceleration.x 
  self.aVelocity = self.aVelocity + self.aAcceleration
  self.aVelocity = constrain(self.aVelocity, -0.1, 0.1)
  self.angle = self.angle + self.aVelocity

  self.acceleration = self.acceleration * 0
end

return Mover

