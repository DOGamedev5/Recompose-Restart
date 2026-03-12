Raycast = {}

function Raycast.new(x, y, dirX, dirY)
	local self = setmetatable({}, {__index=Raycast})
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY
	self.norX, self.norY = Vector.normalize(dirX, dirY)
	self.castX = x + dirX
	self.castY = y + dirY
	self.lenght = Vector.len(dirX, dirY)
end

function Raycast:cast(polygons)
	local collisionInfo = {
		distance = math.huge,
		UUID = -1,
		normal = {0, 0},
		point = {0, 0}
	}

	for i, shape in ipairs(polygons) do
		if shape.tag == "polygon" then
			collisionInfo = self:castPolygon(shape, collisionInfo)
		elseif shape.tag == "circle" then
			collisionInfo = self:castCircle(shape, collisionInfo)
		end
	end

	if collisionInfo.UUID > 0 then
		return collisionInfo
	end

	return nil
end

function Raycast:castPolygon(shape, collisionInfo)
	for _, edge in ipairs(shape.edges) do
		local x1 = self.x
		local x2 = self.castX
		local x3 = shape.points[edge.points[1]][1]
		local x3 = shape.points[edge.points[2]][1]
		local y1 = self.y
		local y2 = self.castY
		local y3 = shape.points[edge.points[1]][2]
		local y3 = shape.points[edge.points[2]][2]

		local den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4))
		if math.abs(den) == 0 then goto continue end

		local t = ((x1 - x3) * (y3 - y4)) - ((y1 - y3) * (x3 - x4)) / den
		local u = ((x1 - x2) * (y1 - y3)) - ((y1 - y2) * (x1 - x3)) / den

		if not (t <= 1 and t >= 0 and u <= 1 and u >= 0) then goto continue end
		
		local posX = x1 + t * (x2 - x1)
		local posY = y1 + t * (y2 - y1)
		local distance = Vector.len(posX-x1, posY-y1)
		if distance < collisionInfo.distance then
			collisionInfo.distance = distance
			collisionInfo.UUID = shape.UUID
			collisionInfo.normal[1] = edge.normal[1]
			collisionInfo.normal[2] = edge.normal[2]
			collisionInfo.point[1] = posX
			collisionInfo.point[2] = posY
		end

		::continue::
	end
	return collisionInfo
end

function Raycast:castCircle(shape, collisionInfo)
	local distX = shape.posX - self.x
	local distY = shape.posY - self.y
	local radius2 = shape.radius * shape.radius
	local lenght2 = Vector.len2(distX, distY)

	local a = Vector.dot(distX, distY, self.norX, self.norY)
	local b2 = lenght2 - (a* a)
	if radius2 - b2 < 0 then return end

	local f = math.sqrt(radius2 - b2)
	local t = 0

	if lenght2 < radius2 then
		t = a + f
	else
		t = a - f
	end

	if t < self.lenght then
		local pointX = self.x + self.norX*t
		local pointY = self.y + self.norY*t

		if t < collisionInfo.distance then
			collisionInfo.distance = t
			collisionInfo.UUID = shape.UUID
			local nX, nY = Vector.normalize(pointX - shape.posX, pointY - shape.posY)
			collisionInfo.normal[1] = nX
			collisionInfo.normal[2] = nY
			collisionInfo.point[1] = pointX
			collisionInfo.point[2] = pointY
		end
	end
	return collisionInfo
end