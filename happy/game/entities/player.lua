local Player = struct({
  x = "number",
  y = "number",
  real_x = "number",
  real_y = "number"
})
Player:impl({
  update = function(self, dt)
    self.real_x = math.lerp(self.real_x, self.x * SIZE, dt * 15)
    self.real_y = math.lerp(self.real_y, self.y * SIZE, dt * 15)
    game.camera.x = math.lerp(game.camera.x, (math.floor(self.real_x * 2 + SIZE / 2)), dt * game.camera.zoom)
    game.camera.y = math.lerp(game.camera.y, (math.floor(self.real_y * 2 + SIZE / 2)), dt * game.camera.zoom)
  end,
  draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(0, 1, 1)
      _with_0.rectangle("fill", self.real_x, self.real_y, SIZE, SIZE)
      _with_0.setColor(0, 0.8, 0.8)
      _with_0.rectangle("line", self.real_x, self.real_y, SIZE, SIZE)
      return _with_0
    end
  end,
  keypressed = function(self, key, isrepeat)
    local dx = 0
    local dy = 0
    local _exp_0 = key
    if "right" == _exp_0 then
      dx = 1
    elseif "left" == _exp_0 then
      dx = -1
    elseif "down" == _exp_0 then
      dy = 1
    elseif "up" == _exp_0 then
      dy = -1
    end
    if game.world.level:vacant(self.x + dx, self.y + dy) then
      self.x = self.x + dx
      self.y = self.y + dy
      if not (dx + dy == 0) then
        game.world.level:set(self.x, self.y, game.world.level.registry.NULL)
      end
      return game.world.level:set(self.x, self.y, game.world.level.registry.PLAYER)
    end
  end
})
return {
  Player = Player
}
