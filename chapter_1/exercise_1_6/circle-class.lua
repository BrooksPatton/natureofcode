local Circle = {}
Circle.__index = Circle

function Circle.new(location, velocity, radius)
    local c = {}
    setmetatable(c, Circle)

    c.location = location
    c.velocity = velocity
    c.r = radius
    c.red = c.randomColor()
    c.green = c.randomColor()
    c.blue = c.randomColor()
    c.multiplier = love.math.random(3, 25)

    return c
end

function Circle.randomColor()
    return love.math.random(0, 255)
end

return Circle