local Concord = require 'lib.Concord'

local BulletDiedSystem = Concord.system({ pool = { 'BulletDied' } })

function BulletDiedSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    entity:destroy()
  end
end

return BulletDiedSystem
