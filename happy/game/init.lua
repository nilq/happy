local path = "game/"
game = state:new()
SIZE = 20
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
  keypressed = function(self, key, isrepeat)
    local _list_0 = self.content
    for _index_0 = 1, #_list_0 do
      local element = _list_0[_index_0]
      if element.keypressed then
        element:keypressed(key, isrepeat)
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
  local player
  player = require(path .. "entities").player
  local Camera
  Camera = require(path .. "camera").Camera
  local world_level = level.Level({
    map = { },
    width = love.graphics.getWidth() / SIZE,
    height = love.graphics.getHeight() / SIZE,
    size = SIZE,
    registry = {
      NULL = 0,
      BLOCK = 1,
      PLAYER = 2
    }
  })
  world_level:init(40, 15)
  self.world = World({
    content = {
      player.Player({
        x = 10,
        y = 10,
        real_x = 10 * 20,
        real_y = 10 * 20,
        speed = 8,
        move_padding = 4
      })
    },
    level = world_level
  })
  self.camera = Camera({
    x = 0,
    y = 0,
    r = 0,
    zoom = 2
  })
end
game.update = function(self, dt)
  return self.world:update(dt)
end
game.draw = function(self)
  self.camera:set()
  self.world:draw()
  return self.camera:unset()
end
game.keypressed = function(self, key, isrepeat)
  self.world:keypressed(key, isrepeat)
  local _exp_0 = key
  if "escape" == _exp_0 then
    return love.event.quit()
  elseif "r" == _exp_0 then
    return love.event.quit("restart")
  end
end
return game
