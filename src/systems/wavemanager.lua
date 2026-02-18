local Concord           = require 'lib.Concord'
local waveconfig        = require 'src.waveconfig'
local assemblers        = require 'src.assemblers'
local globals           = require 'src.globals'

local WaveManagerSystem = Concord.system({ pool = { 'WaveManager' } })

local function Set(list)
  local set = {}

  for _, e in ipairs(list) do
    set[e] = true
  end

  return set
end

local function getRandomPattern(patterns)
  local totalWeight = 0

  for _, p in ipairs(patterns) do
    totalWeight = totalWeight + (p.weight or 1)
  end

  local pick = love.math.random() * totalWeight

  local current = 0
  for _, p in ipairs(patterns) do
    current = current + (p.weight or 1)
    if pick < current then
      return p
    end
  end

  -- Fallback (should theoretically never happen)
  return patterns[1]
end

function WaveManagerSystem:init()
  self.sides = Set { 'Bomber', 'B2' }
end

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

      local pattern = getRandomPattern(waveData.patterns)
      local enemyType = pattern.enemy

      assert(assemblers[enemyType] ~= nil, 'Assembler for ' .. enemyType .. ' does not exist!')

      if pattern.type == 'single' then
        assemblers[enemyType](self:getWorld())
      elseif pattern.type == 'pair' then
        if self.sides[enemyType] then
          local cy = love.math.random(32, globals.renderer.h - 32)
          local cx = -16
          if love.math.random(1, 2) == 2 then
            cx = globals.renderer.w + 16
          end

          assemblers[enemyType](self:getWorld(), cx, cy - pattern.offset)
          assemblers[enemyType](self:getWorld(), cx, cy + pattern.offset)
        else
          local cx = love.math.random(32, globals.renderer.w - 32)
          local cy = -16

          assemblers[enemyType](self:getWorld(), cx - pattern.offset, cy)
          assemblers[enemyType](self:getWorld(), cx + pattern.offset, cy)
        end
      elseif pattern.type == 'v' then
        if self.sides[enemyType] then
          local cy = love.math.random(
            (32 + pattern.sx) * pattern.rank,
            globals.renderer.h - ((48 + pattern.sy) * pattern.rank)
          )
          local cx = -32 * pattern.rank
          if love.math.random(1, 2) == 2 then
            cx = globals.renderer.w + 32 * pattern.rank
          end

          -- Commander
          assemblers[enemyType](self:getWorld(), cx, cy, 200)

          for i = 1, pattern.rank do
            local ox = pattern.sx * i
            local oy = pattern.sy * i

            -- Wingmen
            assemblers[enemyType](self:getWorld(), cx - ox, cy - oy, 200)
            assemblers[enemyType](self:getWorld(), cx - ox, cy + oy, 200)
          end
        else
          local cx = love.math.random(
            (32 + pattern.sx) * pattern.rank,
            globals.renderer.w - ((48 + pattern.sy) * pattern.rank)
          )
          local cy = -32 * pattern.rank

          -- Commander
          assemblers[enemyType](self:getWorld(), cx, cy, 200)

          for i = 1, pattern.rank do
            local ox = pattern.sx * i
            local oy = pattern.sy * i

            -- Wingmen
            assemblers[enemyType](self:getWorld(), cx - ox, cy - oy, 200)
            assemblers[enemyType](self:getWorld(), cx + ox, cy - oy, 200)
          end
        end
      end
    end
  end
end

return WaveManagerSystem
