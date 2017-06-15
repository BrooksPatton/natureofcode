local Pvector = require('./Pvector')

local Block = {}
Block.__index = Block

function Block.new()
    local r = {}
    setmetatable(r, Block)

    r.height = 50
    r.width = 10
    r.location = Pvector.new(width + 5, height / 2 - r.height)
    
    return r
end

function Block:draw()
    love.graphics.rectangle('fill', self.location.x, self.location.y, self.width, self.height)
end

function Block:move(speed)
    self.location.x = self.location.x - speed
end

return Block