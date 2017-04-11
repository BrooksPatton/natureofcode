local PVector = require('./pvector-class')
local Circle = require('./circle-class')

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    circles = {}
    addCircle()
end

function love.draw()
    for i, c in ipairs(circles) do
        c:draw()
    end
end

function love.update(dt)
    addCircle()

    for i, circle in ipairs(circles) do
        local mouseLocation = getMouseLocation()
        local direction = PVector.sub(mouseLocation, circle.location)
        direction:mult(dt / 60)
        direction:normalize()

        circle.velocity:add(direction)
        circle.velocity:limit(circle.topSpeed)
        circle.location:add(circle.velocity)

        if circle:shouldDie() then
            table.remove(circles, i)
        end
    end
end

function getMouseLocation()
    local x, y = love.mouse.getPosition()

    return PVector.new(x, y)
end

function getOffscreenLocation()
    local r = love.math.random(1, 4)
    local x, y

    if r == 1 then
        y = -50
        x = love.math.random(0, width)
    elseif r == 2 then
        x = width + 50
        y = love.math.random(0, height)
    elseif r == 3 then
        y = height + 50
        x = love.math.random(0, width)
    else
        x = -50
        y = love.math.random(0, height)
    end

    return PVector.new(x, y)
end

function addCircle()
    local topspeed = love.math.random(1, 3)
    local location = getOffscreenLocation()
    local velocity = PVector.new(0, 0)
    local radius = love.math.random(1, 15)

    table.insert(circles, Circle.new(location, velocity, radius, topspeed))
end