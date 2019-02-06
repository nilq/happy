libs = require("libs/")
local stager
stager = require("libs/").stager
state = stager
state:switch("game")
math.lerp = function(a, b, t)
  return a + (b - a) * t
end
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
