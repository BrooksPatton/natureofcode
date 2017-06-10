local Vector = require('./vector')

local Pendulum = {}
Pendulum.__index = Pendulum

function Pendulum.new(origin, armLength, noiseOffs)
  local t = {}
  setmetatable(t, Pendulum)

  t.origin = origin:clone()
  t.location = Vector.new(0, 0)
  t.armLength = armLength
  t.angle = math.pi / 4
  t.angularVelocity = 0
  t.angularAcceleration = 0
  t.damping = 0.999999
  t.red = 0
  t.green = 0
  t.blue = 0
  t.armDirection = 'down'
  t.radius = love.math.random(1, 10)
  t.noiseOffs = noiseOffs

  return t
end

function Pendulum:draw()
  love.graphics.setColor({255,255,255})
  --love.graphics.line(self.origin.x, self.origin.y, self.location.x, self.location.y)
  love.graphics.setColor({self.red, self.green, self.blue})
  love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
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

  self.red = love.math.noise(self.noiseOffs.x) * 255
  self.green = love.math.noise(self.noiseOffs.x, self.noiseOffs.y) * 255
  self.blue = love.math.noise(self.noiseOffs.x, self.noiseOffs.y, self.noiseOffs.z) * 255

  self.noiseOffs.x = self.noiseOffs.x + self.noiseOffs.increment
  self.noiseOffs.y = self.noiseOffs.y + self.noiseOffs.increment
  self.noiseOffs.z = self.noiseOffs.z + self.noiseOffs.increment
end

return Pendulum
