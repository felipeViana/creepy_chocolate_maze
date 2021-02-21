local colors = require 'colors'
local sceneManager = require 'sceneManager'
local soundManager = require 'soundManager'

local controls = {}

local RECTANGLE_POSITION = {['x'] = 40, ['y'] = 100}
local RECTANGLE_SIZE = {['width'] = 425, ['height'] = 300}

function controls.load( ... )
  -- body
end


function controls.update( dt )
  -- body
end


function controls.draw( ... )
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

  love.graphics.print('CONTROLS:', RECTANGLE_POSITION.x + 150, RECTANGLE_POSITION.y + 25)
  love.graphics.print('Move with WASD or arrow keys', RECTANGLE_POSITION.x + 75, RECTANGLE_POSITION.y + 125)

  love.graphics.print('click to continue', RECTANGLE_POSITION.x + RECTANGLE_SIZE.width - 175, RECTANGLE_POSITION.y + RECTANGLE_SIZE.height - 40)
end

function controls.keypressed( key )
  if key == 'space' or key == 'return' then
    soundManager.play(confirmSound)
    sceneManager.popScene()
  end
end

function controls.mousepressed( x, y, button )
  soundManager.play(confirmSound)
  sceneManager.popScene()
end

return controls
