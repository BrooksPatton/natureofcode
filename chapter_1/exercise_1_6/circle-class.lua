local Circle = {}
Circle.__index = Circle

function Circle.new(location, velocity, radius)
    local c = {}
    setmetatable(c, Circle)

    c.location = location
    c.velocity = velocity
    c.r = radius

    return c
end

return Circle