local globals = require 'src.globals'
local Concord = require 'lib.Concord'

local Assemblers = {}

local function getRandomXEdge()
  local dx = love.math.random(1, 2) == 2 and -1 or 1
  local x = (dx == -1) and (globals.renderer.w + 16) or -16
  local y = love.math.random(16, globals.renderer.h - 16)
  return x, y, dx
end

local function buildDefaultEnemy(world, x, y, scr, hp)
  return Concord.entity(world)
      :give('Position', x, y)
      :give('Hitbox', 16, 16)
      :give('Score', scr)
      :give('Health', hp)
      :give('HealthDisplay')
      :give('Faction', 'Enemy')
end

function Assemblers.Bomber(world)
  local x, y, dx = getRandomXEdge()

  return buildDefaultEnemy(world, x, y, nil, 2)
      :give('BasicMover', dx, 0)
      :give('Sprite', globals.resources:get('bomber'), nil, nil, dx == -1)
      :give('Physics', love.math.random(80, 100))
      :give('Shooter', 1.5, 150, 'BulletDown', 8, 16)
      :give('Bomber')
end

function Assemblers.BulletDown(world, sx, sy, speed, faction)
  return Concord.entity(world)
      :give('Position', sx, sy)
      :give('Hitbox', 8, 8)
      :give('Bullet', 1)
      :give('BasicMover', 0, 1)
      :give('Physics', speed)
      :give('Sprite', globals.resources:get('bullet'))
      :give('Timer', 2, 'BulletDied')
      :give('Faction', faction)
end

return Assemblers
