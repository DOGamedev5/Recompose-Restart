Object = {}
Object.world = setmetatable({}, {__mode="k"})
local UUID = 1

function Object.new(x, y)
	local self = setmetatable({}, {__index=Object})
	self.x = x
	self.y = y
	self.velX = 0
	self.velY = 0
	self.groundVel = 0
	self.angle = 0
	self.UUID = UUID
	UUID = UUID + 1
	self.world[UUID] = self

	return self
end

function Object:exit()
	self.world[self.UUID] = nil
end

function Object:collide()
	-- body
end