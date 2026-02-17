local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local DamageSystem = Concord.system({ pool = { 'Position', 'Bullet', 'Faction', 'Hitbox' }, enemyPool = { 'Position', 'Health', 'Hitbox', 'Faction' } })

function DamageSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local bulletPos = entity.Position
    local bullet = entity.Bullet
    local bulletFaction = entity.Faction
    local bulletBox = entity.Hitbox

    for _, enemy in ipairs(self.enemyPool) do
      local enemyPos = enemy.Position
      local enemyBox = enemy.Hitbox
      local enemyHealth = enemy.Health
      local enemyFaction = enemy.Faction

      if bulletFaction.name ~= enemyFaction.name then
        local bLeft   = bulletPos.x + bulletBox.ox
        local bRight  = bLeft + bulletBox.w
        local bTop    = bulletPos.y + bulletBox.oy
        local bBottom = bTop + bulletBox.h

        local eLeft   = enemyPos.x + enemyBox.ox
        local eRight  = eLeft + enemyBox.w
        local eTop    = enemyPos.y + enemyBox.oy
        local eBottom = eTop + enemyBox.h

        if bRight > eLeft and
            bLeft < eRight and
            bBottom > eTop and
            bTop < eBottom
        then
          enemyHealth.hp = enemyHealth.hp - bullet.damage

          ---@diagnostic disable-next-line: undefined-field
          globals.worlds.active:shake(0.14, 0.75)

          if enemyHealth.hp < 1 then
            enemy:give('Dead')
          end

          entity:give('Dead')
          break
        end
      end
    end
  end
end

return DamageSystem
