windowSize = {
  x = 100,
  y = 100
}
gameScale = 1
pading = {
  x = 0,
  y = 0
}
windowHandler = {}
windowHandler.cameraPos = {x = 0, y = 0}

function toGame(x, y)
  local ww, wh = love.window.getDesktopDimensions()

  x, y = (x - pading.x) / gameScale, (y - pading.y) / gameScale

  return x, y
end

function windowHandler.setup(width, height)
  windowSize.x = width
  windowSize.y = height
end

function windowHandler.setupConfig()
  love.graphics.translate(pading.x, pading.y)
  love.graphics.scale(gameScale, gameScale)
end

function windowHandler.resizeWindow(w, h)
  local gameScaleX = h / windowSize.y   
  local gameScaleY = w / windowSize.x
  gameScale = math.min(gameScaleX, gameScaleY)

  pading.x = (w - (gameScale * windowSize.x))/2
  pading.y = (h - (gameScale * windowSize.y))/2
end

function windowHandler.drawPadding()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("fill", 0, 0, pading.x, love.graphics.getHeight())
  love.graphics.rectangle("fill", love.graphics.getWidth() - pading.x, 0, pading.x, love.graphics.getHeight() + pading.y)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), pading.y)
  love.graphics.rectangle("fill", 0, love.graphics.getHeight() - pading.y, love.graphics.getWidth(), pading.y)
  love.graphics.setColor(1, 1, 1, 1)

end