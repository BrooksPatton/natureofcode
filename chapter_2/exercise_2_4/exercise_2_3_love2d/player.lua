local Vector = require('./vector')

local Player = {}
Player.__index = Player

function Player.new()
  local t = {}
  setmetatable(t, Player)

  t.location = Vector.new(width / 2, height / 2)
  t.acceleration = Vector.new(0, 0)
  t.velocity = Vector.new(0, 0)

  return t
end

function Player:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', self.location.x, self.location.y, 10, 10)
end

function Player:applyForce(force)
  self.acceleration = self.acceleration + force
end

function Player:update(dt)
  self.velocity = self.velocity + self.acceleration
  self.location = self.location + self.velocity
  self.acceleration = self.acceleration * 0
end

function Player:checkEdges()
  if self.location.x > width - 10 then
    self.location.x = width - 10
    self.velocity.x = 0
  elseif self.location.x < 0 then
    self.location.x = 0
    self.velocity.x = 0
  end

  if self.location.y > height - 10 then
    self.location.y = height - 10
    self.velocity.y = 0
  elseif self.location.y < 0 then
    self.location.y = 0
    self.velocity.y = 0
  end
end
return Player
