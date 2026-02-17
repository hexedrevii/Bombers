local Concord = require 'lib.Concord'

Concord.component('Health', function(c, h)
  c.hp = h or 3
  c.mhp = h or 3
end)
