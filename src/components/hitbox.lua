local Concord = require 'lib.Concord'

Concord.component('Hitbox', function(c, w, h, ox, oy)
  c.w = w
  c.h = h

  c.ox = ox or 0
  c.oy = oy or 0
end)
