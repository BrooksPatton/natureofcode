local Vector = require('./vector')
local Particle = require('./particle')

local particles = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
end

function love.draw()
  for i,particle in ipairs(particles) do
    particle:display()
  end

  love.graphics.setColor(255,255,255)
  love.graphics.print(table.getn(particles), 5, 5)
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  addParticle(width/2, 70)

  for i,particle in ipairs(particles) do
    particle:update(dt)

    if particle:isDead() then
      table.remove(particles, i)
    end
  end
end

function addParticle(x, y)
  table.insert(particles, Particle.new(Vector.new(x, y)))
end
