local Mover = require('./mover')
local allTheMovers = {}

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- mover = Mover.new()
    for i=1, 1000 do
        table.insert(allTheMovers, Mover.new())
    end
end

function love.draw()
    -- mover:draw()
    for i, v in ipairs(allTheMovers) do
        v:draw()
    end
end

function love.update(dt)
    -- mover:update(dt)
    for i, v in ipairs(allTheMovers) do
        v:update(dt)
    end
end