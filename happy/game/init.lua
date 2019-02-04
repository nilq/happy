local path = "game/"
local game = state:new()
love.graphics.setBackgroundColor(1, 1, 1)
local World = struct({
  content = "table",
  level = "table"
})
World:impl({
  update = function(self, dt)
    local _list_0 = self.content
    for _index_0 = 1, #_list_0 do
      local element = _list_0[_index_0]
      if element.update then
        element:update(dt)
      end
    end
  end,
  draw = function(self)
    self.level:draw()
    local _list_0 = self.content
    for _index_0 = 1, #_list_0 do
      local element = _list_0[_index_0]
      if element.draw then
        element:draw()
      end
    end
  end
})
game.init = function(self)
  local level
  level = require(path .. "level").level
  local world_level = level.Level({
    map = { },
    width = 40,
    height = 30,
    size = 20
  })
  world_level:init(40, 15)
  self.world = World({
    content = { },
    level = world_level
  })
end
game.update = function(self, dt)
  return self.world:update(dt)
end
game.draw = function(self)
  return self.world:draw()
end
game.keypressed = function(self, key)
  local _exp_0 = key
  if "escape" == _exp_0 then
    return love.event.quit()
  elseif "r" == _exp_0 then
    return love.event.quit("restart")
  end
end
return game
