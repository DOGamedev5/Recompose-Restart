PlayerBase = {}

function PlayerBase:load()
	
end

function PlayerBase.new(x, y, world)
	local instance = setmetatable({}, {__index=PlayerBase})

	instance.body = love.physics.newBody(world, x, y, "dynamic")

	return instance
end

function PlayerBase:update(delta)
	--windowHandler.cameraPos.x = self.body:getX() - windowSize.x/2
	--windowHandler.cameraPos.y = self.body:getY() - windowSize.y/2
	Camera:lookAt(self.body:getX(), self.body:getY())
end

function PlayerBase:draw()
	--local x, y = self.body:getX(), self.body:getY()
	--love.graphics.rectangle(x-16, y-16, 32, 32)
end
