sti = require("libs.sti")
Vector = require("libs.hump.vector-light")

require("src.utils.windowHandler")
windowHandler.setup(640, 360)
require("src.utils.camera")
Camera:load()

require("src.utils.physics.physics")
require("src.entities.player.playerBase.playerBase")
require("src.entities.player.playerNormal.playerNormal")
require("src.worlds.world")
