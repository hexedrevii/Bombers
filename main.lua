local globals = require "src.globals"
local game = require 'src.worlds.game'

function love.load()
  love.mouse.setCursor(globals.cursor_normal)

  globals.worlds:set(game)
end

function love.update(delta)
  globals.worlds:update(delta)
end

function love.draw()
  globals.worlds:draw()
end
