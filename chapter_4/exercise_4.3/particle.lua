local Vector = require('./vector')
local Particle = {}

Particle.__index = Particle

function Particle.new(location)
  local t = {}

  setmetatable(t, Particle)

  t.acceleration = Vector.new(0, 5)
  t.velocity = Vector.new(love.math.random(-100, 100), love.math.random(-200, 0))
  t.location = location:clone()
  t.lifespan = 256
  print('running')

  return t
end

function Particle:update(dt)
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity * dt
  self.lifespan = self.lifespan - 200 * dt
end

function Particle:display()
  love.graphics.setColor(255, 255, 255, self.lifespan)
  love.graphics.circle('fill', self.location.x, self.location.y, 8)
end

function Particle:isDead()
  if self.lifespan < 0 then
    return true
  else
    return false
  end
end

return Particle
