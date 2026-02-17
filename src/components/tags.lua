local Concord = require 'lib.Concord'

Concord.component('Player', function(c)
  c.score = 0
  c.kills = 0

  c.reloading = false
end)

Concord.component('Reloader')
Concord.component('Dead')
Concord.component('HealthDisplay')
Concord.component('OffScreenDeath')

-- Enemy Tags
Concord.component('Bomber')

-- Timer Tags
Concord.component('FinishedReloading')
Concord.component('BulletDied')
