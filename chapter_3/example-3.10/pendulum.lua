local Vector = require('./vector')

local Pendulum = {}
Pendulum.__index = Pendulum

function Pendulum.new(origin, armLength)
  local t = {}
  setmetatable(t, Pendulum)

  t.origin = origin:clone()
  t.location = Vector.new(0, 0)
  t.armLength = armLength
  t.angle = math.pi / 4
  t.angularVelocity = 0
  t.angularAcceleration = 0
  t.damping = 0.999999

  return t
end

function Pendulum:draw()
  love.graphics.setColor({255,255,255})
  love.graphics.line(self.origin.x, self.origin.y, self.location.x, self.location.y)
  love.graphics.setColor({55,55,55})
  love.graphics.circle('fill', self.location.x, self.location.y, 16)
end

function Pendulum:update(dt)
  local g = gravity

  self.angularAcceleration = (-1 * g / self.armLength) * math.sin(self.angle) * dt

  self.angularVelocity = self.angularVelocity + self.angularAcceleration
  self.angle = self.angle + self.angularVelocity

  self.angularVelocity = self.angularVelocity * self.damping

  self.location.x = self.armLength * math.sin(self.angle)
  self.location.y = self.armLength * math.cos(self.angle)
  self.location = self.location + self.origin
end

return Pendulum
