local Pendulum = require('./pendulum')
local Vector = require('./vector')

local pendulums = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  local noiseOffs = {
    x = 0,
    y = 1000,
    z = 10000,
    increment = 0.000000001
  }

  for i=1, 9000 do
    table.insert(pendulums, Pendulum.new(Vector.new(width/2, 0), love.math.random(20, height-40), noiseOffs))

    noiseOffs.x = noiseOffs.x + 10
    noiseOffs.y = noiseOffs.y + 10
    noiseOffs.z = noiseOffs.z + 10
  end
  gravity = 10
end

function love.draw()
  for i,pendulum in ipairs(pendulums) do
    pendulum:draw()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i,pendulum in ipairs(pendulums) do
    pendulum:update(dt)
  end
end
