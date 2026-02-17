local Concord = require 'lib.Concord'

Concord.component('Shooter', function(c, time, speed, bulletType, ox, oy)
  c.time = time
  c.timer = 0

  c.speed = speed
  c.type = bulletType

  -- Offset from position
  c.ox = ox or 0
  c.oy = oy or 0
end)
