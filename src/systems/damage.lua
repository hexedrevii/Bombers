local Concord = require 'lib.Concord'
local Filter = require 'lib.Concord.concord.filter'

local DamageSystem = Concord.system({ pool = { 'Position', 'Bullet' }, enemyPool = { 'Position', 'Health', 'Hitbox' } })

function DamageSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local bulletPos = entity.Position
    local bullet = entity.Bullet

    for _, enemy in ipairs(self.enemyPool) do
      local enemyPos = enemy.Position
      local enemyBox = enemy.Hitbox
      local enemyHealth = enemy.Health

      -- AABB
      if bulletPos.x >= enemyPos.x and bulletPos.x <= enemyPos.x + enemyBox.w and bulletPos.y >= enemyPos.y and bulletPos.y <= enemyPos.y + enemyBox.h then
        enemyHealth.hp = enemyHealth.hp - bullet.damage
        if enemyHealth.hp < 1 then
          enemy:destroy()
        end

        entity:destroy()
        break
      end
    end
  end
end

return DamageSystem
