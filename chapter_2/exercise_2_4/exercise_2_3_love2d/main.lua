local Vector = require('./vector')
local Mover = require('./mover-class')
local movers, gravity, wind
local frictionMag
local paused = true

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    movers = {}

    for i = 1, 100 do
        local mass = love.math.random() * 5
        local location = Vector.new(0, 0)
        table.insert(movers, Mover.new(mass, location))
    end

    gravity = Vector.new(0, 15)
    wind = Vector.new(5, 0)
    local normal = 1
    local coefficient = 0.01
    frictionMag = normal * coefficient
end

function love.draw()
    for i, mover in ipairs(movers) do
        mover:draw()
    end
end

function love.update(dt)
  if not paused then
    if dt > 0.029 then
      dt = 0.029
    end

    for i, mover in ipairs(movers) do
      local rightWind = Vector.new(mover.location.x * -0.02, 0)
      local mass = mover.mass
      local g = gravity * mass
      local friction = mover.velocity * -1

      friction = friction:normalized()
      friction = friction * frictionMag

      mover:applyForce(g * dt)
      mover:applyForce(wind * dt)
      --mover:applyForce(rightWind * dt)
      mover:applyForce(friction)
      mover:update()
      mover:checkEdges()
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  if scancode == 'space' then
    paused = false
  end
end
