local Concord = require 'lib.Concord'

Concord.component('Sprite', function(c, img, flipped)
  c.image = img
  c.flipped = flipped or false
end)
