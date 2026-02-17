local Concord = require 'lib.Concord'

local OffscreenDeathSystem = Concord.system({ pool = { 'OffScreenDeath', 'Position' } })

function OffscreenDeathSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local buffer = entity.OffScreenDeath.buffer
    local pos = entity.Position

    if pos.x < -buffer then
      entity:destroy()
    elseif pos.x > 320 + buffer then
      entity:destroy()
    elseif pos.y < -buffer then
      entity:destroy()
    elseif pos.y > 180 + buffer then
      entity:destroy()
    end
  end
end

return OffscreenDeathSystem
