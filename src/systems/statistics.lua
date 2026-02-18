local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local StatisticSystem = Concord.system({ pool = { 'Player', 'Health' } })

function StatisticSystem:draw()
  for _, entity in ipairs(self.pool) do
    local plr = entity.Player

    love.graphics.setFont(globals.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('' .. plr.score .. ' score', 5, 16)

    love.graphics.setColor(1, 0, 0)
    love.graphics.print('' .. plr.kills .. ' kills', 5, 30)

    love.graphics.setColor(1, 1, 1)

    for i = 1, entity.Health.hp do
      love.graphics.draw(globals.resources:get('heart'), 2 * i + (8 * (i - 1)), globals.renderer.h - 9)
    end
  end
end

return StatisticSystem
