local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local GameEndSystem = Concord.system({ pool = { 'EndGame' }, plr = { 'Player' } })

function GameEndSystem:update(delta)
  local player = self.plr[1].Player

  for _, entity in ipairs(self.pool) do
    local over = require 'src.worlds.deathscreen'
    over.score = player.score
    over.kills = player.kills

    globals.worlds:set(over)
  end
end

return GameEndSystem
