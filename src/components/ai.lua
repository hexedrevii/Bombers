local Concord = require 'lib.Concord'

Concord.component('BasicMover', function(c, dx, dy)
  c.dx = dx or 0
  c.dy = dy or 0
end)
