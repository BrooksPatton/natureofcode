local Pendulum = require('./pendulum')
local Vector = require('./vector')

local pendulum

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  pendulum = Pendulum.new(Vector.new(width/2, 0), height-16)
  gravity = 10
end

function love.draw()
  pendulum:draw()
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  pendulum:update(dt)
end
