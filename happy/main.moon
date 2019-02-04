export libs = require "libs/"

import stager from require "libs/"

export state = stager

state\switch "game"

love.load   =      -> state\init!
love.update = (dt) -> state\update dt
love.draw   =      -> state\draw!

love.keypressed  = (key, isrepeat)-> state\keypressed  key, isrepeat
love.keyreleased = (key, isrepeat)-> state\keyreleased key, isrepeat
