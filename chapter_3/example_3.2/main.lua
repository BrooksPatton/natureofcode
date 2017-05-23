local Vector = require('./vector')
local Attractor = require('./attractor-class')
local Mover = require('./mover-class')

local attractor
local movers = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  gravity = 15

  local attractorLocation = Vector.new(width/2, height/2)
  attractor = Attractor.new(attractorLocation)

  for i=1, 50 do
    local x = love.math.random(0, width)
    local y = love.math.random(0, height)
    local location = Vector.new(x, y)
    local mass = love.math.random(1, 15)

    table.insert(movers, Mover.new(location, mass))
  end
end

function love.draw()
  attractor:display()

  for i,v in ipairs(movers) do
    love.graphics.push()
    love.graphics.translate(v.location.x + (v.size / 2), v.location.y + (v.size / 2))
    love.graphics.rotate(v.angle)
    v:display()
    love.graphics.pop()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i,v in ipairs(movers) do
    local f = attractor:attract(v)

    v:applyForce(f * dt)

    v:update()
  end
end

function constrain(num, min, max)
  if num < min then
    num = min
  elseif num > max then
    num = max
  end

  return num
end
