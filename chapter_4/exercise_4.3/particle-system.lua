local Vector = require('./vector')
local Particle = require('./particle')
local ParticleSystem = {}

ParticleSystem.__index = ParticleSystem

function ParticleSystem.new(location)
  local t = {}

  setmetatable(t, ParticleSystem)
  t.particles = {}
  t.origin = location:clone()

  return t
end

function ParticleSystem:addParticle()
  table.insert(self.particles, Particle.new(self.origin))
end

function ParticleSystem:display()
  for i,v in ipairs(self.particles) do
    v:display()
  end
end

function ParticleSystem:update(dt)
  for i,v in ipairs(self.particles) do
    v:update(dt)

    if v:isDead() then
      table.remove(self.particles, i)
    end
  end

  self:addParticle()
end

return ParticleSystem
