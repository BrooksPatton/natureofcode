local Vector = require('./vector')

local Bob = {}
Bob.__index = Bob

function Bob.new(location)
  local t = {}
  setmetatable(t, Bob)

  local red = love.math.random(0, 255)
  local green = love.math.random(0, 255)
  local blue = love.math.random(0, 255)
  t.color = {red, green, blue}
  t.size = 15
  t.location = location
  t.acceleration = Vector.new(0, 0)
  t.velocity = Vector.new(0, 0)

  return t
end

function Bob:display()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.location.x, self.location.y, self.size)
end

function Bob:applyForce(force)
  self.acceleration = self.acceleration + force
end

function Bob:update(dt)
  self.velocity = self.velocity + self.acceleration * dt
  self.location = self.location + self.velocity

  self.acceleration = self.acceleration * 0
end

return Bob
