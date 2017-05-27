local Vector = require('./vector')
local Mover = require('./mover')

local circles = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  for i=1,1 do
    addCircle()
  end
end

function love.draw()
  for i,circle in ipairs(circles) do
    circle:draw()
  end
end

function love.update(dt)
  for i, circle in ipairs(circles) do
    circle:update(dt)
  end
end

function addCircle()
  local location = Vector.new(width/2, height/2)
  local c = Mover.new(location, 10)

  table.insert(circles, c)
end
