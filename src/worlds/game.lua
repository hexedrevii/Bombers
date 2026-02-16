local Concord = require 'lib.Concord'
Concord.utils.loadNamespace('src/components')

-- Systems
local CursorMovementSystem = require 'src.systems.cursormovement'

local game = {}

function game:init()
  self.world = Concord.world()

  self.world:addSystems(
    CursorMovementSystem
  )
end

function game:update(delta)
  self.world:emit('update', delta)
end

function game:draw()
  local r, g, b = love.math.colorFromBytes(145, 185, 250);
  love.graphics.clear(r, g, b)

  self.world:emit('draw')
end

return game
