local Concord = require 'lib.Concord'

local DeathSystem = Concord.system({ pool = { 'Dead' }, plr = { 'Player' } })

function DeathSystem:update(delta)
  local playerEntity = self.plr[1]
  local player = playerEntity and playerEntity.Player

  for _, entity in ipairs(self.pool) do
    if entity:has('Player') then
      -- TODO: Kill player
    end

    if entity:has('Score') then
      player.score = player.score + entity.Score.score
      player.kills = player.kills + 1
    end

    entity:destroy()
  end
end

return DeathSystem
