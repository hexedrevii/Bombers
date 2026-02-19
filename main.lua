local globals = require "src.globals"
local game = require 'src.worlds.game'

function love.load()
  globals.input:pushKeymap('shoot', nil, nil, 1)
  globals.input:pushKeymap('quit', 'q')
  globals.input:pushKeymap('retry', 'return')

  globals.resources:add('bomber', love.graphics.newImage('assets/enemies/bomber.png'))
  globals.resources:add('cursor', love.graphics.newImage('assets/cursor-normal-export.png'))
  globals.resources:add('bullet', love.graphics.newImage('assets/bullets/bullet.png'))
  globals.resources:add('bullet-side', love.graphics.newImage('assets/bullets/bullet-side.png'))
  globals.resources:add('downer', love.graphics.newImage('assets/enemies/downer.png'))
  globals.resources:add('b2', love.graphics.newImage('assets/enemies/b2.png'))
  globals.resources:add('heart', love.graphics.newImage('assets/heart.png'))
  globals.resources:add('square', love.graphics.newImage('assets/blank-rect.png'))

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

function love.keypressed(key)
  globals.input:keypressed(key)
end

function love.keyreleased(key)
  globals.input:keyreleased(key)
end

function love.mousepressed(x, y, btn)
  globals.input:mousepressed(x, y, btn)
end

function love.mousereleased(x, y, btn)
  globals.input:mousereleased(x, y, btn)
end
