local Concord = require 'lib.Concord'

local FinishedReloadingSystem = Concord.system({ pool = { 'Player', 'FinishedReloading' } })

function FinishedReloadingSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local plr = entity.Player
    plr.reloading = false

    entity:remove('FinishedReloading')
  end
end

return FinishedReloadingSystem
