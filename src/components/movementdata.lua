local Concord = require 'lib.Concord'

Concord.component('Position', function(c, x, y)
  c.x = x or 0
  c.y = y or 0
end)

Concord.component('Velocity', function(c, x, y)
  c.x = x or 0
  c.y = y or 0
end)
