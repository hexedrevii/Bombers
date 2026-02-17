local Concord = require 'lib.Concord'

local DeathSystem = Concord.system({ pool = { 'Dead' } })

function DeathSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    -- TODO: Player game end, powerups, score, everything lmao
    entity:destroy()
  end
end

return DeathSystem
