Camera = {}

local min, max, abs = math.min, math.max, math.abs
local wx, wy = windowSize.x, windowSize.y

function Camera:load()
	wx, wy = windowSize.x, windowSize.y
	self.x = 0
	self.y = 0
	self.targetX = 0
	self.targetY = 0
	self.zoom = 1
	self.limitsMin = {x = -100000, y = -100000}
	self.limitsMax = {x = 100000, y = 100000}
end

function Camera:setPosition(x, y)
	self.x = x
	self.y = y
	self.targetX = x
	self.targetY = y
end

function Camera:setLimits(minX, minY, maxX, maxY)
	self.limitsMin.x = minX
	self.limitsMin.y = minY
	self.limitsMax.x = maxX
	self.limitsMax.y = maxY
end

function Camera:lookAt(x, y)
	self.targetX = max(min(x, self.limitsMax.x-wx), self.limitsMin.x+wx)
	self.targetY = max(min(y, self.limitsMax.y-wy), self.limitsMin.y+wy)
end

function Camera:clampDistance()
	

end

function Camera:update(delta)
	self.x = tools.lerp(self.x, self.targetX, delta*4)
	self.y = tools.lerp(self.y, self.targetY, delta*4)
	self:clampDistance()
end

function Camera:getDrawX(x)
	return wx*0.5 + ((x or 0) - self.x)
end

function Camera:getDrawY(y)
	return wy*0.5 + ((y or 0) - self.y)
	--return self.y - wy*0.5
end

function Camera:getDrawPos(x, y)
	return self:getDrawX(x), self:getDrawY(y)
end