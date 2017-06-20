local Circle = {}
Circle.__index = Circle

function Circle.new(location, velocity, radius, topSpeed)
    local t = {}
    setmetatable(t, Circle)

    t.location = location
    t.radius = radius
    t.velocity = velocity
    t.red = love.math.random(0, 255)
    t.green = love.math.random(0, 255)
    t.blue = love.math.random(0, 255)
    t.topSpeed = topSpeed
    t.birthtime = love.timer.getTime()
    t.lifespan = 15

    return t
end

function Circle:draw()
    love.graphics.setColor(self.red, self.green, self.blue)

    love.graphics.circle('fill', self.location.x, self.location.y, self.radius)
end

function Circle:shouldDie()
    local dt = love.timer.getTime() - self.birthtime

    if dt > self.lifespan then
        return true
    else
        return false
    end
end

return Circle