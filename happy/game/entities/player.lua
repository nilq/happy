local Player = struct({
  x = "number",
  y = "number",
  real_x = "number",
  real_y = "number",
  speed = "number",
  move_padding = "number"
})
Player:impl({
  update = function(self, dt)
    self.real_x = math.lerp(self.real_x, self.x * SIZE, dt * self.speed)
    self.real_y = math.lerp(self.real_y, self.y * SIZE, dt * self.speed)
    game.camera.x = math.lerp(game.camera.x, (math.floor(self.real_x * game.camera.zoom + SIZE)), dt * game.camera.zoom)
    game.camera.y = math.lerp(game.camera.y, (math.floor(self.real_y * game.camera.zoom + SIZE)), dt * game.camera.zoom)
    do
      local _with_0 = love.keyboard
      if (self.real_x - self.x * SIZE) ^ 2 + (self.real_y - self.y * SIZE) ^ 2 < self.move_padding ^ 2 then
        local dx = 0
        local dy = 0
        if _with_0.isDown("right") then
          dx = 1
        end
        if _with_0.isDown("left") then
          dx = -1
        end
        if _with_0.isDown("down") then
          dy = 1
        end
        if _with_0.isDown("up") then
          dy = -1
        end
        self:move(dx, dy)
      end
      return _with_0
    end
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
  move = function(self, dx, dy)
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
