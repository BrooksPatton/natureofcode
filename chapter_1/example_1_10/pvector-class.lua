local PVector = {}
PVector.__index = PVector

function PVector.new(x, y)
    local t = {}
    setmetatable(t, PVector)

    t.x = x
    t.y = y

    return t
end

function PVector:add(v)
    self.x = self.x + v.x
    self.y = self.y + v.y
end

function PVector:mult(num)
    self.x = self.x * num
    self.y = self.y * num
end

function PVector:div(num)
    self.x = self.x / num
    self.y = self.y / num
end

function PVector:mag()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function PVector:normalize()
    local magnitude = self:mag()

    if not magnitude == 0 then
        self:div(magnitude)
    end
end

function PVector:limit(num)
    if self.x > num then
        self.x = num
    elseif self.x < num * -1 then
        self.x = num * -1
    end

    if self.y > num then
        self.y = num
    elseif self.y < num * -1 then
        self.y = num * -1
    end
end

-- Static methods
function PVector.sub(v1, v2)
    return PVector.new(v1.x - v2.x, v1.y - v2.y)
end

return PVector