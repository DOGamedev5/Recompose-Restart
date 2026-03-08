sti = require("libs.sti")

require("windowHandler")

require("entities.player.playerBase.playerBase")
require("entities.player.playerNormal.playerNormal")
require("worlds.sandDesert.world")

windowHandler.setup(640, 360)
local windowCanvas

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	windowCanvas = love.graphics.newCanvas(640, 360)
	windowHandler.resizeWindow(love.graphics.getWidth(), love.graphics.getHeight())
	PlayerBase:load()
	world:load()
end

function love.update(delta)
	world:update(delta)
end

function love.draw()
	love.graphics.setCanvas(windowCanvas)
    love.graphics.setBlendMode("alpha")
	love.graphics.clear()
 	love.graphics.setBackgroundColor(0, 0, 0, 1)   
  
	love.graphics.setBackgroundColor(0, 0, 0, 1)
	world:draw()
  	love.graphics.setCanvas()
	love.graphics.clear()
  	love.graphics.setBlendMode("alpha", "premultiplied")

  	love.graphics.draw(windowCanvas, pading.x, pading.y, 0, gameScale, gameScale)
end

function love.resize(w, h)
	windowHandler.resizeWindow(w, h)
end

