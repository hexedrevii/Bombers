local Concord = require 'lib.Concord'

local globals = require 'src.globals'

local HitboxSystem = Concord.system({ pool = { 'Position', 'Hitbox' } })

if globals.showHitboxes then
  function HitboxSystem:draw()
    for _, entity in ipairs(self.pool) do
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle('line',
        entity.Position.x + entity.Hitbox.ox, entity.Position.y + entity.Hitbox.oy,
        entity.Hitbox.w, entity.Hitbox.h
      )
      love.graphics.setColor(1, 1, 1)
    end
  end
end

return HitboxSystem
