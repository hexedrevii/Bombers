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
local ReloaderSystem = require 'src.systems.reloadercontrol'
local WaveManagerSystem = require 'src.systems.wavemanager'
local ShooterSystem = require 'src.systems.shootersystem'
local DeathSystem = require 'src.systems.death'
local StatisticSystem = require 'src.systems.statistics'
local HealthDisplaySystem = require 'src.systems.health'
local OffscreenDeathSystem = require 'src.systems.offscreen'
local GameEndSystem = require 'src.systems.finish'

-- Systems (Enemy AI)
local BasicMoverSystem = require 'src.systems.basicmover'

local game = {}

function game:__setupEffect()
  self.effect = moonshine(moonshine.effects.scanlines)
      .chain(moonshine.effects.crt)
      .chain(moonshine.effects.chromasep)
      .chain(moonshine.effects.vignette)

  self.effect.crt.distortionFactor = { 1.055, 1.05 }

  self.effect.vignette.radius = 0.9
  self.effect.scanlines.opacity = 0.3
  self.effect.vignette.opacity = 0.2

  self.effect.chromasep.angle = 3.1
  self.effect.chromasep.radius = 1.4
end

function game:shake(shakeDuration, shakeMagnitude)
  self.shakeTime = 0
  self.shakeDuration = shakeDuration
  self.shakeMagnitude = shakeMagnitude
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
    DamageSystem,
    ReloaderSystem,
    BasicMoverSystem,
    WaveManagerSystem,
    ShooterSystem,
    DeathSystem,
    StatisticSystem,
    HealthDisplaySystem,
    OffscreenDeathSystem,
    GameEndSystem
  )

  self.shakeTime = 0
  self.shakeDuration = 0
  self.shakeMagnitude = 0

  self.ended = false

  self.player = Concord.entity(self.world)
  self.player
      :give('Position')
      :give('Player')
      :give('Health')
      :give('Faction', 'Player')
      :give('Hitbox', 8, 8, -4, -4)
      :give('Sprite', globals.resources:get('cursor'), -8, -8)

  Concord.entity(self.world)
      :give('WaveManager')

  self.staticShader = love.graphics.newShader [[
    extern float time;
    float rand(vec2 co) {
        return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    }
    vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
        float noise = rand(texture_coords + time);
        return vec4(vec3(noise), 1.0); // Output white/black noise
    }
  ]]
end

function game:update(delta)
  self.world:emit('update', delta)

  if self.shakeTime < self.shakeDuration then
    self.shakeTime = self.shakeTime + delta
  end

  if self.ended then
    self.staticShader:send('time', love.timer.getTime())
  end
end

function game:draw()
  globals.renderer:set()

  if self.shakeTime < self.shakeDuration then
    local dx = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
    local dy = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
    love.graphics.translate(dx, dy)
  end

  love.graphics.clear(0.1, 0.1, 0.1)
  self.world:emit('draw')

  if self.ended then
    love.graphics.setShader(self.staticShader)
    love.graphics.draw(globals.resources:get('square'))
    love.graphics.setShader()
  end

  globals.renderer:render(nil, nil, self.effect)
end

function game:resize(w, h)
  self.effect.resize(w, h)
end

return game
