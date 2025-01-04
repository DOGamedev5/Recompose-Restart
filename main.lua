require("entities/player/playerBase/playerBase")
require("worlds/sandDesert/world")

posX = 10

function love.load()
	PlayerBase:load()
	world:load()
end

function love.update(delta)
	posX = posX + (10 *delta)
end

function love.draw()
	love.graphics.print("hello World", posX, 10, 0, 10)
end
