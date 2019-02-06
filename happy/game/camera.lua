local Camera = struct({
  x = "number",
  y = "number",
  r = "number",
  zoom = "number"
})
Camera:impl({
  move = function(self, dx, dy)
    self.x = self.x + dx
    self.y = self.y + dy
  end,
  set = function(self)
    do
      local _with_0 = love.graphics
      _with_0.push()
      _with_0.translate(_with_0.getWidth() / 2 - self.x, _with_0.getHeight() / 2 - self.y)
      _with_0.rotate(self.r)
      _with_0.scale(self.zoom, self.zoom)
      return _with_0
    end
  end,
  unset = function(self)
    return love.graphics.pop()
  end
})
return {
  Camera = Camera
}
