local Wave = {}
Wave.__index = Wave

function Wave.new(a)
  local t = {}
  setmetatable(t, Wave)

  t.startAngle = a
  t.angularVelocity = 0.02
  t.angle = 0
  t.color = {love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255)}

  return t
end

function Wave:display()
  love.graphics.setColor(self.color)

  local x = 0
  local y

  while x <= width do
    local y = love.math.noise(self.angle) * height

    love.graphics.circle('fill', x, y, 20)
    self.angle = self.angle + self.angularVelocity

    x = x + 40
  end
end

function Wave:update()
  self.angle = self.startAngle
  self.startAngle = self.startAngle + self.angularVelocity
end

return Wave
