local Mover = require('./mover')
local Vector = require('./vector')
local Attractor = require('./attractor')

local G
local attractors = {}
local movers = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  G = 1.0

  for i = 1, 15 do
    local location = Vector.new(love.math.random(0, width), love.math.random(0, height))
    local mass = love.math.random(1, 10)

    table.insert(movers, Mover.new(location, mass))
  end

  for i = 1, 2 do
    local location = Vector.new(love.math.random(0, width), love.math.random(0, height))
    table.insert(attractors, Attractor.new(G, location))
  end

end

function love.draw()
  for i, attractor in ipairs(attractors) do
    attractor:display()
  end

  for i, mover in ipairs(movers) do
    mover:draw()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for j, attractor in ipairs(attractors) do
    for i, mover in ipairs(movers) do
      local force = attractor:attract(mover)

       mover:applyForce(force)
    end
  end

  for i, mover in ipairs(movers) do
    mover:update()
  end
end
