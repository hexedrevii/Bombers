local Concord = require 'lib.Concord'

Concord.component('WaveManager', function(c, index)
  c.index = index or 1

  c.waveTimer = 0
  c.spawnTimer = 0
end)
