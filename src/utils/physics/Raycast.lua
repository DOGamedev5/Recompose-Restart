Raycast = {}

function Raycast.new(x, y, dirX, dirY)
	local self = setmetatable({}, {__index=Raycast})
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY
	self.castX = x + dirX
	self.castY = y + dirY
	self.lenght = Vector.len(dirX, dirY)
end

function Raycast:cast(polygons)
	local collisionInfo = {}

	for i, shape in ipairs(polygons) do
		for j, p in ipairs(shape.edges) do
			local p1 = shape.points[p.points[1]]
			local p2 = shape.points[p.points[2]]

			local den = ((self.x - self.castX) * (p1[2] - p2[2])) - ((self.y - self.castY) * (p1[1] - p2[1]))
			if math.abs(den) == 0 then goto continue end

			local t = ((self.x - p1[1]) * (p1[2] - p2[2])) - ((self.y - p1[2]) * (p1[1] - p2[1])) / den
			local u = ((self.x - self.castX) * (self.y - p1[2])) - ((self.y - self.castY) * (self.x - p1[1])) / den

			if t <= 1 and t >= 0 and u <= 1 and u >= 0 then
				local posX = self.x + t * (self.castX - self.x)
				local posY = self.y + t * (self.castY - self.y)
			end

			::continue::
		end
	end

end