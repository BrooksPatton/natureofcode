local Vector = require('./vector')
local Ball = require('./ball-class')

local Baton = {}

Baton.__index = Baton

function Baton.new(location, translate)
  local t = {}
  setmetatable(t, Baton)

  t.location = location
  t.translate = translate
  t.angle = 0
  t.size = 150
  t.ballSize = 5
  t.ball1 = Ball.new(Vector.new(t.location.x + t.size / 2, t.location.y), t.ballSize)
  t.ball2 = Ball.new(Vector.new(t.location.x - t.size / 2, t.location.y), t.ballSize)
  t.aVelocity = 0
  t.aAcceleration = t.radians(love.math.random())
  t.velocity = Vector.new(0, 0)
  t.acceleration = Vector.new(0.5, 0)

  return t
end

function Baton:draw()
  self.ball1:draw()
  self.ball2:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(self.ball1.location.x, self.ball1.location.y, self.ball2.location.x, self.ball2.location.y)
end

function Baton:update(dt)
  self.aVelocity = self.aVelocity + self.aAcceleration * dt
  self.angle = self.angle + self.aVelocity

  self.velocity = self.velocity + self.acceleration * dt
  self.translate = self.translate + self.velocity
end

function Baton.radians(angle)
  local r = angle / 360
  r = 2 * math.pi * r

  return r
end

return Baton
