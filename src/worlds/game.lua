local Concord = require 'lib.Concord'
Concord.utils.loadNamespace('src/components')

local moonshine = require 'lib.moonshine'

local globals = require 'src.globals'

-- Systems
local CursorMovementSystem = require 'src.systems.cursormovement'

local game = {}

function game:init()
  self.effect = moonshine(moonshine.effects.scanlines)
      .chain(moonshine.effects.crt)
      .chain(moonshine.effects.chromasep)
      .chain(moonshine.effects.vignette)

  self.effect.crt.distortionFactor = { 1.055, 1.05 }

  self.effect.vignette.radius = 0.9
  self.effect.scanlines.opacity = 0.1
  self.effect.vignette.opacity = 0.2

  self.effect.chromasep.angle = 1.0472
  self.effect.chromasep.radius = 1.05

  self.world = Concord.world()

  self.world:addSystems(
    CursorMovementSystem
  )

  self.player = Concord.entity(self.world)
  self.player
      :give('Position')
      :give('Player')
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
