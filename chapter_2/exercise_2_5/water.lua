local Water = {}
Water.__index = Water

function Water.new(x, y, w, h, c)
  local t = {}
  setmetatable(t, Water)

  t.x = x
  t.y = y
  t.w = w
  t.h = h
  t.c = c
  t.color = {0, 0, 100}

  return t
end

function Water:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

return Water
