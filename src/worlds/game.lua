local game = {}

function game:init()

end

function game:update(delta)

end

function game:draw()
  local r, g, b = love.math.colorFromBytes(145, 185, 250);
  love.graphics.clear(r, g, b)
end

return game
