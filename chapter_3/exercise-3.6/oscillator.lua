local Vector = require('./vector')

local Oscillator = {}
Oscillator.__index = Oscillator

function Oscillator.new()
  local t = {}
  setmetatable(t, Oscillator)

  t.angle = Vector.new(0, 0)
  t.velocity = Vector.new(love.math.random(-3, 3), love.math.random(-3, 3))
  t.amplitude = Vector.new(love.math.random(0, width/2), love.math.random(0, height/2))
  t.x = 0
  t.y = 0

  return t
end

function Oscillator:update(dt)
  local v = self.velocity * dt
  self.angle = self.angle + v

  self.x = math.sin(self.angle.x) * self.amplitude.x
  self.y = math.sin(self.angle.y) * self.amplitude.y
end

function Oscillator:display()
  love.graphics.push()
  love.graphics.translate(width/2, height/2)
  love.graphics.setColor({255, 255, 255})
  love.graphics.line(0, 0, self.x, self.y)
  love.graphics.setColor({150, 150, 150})
  love.graphics.circle('fill', self.x, self.y, 16)
  love.graphics.pop()
end

return Oscillator
