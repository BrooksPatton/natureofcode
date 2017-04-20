local Vector = require('./vector')
local Mover = require('./mover-class')
local movers, gravity, wind

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    movers = {}

    for i = 1, 100 do
        local mass = love.math.random() * 5
        local location = Vector.new(0, 0)
        table.insert(movers, Mover.new(mass, location))
    end

    gravity = Vector.new(0, 15)
    wind = Vector.new(15, 0)
end

function love.draw()
    for i, mover in ipairs(movers) do
        mover:draw()
    end
end

function love.update(dt)
    for i, mover in ipairs(movers) do
        local rightWind = Vector.new(mover.location.x * -0.02, 0)

        mover:applyForce(gravity * dt)
        mover:applyForce(wind * dt)
        mover:applyForce(rightWind * dt)
        mover:update()
        mover:checkEdges()
    end
end