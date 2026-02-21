local Concord = require 'lib.Concord'

local SpriteSystem = Concord.system({ pool = { 'Sprite', 'Position' } })

function SpriteSystem:draw()
  for _, entity in ipairs(self.pool) do
    local sprite = entity.Sprite
    local pos = entity.Position

    love.graphics.draw(sprite.image,
      math.floor(sprite.flipped and pos.x + sprite.ox + sprite.image:getWidth() or pos.x + sprite.ox),
      math.floor(pos.y + sprite.oy),
      0,
      sprite.flipped and -1 or 1, 1
    )
  end
end

return SpriteSystem
