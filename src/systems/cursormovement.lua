local Concord = require 'lib.Concord'
local globals = require 'src.globals'

local CursorMovementSystem = Concord.system({ pool = { 'Position', 'Player' } })

function CursorMovementSystem:update(delta)
  for _, entity in ipairs(self.pool) do
    local pos = entity.Position
    pos.x, pos.y = globals.renderer:getMouseWorld()
  end
end

return CursorMovementSystem
