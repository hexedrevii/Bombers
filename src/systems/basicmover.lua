local Concord = require 'lib.Concord'

local BasicMoverSystem = Concord.system({ pool = { 'Position', 'Physics', 'BasicMover' } })

function BasicMoverSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local pos = entity.Position
    local phy = entity.Physics
    local bmv = entity.BasicMover

    pos.x = pos.x + bmv.dx * phy.speed * delta
    pos.y = pos.y + bmv.dy * phy.speed * delta
  end
end

return BasicMoverSystem
