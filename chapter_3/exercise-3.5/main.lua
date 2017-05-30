local Vector = require('./vector')
local Mover = require('./mover')

local ship

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  local l = Vector.new(width/2, height/2)
  ship = Mover.new(l, 10, 25)
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(ship.location.x, ship.location.y)
  love.graphics.rotate(radians(ship.angle))
  ship:draw()
  love.graphics.pop()
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  local right = love.keyboard.isScancodeDown('right')
  local left = love.keyboard.isScancodeDown('left')
  local thrust = love.keyboard.isScancodeDown('z')

  if right then
    ship:applyAngularForce(ship.turningSpeed * dt)
  end

  if left then
    ship:applyAngularForce(ship.turningSpeed * dt * -1)
  end

  if thrust then
    local angle = radians(ship.angle - 90)
    local x = 5 * math.cos(angle)
    local y = 5 * math.sin(angle)
    local force = Vector.new(x, y)

    ship.thrusting = true

    force = force:normalized()
    force = force * 15
    ship:applyForce(force * dt)
  else
    ship.thrusting = false
  end

  ship:checkEdges()
  ship:update(dt)
end

function radians(a)
  local r = 2 * math.pi * (a/360)

  return r
end
