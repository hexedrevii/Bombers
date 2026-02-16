local InputManager = require 'lib.marshmallow.input'
local Renderer = require 'lib.marshmallow.pixelCanvas'
local WorldManager = require 'lib.marshmallow.worldController'

local globals = {
  input = InputManager.new(),
  renderer = Renderer.new(320, 180),
  worlds = WorldManager.new(),

  showHitboxes = true,

  font = love.graphics.newFont('assets/fonts/Pixeled.ttf', 6),

  cursor_normal = love.mouse.newCursor('assets/cursor-normal.png', 16, 16),
  cursor_hold = love.mouse.newCursor('assets/cursor-holding.png', 16, 16)
}

return globals
