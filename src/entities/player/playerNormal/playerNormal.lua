PlayerNormal = setmetatable({}, {__index=PlayerBase})

function PlayerNormal.new(x, y, world)
	local instance = setmetatable(PlayerBase.new(x+300, y+200, world), {__index=PlayerNormal})

	instance.shape = love.physics.newCircleShape(0, -16, 16)
	instance.fixture = love.physics.newFixture(instance.body, instance.shape)
	
	instance.fixture:setFriction(100.5)
	instance.body:setLinearDamping(5)
	instance.body:setFixedRotation(true)
	Camera:setPosition(x, y)

	return instance
end

function PlayerNormal:update(delta)
	PlayerBase.update(self, delta)
	local dirx, diry = 0, 0

	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
	    self.body:applyLinearImpulse(10, 0)
	elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
	    self.body:applyLinearImpulse(-10, 0)
	end
	if love.keyboard.isDown("down") then --press the left arrow key to push the ball to the left
	    self.body:applyLinearImpulse(0, 10)
	elseif love.keyboard.isDown("up") then --press the left arrow key to push the ball to the left
	    self.body:applyLinearImpulse(0, -10)
	end
--	if love.keyboard.isDown("up") then --press the left arrow key to push the ball to the left
--	    self.body:applyLinearImpulse(0, -100000)
--	    diry = 100
--	end
	--self.body:setLinearVelocity(dirx, diry)
end

function PlayerNormal:draw()
	local x, y = self.body:getX(), self.body:getY()
	--love.graphics.rectangle("fill", x-16, y-16, 32, 32)
	love.graphics.circle("fill", Camera:getDrawX(x), Camera:getDrawY(y - 16), 16)
	
end