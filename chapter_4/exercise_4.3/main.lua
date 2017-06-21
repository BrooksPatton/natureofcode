local Vector = require('./vector')
local ParticleSystem = require('./particle-system')

local particleSystem

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  particleSystem = ParticleSystem.new(Vector.new(width/2, height/2))
end

function love.draw()
  particleSystem:display()
end

function love.update(dt)
  particleSystem:update(dt)
end
