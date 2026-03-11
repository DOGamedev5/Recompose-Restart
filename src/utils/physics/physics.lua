PhysicsServer = {}

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

local Circle = setmetatable({
	tag="circle"
}, {__index = Shape})

function Circle.new(x, y, radius, uuid)
	local self = setmetatable(Shape.new(x, y, uuid), {__index=Circle})
	self.radius = radius

	return self
end

function PhysicsServer.newRectangleObject(x, y, width, height)
	local instance = Polygon.new({
		{x, y},
		{x+width, y},
		{x+width, y+height},
		{x, y+height},
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

function PhysicsServer.newCircle(x, y, radius)
	local instance = Circle.new(x, y, radius, UUID)
	
	PhysicsServer.world[UUID] = instance
	UUID = UUID + 1

	return instance
end