local waveConfig = {
  [1] = {
    duration = 20,
    spawnRate = 1.5,

    patterns = {
      { type = 'single', enemy = 'Bomber', weight = 50 },
      { type = 'pair',   enemy = 'Bomber', offset = 20, weight = 25 },
      { type = 'single', enemy = 'B2',     weight = 25 },
    }
  },
  [2] = {
    duration = 25,
    spawnRate = 1.5,

    patterns = {
      { type = 'v',      enemy = 'Downer', sx = 24,     sy = 24,    rank = 2, weight = 20 },

      { type = 'single', enemy = 'Downer', weight = 40 },
      { type = 'pair',   enemy = 'Downer', offset = 20, weight = 30 },

      { type = 'single', enemy = 'Bomber', weight = 40 },
      { type = 'pair',   enemy = 'Bomber', offset = 20, weight = 30 },
    }
  },

  [3] = {
    duration = 30,
    spawnRate = 1.4,

    patterns = {
      { type = 'v',      enemy = 'Downer', sx = 24,     sy = 24,    rank = 2, weight = 20 },
      { type = 'v',      enemy = 'B2',     sx = 24,     sy = 24,    rank = 2, weight = 20 },

      { type = 'single', enemy = 'Downer', weight = 40 },
      { type = 'pair',   enemy = 'Downer', offset = 20, weight = 30 },

      { type = 'single', enemy = 'B2',     weight = 25 },
      { type = 'pair',   enemy = 'B2',     offset = 20, weight = 25 },

      { type = 'single', enemy = 'Bomber', weight = 40 },
      { type = 'pair',   enemy = 'Bomber', offset = 20, weight = 30 },
    }
  }
}

return waveConfig
