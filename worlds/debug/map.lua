local map = {}

function map:load(world)
	self.tilemap = sti("worlds/debug/tilemap.lua", 1, 1)
	self:loadCollisions(world)
end

function map:loadCollisions(world)
	self.collisions = {}

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
					print(p.x)
				end

				collider.shape = love.physics.newPolygonShape(points)
			end

			collider.fixture = love.physics.newFixture(collider.body, collider.shape)

			table.insert(self.collisions, collider)
		end
	end
end

function map:draw()
	--self.tilemap:draw(64, 96)
	self.tilemap:draw(-windowHandler.cameraPos.x, -windowHandler.cameraPos.y)
	
end

return map