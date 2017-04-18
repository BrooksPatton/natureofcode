local Mover = require('./mover')
local Vector = require('./vector')

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  local location = Vector.new(width / 2, height / 1.8)

  mover = Mover.new(location)
  gravity = Vector.new(0, -100)
  ceiling = Vector.new(0, gravity.y * -1)
  bounce = Vector.new(0, 1000)

  xoff = 0
  yoff = 0
end

function love.draw()
  mover:draw()
end

function love.update(dt)
  local noiseX = love.math.noise(xoff) -- 0, 1
  noiseX = noiseX - 0.5 -- -0.5, 0.5
  noiseX = noiseX * 150

  local noiseY = love.math.noise(yoff)
  noiseY = noiseY - 0.5
  noiseY = noiseY * 150

  local wind = Vector.new(noiseX, noiseY)

  mover:applyForce(gravity * dt)
  mover:applyForce(wind * dt)

  if mover.atTop then
    mover:applyForce(ceiling * dt)
    mover:applyForce(bounce * dt)
    bounce = bounce * 0.5
  end

  mover:update()

  xoff = xoff + 0.01
  yoff = yoff + 0.01
end
