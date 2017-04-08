local PVector = {}
PVector.__index = PVector

function PVector.new(x, y)
    local v = {}
    setmetatable(v, PVector)

    v.x = x
    v.y = y

    return v
end

function PVector.newRandom()
    local v = {}
    setmetatable(v, PVector)

    v.x = love.math.random(-1, 1)
    v.y = love.math.random(-1, 1)

    return v
end

function PVector:add(vector, dt)
    self.x = self.x + vector.x * dt
    self.y = self.y + vector.y * dt
end

function PVector:limit(num)
    if self.x > num then
        self.x = num
    end

    if self.y > num then
        self.y = num
    end
end

function PVector:multi(num)
    self.x = self.x * num
    self.y = self.y * num
end

return PVector