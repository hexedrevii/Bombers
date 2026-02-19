local moonshine = require 'lib.moonshine'

local globals = require "src.globals"

local death_screen = {}

local wordPlacer = {
  words = {}
}

local function addWord(text, x, y, delay, colour)
  table.insert(wordPlacer.words,
    { skip = false, colour = colour, text = text, x = x, y = y, delay = delay, time = 0, draw = false })
end

local function updateWords(delta)
  for _, word in ipairs(wordPlacer.words) do
    if not word.skip then
      word.time = word.time + delta

      if word.time >= word.delay then
        word.draw = true
        word.skip = true

        death_screen:shake(0.14, 0.60)
      end
    end
  end
end

local function drawWords()
  for i, word in ipairs(wordPlacer.words) do
    if i == 1 then
      love.graphics.setFont(globals.fontBig)
    else
      love.graphics.setFont(globals.font)
    end
    if word.draw then
      love.graphics.setColor(word.colour)

      love.graphics.printf(word.text, 0, word.y, 320, 'center')
      love.graphics.setColor(1, 1, 1, 1)
    end
  end
end

function death_screen:shake(shakeDuration, shakeMagnitude)
  self.shakeTime = 0
  self.shakeDuration = shakeDuration
  self.shakeMagnitude = shakeMagnitude
end

function death_screen:init()
  wordPlacer.words = {}

  self.effect = moonshine(moonshine.effects.scanlines)
      .chain(moonshine.effects.crt)
      .chain(moonshine.effects.chromasep)
      .chain(moonshine.effects.vignette)

  self.effect.crt.distortionFactor = { 1.055, 1.05 }

  self.effect.vignette.radius = 0.9
  self.effect.scanlines.opacity = 0.3
  self.effect.vignette.opacity = 0.2

  self.effect.chromasep.angle = 3.1
  self.effect.chromasep.radius = 1.4

  self.staticShader = love.graphics.newShader [[
    extern float time;
    float rand(vec2 co) {
        return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    }
    vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
        float noise = rand(texture_coords + time);
        return vec4(vec3(noise), 1.0); // Output white/black noise
    }
  ]]

  self.headerAlpha = 0

  addWord('GAME OVER!', 130, 10, 0, { 1, 0, 0 })
  addWord('Score: ' .. self.score, 120, 60, 0.5, { 1, 1, 1 })
  addWord('Kills: ' .. self.kills, 120, 75, 0.75, { 1, 1, 1 })

  addWord('Press enter to start again.', 120, 100, 1, { 1, 1, 1 })
  addWord('Press Q to quit.', 120, 110, 1, { 1, 1, 1 })

  self.shakeTime = 0
  self.shakeDuration = 0
  self.shakeMagnitude = 0
end

function death_screen:update(delta)
  self.staticShader:send('time', love.timer.getTime())

  if globals.input:isPressed('retry') then
    local game = require 'src.worlds.game'
    globals.worlds:set(game)
  end

  if self.shakeTime < self.shakeDuration then
    self.shakeTime = self.shakeTime + delta
  end

  if self.headerAlpha <= 0.5 then
    self.headerAlpha = self.headerAlpha + delta
    return
  end

  updateWords(delta)
end

function death_screen:draw()
  globals.renderer:set()
  love.graphics.clear(0.5, 0.5, 0.5)

  if self.shakeTime < self.shakeDuration then
    local dx = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
    local dy = love.math.random(-self.shakeMagnitude, self.shakeMagnitude)
    love.graphics.translate(dx, dy)
  end

  love.graphics.setShader(self.staticShader)
  love.graphics.draw(globals.resources:get('square'), 0, 0)
  love.graphics.setShader()

  love.graphics.setColor(0, 0, 0, self.headerAlpha)
  love.graphics.rectangle('fill', 0, 0, 320, 180)
  love.graphics.setColor(1, 1, 1, 1)

  drawWords()

  globals.renderer:render(nil, nil, self.effect)
end

function death_screen:resize(w, h)
  self.effect.resize(w, h)
end

return death_screen
