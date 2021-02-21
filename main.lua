local sceneManager = require 'sceneManager'

function love.load( ... )
  defaultFont = love.graphics.newFont('assets/MetalMacabre.ttf', 14)
  moveSound = love.audio.newSource("assets/move.mp3", "static")
  eatSound = love.audio.newSource("assets/eat.ogg", "static")
  errorSound = love.audio.newSource("assets/error.wav", "static")
  confirmSound = love.audio.newSource("assets/confirm.wav", "static")
  bgMusic = love.audio.newSource("assets/music.mp3", "stream")
  bgMusic:setLooping(true)

  spriteSheet = love.graphics.newImage("assets/sprites.png")


  chocolateSprites = {}
  for i = 0, 6 do
    chocolateSprites[i] = love.graphics.newQuad(19 + 32 * i, 28, 32, 25, spriteSheet:getDimensions())
  end

  love.graphics.setFont(defaultFont)
  sceneManager.changeScene(require 'game')
end


function love.update(dt)
  sceneManager.currentScene.update(dt)
end

function love.draw()
  sceneManager.draw()
end

function love.keypressed(key)
  sceneManager.currentScene.keypressed(key)
end

function love.mousepressed(x, y, button)
  sceneManager.currentScene.mousepressed(x, y, button)
end
