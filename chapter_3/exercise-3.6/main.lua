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
local oscilattors = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  for i=1, 10 do
    table.insert(oscilattors, Oscillator.new())
  end
end

function love.draw()
  for i,o in ipairs(oscilattors) do
    o:display()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i,o in ipairs(oscilattors) do
    o:update(dt)
  end
end
