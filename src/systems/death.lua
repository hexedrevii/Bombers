local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local DeathSystem = Concord.system({ pool = { 'Dead' }, plr = { 'Player' } })

function DeathSystem:update(delta)
  local playerEntity = self.plr[1]
  local player = playerEntity and playerEntity.Player

  for _, entity in ipairs(self.pool) do
    if entity:has('Player') then
      ---@diagnostic disable-next-line: inject-field
      globals.worlds.active.ended = true

      local scr = player.score
      local kls = player.kills

      self:getWorld():clear()
      self:getWorld():newEntity():give('Timer', 0.75, 'EndGame'):give('Player', scr, kls)
    end

    if entity:has('Score') then
      player.score = player.score + entity.Score.score
      player.kills = player.kills + 1
    end

    entity:destroy()
  end
end

return DeathSystem
