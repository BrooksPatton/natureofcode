local Vector = require('./vector')
local Wave = require('./wave')

local waves = {}

function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()

  -- Creates a magic bridge
  --for i=0, 0.1, 0.02 do
    --table.insert(waves, Wave.new(i))
  --end

  for i=1, 5 do
    local r = love.math.random(0, 100)

    table.insert(waves, Wave.new(r))
  end
end

function love.draw()
  for i,v in ipairs(waves) do
    v:display()
  end
end

function love.update(dt)
  if dt > 0.029 then dt = 0.029 end

  for i,v in ipairs(waves) do
    v:update()
  end
end
