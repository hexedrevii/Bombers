local Concord = require 'lib.Concord'

local HealthDisplaySystem = Concord.system({ pool = { 'Health', 'HealthDisplay', 'Position' } })

function HealthDisplaySystem:init()
  self.width = 16
  self.height = 4

  self.offset = 2
end

function HealthDisplaySystem:draw()
  for _, entity in ipairs(self.pool) do
    local health = entity.Health
    local pos = entity.Position

    local ratio = health.hp / health.mhp

    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', pos.x - 1, pos.y - self.height - self.offset - 1, self.width + 2, self.height + 2)

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', pos.x, pos.y - self.height - self.offset, self.width * ratio, self.height)

    love.graphics.setColor(1, 1, 1)
  end
end

return HealthDisplaySystem
