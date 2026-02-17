local Concord = require 'lib.Concord'
local waveconfig = require 'src.waveconfig'
local globals = require 'src.globals'

local WaveManagerSystem = Concord.system({ pool = { 'WaveManager' } })

function WaveManagerSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local wave = entity.WaveManager
    local waveData = waveconfig[wave.index]

    wave.waveTimer = wave.waveTimer + delta
    if wave.waveTimer >= waveData.duration then
      print('awa 1')
      wave.index = wave.index + 1
      wave.waveTimer = 0
      wave.spawnTimer = 0
      return
    end

    wave.spawnTimer = wave.spawnTimer + delta
    if wave.spawnTimer >= waveData.spawnRate then
      wave.spawnTimer = 0


      local enemyType = love.math.random(#waveData.enemies)
      self:__spawnEnemy(waveData.enemies[enemyType])
    end
  end
end

function WaveManagerSystem:__spawnEnemy(component)
  if component == 'BasicMover' then
    local dx = love.math.random(1, 2) == 2 and -1 or 1

    local px = dx == -1 and globals.renderer.w + 16 or -16
    local py = love.math.random(16, globals.renderer.h - 16)

    self:getWorld():newEntity()
        :give(component, dx, 0)
        :give('Position', px, py)
        :give('Sprite', globals.resources:get('bomber'), nil, nil, dx == -1 and true or false)
        :give('Physics', love.math.random(80, 100))
        :give('Hitbox', 16, 16)
        :give('Health', 2)
  end
end

return WaveManagerSystem
