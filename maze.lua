local utils = require 'utils'

local maze = {}

local function createGrid( gridSize )
  grid = {}

  for i = 0, gridSize.width do
    grid[i] = {}
    for j = 0, gridSize.height do
      grid[i][j] = '1111'
    end
  end

  return grid
end

function maze.generate( gridSize, startingPosition )
  local currentCell = {['x'] = startingPosition.x, ['y'] = startingPosition.y}
  local totalCells = gridSize.width * gridSize.height
  local totalVisited = 0
  local visited = {}
  local grid = createGrid(gridSize)

  visited[currentCell.x .. currentCell.y] = true
  totalVisited = totalVisited + 1

  while totalVisited < totalCells do
    -- go to random cell
    local direction = utils.random(0, 4) -- 0, 1, 2, 3

    local neighbor = {['x'] = currentCell.x, ['y'] = currentCell.y}
    if direction == 0 then
      neighbor.x = currentCell.x - 1
    elseif direction == 1 then
      neighbor.y = currentCell.y - 1
    elseif direction == 2 then
      neighbor.x = currentCell.x + 1
    else
      neighbor.y = currentCell.y + 1
    end

    while neighbor.x < 0 or neighbor.x >= gridSize.width or neighbor.y < 0 or neighbor.y >= gridSize.height do
      direction = utils.random(0, 4)
      neighbor = {['x'] = currentCell.x, ['y'] = currentCell.y}

      if direction == 0 then
        neighbor.x = currentCell.x - 1
      elseif direction == 1 then
        neighbor.y = currentCell.y - 1
      elseif direction == 2 then
        neighbor.x = currentCell.x + 1
      else
        neighbor.y = currentCell.y + 1
      end
    end


    if not visited[neighbor.x .. neighbor.y] then
      -- remove the walls
      grid[currentCell.x][currentCell.y] = utils.replace_char(direction + 1, grid[currentCell.x][currentCell.y], 0)
      grid[neighbor.x][neighbor.y] = utils.replace_char((direction + 2) % 4 + 1, grid[neighbor.x][neighbor.y], 0)

      visited[neighbor.x .. neighbor.y] = true
      totalVisited = totalVisited + 1
    end

    currentCell.x = neighbor.x
    currentCell.y = neighbor.y
  end


  return grid
end

return maze
