world = {}

function world:load()
	self.physicsWorld = love.physics.newWorld(0, 98)
	--self.physicsWorld:setGravity(0, 980)
	self.physicsWorld:setGravity(0, 0)
	self.worlds = {}
--	self.worlds[1] = sti("worlds/debug/map.lua", 1, 1)
	self.worlds[1] = require("worlds.debug.map")
	self.worlds[1]:load(self.physicsWorld)
	self.player = PlayerNormal.new(100, -40, self.physicsWorld)
end

function world:update(delta)
	--world.worlds[1]:update(delta)

	self.player:update(delta)
	self.physicsWorld:update(delta)
end

function world:draw()
	love.graphics.setColor(0.92, 0.9, 0.995)
	self.worlds[1]:draw()
	love.graphics.setColor(0.92, 0.4, 0.995)
	self.player:draw()
end