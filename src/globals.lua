local InputManager = require 'lib.marshmallow.input'
local Renderer = require 'lib.marshmallow.pixelCanvas'
local WorldManager = require 'lib.marshmallow.worldController'
local ResourceManager = require 'src.resourcemanager'

local globals = {
  input = InputManager.new(),
  renderer = Renderer.new(320, 180),
  worlds = WorldManager.new(),

  showHitboxes = false,

  resources = ResourceManager.new(),

  font = love.graphics.newFont('assets/fonts/Pixeled.ttf', 6),
}

return globals
