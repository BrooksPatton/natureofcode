local Mover = require('./mover-class')

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    mover = Mover.new(50000)
end

function love.draw()
    mover:draw()
end

function love.update(dt)
    mover:update(dt)
end