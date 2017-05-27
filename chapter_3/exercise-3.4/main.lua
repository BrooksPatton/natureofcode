local Vector = require('./vector')
local Mover = require('./mover')

local circles = {}
local xOff
local yOff
local zOff
local noiseIncrement
local time
local tOff
local tOffIncrement

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  xOff = 0
  yOff = 1000
  zOff = 2000
  tOff = 3000
  noiseIncrement = 0.01
  tOffIncrement = 0.0001
  time = love.timer.getTime()

  for i=1,1 do
    addCircle()
  end
end

function love.draw()
  for i,circle in ipairs(circles) do
    circle:draw()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i, circle in ipairs(circles) do
    if circle.offset > width then
      table.remove(circles, i)
    end

    circle:update(dt)
  end

  local now = love.timer.getTime()
  local r = love.math.noise(tOff) * 2

  if now - time > r then
    addCircle()
    time = now
  end

  tOff = tOff + tOffIncrement
end

function addCircle()
  local location = Vector.new(width/2, height/2)
  local r = love.math.noise(xOff) * 255
  local g = love.math.noise(xOff, yOff) * 255
  local b = love.math.noise(xOff, yOff, zOff) * 255
  local color = {r, g, b}
  local c = Mover.new(location, color)

  table.insert(circles, c)
  xOff = xOff + noiseIncrement
  yOff = yOff + noiseIncrement
  zOff = zOff + noiseIncrement
end
