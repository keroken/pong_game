push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())
  smallFont = love.graphics.newFont('font.ttf', 8)
  scoreFont = love.graphics.newFont('font.ttf', 32)
  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player1Score = 0
  player2Score = 0

  player1Y = 30
  player2Y = VIRTUAL_HEIGHT - 50

  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

  gameState = 'start'
end

function love.update(dt)
  -- player1 movement
  if love.keyboard.isDown('w') then
    player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    player1Y = math.min(VIRTUAL_HEIGHT -20, player1Y + PADDLE_SPEED * dt)
  end

  -- player2 movement
  if love.keyboard.isDown('up') then
    player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
    player2Y = math.min(VIRTUAL_HEIGHT -20, player2Y + PADDLE_SPEED * dt)
  end

  if gameState == 'play' then
    ball:update(dt)
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
      ball:reset()
    end
  end
end

function love.draw()
  push:apply('start')

  -- set background color
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  -- print title
  love.graphics.setFont(smallFont)
  if gameState == 'start' then
    love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
  else
    love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
  end

  -- print scores
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player1Score),
    VIRTUAL_WIDTH / 2 - 50, 
    VIRTUAL_HEIGHT / 3)
  love.graphics.print(tostring(player2Score),
    VIRTUAL_WIDTH / 2 + 30, 
    VIRTUAL_HEIGHT / 3)

  -- fist paddle(left)
  love.graphics.rectangle('fill', 10, player1Y, 5, 20)

  -- second paddle(right)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

  -- ball(center)
  ball:render()

  push:apply('end')
end
