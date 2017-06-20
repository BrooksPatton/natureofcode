local Pvector = {}
Pvector.__index = Pvector

function Pvector.new(x, y)
    local v = {}
    setmetatable(v, Pvector)

    v.x = x
    v.y = y

    return v
end

return Pvector