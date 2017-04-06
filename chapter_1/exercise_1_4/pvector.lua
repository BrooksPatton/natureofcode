local Pvector = {}
Pvector.__index = Pvector

function Pvector.new(x, y)
    local pvector = {}
    setmetatable(pvector, Pvector)
    pvector.x = x
    pvector.y = y

    return pvector
end

function Pvector:add(pvector, dt)
    -- dt is being sent in as the delta time from update because I could not figure out how to keep it contained
    self.x = self.x + pvector.x * dt
    self.y = self.y + pvector.y * dt
end

function Pvector:addScalar(scalar)
    if self.x > 0 then
        self.x = self.x + scalar
    end
    if self.y > 0 then
        self.y = self.y + scalar
    end
    if self.x < 0 then 
        self.x = self.x - scalar
    end
    if self.y < 0 then
        self.y = self.y - scalar
    end
end

return Pvector