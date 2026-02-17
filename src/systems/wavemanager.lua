local Concord = require 'lib.Concord'
local waveconfig = require 'src.waveconfig'
local assemblers = require 'src.assemblers'

local WaveManagerSystem = Concord.system({ pool = { 'WaveManager' } })

function WaveManagerSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local wave = entity.WaveManager
    local waveData = waveconfig[wave.index]

    wave.waveTimer = wave.waveTimer + delta
    if wave.waveTimer >= waveData.duration then
      wave.index = wave.index + 1
      wave.waveTimer = 0
      wave.spawnTimer = 0
      return
    end

    wave.spawnTimer = wave.spawnTimer + delta
    if wave.spawnTimer >= waveData.spawnRate then
      wave.spawnTimer = 0

      local enemyType = waveData.enemies[love.math.random(#waveData.enemies)]

      assert(assemblers[enemyType] ~= nil, 'Assembler for ' .. enemyType .. ' does not exist!')
      assemblers[enemyType](self:getWorld())
    end
  end
end

return WaveManagerSystem
