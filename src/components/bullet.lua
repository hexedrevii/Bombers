local Concord = require 'lib.Concord'

Concord.component('Bullet', function(c, dmg)
  c.damage = dmg
end)
