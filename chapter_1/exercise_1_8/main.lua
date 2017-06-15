vector = require('./vector')

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    location = vector.new(width / 2, height / 2)
    velocity = vector.new(0, 0)
    attractor = vector.new(love.math.random(400, 600), love.math.random(200, 400))
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', location.x, location.y, 10)

    love.graphics.points(attractor.x, attractor.y)
end

function love.update(dt)
    -- local mousePosition = vector.new(love.mouse.getX(), love.mouse.getY())

    local direction = attractor - location
    local length = direction:len()

    direction:normalizeInplace()

    local acceleration = direction * calculateMagnitude(length)

    velocity = velocity + acceleration * dt

    velocity = velocity * 0.99

    location = location + velocity
end

function calculateMagnitude(length)
    local speed = 200 / length

    if speed > 200 then
        speed = 200
    end

    return speed
end