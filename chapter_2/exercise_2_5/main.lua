local Ball = require('./ball')
local Vector = require('./vector')
local Water = require('./water')

local balls
local water

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  balls = {}

  for i = 1, 15 do
    local location = Vector.new(50 * i, 50)
    local mass = love.math.random(1, 5)
    table.insert(balls, Ball.new(location, mass))
  end

  water = Water.new(0, height / 2, width, height / 2, 5.5)

  paused = true
end

function love.draw()
  water:draw()

  for i, ball in ipairs(balls) do
    ball:draw()
  end
end

function love.update(dt)
  if not paused then
    if dt > 0.029 then dt = 0.029 end

    for i, ball in ipairs(balls) do
      local gravity = Vector.new(0, 15 * ball.mass)

      ball:applyForce(gravity * dt)
      if ball:isInside(water) then
        ball:drag(water, dt)
      end
  
      ball:checkEdges()

      ball:update()
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == 'space' then
    paused = not paused
  end
end
