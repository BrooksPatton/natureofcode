local Vector = require('./vector')
local Mover = require('./mover')
local Oscillator = require('./oscillator')

local m
local amplitude
local period
local twoPi = math.pi * math.pi
local frameCount
local location
local angleIncrement
local o

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  location = Vector.new(width/2, height/2)
  m = Mover.new(Vector.new(0, 0), 10)

  amplitude = 100
  period = 120
  frameCount = 0
  angleIncrement = 5
  o = Oscillator.new()
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(width/2, height/2) 
  love.graphics.line(0, m.location.y, 0, 0 - height/2)
  m:draw()
  love.graphics.setColor({20, 20, 255})
  love.graphics.pop()

  --love.graphics.line(width/2 + m.location.x, height/2, width/2, 0)
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  --m.location.y = amplitude * math.cos(twoPi * frameCount / period)
  m.location.y = amplitude * math.cos(m.angle)

  m.angle = m.angle + angleIncrement * dt
end
