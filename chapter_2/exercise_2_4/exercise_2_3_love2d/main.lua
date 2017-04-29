local Vector = require('./vector')
local Mover = require('./mover-class')
local Camera = require('./camera')
local Player = require('./player')

local movers, gravity, wind
local frictionMag
local paused = true
local player
local camera

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
    player = Player.new()
    camera = Camera(player.location.x, player.location.y, 2)
end

function love.draw()
  camera:attach()
  player:draw()

  for i, mover in ipairs(movers) do
    mover:draw()
  end

  camera:detach()

  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill',0, 0, width, height)
end

function love.update(dt)
  if not paused then
    if dt > 0.029 then
      dt = 0.029
    end

    movePlayer(dt)
    player:checkEdges()
    player:update()

    camera:lockX(player.location.x)
    camera:lockY(player.location.y)

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

function movePlayer(dt)
  local wDown = love.keyboard.isScancodeDown('w')
  local aDown = love.keyboard.isScancodeDown('a')
  local sDown = love.keyboard.isScancodeDown('s')
  local dDown = love.keyboard.isScancodeDown('d')
  local up = Vector.new(0, 0)
  local right = Vector.new(0, 0)
  local left = Vector.new(0, 0)
  local down = Vector.new(0, 0)
  local friction = player.velocity * -1
  local speed = 1

  friction = friction:normalized()
  friction = friction * frictionMag

  if wDown then
    up.y = speed * -1
  end
  if aDown then
    left.x = speed * -1
  end
  if sDown then
    down.y = speed
  end
  if dDown then
    right.x = speed
  end

  player:applyForce(friction * dt)
  player:applyForce(up * dt)
  player:applyForce(down * dt)
  player:applyForce(left * dt)
  player:applyForce(right *dt)
end
