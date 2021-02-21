local maze = require 'maze'
local colors = require 'colors'
local utils = require 'utils'
local sceneManager = require 'sceneManager'
local soundManager = require 'soundManager'

local TILE_SIZE = 64
local GRID_SIZE = {['width'] = 8, ['height'] = 8}
local STARTING_POSITION = {['x'] = 0, ['y'] = 0}

local grid

local playerPosition = {['x'] = 0, ['y'] = 0}

local chocolatePosition = {['x'] = 0, ['y'] = 0}

local shouldDrawWalls = true

local game = {}

local resetsDone = 0

local shouldBlinkWalls = false
local TOTAL_BLINK_TIME = 0.04
local blinkTime = TOTAL_BLINK_TIME

function game.load( ... )
  grid = maze.generate(GRID_SIZE, STARTING_POSITION)

  playerPosition.x = STARTING_POSITION.x
  playerPosition.y = STARTING_POSITION.y

  chocolatePosition.x = utils.random(5, 8)
  chocolatePosition.y = utils.random(5, 8)
  currentChocolateSprite = utils.random(0, 7)

  sceneManager.pushScene(require 'pop_up_screens/start')
  sceneManager.pushScene(require 'pop_up_screens/controls')
end

function game.update( dt )
  if playerPosition.x == chocolatePosition.x and playerPosition.y == chocolatePosition.y then

    while math.abs(chocolatePosition.x - playerPosition.x) < 2 or math.abs(chocolatePosition.y - playerPosition.y) < 2 do
      chocolatePosition.x = utils.random(0, GRID_SIZE.width)
      chocolatePosition.y = utils.random(0, GRID_SIZE.height)
    end

    currentChocolateSprite = utils.random(0, 7)
    grid = maze.generate(GRID_SIZE, STARTING_POSITION)

    soundManager.play(eatSound)
    resetsDone = resetsDone + 1

    if resetsDone == 1 then
      sceneManager.pushScene(require 'pop_up_screens/new_maze')
    elseif resetsDone == 2 then
      sceneManager.pushScene(require 'pop_up_screens/creepy_time')
      shouldDrawWalls = false
    elseif resetsDone == 3 then
      sceneManager.pushScene(require 'pop_up_screens/endless')
    end
  end

  if shouldBlinkWalls then
    blinkTime = blinkTime - dt

    if blinkTime < 0 then
      shouldBlinkWalls = false
      blinkTime = TOTAL_BLINK_TIME
    end
  end
end

function game.draw( ... )
  for i = 0, (GRID_SIZE.width - 1) * TILE_SIZE, TILE_SIZE do
    for j = 0, (GRID_SIZE.height - 1) * TILE_SIZE, TILE_SIZE do
      love.graphics.setColor(colors.black)
      love.graphics.rectangle(
        'fill',
        i,
        j,
        TILE_SIZE,
        TILE_SIZE
      )

      local gridX = i / TILE_SIZE
      local gridY = j / TILE_SIZE
      love.graphics.setColor(colors.pink)
      if shouldDrawWalls or shouldBlinkWalls then
        if grid[gridX][gridY]:sub(1, 1) == '1' then
          love.graphics.line(
            i,
            j,
            i,
            j + TILE_SIZE
          )
        end
        if grid[gridX][gridY]:sub(2, 2) == '1' then
          love.graphics.line(
            i,
            j,
            i + TILE_SIZE,
            j
          )
        end
        if grid[gridX][gridY]:sub(3, 3) == '1' then
          love.graphics.line(
            i + TILE_SIZE,
            j,
            i + TILE_SIZE,
            j + TILE_SIZE
          )
        end
        if grid[gridX][gridY]:sub(4, 4) == '1' then
          love.graphics.line(
            i,
            j + TILE_SIZE,
            i + TILE_SIZE,
            j + TILE_SIZE
          )
        end
      end

      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(
        spriteSheet,
        chocolateSprites[currentChocolateSprite],
        chocolatePosition.x * TILE_SIZE + TILE_SIZE / 4,
        chocolatePosition.y * TILE_SIZE + TILE_SIZE / 4
      )

      love.graphics.setColor(colors.green)
      love.graphics.rectangle(
        'fill',
        playerPosition.x * TILE_SIZE + TILE_SIZE / 8,
        playerPosition.y * TILE_SIZE + TILE_SIZE / 8,
        TILE_SIZE * 3 / 4,
        TILE_SIZE * 3 / 4
      )
    end
  end
end

function game.keypressed( key )
  local currentCellWalls = grid[playerPosition.x][playerPosition.y]

  if key == 'w' or key == 'up' then
    if currentCellWalls:sub(2, 2) == '0' then
      playerPosition.y = playerPosition.y - 1
      soundManager.play(moveSound)
    else
      soundManager.play(errorSound)
      shouldBlinkWalls = true
    end
  end
  if key == 'd' or key == 'right' then
    if currentCellWalls:sub(3, 3) == '0' then
      playerPosition.x = playerPosition.x + 1
      soundManager.play(moveSound)
    else
      soundManager.play(errorSound)
      shouldBlinkWalls = true
    end
  end
  if key == 's' or key == 'down' then
    if currentCellWalls:sub(4, 4) == '0' then
      playerPosition.y = playerPosition.y + 1
      soundManager.play(moveSound)
    else
      soundManager.play(errorSound)
      shouldBlinkWalls = true
    end
  end
  if key == 'a' or key == 'left' then
    if currentCellWalls:sub(1, 1) == '0' then
      playerPosition.x = playerPosition.x - 1
      soundManager.play(moveSound)
    else
      soundManager.play(errorSound)
      shouldBlinkWalls = true
    end
  end
end

return game
