---@type [{duration: number, spawnRate: number, enemies: [string]}]
local waveConfig = {
  {
    duration = 20,
    spawnRate = 1.5,

    enemies = { 'Bomber' }
  },
  {
    duration = 30,
    spawnRate = 1.3,

    enemies = { 'Bomber', 'Dropper', 'Looper' }
  }
}

return waveConfig
