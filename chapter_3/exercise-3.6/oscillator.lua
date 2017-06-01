local Vector = require('./vector')

local Oscillator = {}
Oscillator.__index = Oscillator

function Oscillator.new()
  local t = {}
  setmetatable(t, Oscillator)

  t.angle = Vector.new(0, 0)
  t.velocity = Vector.new(love.math.random(-5, 5), love.math.random(-5, 5))
  t.amplitude = Vector.new(love.math.random(width/2), love.math.random(height/2))
  t.x
  t.y

  return t
end

function Oscillator:update(dt)
  self.angle = self.angle + self.velocity * dt

  x = math.sin(self.angle.x) * self.amplitude.x
  y = math.sin(self.angle.y) * self.amplitude.y
end

function Oscillator:display()
  love.graphics.setColor({255, 255, 255})
  love.graphics.line(0, 0, self.x, self.y)
  love.graphics.setColor({150, 150, 150})
  love.graphics.circle('fill', x, y, 16)
end

return Oscillator
