local Concord = require 'lib.Concord'

Concord.component('Sprite', function(c, img, ox, oy, flipped)
  c.image = img
  c.ox = ox or 0
  c.oy = oy or 0
  c.flipped = flipped or false
end)
