vector = require('./vector')

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    location = vector.new(width / 2, height / 2)
    velocity = vector.new(0, 0)

    topspeed = 5
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', location.x, location.y, 10)
end

function love.update(dt)
    local mousePosition = vector.new(love.mouse.getX(), love.mouse.getY())

    local direction = mousePosition - location
    direction:normalizeInplace()

    local acceleration = 0.5 * direction

    velocity = velocity + acceleration * dt
    limitVelocity()
    location = location + velocity
end

function limitVelocity()
    if velocity.x > topspeed then
        velocity.x = topspeed
    elseif velocity.y > topspeed then
        velocity.y = topst
    end
end