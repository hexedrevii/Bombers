local Concord = require 'lib.Concord'

Concord.component('Player', function(c, scr, kills)
  c.score = scr or 0
  c.kills = kills or 0

  c.reloading = false
end)

Concord.component('Reloader')
Concord.component('Dead')
Concord.component('HealthDisplay')

Concord.component('OffScreenDeath', function(c, buffer)
  c.buffer = buffer or 50
end)

-- Enemy Tags
Concord.component('Bomber')
Concord.component('Downer')
Concord.component('B2')

-- Timer Tags
Concord.component('FinishedReloading')
Concord.component('BulletDied')
Concord.component('EndGame')
