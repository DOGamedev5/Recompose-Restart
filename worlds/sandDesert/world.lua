world = {}

function world:load()
	world.rooms = {}
	world.rooms[0] = require("worlds/sandDesert/rooms/room1/tilemap")
end
