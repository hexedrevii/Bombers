local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local CursorMovementSystem = Concord.system({ pool = { 'Position', 'Hitbox', 'Player' } })

function CursorMovementSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local pos = entity.Position
    local hb = entity.Hitbox
    local plr = entity.Player
    pos.x, pos.y = globals.renderer:getMouseWorld()

    if globals.input:isPressed('shoot') and not plr.reloading then
      plr.reloading = true
      entity:give('Timer', 0.5, 'FinishedReloading')
      entity:give('Reloader')

      ---@diagnostic disable-next-line: undefined-field
      globals.worlds.active:shake(0.14, 0.75)

      globals.explosion:setPosition(pos.x, pos.y)
      globals.explosion:emit(7)

      -- Create the bullet
      Concord.entity(entity:getWorld())
          :give('Bullet', 1)
          :give('Faction', 'Player')
          :give('Hitbox', hb.w, hb.h, hb.ox, hb.oy)
          :give('Position', pos.x, pos.y)
          :give('Timer', 0.1, 'BulletDied')
    end
  end
end

return CursorMovementSystem
