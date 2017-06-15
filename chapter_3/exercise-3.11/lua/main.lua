local Vector = require('./vector')
local Bob = require('./bob')
local Spring = require('./spring')

local bobs = {}
local spring

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  gravity = Vector.new(0, 10)

  spring = Spring.new(Vector.new(width/2, 100), 10)
end

function love.draw()
  for i, bob in ipairs(bobs) do
    bob:display()
    spring:displayLine(bob)
  end

  spring:display()
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i, bob in ipairs(bobs) do
    local friction = bob.velocity:clone()
    friction = friction * -1
    friction = friction:normalized()
    friction = friction * 25 * dt

    bob:applyForce(gravity)
    bob:applyForce(friction)
    spring:connect(bob, dt)
    bob:update(dt)
  end

  spring:constrain()
end

function love.mousereleased(x, y, button)
  table.insert(bobs, Bob.new(Vector.new(x, y)))
end
