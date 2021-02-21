local colors = require 'colors'
local sceneManager = require 'sceneManager'
local soundManager = require 'soundManager'

local start = {}

local RECTANGLE_POSITION = {['x'] = 40, ['y'] = 100}
local RECTANGLE_SIZE = {['width'] = 425, ['height'] = 300}

function start.load( ... )
  -- body
end


function start.update( dt )
  -- body
end


function start.draw( ... )
  love.graphics.setColor(colors.green)
  love.graphics.rectangle(
    'fill',
    RECTANGLE_POSITION.x,
    RECTANGLE_POSITION.y,
    RECTANGLE_SIZE.width,
    RECTANGLE_SIZE.height
  )

  love.graphics.setColor(colors.black)
  love.graphics.rectangle(
    'line',
    RECTANGLE_POSITION.x,
    RECTANGLE_POSITION.y,
    RECTANGLE_SIZE.width,
    RECTANGLE_SIZE.height
  )

  love.graphics.print('CREEPY TIME!', RECTANGLE_POSITION.x + 130, RECTANGLE_POSITION.y + 100)
  love.graphics.print('Now the walls are invisible!', RECTANGLE_POSITION.x + 90, RECTANGLE_POSITION.y + 150)

  love.graphics.print('OK ...', RECTANGLE_POSITION.x + RECTANGLE_SIZE.width - 50, RECTANGLE_POSITION.y + RECTANGLE_SIZE.height - 40)
end

function start.keypressed( key )
  if key == 'space' then
    soundManager.play(confirmSound)
    sceneManager.popScene()
  end
end

function start.mousepressed( x, y, button )
  soundManager.play(confirmSound)
  sceneManager.popScene()
end

return start
