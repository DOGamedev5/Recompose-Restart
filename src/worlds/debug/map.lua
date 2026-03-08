local map = {}

function map:load(world)
	self.tilemap = sti("src/worlds/debug/tilemap.lua", 1, 1)
	self:loadCollisions(world)
end

function map:loadCollisions(world)
	self.collisions = self.collisions or {}
	self:clearCollisions()

	if self.tilemap.layers["collision"] then
		for i, v in ipairs(self.tilemap.layers["collision"].objects) do
			local collider = {}
			collider.body = love.physics.newBody(world, v.x, v.y, "static")

			if v.shape == "rectangle" then
				collider.shape = love.physics.newRectangleShape(v.width/2, v.height/2, v.width, v.height)

			elseif v.shape == "polygon" then
				local points = {}
				for j, p in pairs(v.polygon) do
					points[#points + 1] = p.x - v.x
					points[#points + 1] = p.y - v.y
				end

				collider.shape = love.physics.newPolygonShape(points)
			end

			collider.fixture = love.physics.newFixture(collider.body, collider.shape)

			table.insert(self.collisions, collider)
		end
	end
end

function map:update(delta)
	self.tilemap:update(delta)
end

function map:draw()
	--self.tilemap:draw(64, 96)
	self.tilemap:draw(Camera:getDrawX(0), Camera:getDrawY(0))
	
end

function map:clearCollisions()
	for i, v in ipairs(self.collisions) do
		v.fixture:destroy()
		v.fixture:release()
		v.shape:destroy()
		v.shape:release()
		v.body:destroy()
		v.body:release()
	end
end

function map:exit()
	self:clearCollisions()
end

return map