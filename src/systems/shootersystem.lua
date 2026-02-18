local Concord = require 'lib.Concord'
local assemblers = require 'src.assemblers'

local ShooterSystem = Concord.system({ pool = { 'Position', 'Shooter', 'Faction' } })

function ShooterSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local sht = entity.Shooter
    local pos = entity.Position

    sht.timer = sht.timer + delta
    if sht.timer >= sht.time then
      sht.timer = 0

      local sx = pos.x + sht.ox
      local sy = pos.y + sht.oy

      assert(assemblers[sht.type] ~= nil, 'Assembler for ' .. sht.type .. ' does not exist!')

      assemblers[sht.type](self:getWorld(), sx, sy, sht.speed, entity.Faction.name, sht.dx, sht.dy)
    end
  end
end

return ShooterSystem
