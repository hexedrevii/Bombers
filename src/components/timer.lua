local Concord = require 'lib.Concord'

Concord.component('Timer', function(c, timeout, componentName)
  c.timeout = timeout or 1.0
  c.component = componentName

  c.time = 0
end)
