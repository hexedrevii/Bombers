local Concord = require 'lib.Concord'

Concord.component('Player', function(c)
  c.score = 0
  c.kills = 0
  c.misses = 0

  c.reloading = false
end)

-- Timer Tags
Concord.component('FinishedReloading')
Concord.component('BulletDied')
