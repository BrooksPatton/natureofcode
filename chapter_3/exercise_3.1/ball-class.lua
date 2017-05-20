local Vector = require('./vector')

local Ball = {}
Ball.__index = Ball

function Ball.new(location, radius)
  local t = {}
  setmetatable(t, Ball)

  t.location = location
  t.color = {255, 255, 255}
  t.radius = radius

  return t
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
end

return Ball
