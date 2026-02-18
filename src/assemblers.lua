local globals = require 'src.globals'
local Concord = require 'lib.Concord'

local Assemblers = {}

local function getRandomXEdge()
  local dx = love.math.random(1, 2) == 2 and -1 or 1
  local x = (dx == -1) and (globals.renderer.w + 16) or -16
  local y = love.math.random(16, globals.renderer.h - 16)
  return x, y, dx
end

local function buildDefaultEnemy(world, x, y, scr, hp, buff)
  return Concord.entity(world)
      :give('Position', x, y)
      :give('Hitbox', 16, 16)
      :give('Score', scr)
      :give('Health', hp)
      :give('HealthDisplay')
      :give('Faction', 'Enemy')
      :give('OffScreenDeath', buff)
end

function Assemblers.Bomber(world, x, y, buff)
  local dx;

  if not x or not y then
    x, y, dx = getRandomXEdge()
  else
    dx = (x < globals.renderer.w / 2) and 1 or -1
  end

  return buildDefaultEnemy(world, x, y, nil, 2, buff)
      :give('BasicMover', dx, 0)
      :give('Sprite', globals.resources:get('bomber'), nil, nil, dx == -1)
      :give('Physics', 100)
      :give('Shooter', 1.5, 150, 'BulletDown', 8, 16)
      :give('Bomber')
end

function Assemblers.Downer(world, x, y, buff)
  if not x and not y then
    x, y = love.math.random(16, globals.renderer.w - 16), -16
  end

  return buildDefaultEnemy(world, x, y, 50, 2, buff)
      :give('BasicMover', 0, 1)
      :give('Sprite', globals.resources:get('downer'))
      :give('Physics', 100)
      :give('Shooter', 1.25, 200, 'BulletDown', 8, 16)
      :give('Downer')
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
