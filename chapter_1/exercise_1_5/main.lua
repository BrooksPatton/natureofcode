Pvector = require('./Pvector')
Runner = require('./Runner')
Block = require('./Block')

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    location = Pvector.new(25, height / 2)
    runner = Runner.new(location)
    blocks = {}
    table.insert(blocks, Block.new())
end

function love.draw()
    runner:draw()
    drawHorizon()

    for i, v in ipairs(blocks) do
        v:draw()
    end
end

function love.update(dt)
    runner:update()

    for i, v in ipairs(blocks) do
        v:move(runner.speed * dt)
    end

    if shouldCreateNewBlock() then
        table.insert(blocks, Block.new())
    end
end

function drawHorizon()
    local startLocation = Pvector.new(0, height / 2 + runner.size / 2)
    local endLocation = Pvector.new(width, height / 2 + runner.size / 2)

    love.graphics.line(startLocation.x, startLocation.y, endLocation.x, endLocation.y)
end

function shouldCreateNewBlock()
    local r = love.math.random(0, 100)

    return r > 99
end