local sceneManager = require 'sceneManager'

function love.load( ... )
  defaultFont = love.graphics.newFont('assets/MetalMacabre.ttf', 14)
  moveSound = love.audio.newSource("assets/move.mp3", "static")
  eatSound = love.audio.newSource("assets/eat.ogg", "static")
  errorSound = love.audio.newSource("assets/error.wav", "static")
  confirmSound = love.audio.newSource("assets/confirm.wav", "static")
  -- bgMusic = love.audio.newSource("assets/music.wav", "stream")
  -- bgMusic:setLooping(true)

  spriteSheet = love.graphics.newImage("assets/sprites.png")


  -- chocolateSprite0 = love.graphics.newQuad(18, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite1 = love.graphics.newQuad(18 + 32 * 1, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite2 = love.graphics.newQuad(18 + 32 * 2, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite3 = love.graphics.newQuad(18 + 32 * 3, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite4 = love.graphics.newQuad(18 + 32 * 4, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite5 = love.graphics.newQuad(18 + 32 * 5, 28, 32, 25, spriteSheet:getDimensions())
  -- chocolateSprite6 = love.graphics.newQuad(18 + 32 * 6, 28, 32, 25, spriteSheet:getDimensions())
  chocolateSprites = {}
  for i = 0, 6 do
    chocolateSprites[i] = love.graphics.newQuad(19 + 32 * i, 28, 32, 25, spriteSheet:getDimensions())
  end

  -- chocolateSprite = love.graphics.newQuad(10 + 28 * 6, 28, 32, 25, spriteSheet:getDimensions())

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
