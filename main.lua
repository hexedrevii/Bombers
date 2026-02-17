local globals = require "src.globals"
local game = require 'src.worlds.game'

function love.load()
  globals.input:pushKeymap('shoot', nil, nil, 1)

  globals.worlds:set(game)
end

function love.update(delta)
  globals.worlds:update(delta)
end

function love.draw()
  globals.worlds:draw()
end

function love.resize(w, h)
  globals.worlds:resize(w, h)
end

function love.mousepressed(x, y, btn)
  globals.input:mousepressed(x, y, btn)
end

function love.mousereleased(x, y, btn)
  globals.input:mousereleased(x, y, btn)
end
