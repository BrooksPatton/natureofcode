local Vector = require('./vector')

local Spring = {}
Spring.__index = Spring

function Spring.new(anchor, length)
  local t = {}
  setmetatable(t, Spring)

  t.anchor = anchor
  t.size = 10
  t.length = length
  t.minLength = 25
  t.maxLength = 35
  t.k = 0.1
  t.color = {100, 100, 100}

  return t
end

function Spring:connect(bob, dt)
  local force = bob.location - self.anchor
  local d = force:len()
  local stretch = d - self.length

  force = force:normalized()
  force = force * -1 * self.k * stretch

  bob:applyForce(force)
end

function Spring:display()
  love.graphics.setColor(self.color)
  local x = self.anchor.x - (self.size / 2)
  local y = self.anchor.y - (self.size / 2)
  love.graphics.rectangle('fill', x, y, self.size, self.size)
end

function Spring:displayLine(bob)
  love.graphics.setColor({255, 255, 255})
  love.graphics.line(bob.location.x, bob.location.y, self.anchor.x, self.anchor.y)
end

function Spring:constrain()
  if self.length > self.maxLength then
    self.length = self.maxLength
  elseif self.length < self.minLength then
    self.length = self.minLength
  end
end

return Spring
