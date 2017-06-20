local Circle = {}
Circle.__index = Circle

function Circle.new(location, size)
    local circle = {}
    setmetatable(circle, Circle)

    circle.location = location
    circle.size = size

    return circle
end

function Circle:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', self.location.x, self.location.y, self.size)
end

return Circle