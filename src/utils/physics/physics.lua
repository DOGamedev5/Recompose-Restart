PhysicsServer = {}
require("src.utils.physics.raycast")

PhysicsServer.world = {}

local UUID = 1

local Shape = {}

function Shape.new(x, y, uuid)
	local self = setmetatable({}, {__index=Shape})
	self.posX = x
	self.posY = y
	self.UUID = uuid
	return self
end

function Shape:remove()
	PhysicsServer.world[self.UUID] = nil
end

local Polygon = setmetatable({
	tag = "polygon"
}, {__index=Shape})

function Polygon.new(points, x, y, uuid)
	local self = setmetatable(Shape.new(x, y, uuid), {__index=Polygon})
	self.points = points
	self:getEdges()

	return self
end

function Polygon:getEdges()
	local edges = {}
	for i=1, #self.points-1 do
		local dirX = self.points[i+1][1] - self.points[i][1]
		local dirY = self.points[i+1][2] - self.points[i][2]
		local normalX, normalY = Vector.normalize(Vector.perpendicular(dirX, dirY))

		table.insert(edges, {points = {i, i+1}, normal = {normalX, normalY}})
	end
	local dirX = self.points[#self.points][1] - self.points[1][1]
	local dirY = self.points[#self.points][2] - self.points[1][2]
	local normalX, normalY = Vector.normalize(Vector.perpendicular(dirX, dirY))

	table.insert(edges, {points = {#self.points, 1}, normal = {normalX, normalY}})

	self.edges = edges
end

function Polygon:draw()
	local vertices = {}
	for i, p in ipairs(self.points) do
		table.insert(vertices, p[1] + self.posX)
		table.insert(vertices, p[2] + self.posY)
	end

	love.graphics.polygon("line", vertices)
	

	for i, e in ipairs(self.edges) do
		love.graphics.setColor(0.0 + i*0.15, 0.2+i*0.05, 0.3, 0.8)
		local p1 = e.points[1]
		local p2 = e.points[2]

		love.graphics.line(self.points[p1][1] + self.posX, self.points[p1][2] + self.posY, self.points[p2][1] + self.posX, self.points[p2][2] + self.posY)
	end
end

local Circle = setmetatable({
	tag="circle"
}, {__index = Shape})

function Circle.new(x, y, radius, uuid)
	local self = setmetatable(Shape.new(x, y, uuid), {__index=Circle})
	self.radius = radius

	return self
end

function Circle:draw()
	love.graphics.circle("line", self.posX, self.posY, self.radius)
end

function PhysicsServer.newRectangleObject(x, y, width, height)
	local instance = Polygon.new({
		{0, 0},
		{width, 0},
		{width, height},
		{0, height},
	}, x, y, UUID)
	
	PhysicsServer.world[UUID] = instance
	UUID = UUID + 1

	return instance
end

function PhysicsServer.newPolygonObject(x, y, points)
	local instance = Polygon.new(points, x, y, UUID)
	
	PhysicsServer.world[UUID] = instance
	UUID = UUID + 1

	return instance
end

function PhysicsServer.newCircleObject(x, y, radius)
	local instance = Circle.new(x, y, radius, UUID)
	
	PhysicsServer.world[UUID] = instance
	UUID = UUID + 1

	return instance
end

function PhysicsServer:draw()
	
end