local maze = require 'maze'
local colors = require 'colors'

local TILE_SIZE = 64
local GRID_SIZE = {['width'] = 8, ['height'] = 8}
local STARTING_POSITION = {['x'] = 0, ['y'] = 0}

local grid

local playerPosition = {['x'] = 0, ['y'] = 0}

local shouldDrawWalls = true

function love.load( ... )
  grid = maze.generate(GRID_SIZE, STARTING_POSITION)

  playerPosition.x = STARTING_POSITION.x
  playerPosition.y = STARTING_POSITION.y
end

function love.update( dt )
  -- body
end

function love.draw( ... )
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
      if shouldDrawWalls then
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

function love.keypressed( key )
  if key == 'escape' then
    love.event.quit(0)
  end

  if key == 'space' then
    grid = maze.generate(GRID_SIZE, STARTING_POSITION)
  end


  local currentCellWalls = grid[playerPosition.x][playerPosition.y]

  if key == 'w' or key == 'up' then
    if currentCellWalls:sub(2, 2) == '0' then
      playerPosition.y = playerPosition.y - 1
    end
  end
  if key == 'd' or key == 'right' then
    if currentCellWalls:sub(3, 3) == '0' then
      playerPosition.x = playerPosition.x + 1
    end
  end
  if key == 's' or key == 'down' then
    if currentCellWalls:sub(4, 4) == '0' then
      playerPosition.y = playerPosition.y + 1
    end
  end
  if key == 'a' or key == 'left' then
    if currentCellWalls:sub(1, 1) == '0' then
      playerPosition.x = playerPosition.x - 1
    end
  end
end
