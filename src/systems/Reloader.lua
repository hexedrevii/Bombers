local Concord = require 'lib.Concord'
local globals = require 'src.globals'

ReloaderSystem = Concord.system({ pool = { 'Reloader' } })

function ReloaderSystem:draw()
  for _, entity in ipairs(self.pool) do
    love.graphics.setFont(globals.font)
    love.graphics.setColor(1, 0, 0)

    love.graphics.print('RELOADING...', 5, 1)

    love.graphics.setColor(1, 1, 1)
  end
end

return ReloaderSystem
