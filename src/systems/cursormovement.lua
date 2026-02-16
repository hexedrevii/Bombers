local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local CursorMovementSystem = Concord.system({ pool = { 'Position', 'Player' } })

function CursorMovementSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local pos = entity.Position
    local plr = entity.Player
    pos.x, pos.y = globals.renderer:getMouseWorld()

    if globals.input:isPressed('shoot') and not plr.reloading then
      plr.reloading = true
      entity:give('Timer', 0.5, 'FinishedReloading')

      -- Create the bullet
      Concord.entity(entity:getWorld())
          :give('Bullet', 1)
          :give('Position', pos.x, pos.y)
          :give('Timer', 0.1, 'BulletDied')
    end
  end
end

return CursorMovementSystem
