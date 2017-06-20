local Vector = require('./vector')

local Particle = {}
Particle.__index = Particle

function Particle.new(location)
  local t = {}
  setmetatable(t, Particle)

  t.acceleration = Vector.new(0, 1)
  t.velocity = Vector.new(love.math.random(-30, 30), love.math.random(-50,0))
  t.location = location:clone()
  t.lifespan = 255
  t.size = 8
  t.xoff = love.math.random(0, 10)
  t.noiseIncrement = 0.01
  t.red = 0
  t.green = 20
  t.blue = 20

  return t
end

function Particle:display()
  love.graphics.setColor(self.red, self.green, self.blue, self.lifespan)
  love.graphics.circle('fill', self.location.x, self.location.y, self.size)
end

function Particle:update(dt)
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity * dt
  self.lifespan = self.lifespan - 100 * dt

  self.red = love.math.noise(self.xoff) * 255

  self.xoff = self.xoff + self.noiseIncrement
end

function Particle:isDead()
  if self.lifespan <= 0 then
    return true
  else
    return false
  end
end

return Particle
