local Concord = require 'lib.Concord'

---@param who 'Player'|'Enemy'
Concord.component('Faction', function(c, who)
  c.name = who
end)
