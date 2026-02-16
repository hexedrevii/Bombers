local Concord = require 'lib.Concord'
Concord.utils.loadNamespace('src/components')

local moonshine = require 'lib.moonshine'

local globals = require 'src.globals'

-- Systems
local CursorMovementSystem = require 'src.systems.cursormovement'
local FinishedReloadingSystem = require 'src.systems.timerSystems.finishedreloading'
local BulletDiedSystem = require 'src.systems.timerSystems.bulletdied'
local TimerControlSystem = require 'src.systems.timerhandler'
local SpriteSystem = require 'src.systems.spritecontrol'
local HitboxSystem = require 'src.systems.hitboxcontrol'
local DamageSystem = require 'src.systems.damage'

local game = {}

function game:__setupEffect()
  self.effect = moonshine(moonshine.effects.scanlines)
      .chain(moonshine.effects.crt)
      .chain(moonshine.effects.chromasep)
      .chain(moonshine.effects.vignette)

  self.effect.crt.distortionFactor = { 1.055, 1.05 }

  self.effect.vignette.radius = 0.9
  self.effect.scanlines.opacity = 0.1
  self.effect.vignette.opacity = 0.2

  self.effect.chromasep.angle = 1.0645
  self.effect.chromasep.radius = 1.1
end

function game:init()
  self:__setupEffect()

  self.world = Concord.world()

  self.world:addSystems(
    CursorMovementSystem,
    FinishedReloadingSystem,
    TimerControlSystem,
    SpriteSystem,
    HitboxSystem,
    BulletDiedSystem,
    DamageSystem
  )

  self.player = Concord.entity(self.world)
  self.player
      :give('Position')
      :give('Player')
      :give('Health')

  Concord.entity(self.world)
      :give('Position', 40, 40)
      :give('Health', 2)
      :give('Sprite', love.graphics.newImage('assets/enemies/bomber.png'))
      :give('Hitbox', 16, 16)
end

function game:update(delta)
  self.world:emit('update', delta)
end

function game:draw()
  globals.renderer:set()
  love.graphics.clear(0, 0, 0)

  self.world:emit('draw')

  globals.renderer:render(nil, nil, self.effect)
end

return game
