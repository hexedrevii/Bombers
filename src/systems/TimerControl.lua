local Concord = require 'lib.Concord'

local TimerControlSystem = Concord.system({ pool = { 'Timer' } })

function TimerControlSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local timer = entity.Timer
    timer.time = timer.time + delta
    if timer.time >= timer.timeout then
      entity:give(timer.component)
      entity:remove('Timer')
    end
  end
end

return TimerControlSystem
