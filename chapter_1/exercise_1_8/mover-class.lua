local Mover = {}
Mover.__index = Mover

function Mover.new()
    local t = {}
    setmetatable(t, Mover)

    

    return t
end