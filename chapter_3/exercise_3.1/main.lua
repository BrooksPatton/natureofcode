local Vector = require('./vector')
local Baton = require('./baton-class')

local batons = {}
local lastBatonAddedOn

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  addBaton()
end

function love.draw()
  for i,baton in ipairs(batons) do
    love.graphics.push()
    love.graphics.translate(baton.translate.x, baton.translate.y)
    love.graphics.rotate(baton.angle)
    baton:draw()
    love.graphics.pop()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i,baton in ipairs(batons) do
    baton:update(dt)
  end

  if shouldAddBaton() then
    addBaton()
  end
end

function addBaton()
  local loc = Vector.new(0, 0)
  local translate = Vector.new(-100, love.math.random(0, height))

  table.insert(batons, Baton.new(loc, translate))

  lastBatonAddedOn = love.timer.getTime()
end

function shouldAddBaton()
  local now = love.timer.getTime()

  if now - lastBatonAddedOn > 1 then
    return true
  else
    return false
  end
end
