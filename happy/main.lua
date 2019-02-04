libs = require("libs/")
local stager
stager = require("libs/").stager
state = stager
state:switch("game")
love.load = function()
  return state:init()
end
love.update = function(dt)
  return state:update(dt)
end
love.draw = function()
  return state:draw()
end
love.keypressed = function(key, isrepeat)
  return state:keypressed(key, isrepeat)
end
love.keyreleased = function(key, isrepeat)
  return state:keyreleased(key, isrepeat)
end
