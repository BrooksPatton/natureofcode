local Vector = require('./vector')

local Ball = {}
Ball.__index = Ball

function Ball.new(location, mass)
  local t = {}
  setmetatable(t, Ball)

  t.location = location
  t.mass = mass
  t.velocity = Vector.new(3, 0)
  t.acceleration = Vector.new(0, 0)
  t.radius = mass * 1.5
  t.color = {200, 200, 200}

  return t
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
end

function Ball:update()
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity
  self.acceleration = self.acceleration * 0
end

function Ball:applyForce(force)
  local f = force / self.mass

  self.acceleration = self.acceleration + f
end

function Ball:checkEdges()
  if self.location.y > height then
    self.location.y = height
    self.velocity.y = self.velocity.y * -1
  end
end

function Ball:isInside(obj)
  if self.location.y > obj.y then
    return true
  end

  return false
end

function Ball:drag(obj, dt)
  --get the magnitude
  local speed = self.velocity:len()
  local dragMag = obj.c * speed * speed
  local drag = self.velocity * -1

  drag:normalizeInplace()
  drag = drag * dragMag

  self:applyForce(drag * dt)
end

return Ball

