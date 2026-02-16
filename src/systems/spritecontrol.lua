local Concord = require 'lib.Concord'

local SpriteSystem = Concord.system({ pool = { 'Sprite', 'Position' } })

function SpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    local sprite = entity.Sprite
    local pos = entity.Position
    love.graphics.draw(sprite.image, math.floor(pos.x), math.floor(pos.y))
  end
end

return SpriteSystem
