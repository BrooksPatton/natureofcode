local Vector = require('./vector')
local Mover = require('./mover-class')

local m
local xOff
local yOff

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  local loc = Vector.new(width/2, height/2)
  m = Mover.new(loc, 10)

  xOff = 0
  yOff = 10000
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(m.location.x, m.location.y)
  love.graphics.rotate(m.angle)
  m:draw()
  love.graphics.pop()
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  --local mouseX = love.mouse.getX()
  --local mouseY = love.mouse.getY()
  --local mousePos = Vector.new(mouseX, mouseY)
  local randX = love.math.noise(xOff) * width
  local randY = love.math.noise(yOff) * height
  local randomDir = Vector.new(randX, randY)
  local direction = randomDir - m.location
  local friction = m.velocity:normalized()
  
  direction = direction:normalized()
  friction = friction * -1
  friction = friction * 10 * dt

  local force = direction * 15 * dt

  m:applyForce(force)
  m:applyForce(friction)
  m:update()

  xOff = xOff + 0.001
  yOff = yOff + 0.001
end
