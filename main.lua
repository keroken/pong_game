push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  smallFont = love.graphics.newFont('font.ttf', 8)
  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  love.graphics.printf('Hello Pong', 0, 20, VIRTUAL_WIDTH, 'center')

  push:apply('end')
end
