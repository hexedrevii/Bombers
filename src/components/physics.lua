local Concord = require 'lib.Concord'

Concord.component('Physics', function(c, speed)
  c.speed = speed or 100
end)
