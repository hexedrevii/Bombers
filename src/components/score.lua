local Concord = require 'lib.Concord'

Concord.component('Score', function(c, score)
  c.score = score or 25
end)
